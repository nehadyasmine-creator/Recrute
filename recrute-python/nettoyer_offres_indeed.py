import re
import datetime
from bs4 import BeautifulSoup

def extraire_donnees_offre(fichier_path):
    # Initialisation du dictionnaire
    offre = {
        "titre": None,
        "entreprise": None,
        "localisation": None,
        "salaire": None,
        "duree": None,
        "experience_requise": None,
        "type_contrat": None,
        "date_debut": None,
        "date_publication": datetime.date.today(), # On peut l'assigner directement ici
        "teletravail": None,
        "description": None,
    }

    try:
        with open(fichier_path, "r", encoding="utf-8") as f:
            # On parse le fichier une seule fois
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

                # --- 3. INTEGÉRATION MÉTHODE 1 (Analyse NLP basique via Regex) ---
                desc_lower = description_texte.lower()

                # Télétravail
                if "télétravail" in desc_lower or "remote" in desc_lower or "hybride" in desc_lower:
                    if "100% télétravail" in desc_lower or "full remote" in desc_lower:
                        offre["teletravail"] = "100% Distanciel"
                    elif "hybride" in desc_lower:
                        offre["teletravail"] = "Hybride"
                    else:
                        offre["teletravail"] = "Oui (à vérifier)"

                # Expérience requise (ex: "3 ans d'expérience", "2 à 5 ans")
                match_exp = re.search(r'(\d+)\s*(?:à|-)?\s*(\d+)?\s*(?:ans|années)\s*(?:d\'|d’)?expérience', desc_lower)
                if match_exp:
                    offre["experience_requise"] = match_exp.group(0)

                # Date de début
                if "dès que possible" in desc_lower or "asap" in desc_lower:
                    offre["date_debut"] = "Dès que possible"
                else:
                    match_date = re.search(r'à partir de (janvier|février|mars|avril|mai|juin|juillet|août|septembre|octobre|novembre|décembre)', desc_lower)
                    if match_date:
                        offre["date_debut"] = match_date.group(0).capitalize()

                # Durée (surtout utile si c'est un stage ou un CDD)
                if offre["type_contrat"] and ("stage" in offre["type_contrat"].lower() or "cdd" in offre["type_contrat"].lower()):
                    match_duree = re.search(r'(\d+)\s*(?:à|-)?\s*(\d+)?\s*mois', desc_lower)
                    if match_duree:
                        offre["duree"] = match_duree.group(0)

    except Exception as e:
        print(f"[-] Erreur lors de l'analyse du fichier {fichier_path} : {e}")

    return offre

# --- Test du script ---
if __name__ == "__main__":
    fichier_test = "indeed_offre_1.html"
    donnees = extraire_donnees_offre(fichier_test)

    print("\n[+] Données extraites :")
    for cle, valeur in donnees.items():
        if cle == "description" and valeur:
            print(f"  - {cle.capitalize()} : {valeur[:80]}... (tronqué)")
        else:
            print(f"  - {cle.capitalize()} : {valeur}")


# --- Test du script ---
if __name__ == "__main__":
    # Remplace par le nom de ton fichier HTML sauvegardé
    fichier_test = "indeed_offre_1.html"

    offre = extraire_donnees_offre(fichier_test)


    print("\n[+] Données extraites :")
    for cle, valeur in offre.items():
        if cle == "description" and valeur:
            print(f"  - {cle.capitalize()} : {valeur[:100]}... (tronqué)")
        else:
            print(f"  - {cle.capitalize()} : {valeur}")
