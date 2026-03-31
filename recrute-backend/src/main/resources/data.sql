-- Compétences
INSERT INTO Competence (category, nom) VALUES
('technique', 'Java'),
('technique', 'Python'),
('technique', 'Spring Boot'),
('technique', 'React'),
('technique', 'Docker'),
('technique', 'SQL'),
('soft_skill', 'Communication'),
('soft_skill', 'Gestion de projet'),
('langue', 'Anglais'),
('langue', 'Français');

-- Entreprises
INSERT INTO Entreprise (nom, secteur, siegeSocial, SIREN, taille, siteWeb) VALUES
('TechCorp', 'Informatique', 'Paris', '123456789', 'grand_groupe', 'https://techcorp.fr'),
('StartupAI', 'Intelligence Artificielle', 'Lyon', '987654321', 'startup', 'https://startupai.fr'),
('IngéConsult', 'Conseil en ingénierie', 'Bordeaux', '456789123', 'pme', 'https://ingeconsult.fr');

-- Utilisateurs
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role) VALUES
('Dupont', 'Alice', 'alice@techcorp.fr', '0601020304', 'hashed_pass_1', 'recruteur'),
('Martin', 'Bob', 'bob@email.fr', '0605060708', 'hashed_pass_2', 'candidat'),
('Durand', 'Clara', 'clara@email.fr', '0609101112', 'hashed_pass_3', 'candidat');

-- Recruteur
INSERT INTO Recruteur (id_utilisateur, id_entreprise, poste) VALUES
(1, 1, 'Responsable RH');

-- Candidats
INSERT INTO Candidat (id_utilisateur, typeContrat, ville, disponibilite) VALUES
(2, 'CDI', 'Paris', '2026-04-01'),
(3, 'Freelance', 'Lyon', '2026-03-15');

-- Offres
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, experience_requise) VALUES
(1, 'Développeur Java Senior', 'Développement backend Spring Boot', 'Paris', 'CDI', 55000, 3),
(1, 'Ingénieur DevOps', 'Gestion infrastructure cloud et CI/CD', 'Remote', 'CDI', 50000, 2);

-- Compétences des candidats
INSERT INTO CompetenceCandidat (id_candidat, id_competence, niveau) VALUES
(1, 1, 'avance'),   -- Bob : Java avancé
(1, 3, 'avance'),   -- Bob : Spring Boot avancé
(1, 5, 'intermediaire'), -- Bob : Docker intermédiaire
(2, 2, 'expert'),   -- Clara : Python expert
(2, 4, 'intermediaire'); -- Clara : React intermédiaire

-- Compétences requises pour les offres
INSERT INTO CompetenceOffre (id_offre, id_competence, obligatoire) VALUES
(1, 1, true),   -- Offre Java : Java obligatoire
(1, 3, true),   -- Offre Java : Spring Boot obligatoire
(1, 5, false),  -- Offre Java : Docker optionnel
(2, 5, true),   -- Offre DevOps : Docker obligatoire
(2, 6, true);   -- Offre DevOps : SQL obligatoireINSERT INTO Entreprise (nom, siegesocial) VALUES ('Economat des Armées', 'Pantin');


-- Entreprises
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('Economat des Armées', 'Pantin', 'Restauration', 'https://www.economat-des-armees.fr/', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('Advanced Schema', 'Paris', 'Informatique', 'https://www.advancedschema.com/', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('CESI Campus NANTERRE', 'Paris', 'Informatique', 'https://www.cesi.fr/', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('Thales', 'Gennevilliers', 'Défense', 'https://www.thalesgroup.com', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('Groupement Mousquetaires', 'Châtillon', 'Distribution', 'https://www.groupe-mousquetaires.com', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('ISCOD', 'Massy', 'Informatique', 'https://iscod.fr', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('Cosium', 'Versailles', 'Informatique', 'https://www.cosium.com', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('Salute Inc.', 'Paris', 'DataCenter', 'https://www.saluteinc.com', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('Odysis', 'Paris', 'Informatique', 'https://odysis.com', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('INPI', 'Courbevoie', 'Public', 'inpi.fr', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('Seyos', 'Gennevilliers', 'Informatique', 'https://www.seyos.fr/', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('Siemens', 'Châtillon', 'Mobilité', 'https://www.siemens.com', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('RATP EPIC', 'Noisy-le-Grand', 'Transport', 'https://www.ratp.fr/groupe-ratp', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('Inetum', 'Saint-Ouen', 'Informatique', 'https://www.inetum.com', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('Atos', 'Bezons', 'Informatique', 'https://atos.net', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('Sia', 'Paris', 'Conseil', 'https://www.sia-consulting.com', 'grand_groupe');

-- Utilisateurs
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Lopes', 'Gaetan', 'LopesGaetan@gmail.com', '+33788477558', 'LopesGaetan', 'Recruteur','2026-03-31');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Lopes', 'Christophe', 'LopesChristophe@gmail.com', '+33746085100', 'LopesChristophe', 'Recruteur','2026-03-31');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Lopes', 'Malo', 'LopesMalo@gmail.com', '+33635252043', 'LopesMalo', 'Recruteur','2026-03-31');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Lopes', 'Sabine', 'LopesSabine@gmail.com', '+33706559584', 'LopesSabine', 'Recruteur','2026-03-31');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Lopes', 'Yasmine', 'LopesYasmine@gmail.com', '+33633465067', 'LopesYasmine', 'Recruteur','2026-03-31');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Lopes', 'Clément', 'LopesClément@gmail.com', '+33758188241', 'LopesClément', 'Recruteur','2026-03-31');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Lopes', 'Martin', 'LopesMartin@gmail.com', '+33704735987', 'LopesMartin', 'Recruteur','2026-03-31');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Lopes', 'Pierre', 'LopesPierre@gmail.com', '+33705695055', 'LopesPierre', 'Recruteur','2026-03-31');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Lopes', 'Ilyes', 'LopesIlyes@gmail.com', '+33694817360', 'LopesIlyes', 'Recruteur','2026-03-31');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Lopes', 'Thomas', 'LopesThomas@gmail.com', '+33660990181', 'LopesThomas', 'Recruteur','2026-03-31');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Dufournier', 'Gaetan', 'DufournierGaetan@gmail.com', '+33779729657', 'DufournierGaetan', 'Recruteur','2026-03-31');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Dufournier', 'Christophe', 'DufournierChristophe@gmail.com', '+33790646885', 'DufournierChristophe', 'Recruteur','2026-03-31');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Dufournier', 'Malo', 'DufournierMalo@gmail.com', '+33783634795', 'DufournierMalo', 'Recruteur','2026-03-31');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Dufournier', 'Sabine', 'DufournierSabine@gmail.com', '+33664907718', 'DufournierSabine', 'Recruteur','2026-03-31');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Dufournier', 'Yasmine', 'DufournierYasmine@gmail.com', '+33655925556', 'DufournierYasmine', 'Recruteur','2026-03-31');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Dufournier', 'Clément', 'DufournierClément@gmail.com', '+33729397168', 'DufournierClément', 'Recruteur','2026-03-31');
