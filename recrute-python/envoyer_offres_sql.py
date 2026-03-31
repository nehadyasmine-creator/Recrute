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

# J'ai passé le mode en 'w' (write) pour écraser le fichier à chaque test, c'est plus sûr
with open(chemin_csv, mode='r', encoding='utf-8') as file_in, \
        open(chemin_sql, mode='w', encoding='utf-8') as file_out:
    lignes_csv = list(csv.DictReader(file_in))

    file_out.write('-- ==========================\n')
    file_out.write('-- Entreprises\n')
    file_out.write('-- ==========================\n')

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

    file_out.write('\n-- ==========================\n')
    file_out.write('-- Recruteurs (Utilisateurs)\n')
    file_out.write('-- ==========================\n')

    prenoms = ['Yasmine', 'Malo', 'Gaetan', 'Martin', 'Pierre', 'Clément', 'Thomas', 'Ilyes', 'Christophe', 'Sabine']
    shuffle(prenoms)
    noms = ['Nehad', 'Dufournier', 'Puiseux', 'Ladan', 'Ingrachen', 'Martinez', 'Dupont', 'Bennacer', 'Denis', 'Lopes']
    shuffle(noms)
    i = 0

    entreprises_traitees = set()

    # NOUVEAU : Dictionnaire pour mémoriser l'ID du recruteur par entreprise
    map_entreprise_recruteur = {}

    for row in lignes_csv:
        nom_entreprise = row['entreprise']
        nom = noms[(i // 10) % 10]
        prenom = prenoms[i % 10]
        email = prenom.lower() + '.' + nom.lower() + '@gmail.com'
        telephone = '+33' + str(randint(600000000, 799999999))
        motdepasse_clair = prenom + nom
        role = 'recruteur'
        dateCreation = datetime.date.today()

        if nom_entreprise not in entreprises_traitees:
            nom_echappe = nom.replace("'", "''")
            prenom_echappe = prenom.replace("'", "''")
            email_echappe = email.replace("'", "''")

            sel = bcrypt.gensalt(rounds=10)
            motdepasse_hashe = bcrypt.hashpw(motdepasse_clair.encode('utf-8'), sel).decode('utf-8')

            i += 1  # On incrémente l'ID

            requete_sql_utilisateur = (
                f"INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES"
                f" ('{nom_echappe}', '{prenom_echappe}', '{email_echappe}'"
                f", '{telephone}', '{motdepasse_hashe}', '{role}','{dateCreation}');\n")
            file_out.write(requete_sql_utilisateur)

            requete_sql_recruteur = (
                f"INSERT INTO Recruteur (id_utilisateur, id_entreprise, poste) VALUES"
                f" ({i}, {i}, 'Responsable RH');\n")
            file_out.write(requete_sql_recruteur)

            # On sauvegarde la correspondance entre l'entreprise et cet ID
            map_entreprise_recruteur[nom_entreprise] = i
            entreprises_traitees.add(nom_entreprise)

    file_out.write('\n-- ==========================\n')
    file_out.write('-- Offres\n')
    file_out.write('-- ==========================\n')

    # Troisième boucle : on parcourt TOUTES les lignes (plus de 'set' car on veut toutes les offres)
    # ... (Début de la 3ème boucle)
    for row in lignes_csv:
        nom_entreprise = row['entreprise']

        # 1. LIAISON CLÉ ÉTRANGÈRE (INT)
        id_recruteur = map_entreprise_recruteur[nom_entreprise]

        # 2. CHAÎNES DE CARACTÈRES (VARCHAR / TEXT) -> Échappement des apostrophes
        titre_echappe = row.get('titre', '').replace("'", "''")
        lieu_echappe = row.get('localisation', '').replace("'", "''")
        duree_echappe = row.get('duree', '').replace("'", "''")
        description_echappe = row.get('description', 'Description non fournie').replace("'", "''")

        # 3. ENUMERATIONS (contrat_type / statut_offre) -> Échappement comme des chaînes
        type_contrat_echappe = row.get('type_contrat', 'CDI').replace("'", "''")

        # 4. NOMBRES (INT / DECIMAL) -> Conversion propre + Pas de guillemets dans le SQL !
        # Gestion du salaire (DECIMAL 10,2) : on s'assure que c'est bien un float
        salaire_brut = row.get('salaire', '0')
        try:
            salaire = float(salaire_brut.replace(' ', '').replace(',', '.')) if salaire_brut else 0.0
        except ValueError:
            salaire = 0.0  # Fallback si le CSV contient du texte comme "Non renseigné"

        # Gestion de l'expérience (INT)
        exp_brute = row.get('experience_requise', '0')
        experience_requise = int(exp_brute) if exp_brute.isdigit() else 0

        # 5. DATES (DATE) -> Format YYYY-MM-DD entouré de guillemets simples
        date_debut_csv = row.get('date_debut', '').strip()
        date_debut_sql = f"'{date_debut_csv}'" if date_debut_csv else "NULL"
        date_publication = row.get('date_publication', str(datetime.date.today()))

        # 6. BOOLEAN -> Mot-clé SQL natif TRUE ou FALSE (sans guillemets)
        teletravail_brut = str(row.get('boolean', 'False')).strip().lower()
        teletravail_sql = 'TRUE' if teletravail_brut in ['true', '1', 'oui', 'yes'] else 'FALSE'

        # --- GÉNÉRATION DE LA REQUÊTE ---
        requete_sql_offre = (
            f"INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, "
            f"experience_requise, date_debut, date_publication, teletravail) VALUES "
            f"({id_recruteur}, '{titre_echappe}', '{description_echappe}', '{lieu_echappe}', '{type_contrat_echappe}', "
            f"{salaire}, '{duree_echappe}', {experience_requise}, '{date_debut_sql}', '{date_publication}', "
            f"'{teletravail_sql});\n"
        )

        file_out.write(requete_sql_offre)

print(f"Les requêtes SQL ont été générées avec succès dans : {chemin_sql}")