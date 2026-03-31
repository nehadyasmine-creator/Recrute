import csv
import os

dossier_actuel = os.path.dirname(os.path.abspath(__file__))
chemin_csv = os.path.join(dossier_actuel, 'offres_indeed_extraites.csv')

chemin_sql = os.path.abspath(
    os.path.join(dossier_actuel, '..', 'recrute-backend', 'src', 'main', 'resources', 'data.sql'))

entreprises_traitees = set()

with open(chemin_csv, mode='r', encoding='utf-8') as file_in, \
        open(chemin_sql, mode='a', encoding='utf-8') as file_out:
    reader = csv.DictReader(file_in)
    file_out.write('-- Entreprises\n')

    for row in reader:
        nom_entreprise = row['entreprise']
        siegesocial = row['localisation']
        secteur = row['secteur']
        site_web = row['site_web']

        if nom_entreprise not in entreprises_traitees:
            nom_echappe = nom_entreprise.replace("'", "''")
            siege_echappe = siegesocial.replace("'", "''")
            secteur_echappe = secteur.replace("'", "''")
            site_echappe = site_web.replace("'", "''")
            taille_echappe = "grand_groupe"

            requete_sql = (f"INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES"
                           f" ('{nom_echappe}', '{siege_echappe}', '{secteur_echappe}'"
                           f", '{site_echappe}', '{taille_echappe}');\n")

            file_out.write(requete_sql)

            entreprises_traitees.add(nom_entreprise)

print(f"Les requêtes SQL ont été générées avec succès dans : {chemin_sql}")