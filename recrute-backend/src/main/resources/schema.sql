DROP TABLE IF EXISTS Messagerie;
DROP TABLE IF EXISTS Lien;
DROP TABLE IF EXISTS Candidature;
DROP TABLE IF EXISTS CompetenceCandidat;
DROP TABLE IF EXISTS CompetenceOffre;
DROP TABLE IF EXISTS Experience;
DROP TABLE IF EXISTS Offre;
DROP TABLE IF EXISTS Recruteur;
DROP TABLE IF EXISTS Candidat;
DROP TABLE IF EXISTS Competence;
DROP TABLE IF EXISTS Entreprise;
DROP TABLE IF EXISTS Utilisateur;

DROP TYPE IF EXISTS role_type;
DROP TYPE IF EXISTS taille_type;
DROP TYPE IF EXISTS contrat_type;
DROP TYPE IF EXISTS categorie_competence;
DROP TYPE IF EXISTS niveau_type;
DROP TYPE IF EXISTS statut_offre;
DROP TYPE IF EXISTS statut_candidature;

CREATE TYPE role_type AS ENUM ('candidat','recruteur','admin');
CREATE TYPE taille_type AS ENUM ('startup','pme','eti','grand_groupe');
CREATE TYPE contrat_type AS ENUM ('CDI','CDD','Stage','Alternance','Freelance','Interim');
CREATE TYPE categorie_competence AS ENUM ('technique','soft_skill','langue','autre');
CREATE TYPE niveau_type AS ENUM ('debutant','intermediaire','avance','expert');
CREATE TYPE statut_offre AS ENUM ('ouverte','fermee');
CREATE TYPE statut_candidature AS ENUM ('envoyee','en_attente','refusee','acceptee');

CREATE TABLE Utilisateur (
    id_utilisateur SERIAL PRIMARY KEY,
    nom VARCHAR(100),
    prenom VARCHAR(100),
    email VARCHAR(255) UNIQUE NOT NULL,
    telephone VARCHAR(20),
    motDePasse VARCHAR(255) NOT NULL,
    role role_type,
    dateCreation DATE DEFAULT CURRENT_DATE,
    pdp TEXT
);

CREATE TABLE Entreprise (
    id_entreprise SERIAL PRIMARY KEY,
    nom VARCHAR(255),
    secteur VARCHAR(255),
    siegeSocial VARCHAR(255),
    SIREN VARCHAR(9) UNIQUE,
    taille taille_type,
    siteWeb TEXT
);

CREATE TABLE Candidat (
    id_candidat SERIAL PRIMARY KEY,
    id_utilisateur INT REFERENCES Utilisateur(id_utilisateur),
    typeContrat contrat_type,
    ville VARCHAR(255),
    disponibilite DATE,
    cv TEXT
);

CREATE TABLE Recruteur (
    id_recruteur SERIAL PRIMARY KEY,
    id_utilisateur INT REFERENCES Utilisateur(id_utilisateur),
    id_entreprise INT REFERENCES Entreprise(id_entreprise),
    poste VARCHAR(255)
);

CREATE TABLE Competence (
    id_competence SERIAL PRIMARY KEY,
    category categorie_competence,
    nom VARCHAR(255)
);

CREATE TABLE Offre (
    id_offre SERIAL PRIMARY KEY,
    id_recruteur INT REFERENCES Recruteur(id_recruteur),
    titre VARCHAR(255),
    description TEXT,
    lieu VARCHAR(255),
    type_contrat contrat_type,
    salaire DECIMAL(10,2),
    duree VARCHAR(100),
    experience_requise INT,
    date_debut DATE,
    date_publication DATE DEFAULT CURRENT_DATE,
    statut statut_offre DEFAULT 'ouverte',
    teletravail BOOLEAN DEFAULT false
);

CREATE TABLE Experience (
    id_experience SERIAL PRIMARY KEY,
    id_candidat INT REFERENCES Candidat(id_candidat),
    id_entreprise INT REFERENCES Entreprise(id_entreprise),
    poste VARCHAR(255),
    date_debut DATE,
    date_fin DATE,
    description TEXT,
    entreprise VARCHAR(255)
);

CREATE TABLE CompetenceCandidat (
    id_candidat INT REFERENCES Candidat(id_candidat),
    id_competence INT REFERENCES Competence(id_competence),
    niveau niveau_type,
    PRIMARY KEY (id_candidat, id_competence)
);

CREATE TABLE CompetenceOffre (
    id_offre INT REFERENCES Offre(id_offre),
    id_competence INT REFERENCES Competence(id_competence),
    obligatoire BOOLEAN DEFAULT false,
    PRIMARY KEY (id_offre, id_competence)
);

CREATE TABLE Candidature (
    id_candidature SERIAL PRIMARY KEY,
    id_candidat INT REFERENCES Candidat(id_candidat),
    id_offre INT REFERENCES Offre(id_offre),
    score_matching DECIMAL(5,2),
    date_candidature DATE DEFAULT CURRENT_DATE,
    lettre_motivation TEXT,
    statut statut_candidature DEFAULT 'envoyee'
);

CREATE TABLE Messagerie (
    id_messagerie SERIAL PRIMARY KEY,
    id_candidature INT REFERENCES Candidature(id_candidature),
    id_recruteur INT REFERENCES Recruteur(id_recruteur),
    id_candidat INT REFERENCES Candidat(id_candidat),
    message TEXT,
    sendAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    lu BOOLEAN DEFAULT false
);

CREATE TABLE Lien (
    id_lien SERIAL PRIMARY KEY,
    id_candidat INT REFERENCES Candidat(id_candidat),
    nom VARCHAR(255),
    url_lien TEXT
);