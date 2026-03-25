import os
import time
import random
import urllib.parse
from seleniumbase import SB

TARGET_COUNT = 20
HTML_DIR = "html"

# Listes étoffées pour garantir +100 offres uniques rien qu'avec les "Pages 1"
MOTS_CLES = ["ingénieur système", "ingénieur data", "ingénieur mécanique", "ingénieur logiciel", "ingénieur cloud",
             "ingénieur devops", "ingénieur réseau", "ingénieur IA"]
VILLES = ["Paris", "Lyon", "Toulouse", "Nantes", "Lille", "Bordeaux", "Rennes", "Strasbourg", "Montpellier"]


def extraire_sans_paginer_ni_date():
    os.makedirs(HTML_DIR, exist_ok=True)

    collected_links = set()
    objectif_atteint = False

    print("[!] Mode Hit & Run : 1 requête = 1 navigateur neuf. Zéro pagination. Zéro filtre de date.")

    # --- ÉTAPE 1 : COLLECTE DES LIENS ---
    for ville in VILLES:
        if objectif_atteint: break

        for mot_cle in MOTS_CLES:
            if len(collected_links) >= TARGET_COUNT:
                objectif_atteint = True
                break

            print(f"\n[*] Lancement navigateur jetable : '{mot_cle}' à {ville}")

            with SB(uc=True, headless=False, test=True, incognito=True) as sb:
                query_encoded = urllib.parse.quote(mot_cle)
                loc_encoded = urllib.parse.quote(ville)

                # URL ciblant la PAGE 1 UNIQUEMENT, basique
                page_url = f"https://fr.indeed.com/jobs?q={query_encoded}&l={loc_encoded}"

                sb.driver.uc_open_with_reconnect(page_url, reconnect_time=5)
                time.sleep(random.uniform(3, 5))

                try:
                    # Nettoyage des pop-ups
                    sb.execute_script(
                        "document.querySelectorAll('.icl-Modal, .icl-Modal-backdrop').forEach(e => e.remove()); document.body.style.overflow = 'auto';")

                    sb.wait_for_element('a.jcs-JobTitle', timeout=8)
                    elements = sb.find_elements('a.jcs-JobTitle')

                    for el in elements:
                        href = el.get_attribute("href")
                        if href:
                            clean_url = href.split("?")[0] if "viewjob" in href else href
                            absolute_url = clean_url if clean_url.startswith(
                                "http") else f"https://fr.indeed.com{clean_url}"
                            collected_links.add(absolute_url)

                    print(
                        f"[+] {len(elements)} offres vues sur cette page. Total provisoire : {len(collected_links)}/{TARGET_COUNT}")

                except Exception:
                    print("[-] Aucun résultat ou captcha. Fermeture immédiate et passage au suivant.")

    liens_finaux = list(collected_links)[:TARGET_COUNT]
    print(f"\n[+] Collecte terminée : {len(liens_finaux)} liens uniques obtenus.")
    print("-" * 50)

    # --- ÉTAPE 2 : TÉLÉCHARGEMENT DES OFFRES ---
    print("\n[*] Lancement d'un navigateur unique pour le téléchargement de toutes les offres...")

    # Le navigateur s'ouvre UNE SEULE FOIS pour toute la phase 2
    with SB(uc=True, headless=False, test=True, incognito=True) as sb:
        for index, job_url in enumerate(liens_finaux, start=1):
            print(f"[*] Visite de l'offre {index}/{len(liens_finaux)}")

            sb.driver.uc_open_with_reconnect(job_url, reconnect_time=4)

            try:
                sb.execute_script(
                    "document.querySelectorAll('.icl-Modal, .icl-Modal-backdrop').forEach(e => e.remove()); document.body.style.overflow = 'auto';")
                sb.wait_for_element('div#jobDescriptionText', timeout=8)

                html_content = sb.driver.page_source
                filename = os.path.join(HTML_DIR, f"indeed_offre_{index}.html")

                with open(filename, "w", encoding="utf-8") as f:
                    f.write(html_content)
                print(f"[+] Fichier sauvegardé avec succès.")

            except Exception:
                print(f"[-] Impossible de lire l'offre {index} (Captcha ou page introuvable).")

            # Pause aléatoire vitale pour ne pas se faire bloquer dans cette session unique
            time.sleep(random.uniform(4, 8))


if __name__ == "__main__":
    try:
        extraire_sans_paginer_ni_date()
        print("\n[+] Opération finale terminée.")
    except Exception as e:
        print(f"[!] Erreur critique : {e}")