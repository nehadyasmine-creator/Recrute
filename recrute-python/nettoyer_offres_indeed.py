import os
import re
import csv
import datetime
from bs4 import BeautifulSoup

# Paramètres des dossiers et fichiers
HTML_DIR = "html"
OUTPUT_CSV = "offres_indeed_extraites.csv"


def extraire_donnees_offre(fichier_path):
    # Initialisation du dictionnaire
    offre = {
        "fichier_source": os.path.basename(fichier_path),  # Pratique pour le débogage
        "titre": None,
        "entreprise": None,
        "localisation": None,
        "salaire": None,
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

            # --- 1. Extraction des métadonnées standard ---
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
                    offre["salaire"] = [ligne for ligne in details_text.split('-') if '€' in ligne][0].strip()

                mots_cles_contrat = ['CDI', 'CDD', 'Freelance', 'Stage', 'Alternance', 'Temps plein', 'Temps partiel']
                contrats_trouves = [mot for mot in mots_cles_contrat if mot.lower() in details_text.lower()]
                if contrats_trouves:
                    offre["type_contrat"] = ", ".join(contrats_trouves)

            # --- 2. Extraction de la description ---
            desc_el = soup.find('div', id='jobDescriptionText')
            if desc_el:
                description_texte = desc_el.get_text(separator='\n').strip()
                offre["description"] = description_texte

                # --- 3. Analyse NLP basique via Regex ---
                desc_lower = description_texte.lower()

                # Télétravail
                if "télétravail" in desc_lower or "remote" in desc_lower or "hybride" in desc_lower:
                    if "100% télétravail" in desc_lower or "full remote" in desc_lower:
                        offre["teletravail"] = "100% Distanciel"
                    elif "hybride" in desc_lower:
                        offre["teletravail"] = "Hybride"
                    else:
                        offre["teletravail"] = "Oui (à vérifier)"

                # Expérience requise
                match_exp = re.search(r'(\d+)\s*(?:à|-)?\s*(\d+)?\s*(?:ans|années)\s*(?:d\'|d’)?expérience', desc_lower)
                if match_exp:
                    offre["experience_requise"] = match_exp.group(0)

                # Date de début
                if "dès que possible" in desc_lower or "asap" in desc_lower:
                    offre["date_debut"] = "Dès que possible"
                else:
                    match_date = re.search(
                        r'à partir de (janvier|février|mars|avril|mai|juin|juillet|août|septembre|octobre|novembre|décembre)',
                        desc_lower)
                    if match_date:
                        offre["date_debut"] = match_date.group(0).capitalize()

                # Durée
                if offre["type_contrat"] and (
                        "stage" in offre["type_contrat"].lower() or "cdd" in offre["type_contrat"].lower()):
                    match_duree = re.search(r'(\d+)\s*(?:à|-)?\s*(\d+)?\s*mois', desc_lower)
                    if match_duree:
                        offre["duree"] = match_duree.group(0)

    except Exception as e:
        print(f"[-] Erreur lors de l'analyse du fichier {fichier_path} : {e}")

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
    for nom_fichier in fichiers_html:
        chemin_complet = os.path.join(HTML_DIR, nom_fichier)
        donnees = extraire_donnees_offre(chemin_complet)
        toutes_les_offres.append(donnees)

    # Sauvegarde des données dans un fichier CSV
    colonnes = toutes_les_offres[0].keys()

    with open(OUTPUT_CSV, 'w', newline='', encoding='utf-8') as fichier_csv:
        writer = csv.DictWriter(fichier_csv, fieldnames=colonnes)
        writer.writeheader()
        writer.writerows(toutes_les_offres)

    print(f"\n[+] Succès ! {len(toutes_les_offres)} offres ont été extraites.")
    print(f"[+] Les données ont été sauvegardées dans : {OUTPUT_CSV}")


if __name__ == "__main__":
    traiter_dossier_html()