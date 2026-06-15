import os
import pdfplumber
import numpy as np
import json
from pymongo import MongoClient
from sentence_transformers import SentenceTransformer
from fastapi import FastAPI, UploadFile, File
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
import uvicorn

# --- CONFIGURATION ---
MODEL_NAME = "sentence-transformers/paraphrase-multilingual-MiniLM-L12-v2"
MONGO_URI = "mongodb://localhost:27017/"
DB_NAME = "recrute_mongo"


# --- MODELES DE REQUETE ---
# Modèle pour recevoir les données de l'offre depuis le site web
class OfferRequest(BaseModel):
    titre: str = ""
    description: str = ""


class CRMAtchingEngine:
    def __init__(self):
        print(f"[INFO] Chargement du moteur de matching...")
        self.model = SentenceTransformer(MODEL_NAME)
        self.client = MongoClient(MONGO_URI)
        # On accède directement à la DB pour pouvoir choisir la collection dynamiquement
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

    # ==========================================
    # MATCHING : CV -> OFFRES
    # ==========================================
    def find_matches_for_cv(self, cv_path, top_n=5):
        raw_text = self.extract_cv_text(cv_path)
        if not raw_text: return []

        cv_embedding = self.model.encode(raw_text).tolist()

        # Recherche dans la collection "offres"
        all_offers = list(self.db["offres"].find({}, {"metadata": 1, "embedding": 1}))

        print(f"[DEBUG] Offres récupérées dans la BD : {len(all_offers)}")

        results = []
        for offer in all_offers:
            if 'embedding' not in offer:
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

    # ==========================================
    # MATCHING : OFFRE -> CANDIDATS
    # ==========================================
    def find_matches_for_offer(self, offer_text, top_n=5):
        if not offer_text.strip(): return []

        # On encode le texte de l'offre envoyé par le site
        offer_embedding = self.model.encode(offer_text).tolist()

        # Recherche dans la collection "candidats"
        all_candidates = list(self.db["candidats"].find({}, {"metadata": 1, "embedding": 1}))

        print(f"[DEBUG] Candidats récupérés dans la BD : {len(all_candidates)}")

        results = []
        for candidat in all_candidates:
            if 'embedding' not in candidat:
                print(f"[ATTENTION] Le candidat {candidat.get('_id')} n'a pas d'embedding !")
                continue

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

        results = sorted(results, key=lambda x: x['score'], reverse=True)
        return results[:top_n]


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


    # --- ROUTE 1 : RECHERCHE D'OFFRES DEPUIS UN CV ---
    @app.post("/api/match-cv")
    async def api_match_file(file: UploadFile = File(...)):
        print(f"\n{'=' * 50}")
        print(f"[INPUT] NOUVELLE REQUETE CV -> OFFRES")
        print(f"[INFO] Nom du fichier : {file.filename}")

        temp_path = f"temp_{file.filename}"
        try:
            file_content = await file.read()
            if len(file_content) == 0:
                print("[ERREUR] Le fichier recu est vide !")
                return []

            with open(temp_path, "wb") as buffer:
                buffer.write(file_content)

            suggestions = engine.find_matches_for_cv(temp_path)

            print(f"[OUTPUT] Renvoi de {len(suggestions)} resultats au site.")
            print(f"{'=' * 50}\n")
            return suggestions

        except Exception as e:
            print(f"[CRASH] Une erreur s'est produite : {e}")
            return []
        finally:
            if os.path.exists(temp_path):
                os.remove(temp_path)


    # --- ROUTE 2 : RECHERCHE DE CANDIDATS DEPUIS UNE OFFRE ---
    @app.post("/api/match-offer")
    async def api_match_offer(offer: OfferRequest):
        print(f"\n{'=' * 50}")
        print(f"[INPUT] NOUVELLE REQUETE OFFRE -> CANDIDATS")
        print(f"[INFO] Titre de l'offre reçue : {offer.titre}")

        try:
            # On reproduit la logique d'assemblage du texte de ton DataIndexer
            full_content = f"{offer.titre}. {offer.description}"

            print(f"[PROCESSING] Lancement de l'IA de matching...")
            suggestions = engine.find_matches_for_offer(full_content)

            print(f"[OUTPUT] Renvoi de {len(suggestions)} candidats au site :")
            print(json.dumps(suggestions, indent=2))
            print(f"{'=' * 50}\n")

            return suggestions

        except Exception as e:
            print(f"[CRASH] Une erreur s'est produite : {e}")
            return []


    uvicorn.run(app, host="0.0.0.0", port=8000)