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
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Puiseux', 'Martin', 'PuiseuxMartin@gmail.com', '+33783910517', '$2b$10$GDbT.4G/BZP6WlNmZ5Dz0ulrFnQ9/.RxFJHZkqt8GZVqdJVulmF4.', 'recruteur','2026-03-31');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Puiseux', 'Ilyes', 'PuiseuxIlyes@gmail.com', '+33655811650', '$2b$10$4q.gXQ.QVd/9WgTGZlVFBe/kR6Pi74GlKPfKPbYlmzlUaBGkxQa/C', 'recruteur','2026-03-31');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Puiseux', 'Gaetan', 'PuiseuxGaetan@gmail.com', '+33762082117', '$2b$10$fr2BB.f8eljPyIK/QcoXoueREAfScSGe8WDYgnIKMJfB/wAGZoHH.', 'recruteur','2026-03-31');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Puiseux', 'Clément', 'PuiseuxClément@gmail.com', '+33621393015', '$2b$10$.JdLrpRbVnRywrPz8HAW9.BLA.kZREcoTU9w/ad.tz/BPYskotMQO', 'recruteur','2026-03-31');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Puiseux', 'Thomas', 'PuiseuxThomas@gmail.com', '+33621464509', '$2b$10$M1cLP7Gmbkji5R0blIIbjeSVhy1rwxLHDIv4E4yAEeGh977gTSq6y', 'recruteur','2026-03-31');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Puiseux', 'Malo', 'PuiseuxMalo@gmail.com', '+33774168066', '$2b$10$4kAiJ0goc0kWaT5/9AYeZu9JnZEwC4D8ULz6OiMVHkahi0vg2ESj.', 'recruteur','2026-03-31');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Puiseux', 'Yasmine', 'PuiseuxYasmine@gmail.com', '+33789193873', '$2b$10$VEuQ5LN/tP3oFuAiwF0lQ./UAN4lSEkSeGLSc0QmlVvzvM02dJUYu', 'recruteur','2026-03-31');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Puiseux', 'Christophe', 'PuiseuxChristophe@gmail.com', '+33795629951', '$2b$10$qSOPOKN7yrvEOVk6lznG7uH8rBCIvTEL.iOlZ/teedVwysnIR/XUG', 'recruteur','2026-03-31');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Puiseux', 'Pierre', 'PuiseuxPierre@gmail.com', '+33604863718', '$2b$10$xRSDv2dMb1Q4sYvWKtCds.aEuKO7Dw6bBAeXT0Z4s3wQhJzuBY.ve', 'recruteur','2026-03-31');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Puiseux', 'Sabine', 'PuiseuxSabine@gmail.com', '+33614401961', '$2b$10$3cL/1mgb0/4rysSiiZapDOYEhHbMqspzEOuS3AZ2OgVIv/p/ooJWC', 'recruteur','2026-03-31');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Dufournier', 'Martin', 'DufournierMartin@gmail.com', '+33736096726', '$2b$10$SrOTdbbBTQkaI3VqFy95S.HMwV.tYqMyRg2ntIpL3Qnh6AwtT8ihK', 'recruteur','2026-03-31');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Dufournier', 'Ilyes', 'DufournierIlyes@gmail.com', '+33756636923', '$2b$10$/ub6rKgQuo2oB8mPQhlKh.qjorHHUursRZ9j8S7xH09wrWDbHYoRa', 'recruteur','2026-03-31');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Dufournier', 'Gaetan', 'DufournierGaetan@gmail.com', '+33736964088', '$2b$10$bK3AgS19SSzJ/tX5EShphOY19zMOU6HbYIHt1P0zjv3JNXSql5Qbq', 'recruteur','2026-03-31');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Dufournier', 'Clément', 'DufournierClément@gmail.com', '+33781680569', '$2b$10$S/4AglFtiwzT.IYyEdf/8OIIngcDyiwSrJFgYBLf1Rbfxqj.rtcsi', 'recruteur','2026-03-31');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Dufournier', 'Thomas', 'DufournierThomas@gmail.com', '+33620263337', '$2b$10$r7tg3n7t2MmpMy0PXAJvqu0WpO5xFelUEM0HttDTSiFs133Nk4NTy', 'recruteur','2026-03-31');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Dufournier', 'Malo', 'DufournierMalo@gmail.com', '+33798132449', '$2b$10$cI/dcb4AT.eVX6tqNzwYZ.e1T2yZXKcUyTykNmKFfoGvMnZYtUHN.', 'recruteur','2026-03-31');
