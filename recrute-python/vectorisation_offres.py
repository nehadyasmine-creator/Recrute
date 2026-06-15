import re
import time
import requests
import logging
from pymongo import MongoClient
from sentence_transformers import SentenceTransformer

API_URL = "http://localhost:8080/offres"
MODEL_NAME = "sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2"
MONGO_URI = "mongodb://localhost:27017/"
DB_NAME = "recrute_mongo"
COLLECTION_NAME = "offres"

logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

class OfferIndexer:
    def __init__(self):
        print(f"[INFO] Initialisation du modèle {MODEL_NAME}...")
        self.model = SentenceTransformer(MODEL_NAME)
        self.client = MongoClient(MONGO_URI)
        self.db = self.client[DB_NAME]
        self.collection = self.db[COLLECTION_NAME]

    def recuperer_offres_api(self):
        """Récupère les offres depuis l'API locale."""
        print(f"[INFO] Récupération des offres depuis {API_URL}...")
        try:
            response = requests.get(API_URL, timeout=10)
            response.raise_for_status()
            offres = response.json()
            print(f"[INFO] {len(offres)} offres récupérées avec succès de l'API.")
            return offres
        except requests.exceptions.RequestException as e:
            logging.error(f"Erreur lors de la récupération des offres sur l'API : {e}")
            return []

    def clean_text(self, text):
        if text is None or not str(text).strip():
            return ""
        text = re.sub(r'<[^>]+>', ' ', str(text))
        text = re.sub(r'[\n\r\t]', ' ', text)
        text = re.sub(r'\s+', ' ', text)
        return text.strip()

    def run(self):
        offres = self.recuperer_offres_api()
        if not offres:
            print("[ERREUR] Aucune offre à traiter. Arrêt du script.")
            return

        print("[INFO] Effacement des anciennes données dans MongoDB...")
        result = self.collection.delete_many({})
        print(f"[INFO] {result.deleted_count} anciens documents ont été supprimés.")

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

            if (idx + 1) % 10 == 0:
                print(f"[PROGRESS] {idx + 1} offres traitées...")

        if docs:
            self.collection.insert_many(docs)

        duration = round(time.time() - start_time, 2)
        print(f"\n[SUCCÈS] {len(docs)} offres indexées en {duration}s.")


if __name__ == "__main__":
    indexer = OfferIndexer()
    indexer.run()