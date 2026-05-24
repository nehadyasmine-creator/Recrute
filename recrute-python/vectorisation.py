import os
import re
import time
import requests
import logging
import pdfplumber
import json
from bson import json_util
from pymongo import MongoClient
from sentence_transformers import SentenceTransformer

# --- CONFIGURATION ---
API_URL_OFFRES = "http://localhost:8080/offres"
API_URL_CANDIDATS = "http://localhost:8080/candidats"

MODEL_NAME = "sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2"
MONGO_URI = "mongodb://localhost:27017/"
DB_NAME = "recrute_mongo"

# Chemins
CV_DIR = "../recrute-backend/uploads/cv"
EXPORT_DIR = "../recrute-backend/src/main/resources/mongo-init"

# Configuration du logger
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')


class DataIndexer:
    def __init__(self):
        print(f"[INFO] Initialisation du modèle {MODEL_NAME}...")
        self.model = SentenceTransformer(MODEL_NAME)
        self.client = MongoClient(MONGO_URI)
        self.db = self.client[DB_NAME]

    def clean_text(self, text):
        if text is None or not str(text).strip():
            return ""
        text = re.sub(r'<[^>]+>', ' ', str(text))
        text = re.sub(r'[\n\r\t]', ' ', text)
        text = re.sub(r'\s+', ' ', text)
        return text.strip()

    # ==========================================
    # GESTION DES OFFRES
    # ==========================================
    def process_offres(self):
        collection = self.db["offres"]

        print(f"[INFO] Récupération des offres depuis {API_URL_OFFRES}...")
        try:
            response = requests.get(API_URL_OFFRES, timeout=10)
            response.raise_for_status()
            offres = response.json()
        except requests.exceptions.RequestException as e:
            logging.error(f"Erreur API Offres : {e}")
            return

        if not offres:
            print("[WARN] Aucune offre à traiter.")
            return

        # COMME AVANT : On efface tout
        print("[INFO] Effacement des anciennes offres dans MongoDB...")
        collection.delete_many({})

        print("[INFO] Indexation des offres en cours...")
        start_time = time.time()
        docs = []

        for idx, offer in enumerate(offres):
            titre = str(offer.get('titre', ''))
            description = str(offer.get('description', ''))

            full_content = f"{titre}. {description}"
            cleaned_content = self.clean_text(full_content)

            if not cleaned_content:
                continue

            embedding = self.model.encode(cleaned_content).tolist()
            recruteur = offer.get('recruteur', {})
            entreprise = recruteur.get('entreprise', {})

            doc = {
                "metadata": {
                    "titre": titre,
                    "entreprise": str(entreprise.get('nom', '')),
                    "secteur": str(entreprise.get('secteur', '')),
                    "localisation": str(offer.get('lieu', '')),
                    "salaire": str(offer.get('salaire', '')),
                    "type_contrat": str(offer.get('typeContrat', '')),
                    "experience_requise": str(offer.get('experienceRequise', '')),
                    "teletravail": str(offer.get('teletravail', False)),
                    "site_web": str(entreprise.get('siteWeb', ''))
                },
                "texte_brut": description,
                "embedding": embedding
            }
            docs.append(doc)
            if (idx + 1) % 10 == 0: print(f"[PROGRESS] {idx + 1} offres traitées...")

        if docs:
            collection.insert_many(docs)
            print(f"[SUCCÈS] {len(docs)} offres indexées en {round(time.time() - start_time, 2)}s.")

    # ==========================================
    # GESTION DES CANDIDATS
    # ==========================================
    def extract_cv_text_locally(self, filename):
        if not filename: return ""
        file_path = os.path.join(CV_DIR, filename)
        if not os.path.exists(file_path):
            return ""

        text = ""
        try:
            with pdfplumber.open(file_path) as pdf:
                for page in pdf.pages:
                    content = page.extract_text()
                    if content: text += content + "\n"
        except Exception as e:
            logging.error(f"Erreur lecture PDF {filename} : {e}")
        return text.strip()

    def process_candidats(self):
        collection = self.db["candidats"]

        print(f"[INFO] Récupération des candidats depuis {API_URL_CANDIDATS}...")
        try:
            response = requests.get(API_URL_CANDIDATS, timeout=10)
            response.raise_for_status()
            candidats = response.json()
        except requests.exceptions.RequestException as e:
            logging.error(f"Erreur API Candidats : {e}")
            return

        if not candidats:
            print("[WARN] Aucun candidat à traiter.")
            return

        # COMME AVANT : On efface tout
        print("[INFO] Effacement des anciens candidats dans MongoDB...")
        collection.delete_many({})

        print("[INFO] Indexation des candidats en cours...")
        start_time = time.time()
        docs = []

        for idx, candidat in enumerate(candidats):
            nom_fichier_cv = candidat.get('cv')
            if not nom_fichier_cv: continue

            utilisateur = candidat.get('utilisateur', {})
            prenom = str(utilisateur.get('prenom', ''))
            nom = str(utilisateur.get('nom', ''))
            type_contrat = str(candidat.get('typeContrat', ''))
            ville = str(candidat.get('ville', ''))
            dispo = str(candidat.get('disponibilite', ''))

            texte_cv_extrait = self.extract_cv_text_locally(nom_fichier_cv)

            full_content = f"Candidat: {prenom} {nom}. Recherche: {type_contrat} à {ville}. Dispo: {dispo}. "
            if texte_cv_extrait:
                full_content += f"Contenu du CV : {texte_cv_extrait}"

            cleaned_content = self.clean_text(full_content)
            if not cleaned_content: continue

            embedding = self.model.encode(cleaned_content).tolist()

            doc = {
                "metadata": {
                    "candidat_id": candidat.get('id'),
                    "utilisateur_id": utilisateur.get('id'),
                    "nom": nom,
                    "prenom": prenom,
                    "type_contrat": type_contrat,
                    "ville": ville,
                    "fichier_cv": nom_fichier_cv,
                    "cv_parse_avec_succes": bool(texte_cv_extrait)
                },
                "texte_brut_combine": cleaned_content,
                "embedding": embedding
            }
            docs.append(doc)
            if (idx + 1) % 10 == 0: print(f"[PROGRESS] {idx + 1} candidats traités...")

        if docs:
            collection.insert_many(docs)
            print(f"[SUCCÈS] {len(docs)} candidats indexés en {round(time.time() - start_time, 2)}s.")

    # ==========================================
    # EXPORTATION JSON AUTOMATIQUE
    # ==========================================
    def export_to_json(self, collection_name):
        os.makedirs(EXPORT_DIR, exist_ok=True)
        file_path = os.path.join(EXPORT_DIR, f"{collection_name}.json")

        collection = self.db[collection_name]
        documents = list(collection.find())

        if documents:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(json_util.dumps(documents, indent=4, ensure_ascii=False))
            print(f"[EXPORT] Collection '{collection_name}' exportée dans {file_path}")
        else:
            print(f"[WARN] La collection '{collection_name}' est vide, rien à exporter.")

    def run(self):
        # 1. Traitement avec écrasement complet
        self.process_offres()
        self.process_candidats()

        # 2. Sauvegarde Automatique
        print("\n--- Lancement des exports JSON ---")
        self.export_to_json("offres")
        self.export_to_json("candidats")
        print("--- Processus terminé ---")


if __name__ == "__main__":
    indexer = DataIndexer()
    indexer.run()