import os
import time
import random
from seleniumbase import SB

# Requête modifiée pour la France entière
BASE_URL = "https://fr.indeed.com/jobs?q=ing%C3%A9nieur&l=France"
TARGET_COUNT = 2
HTML_DIR = "html"


def save_html(path, html):
    with open(path, "w", encoding="utf-8") as f:
        f.write(html)
    print(f"[+] Fichier sauvegardé : {path}")


def fetch_100_offers():
    # Création du dossier html s'il n'existe pas
    os.makedirs(HTML_DIR, exist_ok=True)

    collected_links = []
    start_index = 0

    print("[+] Lancement du navigateur en mode furtif (Undetected)...")

    with SB(uc=True, headless=False, test=True) as sb:

        # ==========================================
        # ÉTAPE 1 : Collecte des 100 liens d'offres
        # ==========================================
        print(f"[*] Début de la collecte des liens (Objectif : {TARGET_COUNT})...")

        while len(collected_links) < TARGET_COUNT:
            # Construction de l'URL avec la pagination (0, 10, 20...)
            page_url = f"{BASE_URL}&start={start_index}"
            print(f"[+] Navigation vers la page de recherche : {page_url}")

            sb.driver.uc_open_with_reconnect(page_url, reconnect_time=5)
            # Pause aléatoire pour contourner les protections
            time.sleep(random.uniform(4, 7))

            try:
                sb.wait_for_element('a.jcs-JobTitle', timeout=15)
            except Exception:
                print("[-] Impossible de charger les résultats (fin des pages ou blocage).")
                break

            job_link_elements = sb.find_elements('a.jcs-JobTitle')

            if not job_link_elements:
                print("[-] Aucun lien trouvé sur cette page, arrêt de la collecte.")
                break

            for element in job_link_elements:
                href = element.get_attribute("href")
                if href:
                    absolute_url = href if href.startswith("http") else f"https://fr.indeed.com{href}"
                    # Éviter les doublons
                    if absolute_url not in collected_links:
                        collected_links.append(absolute_url)

                    # Arrêt dès que le compte est atteint
                    if len(collected_links) >= TARGET_COUNT:
                        break

            # Passage à la page suivante (Indeed incrémente souvent par 10)
            start_index += 10

        print(f"\n[+] {len(collected_links)} liens d'offres uniques extraits. Début du scraping...")
        print("-" * 50)

        # ==========================================
        # ÉTAPE 2 : Visite et extraction du HTML
        # ==========================================
        for index, job_url in enumerate(collected_links, start=1):
            print(f"[*] Visite de l'offre {index}/{len(collected_links)}")

            sb.driver.uc_open_with_reconnect(job_url, reconnect_time=4)

            try:
                sb.wait_for_element('div#jobDescriptionText', timeout=10)
                print(f"[+] Offre {index} chargée avec succès.")
            except Exception:
                print(f"[-] L'offre {index} a mis trop de temps à charger (ou présence de captcha).")

            # Récupération du code source
            html_content = sb.driver.page_source

            # Sauvegarde immédiate dans le dossier html
            filename = os.path.join(HTML_DIR, f"indeed_offre_{index}.html")
            save_html(filename, html_content)

            # Pause aléatoire entre chaque visite pour ne pas trigger les sécurités
            time.sleep(random.uniform(5, 9))


if __name__ == "__main__":
    try:
        fetch_100_offers()
        print("\n[+] Opération terminée avec succès.")
    except Exception as e:
        print(f"[!] Erreur critique : {e}")