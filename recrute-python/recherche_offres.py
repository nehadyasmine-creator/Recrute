import os
import pdfplumber
import numpy as np
from pymongo import MongoClient
from sentence_transformers import SentenceTransformer
from fastapi import FastAPI, UploadFile, File
from fastapi.middleware.cors import CORSMiddleware
import uvicorn

# --- CONFIGURATION ---
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
        # Sécurité pour éviter la division par zéro
        norm_v1 = np.linalg.norm(v1)
        norm_v2 = np.linalg.norm(v2)
        if norm_v1 == 0 or norm_v2 == 0:
            return 0.0
        return np.dot(v1, v2) / (norm_v1 * norm_v2)

    def find_matches(self, cv_path, top_n=5):
        raw_text = self.extract_cv_text(cv_path)
        if not raw_text: return []

        cv_embedding = self.model.encode(raw_text).tolist()

        all_offers = list(self.collection.find({}, {"metadata": 1, "embedding": 1}))

        # 👇 AJOUTE CETTE LIGNE POUR VÉRIFIER LA CONNEXION
        print(f"[DEBUG] Offres recuperees dans la BD : {len(all_offers)}")

        results = []
        for offer in all_offers:
            if 'embedding' not in offer:
                # 👇 AJOUTE CETTE LIGNE POUR VÉRIFIER LES DONNÉES
                print(f"[ATTENTION] L'offre {offer.get('_id')} n'a pas d'embedding !")
                continue

            score = self.cosine_similarity(cv_embedding, offer['embedding'])

            metadata = offer.get('metadata', {})
            results.append({
                "idOffre": metadata.get('id_offre_sql'),
                "titre": metadata.get('titre', 'Inconnu'),
                "entreprise": metadata.get('entreprise', 'N/A'),
                "score": round(score * 100, 2)
            })

        results = sorted(results, key=lambda x: x['score'], reverse=True)
        return results[:top_n]


if __name__ == "__main__":
    app = FastAPI()

    # Autorise Angular (CORS) à lire les données Python
    app.add_middleware(
        CORSMiddleware,
        allow_origins=["*"],
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

    engine = CRMAtchingEngine()

    # Route POST exclusive pour analyser un fichier envoyé par l'utilisateur
    @app.post("/api/match-cv")
    async def api_match_file(file: UploadFile = File(...)):
        print(f"\n{'=' * 50}")
        print(f"[INPUT] NOUVELLE REQUETE RECUE")
        print(f"[INFO] Nom du fichier : {file.filename}")
        print(f"[INFO] Type de fichier : {file.content_type}")

        temp_path = f"temp_{file.filename}"
        try:
            file_content = await file.read()
            print(f"[INFO] Taille du fichier : {len(file_content)} octets")

            if len(file_content) == 0:
                print("[ERREUR] Le fichier recu est vide !")
                return []

            with open(temp_path, "wb") as buffer:
                buffer.write(file_content)

            raw_text = engine.extract_cv_text(temp_path)
            print(f"[PROCESSING] Texte extrait du PDF : {len(raw_text)} caracteres.")
            if len(raw_text) == 0:
                print("[ATTENTION] pdfplumber n'a trouve aucun texte dans ce PDF.")

            print(f"[PROCESSING] Lancement de l'IA...")
            suggestions = engine.find_matches(temp_path)

            print(f"[OUTPUT] Renvoi de {len(suggestions)} resultats au site :")
            import json
            print(json.dumps(suggestions, indent=2))
            print(f"{'=' * 50}\n")

            return suggestions

        except Exception as e:
            print(f"[CRASH] Une erreur s'est produite : {e}")
            return []

        finally:
            if os.path.exists(temp_path):
                os.remove(temp_path)
    # Lancement de l'API
    uvicorn.run(app, host="0.0.0.0", port=8000)