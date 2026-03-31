import os
import csv
import json
import time
import datetime
from bs4 import BeautifulSoup
from dotenv import load_dotenv

from openai import OpenAI

# --- Configuration de l'API OpenAI via le fichier .env ---
load_dotenv()

# Récupère la clé API de manière sécurisée
VOTRE_CLE_API = os.getenv("OPENAI_API_KEY")

if not VOTRE_CLE_API:
    raise ValueError("Erreur : La clé API est introuvable. Avez-vous bien créé le fichier .env avec OPENAI_API_KEY ?")

# Initialisation du client OpenAI
# Note : par défaut, OpenAI() lit directement os.getenv("OPENAI_API_KEY"),
# mais la passer explicitement permet de garder la même logique que votre code initial.
client = OpenAI(api_key=VOTRE_CLE_API)

# --- Configuration des dossiers et fichiers ---
HTML_DIR = "html"
OUTPUT_CSV = "offres_indeed_extraites.csv"

def extraire_donnees_offre(fichier_path):
    # Initialisation du dictionnaire
    offre = {
        "fichier_source": os.path.basename(fichier_path),
        "titre": None,
        "entreprise": None,
        "secteur" : None,
        "localisation": None,
        "salaire": None,
        "site_web" : None,
        "duree": None,
        "experience_requise": None,
        "type_contrat": None,
        "date_debut": None,
        "date_publication": datetime.date.today().strftime("%Y-%m-%d"),
        "teletravail": None,
        "description": None,
    }

    try:
        with open(fichier_path, "r", encoding="utf-8") as f:
            soup = BeautifulSoup(f, 'lxml')

            # --- 1. Extraction des métadonnées standard (BeautifulSoup) ---
            titre_el = soup.find('h1', attrs={'data-testid': 'jobsearch-JobInfoHeader-title'})
            if titre_el:
                offre["titre"] = titre_el.text.strip()

            entreprise_el = soup.find(attrs={'data-testid': 'inlineHeader-companyName'})
            if entreprise_el:
                offre["entreprise"] = entreprise_el.text.strip()

            localisation_el = soup.find(attrs={'data-testid': 'inlineHeader-companyLocation'})
            if localisation_el:
                offre["localisation"] = localisation_el.text.strip()

            details_el = soup.find('div', id='salaryInfoAndJobType')
            if details_el:
                details_text = details_el.text.strip()

                if '€' in details_text:
                    parts = details_text.split('-')
                    salaire_parts = [ligne for ligne in parts if '€' in ligne]
                    if salaire_parts:
                        offre["salaire"] = salaire_parts[0].strip(' ')

                mots_cles_contrat = ['CDI', 'CDD', 'Freelance', 'Stage', 'Alternance', 'Temps plein', 'Temps partiel']
                contrats_trouves = [mot for mot in mots_cles_contrat if mot.lower() in details_text.lower()]
                if contrats_trouves:
                    offre["type_contrat"] = ", ".join(contrats_trouves)

            # --- 2. Extraction de la description ---
            desc_el = soup.find('div', id='jobDescriptionText')
            if desc_el:
                description_texte = desc_el.get_text(separator='\n').strip()
                offre["description"] = description_texte

                prompt = f"""
                Tu es un assistant spécialisé dans l'analyse de données RH.
                Analyse la description d'offre d'emploi ci-dessous et extrais les informations demandées.

                Les clés du JSON doivent être exactement celles-ci :
                - "secteur" : secteur de l'entreprise en un mot basé sur le nom de l'entreprise et la description (ex : "Informatique", "Aéronautique") 
                - "teletravail": "100% Distanciel", "Hybride", "Oui" ou null si non mentionné
                - "experience_requise": la durée minimale (ex: "2 ans", "3 ans", "5 ans", pas "3 à 5 ans") ou null si non mentionné
                - "date_debut": la période (ex: "Dès que possible", "Septembre") ou null si non mentionné
                - "duree": la durée du contrat (ex: "6 mois", "1 an") ou null si CDI ou non mentionné
                - "salaire" : nettoyer le salaire minimal proposé sous la forme d'un entier (ex : 1000, 40000 ) ou null si non mentionné
                - "localisation" : nettoyer le lieu de stage et ne renvoyer que la ville (ex : "Pantin", "Paris", "Lyon") ou null si non mentionné
                - "site_web" : trouver le site web de l'entreprise sachant son nom

                Description de l'offre :
                entreprise : {offre["entreprise"]}
                localisation : {offre["localisation"]}
                salaire : {offre["salaire"]}
                {description_texte}
                """

                try:
                    reponse = client.chat.completions.create(
                        model="gpt-4o-mini",  # L'équivalent rapide et économique (comme le modèle Flash)
                        messages=[
                            {"role": "user", "content": prompt}
                        ],
                        response_format={"type": "json_object"}
                    )
                    contenu = reponse.choices[0].message.content

                    donnees_extraites = json.loads(contenu)

                    offre["teletravail"] = donnees_extraites.get("teletravail", offre["teletravail"])
                    offre["experience_requise"] = donnees_extraites.get("experience_requise",
                                                                        offre["experience_requise"])
                    offre["date_debut"] = donnees_extraites.get("date_debut", offre["date_debut"])
                    offre["duree"] = donnees_extraites.get("duree", offre["duree"])
                    offre["localisation"] = donnees_extraites.get("localisation", offre["localisation"])
                    offre["salaire"] = donnees_extraites.get("salaire", offre["salaire"])
                    offre["secteur"] = donnees_extraites.get("secteur", offre["secteur"])
                    offre["site_web"] = donnees_extraites.get("site_web", offre["site_web"])
                    if offre["salaire"] is not None:
                        if offre["salaire"] < 10000:
                            offre["salaire"] = offre["salaire"]*12


                except Exception as e_api:
                    print(f"[-] Erreur lors de l'appel à l'API OpenAI pour {os.path.basename(fichier_path)} : {e_api}")

    except Exception as e:
        print(f"[-] Erreur lors de la lecture du fichier {fichier_path} : {e}")

    return offre


def traiter_dossier_html():
    if not os.path.exists(HTML_DIR):
        print(f"[!] Le dossier '{HTML_DIR}' n'existe pas. Veuillez lancer le scraper d'abord.")
        return

    fichiers_html = [f for f in os.listdir(HTML_DIR) if f.endswith('.html')]

    if not fichiers_html:
        print(f"[-] Aucun fichier HTML trouvé dans le dossier '{HTML_DIR}'.")
        return

    print(f"[*] Début de l'analyse de {len(fichiers_html)} offres...")
    toutes_les_offres = []

    # Boucle sur chaque fichier du dossier
    for index, nom_fichier in enumerate(fichiers_html, start=1):
        chemin_complet = os.path.join(HTML_DIR, nom_fichier)
        print(f"[{index}/{len(fichiers_html)}] Traitement de {nom_fichier} avec OpenAI...")

        donnees = extraire_donnees_offre(chemin_complet)
        toutes_les_offres.append(donnees)

        if index < len(fichiers_html):
            time.sleep(6.1)

    # Sauvegarde des données dans un fichier CSV
    if toutes_les_offres:
        colonnes = toutes_les_offres[0].keys()

        with open(OUTPUT_CSV, 'w', newline='', encoding='utf-8') as fichier_csv:
            writer = csv.DictWriter(fichier_csv, fieldnames=colonnes)
            writer.writeheader()
            writer.writerows(toutes_les_offres)

        print(f"\n[+] Succès ! {len(toutes_les_offres)} offres ont été extraites.")
        print(f"[+] Les données ont été sauvegardées dans : {OUTPUT_CSV}")
    else:
        print("\n[-] Aucune donnée n'a pu être extraite.")


if __name__ == "__main__":
    traiter_dossier_html()