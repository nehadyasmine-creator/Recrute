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
(2, 6, true);   -- Offre DevOps : SQL obligatoire