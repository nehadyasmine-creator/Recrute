import pandas as pd
import re
import time
from pymongo import MongoClient
from sentence_transformers import SentenceTransformer

# --- CONFIGURATION ---
CSV_FILE_PATH = "offres_indeed_extraites.csv"
MODEL_NAME = "sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2"
MONGO_URI = "mongodb://localhost:27017/"
DB_NAME = "marketplace_rh"
COLLECTION_NAME = "offres"


class OfferIndexer:
    def __init__(self):
        print(f"[INFO] Initialisation du modèle {MODEL_NAME}...")
        self.model = SentenceTransformer(MODEL_NAME)
        self.client = MongoClient(MONGO_URI)
        self.db = self.client[DB_NAME]
        self.collection = self.db[COLLECTION_NAME]

    def clean_text(self, text):
        """Nettoyage expert : suppression HTML, normalisation des espaces."""
        if not text or pd.isna(text): return ""
        text = re.sub(r'<[^>]+>', ' ', str(text))
        text = re.sub(r'[\n\r\t]', ' ', text)
        text = re.sub(r'\s+', ' ', text)
        return text.strip()

    def run(self):
        try:
            df = pd.read_csv(CSV_FILE_PATH).fillna("")
        except Exception as e:
            print(f"[ERREUR] Impossible de lire le CSV : {e}")
            return

        print("[INFO] Effacement des anciennes données dans MongoDB...")
        result = self.collection.delete_many({})
        print(f"[INFO] {result.deleted_count} anciens documents ont été supprimés.")

        start_time = time.time()
        docs = []

        for idx, row in df.iterrows():
            titre = str(row['titre'])
            description = str(row['description'])

            # Feature Engineering : On fusionne titre et description pour un vecteur riche
            full_content = f"{titre}. {description}"
            cleaned_content = self.clean_text(full_content)

            if not cleaned_content: continue

            # Vectorisation
            embedding = self.model.encode(cleaned_content).tolist()

            # Construction du document normé
            doc = {
                "metadata": {
                    "titre": titre,
                    "entreprise": str(row['entreprise']),
                    "secteur": str(row['secteur']),
                    "localisation": str(row['localisation']),
                    "salaire": str(row['salaire']),
                    "type_contrat": str(row['type_contrat']),
                    "experience_requise": str(row['experience_requise']),
                    "teletravail": str(row['teletravail']),
                    "site_web": str(row['site_web'])
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