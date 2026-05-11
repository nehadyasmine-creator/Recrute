import pdfplumber
import numpy as np
from pymongo import MongoClient
from sentence_transformers import SentenceTransformer

# --- CONFIGURATION ---
CV_PATH = "CV_INGRACHEN_Pierre.pdf"
MODEL_NAME = "sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2"
MONGO_URI = "mongodb://localhost:27017/"
DB_NAME = "marketplace_rh"
COLLECTION_NAME = "offres"


class CRMAtchingEngine:
    def __init__(self):
        print(f"[INFO] Chargement du moteur de matching...")
        self.model = SentenceTransformer(MODEL_NAME)
        self.client = MongoClient(MONGO_URI)
        self.collection = self.client[DB_NAME][COLLECTION_NAME]

    def extract_cv_text(self, path):
        text = ""
        try:
            with pdfplumber.open(path) as pdf:
                for page in pdf.pages:
                    content = page.extract_text()
                    if content: text += content + "\n"
            return text.strip()
        except Exception as e:
            print(f"[ERREUR] Lecture PDF : {e}")
            return ""

    def cosine_similarity(self, v1, v2):
        """Calcul haute performance via Numpy."""
        v1, v2 = np.array(v1), np.array(v2)
        return np.dot(v1, v2) / (np.linalg.norm(v1) * np.linalg.norm(v2))

    def find_matches(self, top_n=5):
        raw_text = self.extract_cv_text(CV_PATH)
        if not raw_text: return

        print(f"[INFO] Analyse sémantique du CV...")
        cv_embedding = self.model.encode(raw_text).tolist()

        # Récupération de toutes les offres
        all_offers = list(self.collection.find({}, {"metadata": 1, "embedding": 1}))

        results = []
        for offer in all_offers:
            score = self.cosine_similarity(cv_embedding, offer['embedding'])
            results.append({
                "titre": offer['metadata'].get('titre', 'Inconnu'),
                "entreprise": offer['metadata'].get('entreprise', 'N/A'),
                "score": round(score * 100, 2)
            })

        # Tri par score décroissant
        results = sorted(results, key=lambda x: x['score'], reverse=True)

        print("\n" + "═" * 50)
        print(f" MATCHING IA : TOP {top_n} OFFRES POUR VOTRE PROFIL")
        print("═" * 50)
        for i, res in enumerate(results[:top_n], 1):
            print(f"{i}. [{res['score']}%] {res['titre']} @ {res['entreprise']}")
        print("═" * 50)


if __name__ == "__main__":
    engine = CRMAtchingEngine()
    engine.find_matches()