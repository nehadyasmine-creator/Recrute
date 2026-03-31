import csv
import datetime
import os
import bcrypt
from random import shuffle
from random import randint

dossier_actuel = os.path.dirname(os.path.abspath(__file__))
chemin_csv = os.path.join(dossier_actuel, 'offres_indeed_extraites.csv')

chemin_sql = os.path.abspath(
    os.path.join(dossier_actuel, '..', 'recrute-backend', 'src', 'main', 'resources', 'data.sql'))

entreprises_traitees = set()

with open(chemin_csv, mode='r', encoding='utf-8') as file_in, \
        open(chemin_sql, mode='a', encoding='utf-8') as file_out:
    # SOLUTION : On lit tout le CSV et on le stocke dans une liste en mémoire
    lignes_csv = list(csv.DictReader(file_in))

    file_out.write('-- Entreprises\n')

    # Première boucle sur la liste
    for row in lignes_csv:
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

    file_out.write('\n-- Utilisateurs\n')  # Petit retour à la ligne ajouté pour la propreté du SQL

    prenoms = ['Yasmine', 'Malo', 'Gaetan', 'Martin', 'Pierre', 'Clément', 'Thomas', 'Ilyes', 'Christophe', 'Sabine']
    shuffle(prenoms)
    noms = ['Nehad', 'Dufournier', 'Puiseux', 'Ladan', 'Ingrachen', 'Martinez', 'Dupont', 'Bennacer', 'Denis', 'Lopes']
    shuffle(noms)
    i = 0

    # On réinitialise bien les entreprises traitées pour la table Utilisateur
    entreprises_traitees = set()

    # Deuxième boucle sur la MÊME liste
    for row in lignes_csv:
        nom_entreprise = row['entreprise']
        nom = noms[i // 10]
        prenom = prenoms[i % 10]
        email = nom + prenom + '@gmail.com'
        telephone = '+33' + str(randint(600000000, 799999999))
        motdepasse_clair = nom + prenom
        role = 'recruteur'
        dateCreation = datetime.date.today()

        if nom_entreprise not in entreprises_traitees:
            nom_echappe = nom.replace("'", "''")
            prenom_echappe = prenom.replace("'", "''")
            email_echappe = email.replace("'", "''")

            # --- MODIFICATION ICI : Hachage du mot de passe ---
            sel = bcrypt.gensalt(rounds=10)
            motdepasse_hashe = bcrypt.hashpw(motdepasse_clair.encode('utf-8'), sel).decode('utf-8')
            # --------------------------------------------------

            # On utilise motdepasse_hashe dans l'insertion
            requete_sql = (
                f"INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES"
                f" ('{nom_echappe}', '{prenom_echappe}', '{email_echappe}'"
                f", '{telephone}', '{motdepasse_hashe}', '{role}','{dateCreation}');\n")

            file_out.write(requete_sql)
            entreprises_traitees.add(nom_entreprise)
            i += 1

print(f"Les requêtes SQL ont été générées avec succès dans : {chemin_sql}")