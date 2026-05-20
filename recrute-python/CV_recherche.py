import os
import pdfplumber
import numpy as np
from pymongo import MongoClient
from sentence_transformers import SentenceTransformer
from fastapi import FastAPI, UploadFile, File
from fastapi.middleware.cors import CORSMiddleware # <--- AJOUT OBLIGATOIRE
import uvicorn

# --- CONFIGURATION ---
CV_PATH = "CV_axel_guenot.pdf"
MODEL_NAME = "sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2"
MONGO_URI = "mongodb://localhost:27017/"
DB_NAME = "recrute_mongo"
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
        v1, v2 = np.array(v1), np.array(v2)
        return np.dot(v1, v2) / (np.linalg.norm(v1) * np.linalg.norm(v2))

    def find_matches(self, cv_path=CV_PATH, top_n=5):
        raw_text = self.extract_cv_text(cv_path)
        if not raw_text: return []

        print(f"[INFO] Analyse sémantique du CV...")
        cv_embedding = self.model.encode(raw_text).tolist()

        all_offers = list(self.collection.find({}, {"metadata": 1, "embedding": 1}))

        results = []
        for offer in all_offers:
            score = self.cosine_similarity(cv_embedding, offer['embedding'])
            results.append({
                "idOffre": str(offer.get('_id', '')),
                "titre": offer['metadata'].get('titre', 'Inconnu'),
                "entreprise": offer['metadata'].get('entreprise', 'N/A'),
                "score": round(score * 100, 2)
            })

        results = sorted(results, key=lambda x: x['score'], reverse=True)
        return results[:top_n]


if __name__ == "__main__":
    app = FastAPI()

    # ANTI-ERREUR 1 : Autorise Angular (CORS) à lire les données Python
    app.add_middleware(
        CORSMiddleware,
        allow_origins=["*"],
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

    engine = CRMAtchingEngine()

    # ANTI-ERREUR 2 : Route POST si vous envoyez un fichier physique un jour
    @app.post("/api/match-cv")
    async def api_match_file(file: UploadFile = File(...)):
        temp_path = f"temp_{file.filename}"
        with open(temp_path, "wb") as buffer:
            buffer.write(await file.read())
        suggestions = engine.find_matches(temp_path)
        if os.path.exists(temp_path):
            os.remove(temp_path)
        return suggestions

    # ANTI-ERREUR 3 : Route GET pour répondre à la méthode Angular (getIASuggestions)
    @app.get("/api/match-cv/{candidat_id}")
    async def api_match_id(candidat_id: str):
        # Pour que ça marche instantanément sans erreur de base de données,
        # on utilise le CV par défaut déclaré dans la configuration.
        return engine.find_matches(CV_PATH)

    # Lancement de l'API
    uvicorn.run(app, host="0.0.0.0", port=8000)