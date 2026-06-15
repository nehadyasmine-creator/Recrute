import os
import pdfplumber
import numpy as np
import json
from typing import List
from pymongo import MongoClient
from sentence_transformers import SentenceTransformer
from fastapi import FastAPI, UploadFile, File, Form
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import uvicorn

MODEL_NAME = "sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2"
MONGO_URI = "mongodb://localhost:27017/"
DB_NAME = "recrute_mongo"


class OfferRequest(BaseModel):
    titre: str = ""
    description: str = ""


class CRMAtchingEngine:
    def __init__(self):
        print(f"[INFO] Chargement du moteur de matching...")
        self.model = SentenceTransformer(MODEL_NAME)
        self.client = MongoClient(MONGO_URI)
        self.db = self.client[DB_NAME]

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
        norm_v1 = np.linalg.norm(v1)
        norm_v2 = np.linalg.norm(v2)
        if norm_v1 == 0 or norm_v2 == 0:
            return 0.0
        return np.dot(v1, v2) / (norm_v1 * norm_v2)

    def find_matches_for_cv(self, cv_path, top_n=5):
        raw_text = self.extract_cv_text(cv_path)
        if not raw_text: return []

        cv_embedding = self.model.encode(raw_text).tolist()
        all_offers = list(self.db["offres"].find({}, {"metadata": 1, "embedding": 1}))

        results = []
        for offer in all_offers:
            if 'embedding' not in offer: continue
            score = self.cosine_similarity(cv_embedding, offer['embedding'])
            metadata = offer.get('metadata', {})
            results.append({
                "idOffre": metadata.get('id_offre_sql'),
                "titre": metadata.get('titre', 'Inconnu'),
                "entreprise": metadata.get('entreprise', 'N/A'),
                "score": round(score * 100, 2)
            })

        return sorted(results, key=lambda x: x['score'], reverse=True)[:top_n]

    def find_matches_for_offer(self, offer_text, top_n=5):
        if not offer_text.strip(): return []

        offer_embedding = self.model.encode(offer_text).tolist()
        all_candidates = list(self.db["candidats"].find({}, {"metadata": 1, "embedding": 1}))

        results = []
        for candidat in all_candidates:
            if 'embedding' not in candidat: continue
            score = self.cosine_similarity(offer_embedding, candidat['embedding'])
            metadata = candidat.get('metadata', {})
            results.append({
                "idCandidat": metadata.get('id_candidat_sql'),
                "idUtilisateur": metadata.get('id_utilisateur_sql'),
                "prenom": metadata.get('prenom', 'Inconnu'),
                "nom": metadata.get('nom', 'Inconnu'),
                "ville": metadata.get('ville', 'Inconnue'),
                "typeContrat": metadata.get('type_contrat', 'Inconnu'),
                "score": round(score * 100, 2)
            })

        return sorted(results, key=lambda x: x['score'], reverse=True)[:top_n]

    def compare_specific_cvs(self, offer_text, cv_files_data):
        if not offer_text.strip() or not cv_files_data: return []

        print("[PROCESSING] Encodage de l'offre de référence...")
        offer_embedding = self.model.encode(offer_text).tolist()
        
        results = []
        for cv_data in cv_files_data:
            path = cv_data['path']
            filename = cv_data['filename']

            raw_text = self.extract_cv_text(path)
            
            if not raw_text:
                print(f"[ATTENTION] Impossible d'extraire le texte de {filename}")
                score = 0.0
            else:
                cv_embedding = self.model.encode(raw_text).tolist()
                score = self.cosine_similarity(offer_embedding, cv_embedding)

            results.append({
                "nomFichier": filename,
                "score": round(score * 100, 2)
            })

        return sorted(results, key=lambda x: x['score'], reverse=True)


if __name__ == "__main__":
    app = FastAPI()

    app.add_middleware(
        CORSMiddleware,
        allow_origins=["*"],
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

    engine = CRMAtchingEngine()

    @app.post("/api/match-cv")
    async def api_match_file(file: UploadFile = File(...)):
        temp_path = f"temp_{file.filename}"
        try:
            file_content = await file.read()
            if len(file_content) == 0: return []
            with open(temp_path, "wb") as buffer: buffer.write(file_content)
            return engine.find_matches_for_cv(temp_path)
        except Exception as e:
            return []
        finally:
            if os.path.exists(temp_path): os.remove(temp_path)

    @app.post("/api/match-offer")
    async def api_match_offer(offer: OfferRequest):
        try:
            full_content = f"{offer.titre}. {offer.description}"
            return engine.find_matches_for_offer(full_content)
        except Exception as e:
            return []

    @app.post("/api/compare-cvs")
    async def api_compare_cvs(
        titre: str = Form(...),
        description: str = Form(...),
        files: List[UploadFile] = File(...)
    ):
        print(f"\n{'=' * 50}")
        print(f"[INPUT] NOUVELLE REQUETE COMPARAISON DE {len(files)} CVs")
        print(f"[INFO] Offre de référence : {titre}")

        full_offer_text = f"{titre}. {description}"
        temp_files_info = []

        try:
            for file in files:
                temp_path = f"temp_comp_{file.filename}"
                content = await file.read()
                
                if len(content) > 0:
                    with open(temp_path, "wb") as buffer:
                        buffer.write(content)
                    temp_files_info.append({
                        "path": temp_path, 
                        "filename": file.filename
                    })

            if not temp_files_info:
                print("[ERREUR] Tous les fichiers reçus sont vides.")
                return []

            print(f"[PROCESSING] Lancement de l'analyse IA de groupe...")
            classement = engine.compare_specific_cvs(full_offer_text, temp_files_info)

            print(f"[OUTPUT] Renvoi du classement de {len(classement)} CVs :")
            print(json.dumps(classement, indent=2))
            print(f"{'=' * 50}\n")

            return classement

        except Exception as e:
            print(f"[CRASH] Une erreur s'est produite : {e}")
            return []

        finally:
            for info in temp_files_info:
                if os.path.exists(info['path']):
                    os.remove(info['path'])

    uvicorn.run(app, host="0.0.0.0", port=8000)