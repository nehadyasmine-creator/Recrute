import os
import re
import time
import requests
import logging
import pdfplumber
from pymongo import MongoClient
from sentence_transformers import SentenceTransformer

API_URL_CANDIDATS = "http://localhost:8080/candidats"
MODEL_NAME = "sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2"
MONGO_URI = "mongodb://localhost:27017/"
DB_NAME = "recrute_mongo"
COLLECTION_NAME = "candidats"

CV_DIR = "../recrute-backend/uploads/cv"

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')


class CandidateIndexer:
    def __init__(self):
        print(f"[INFO] Initialisation du modèle {MODEL_NAME}...")
        self.model = SentenceTransformer(MODEL_NAME)
        self.client = MongoClient(MONGO_URI)
        self.db = self.client[DB_NAME]
        self.collection = self.db[COLLECTION_NAME]

    def recuperer_candidats_api(self):
        print(f"[INFO] Récupération des candidats depuis {API_URL_CANDIDATS}...")
        try:
            response = requests.get(API_URL_CANDIDATS, timeout=10)
            response.raise_for_status()
            return response.json()
        except requests.exceptions.RequestException as e:
            logging.error(f"Erreur lors de la récupération des candidats : {e}")
            return []

    def extract_cv_text_locally(self, filename):
        """Lit le CV directement depuis le dossier local."""
        if not filename:
            return ""

        file_path = os.path.join(CV_DIR, filename)
        text = ""

        if not os.path.exists(file_path):
            logging.warning(f"Fichier introuvable sur le disque : {file_path}")
            return ""

        try:
            with pdfplumber.open(file_path) as pdf:
                for page in pdf.pages:
                    content = page.extract_text()
                    if content:
                        text += content + "\n"
        except Exception as e:
            logging.error(f"Erreur lors de la lecture du PDF {filename} : {e}")

        return text.strip()

    def clean_text(self, text):
        if text is None or not str(text).strip():
            return ""
        text = re.sub(r'<[^>]+>', ' ', str(text))
        text = re.sub(r'[\n\r\t]', ' ', text)
        text = re.sub(r'\s+', ' ', text)
        return text.strip()

    def run(self):
        candidats = self.recuperer_candidats_api()
        if not candidats:
            print("[ERREUR] Aucun candidat à traiter.")
            return

        print("[INFO] Effacement des anciennes données dans MongoDB...")
        self.collection.delete_many({})

        start_time = time.time()
        docs = []

        for idx, candidat in enumerate(candidats):
            nom_fichier_cv = candidat.get('cv')

            if not nom_fichier_cv:
                continue

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
            self.collection.insert_many(docs)

        print(f"\n[SUCCÈS] {len(docs)} candidats avec CV indexés en {round(time.time() - start_time, 2)}s.")


if __name__ == "__main__":
    indexer = CandidateIndexer()
    indexer.run()