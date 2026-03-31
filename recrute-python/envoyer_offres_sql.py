import csv
import datetime
import os
import bcrypt
from random import shuffle
from random import randint
import textwrap

dossier_actuel = os.path.dirname(os.path.abspath(__file__))
chemin_csv = os.path.join(dossier_actuel, 'offres_indeed_extraites.csv')

chemin_sql = os.path.abspath(
    os.path.join(dossier_actuel, '..', 'recrute-backend', 'src', 'main', 'resources', 'data.sql'))

lignes_a_conserver = []
if os.path.exists(chemin_sql):
    with open(chemin_sql, mode='r', encoding='utf-8') as f:
        lignes_existantes = f.readlines()
        for i, ligne in enumerate(lignes_existantes):
            # On s'arrête dès qu'on détecte le début de la génération des entreprises
            if '-- ==========================' in ligne and i + 1 < len(lignes_existantes) and 'Entreprises' in \
                    lignes_existantes[i + 1]:
                break
            elif '-- Entreprises' in ligne:  # Cas de secours si le format des '=' a changé
                break
            lignes_a_conserver.append(ligne)

entreprises_traitees = set()

with open(chemin_csv, mode='r', encoding='utf-8') as file_in, \
        open(chemin_sql, mode='w', encoding='utf-8') as file_out:  # Mode 'w' car on réécrit l'entête nous-mêmes

    lignes_csv = list(csv.DictReader(file_in))

    # On réinjecte le contenu manuel qu'on a sauvegardé (s'il y en a)
    file_out.writelines(lignes_a_conserver)

    # Si le fichier ne se termine pas par un saut de ligne, on en ajoute un pour la propreté
    if lignes_a_conserver and not lignes_a_conserver[-1].endswith('\n'):
        file_out.write('\n\n')

    file_out.write('-- Entreprises\n')

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

    file_out.write('-- Recruteurs (Utilisateurs)\n')

    prenoms = ['Yasmine', 'Malo', 'Gaetan', 'Martin', 'Pierre', 'Clément', 'Thomas', 'Ilyes', 'Christophe', 'Sabine']
    shuffle(prenoms)
    noms = ['Nehad', 'Dufournier', 'Puiseux', 'Ladan', 'Ingrachen', 'Martinez', 'Dupont', 'Bennacer', 'Denis', 'Lopes']
    shuffle(noms)
    i = 0

    entreprises_traitees = set()
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

            i += 1

            requete_sql_utilisateur = (
                f"INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES"
                f" ('{nom_echappe}', '{prenom_echappe}', '{email_echappe}'"
                f", '{telephone}', '{motdepasse_hashe}', '{role}','{dateCreation}');\n")
            file_out.write(requete_sql_utilisateur)

            requete_sql_recruteur = (
                f"INSERT INTO Recruteur (id_utilisateur, id_entreprise, poste) VALUES"
                f" ({i}, {i}, 'Responsable RH');\n")
            file_out.write(requete_sql_recruteur)

            map_entreprise_recruteur[nom_entreprise] = i
            entreprises_traitees.add(nom_entreprise)

    file_out.write('\n-- ==========================\n')
    file_out.write('-- Offres\n')
    file_out.write('-- ==========================\n')

    for row in lignes_csv:
        nom_entreprise = row['entreprise']

        id_recruteur = map_entreprise_recruteur[nom_entreprise]

        titre_echappe = row.get('titre', '').replace("'", "''")
        lieu_echappe = row.get('localisation', '').replace("'", "''")
        duree_echappe = row.get('duree', '').replace("'", "''")
        description_echappe = row.get('description', 'Description non fournie').replace("'", "''")

        type_contrat_echappe = row.get('type_contrat', 'CDI').replace("'", "''")

        salaire_brut = row.get('salaire', '0')
        try:
            salaire = float(salaire_brut.replace(' ', '').replace(',', '.')) if salaire_brut else 0.0
        except ValueError:
            salaire = 0.0

        exp_brute = row.get('experience_requise', '0')
        experience_requise = int(exp_brute) if exp_brute.isdigit() else 0

        date_debut_csv = row.get('date_debut', '').strip()
        date_debut_sql = f"'{date_debut_csv}'" if date_debut_csv else "NULL"
        date_publication = row.get('date_publication', str(datetime.date.today()))

        teletravail_brut = str(row.get('boolean', 'False')).strip().lower()
        teletravail_sql = 'TRUE' if teletravail_brut in ['true', '1', 'oui', 'yes'] else 'FALSE'

        # CORRECTION DES GUILLEMETS DANS CETTE REQUÊTE :
        # 1. Enlevé les '' autour de {date_debut_sql} (car ils y sont déjà s'il y a une date)
        # 2. Corrigé la fin de la chaîne avant teletravail_sql
        requete_sql_offre = (
            f"INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, "
            f"experience_requise, date_debut, date_publication, teletravail) VALUES "
            f"({id_recruteur}, '{titre_echappe}', '{description_echappe}', '{lieu_echappe}', '{type_contrat_echappe}', "
            f"{salaire}, '{duree_echappe}', {experience_requise}, {date_debut_sql}, '{date_publication}', "
            f"{teletravail_sql});\n"
        )

        # ... (Fin de votre boucle for row in lignes_csv pour les offres)
        file_out.write(requete_sql_offre)
    requetes_manuelles = textwrap.dedent("""
                                         -- Candidats
                                         INSERT INTO Candidat (id_utilisateur, typeContrat, ville, disponibilite)
                                         VALUES (2, 'CDI', 'Paris', '2026-04-01'),
                                                (3, 'Freelance', 'Lyon', '2026-03-15');

                                         -- Compétences des candidats
                                         INSERT INTO CompetenceCandidat (id_candidat, id_competence, niveau)
                                         VALUES (1, 1, 'avance'),        -- Bob : Java avancé
                                                (1, 3, 'avance'),        -- Bob : Spring Boot avancé
                                                (1, 5, 'intermediaire'), -- Bob : Docker intermédiaire
                                                (2, 2, 'expert'),        -- Clara : Python expert
                                                (2, 4, 'intermediaire');
                                         -- Clara : React intermédiaire

                                         -- Compétences requises pour les offres
                                         INSERT INTO CompetenceOffre (id_offre, id_competence, obligatoire)
                                         VALUES (1, 1, true),  -- Offre Java : Java obligatoire
                                                (1, 3, true),  -- Offre Java : Spring Boot obligatoire
                                                (1, 5, false), -- Offre Java : Docker optionnel
                                                (2, 5, true),  -- Offre DevOps : Docker obligatoire
                                                (2, 6, true); -- Offre DevOps : SQL obligatoire
                                         """)

    file_out.write(requetes_manuelles)

# Fin du bloc 'with open(...)'
print(f"Les requêtes SQL ont été générées avec succès dans : {chemin_sql}")