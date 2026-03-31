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
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('Economat des Armées', 'Pantin', 'Public', 'https://www.economat-des-armees.fr', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('Advanced Schema', 'Paris', 'Informatique', 'https://www.advanced-schema.com/', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('CESI Campus NANTERRE', 'Paris', 'Informatique', 'https://www.cesi.fr', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('Thales', 'Gennevilliers', 'Aéronautique', 'https://www.thalesgroup.com/', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('Groupement Mousquetaires', 'Châtillon', 'Distribution', 'https://www.mousquetaires.com', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('ISCOD', 'Massy', 'Digital', 'https://www.iscod.fr', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('Cosium', 'Versailles', 'Informatique', 'https://www.cosium.fr', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('Salute Inc.', 'Paris', 'DataCenter', 'https://www.saluteinc.com', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('Odysis', 'Paris', 'Informatique', 'https://www.odysis.com', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('INPI', 'Courbevoie', 'Informatique', 'https://www.inpi.fr/', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('Seyos', 'Gennevilliers', 'Numérique', 'https://www.seyos.fr/', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('Siemens', 'Châtillon', 'Mobilité', 'https://www.siemens.com', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('RATP EPIC', 'Noisy-le-Grand', 'Transports', 'https://www.ratp.fr/groupe-ratp', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('Inetum', 'Saint-Ouen', 'Numérique', 'https://www.inetum.com', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('Atos', 'Bezons', 'Informatique', 'https://atos.net', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('Sia', 'Paris', 'Conseil', 'https://www.sia.fr', 'grand_groupe');
-- Recruteurs (Utilisateurs)
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Nehad', 'Gaetan', 'gaetan.nehad@gmail.com', '+33776079680', '$2b$10$09ueJIsNa1xOVoLhY0OFeOzxx45.pMu9c1WK3UFk54YVyB3nPUIZS', 'recruteur','2026-03-31');
INSERT INTO Recruteur (id_utilisateur, id_entreprise, poste) VALUES (1, 1, 'Responsable RH');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Nehad', 'Martin', 'martin.nehad@gmail.com', '+33633805591', '$2b$10$ZPvfuq8Rl2WOUMTznrmqi.PNaApLCtAV3fsASfY6wRnbRlHEWHiPe', 'recruteur','2026-03-31');
INSERT INTO Recruteur (id_utilisateur, id_entreprise, poste) VALUES (2, 2, 'Responsable RH');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Nehad', 'Sabine', 'sabine.nehad@gmail.com', '+33730599076', '$2b$10$QDVE0oj5i6mb7BDi0oawjeKgWNV8ovC6nxnBqiyZUNe9QYrheMJ/G', 'recruteur','2026-03-31');
INSERT INTO Recruteur (id_utilisateur, id_entreprise, poste) VALUES (3, 3, 'Responsable RH');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Nehad', 'Pierre', 'pierre.nehad@gmail.com', '+33708682087', '$2b$10$4ca8sRQ3ZJzaLcB2VPUfc.HSJF82dndeCtnQqCqWN2WeulQOpUrQS', 'recruteur','2026-03-31');
INSERT INTO Recruteur (id_utilisateur, id_entreprise, poste) VALUES (4, 4, 'Responsable RH');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Nehad', 'Yasmine', 'yasmine.nehad@gmail.com', '+33623250601', '$2b$10$1GuBwDBtA9pt2DbjQgan.OHrlniyNdaYTWSM.aW7sYX6y26w472Si', 'recruteur','2026-03-31');
INSERT INTO Recruteur (id_utilisateur, id_entreprise, poste) VALUES (5, 5, 'Responsable RH');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Nehad', 'Ilyes', 'ilyes.nehad@gmail.com', '+33636293740', '$2b$10$dqXu5WZMWuyQQ/8.YEFTnOuDisepHGu/hXNVLWslInmy3YDw6/xdy', 'recruteur','2026-03-31');
INSERT INTO Recruteur (id_utilisateur, id_entreprise, poste) VALUES (6, 6, 'Responsable RH');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Nehad', 'Malo', 'malo.nehad@gmail.com', '+33759428436', '$2b$10$pylXWHvTVPKM8xysdczfVOQNkLbhjpgAnOcAIrNMpO8M/A4JHYu9m', 'recruteur','2026-03-31');
INSERT INTO Recruteur (id_utilisateur, id_entreprise, poste) VALUES (7, 7, 'Responsable RH');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Nehad', 'Clément', 'clément.nehad@gmail.com', '+33728313895', '$2b$10$d0ef4EyAcZCO1DUIHprIMek9ZzrZkc6Ameic7m43Bt0CkHHSmWole', 'recruteur','2026-03-31');
INSERT INTO Recruteur (id_utilisateur, id_entreprise, poste) VALUES (8, 8, 'Responsable RH');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Nehad', 'Thomas', 'thomas.nehad@gmail.com', '+33721913727', '$2b$10$j34NNnNm9WULlA9E0kOt2ui/E3wN565/8MEGi.4xFJA9sWlZerFK2', 'recruteur','2026-03-31');
INSERT INTO Recruteur (id_utilisateur, id_entreprise, poste) VALUES (9, 9, 'Responsable RH');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Nehad', 'Christophe', 'christophe.nehad@gmail.com', '+33627839966', '$2b$10$8gJ0UbwlsaRR6b31s1zKSuuOJXylJAPGM/pfFtuEt2gLKORoR4JMS', 'recruteur','2026-03-31');
INSERT INTO Recruteur (id_utilisateur, id_entreprise, poste) VALUES (10, 10, 'Responsable RH');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Denis', 'Gaetan', 'gaetan.denis@gmail.com', '+33758838298', '$2b$10$5DmMvKM7byNKrY44BVm/QeuSxGLWUrh4zJ1R/dNp/EGVhGe0kwbRq', 'recruteur','2026-03-31');
INSERT INTO Recruteur (id_utilisateur, id_entreprise, poste) VALUES (11, 11, 'Responsable RH');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Denis', 'Martin', 'martin.denis@gmail.com', '+33699954901', '$2b$10$FYA9fMJnso6ns7PxsL/aeeK8agnO7eLZHS2LYzQLi/B8vRgVquotK', 'recruteur','2026-03-31');
INSERT INTO Recruteur (id_utilisateur, id_entreprise, poste) VALUES (12, 12, 'Responsable RH');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Denis', 'Sabine', 'sabine.denis@gmail.com', '+33727049476', '$2b$10$o.SUay2rEmoBwL09puABd.5ZdMDYSLZvcDwznrXPiTV//tr0rU/LK', 'recruteur','2026-03-31');
INSERT INTO Recruteur (id_utilisateur, id_entreprise, poste) VALUES (13, 13, 'Responsable RH');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Denis', 'Pierre', 'pierre.denis@gmail.com', '+33610098964', '$2b$10$CH.Z.DG8HipXv9cnLpXwSeuzzRS33g.mUx7NyP11SHILv0EKcl2c.', 'recruteur','2026-03-31');
INSERT INTO Recruteur (id_utilisateur, id_entreprise, poste) VALUES (14, 14, 'Responsable RH');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Denis', 'Yasmine', 'yasmine.denis@gmail.com', '+33650456569', '$2b$10$J7MZul1KcsTiFmMmDHDyrumrok1NeVDMZcXnE9DWGe8az1NBQwzka', 'recruteur','2026-03-31');
INSERT INTO Recruteur (id_utilisateur, id_entreprise, poste) VALUES (15, 15, 'Responsable RH');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Denis', 'Ilyes', 'ilyes.denis@gmail.com', '+33798054899', '$2b$10$iNTcqd26an1hMVUkJ37eP.QPjIHuGvcZuLcFymaihXyaWwjuBsFAW', 'recruteur','2026-03-31');
INSERT INTO Recruteur (id_utilisateur, id_entreprise, poste) VALUES (16, 16, 'Responsable RH');

-- ==========================
-- Offres
-- ==========================
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (1, 'Développeur data (H/F)', 'Référence : 2025_DSI_013
 CDI


Au quotidien, les femmes et les hommes de l’EdA s’engagent aux côtés de nos forces armées sur le territoire national et à l’étranger.


L’EdA c’est 1 000 collaborateurs dans le monde, 20 familles de métiers, pour assurer l’approvisionnement en denrées alimentaires, la restauration collective – externalisée ou en régie – et les activités de loisirs, la gestion des camps en opérations extérieures et le soutien aux évènements.




 Notre offre




Sous la responsabilité du chef du département « études et développement » de la Direction des Systèmes d’Information (DSI), le développeur data est responsable sur les missions confiées de l’analyse, de la gestion et de la présentation des données, tout en contribuant au développement et à l’optimisation des applications nécessaires à mettre en place pour garantir la fiabilité et la performance des flux de données.




 Vos missions au quotidien




Analyse de données :




Collecter, nettoyer et structurer des données provenant de différentes sources (bases de données, API, fichiers externes, …).


Effectuer des analyses pour répondre aux besoins métiers.


Créer des rapports et des dashboards interactifs avec des outils BI (Power BI, Qlik, etc.).


Fournir des insights et recommandations à partir des données pour améliorer les processus et les performances de l''établissement.


Gérer et maintenir des bases de données analytiques.




Développement Web :




Développer et maintenir des applications web internes ou externes en utilisant des technologies comme HTML, CSS, JavaScript, ainsi que des frameworks du marché.


Concevoir et développer des interfaces utilisateurs intuitives et responsives.


Concevoir des expériences utilisateurs fluides, centrées sur les besoins métiers et les utilisateurs finaux.




Gestion de bases de données et SQL :




Rédiger et optimiser des requêtes SQL pour extraire et manipuler des données à partir de bases de données relationnelles (MySQL, PostgreSQL, SQL Server, etc.).


Développer et maintenir des procédures stockées, des triggers et des vues dans les bases de données.


Assurer la performance et l''intégrité des bases de données en optimisant les processus d''extraction et de traitement des données.




Développement et tests des flux de données et des interfaces :




Développer et maintenir des flux de données entre différentes applications et bases de données, en garantissant leur cohérence et leur performance.


Tester les flux de données pour s''assurer de leur bon fonctionnement, de leur exactitude et de leur sécurité (tests de bout en bout, tests d''intégration).


Concevoir et réaliser des tests de performance pour les applications et les interfaces utilisateurs, en s''assurant de leur réactivité et de leur scalabilité.


Mettre en place des tests automatisés pour les interfaces et les processus d’intégration afin de garantir une qualité continue des systèmes.




Votre profil


 Le candidat est de nationalité française et/ou ressortissant européen.
 
Etablissement soumis à enquête administrative.




Votre parcours
 


Bac +3/5 en informatique, analyse de données, statistiques ou domaines similaires. Expérience professionnelle de 3 à 5 ans minimum dans un rôle similaire, alliant analyse de données, développement web, et tests de flux et d''interfaces.


 
Vos savoir-faire


Compétences techniques :




Compétences avancées en SQL et gestion de bases de données relationnelles.


Maîtrise des langages de programmation web (HTML, CSS, JavaScript, PHP, etc.).


Expérience avec des outils de visualisation de données (Power BI, Qlik, etc.).


Maîtrise des processus et outils de tests (tests unitaires, tests d’intégration, tests fonctionnels et de performance).


Compétences en automatisation des tests pour les applications web et les flux de données.


Expérience dans la gestion des flux de données et l''intégration d''API.




Compétences analytiques :




Capacité à analyser des ensembles de données complexes et à en extraire des insights significatifs.


Sens de la rigueur et de l''organisation dans le traitement des données.


Excellentes capacités de résolution de problèmes et de prise de décision basée sur les données.




 
Les savoir-être partagés par tous les collaborateurs de l’EdA


Esprit d’équipe, sens du service, discrétion, implication, agilité, éthique, communication, initiative


 
 Nos propositions




CDI statut cadre à pourvoir ASAP
 Poste basé à Pantin avec de possibles déplacements de courte durée en France ou à l’étranger.
 Restaurant et parking sur site ;
 Horaires flexibles et télétravail ;
 13 RTT annuel, intéressement, PEE, PERCO, CET ;
 Prime de performance individuelle en fonction des résultat obtenus ;
 Un parcours d’intégration complet pour faciliter la prise en main de votre poste et découvrir votre environnement, avec des sessions d’intégration ;
 Une large palette de formations pour votre projet professionnel ;
 Des avantages et prestations sociales intéressants : sport, voyages, billetterie, culture, aide à l’accès au logement, accompagnement à la mobilité, facilités crèche, activités sportives à tarifs avantageux, etc.


 
 Pourquoi postuler


L’engagement au côté des forces armées françaises nous permet de donner du sens à nos actions et de nous accomplir au quotidien. C’est l’opportunité de mettre nos expertises et notre créativité au service de projets dimensionnants.
 Pour garantir leur réussite, nous veillons à développer et conjuguer les talents de chacun.
 
 Nous rejoindre c’est intégrer un collectif où l’humain reste au centre des attentions, qu’il soit client ou collaborateur. Nous avons la conviction que le service indéfectible que nous devons à nos prescripteurs ne peut être garanti que par la qualité de l’environnement que nous proposons à nos équipes.
 
 A la jonction des univers militaire et civil, l’EdA est riche d’une culture de mixité.
 En postulant chez nous, ne vous posez pas d’autre question que celle de savoir si vous partagez nos valeurs et ambitions.
 Au-delà de votre expertise, nous recherchons les qualités qui font la force de nos équipes : éthique, implication, audace, rigueur, empathie et créativité.
 
 Ce poste est ouvert aux personnes en situation de handicap.', 'Pantin', 'CDI', 0.0, '', 3, '2026-03-31', '2026-03-31', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (2, 'Data Engineer', 'En tant que
Data Engineer
, vous aurez les 
missions
 suivantes :




 Concevoir 
des modélisations physiques


 Construire 
des mappings techniques et rédaction de spécifications d’alimentation.


 Développer 
des flux des données


 Contribuer 
au pilotage de projets, de proof of concepts


 Participer 
à des missions d’expertise




N''hésitez pas à postuler même si vous ne répondez pas à toutes les exigences. Nous accordons autant d''importance à la 
capacité d''apprendre qu''à la maîtrise d''une technologie
.


Ce poste
 
est à pourvoir en
 stage 
et
 CDI


 Compétences professionnelles & niveau d''études requis :




Vous êtes titulaire d''un diplôme 
Bac +3
 minimum dans le domaine de la 
data


Vous possédez minimum 
1 an d''expérience
 dans le métier


Être 
enthousiaste 
à l''idée 
d''apprendre de nouvelles technologies


Expérience de la méthodologie 
Agile / Scrum


Capacité à 
planifier et à prioriser 
les 
tâches
 et les 
activités confiées
 en autonomie


 Maîtrise 
de l’anglais oral et technique obligatoire


 Expérience
 avérée dans l''écriture de code propre avec 2 ou plusieurs des technologies suivantes :
 BASH, SQL, Java, Python, NoSQL', 'Paris', 'CDI', 0.0, '', 1, NULL, '2026-03-31', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (3, 'Administrateur systèmes et réseaux H/F en alternance (école CESI Campus Nanterre)', 'À propos du poste


L’école CESI recherche pour l''un de ses partenaires, un·e alternant·e Administrateur·rice Réseau pour renforcer l’équipe IT; Projets sur un parc multi-sites, vous participerez à l’exploitation quotidienne, au support N1/N2 et aux déploiements encadrés par des ingénieurs réseau. En tant que professionnel(le) de l''informatique, vous serez responsable de la gestion, de la maintenance et de l''optimisation des infrastructures IT.


Responsabilités


Encadré par le responsable technique, vous participerez à :




Administrer les dossiers courants au niveau des postes de travail et serveurs (Windows, Linux)


Contribuer à l’amélioration continue de la documentation et des procédures internes


Gérer les droits utilisateurs, les accès, le parc informatique


Superviser l’infrastructure


Déployer, faire la maintenance et mettre à jour les solutions réseaux (VPN, Firewalls, routeurs)


Participer aux audits de sécurité


Supports utilisateur de niveau 1 et 2




Profil recherché
Vous souhaitez intégrer le Bachelor Administrateur Systèmes Réseaux (ASR) au sein du campus CESI NANTERRE, une formation sur 12 mois en alternance, au rythme d''1 semaine à l''école et de 3 semaines en entreprise.


L'' alternance vous offrira une formation professionnalisante, avec une montée en compétences accélérée au contact de professionnels engagés.


Le profil souhaité :




Titulaire d’un bac +2 en INFORMATIQUE (Cybersécurité, réseaux, systèmes d’informations ou équivalent)


A l’aise avec les environnements Linux et Windows


Sens de l’écoute, rigueur et autonomie


Intérêt marqué pour la cybersécurité, les systèmes et réseaux


Envie d’apprendre, de contribuer et d’évoluer dans un cadre bienveillant et professionnel




Bon à savoir :


Scolarité financée et rémunérée dans le cadre d’un contrat de travail en apprentissage ou de professionnalisation. Les éventuels frais d’inscription sont également à la charge exclusive de l’employeur, dans le cadre du principe de gratuité des contrats en alternance.


Pourquoi choisir CESI ?


Une autre idée de l’excellence : École d’ingénieurs créée en 1958 par des entreprises industrielles, CESI compte 26 campus sur tout le territoire, dotés d’équipements pédagogiques de pointe, 110 000 alumni, 8 000 entreprises d’accueil et plus de 130 universités partenaires dans le monde.


Pourquoi choisir notre entreprise partenaire ?


Rejoindre notre partenaire, c’est évoluer dans une entreprise où l’humain passe avant le process et ou chaque collaborateur est encouragé à être acteur de son parcours


Type d''emploi : Alternance


Lieu du poste : En présentiel


Date de démarrage: octobre 2026


Candidature à : mfmarques@cesi.fr


Type d''emploi : Alternance


Rémunération : 774,00€ à 1 801,00€ par mois


Lieu du poste : En présentiel', 'Paris', 'Alternance', 9288.0, '12 mois', 0, '2026-10-01', '2026-03-31', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (4, 'Ingénieur Système Equipements électroniques F/H', 'Lieu : Gennevilliers, France
 


 Construisons ensemble un avenir de confiance




Thales est un leader mondial des hautes technologies spécialisé dans trois secteurs d’activité : Défense & Sécurité, Aéronautique & Spatial, et Cyber & Digital. Il développe des produits et solutions qui contribuent à un monde plus sûr, plus respectueux de l’environnement et plus inclusif. Le Groupe investit près de 4 milliards d’euros par an en Recherche & Développement, notamment dans des domaines clés de l’innovation tels que l’IA, la cybersécurité, le quantique, les technologies du cloud et la 6G. Thales compte près de 81 000 collaborateurs dans 68 pays.




Nos engagements, vos avantages




Une réussite portée par notre excellence technologique, votre expérience et notre ambition partagée


Un package de rémunération attractif


Un développement des compétences en continu : parcours de formation, académies et communautés internes


Un environnement inclusif, bienveillant et respectant l’équilibre des collaborateurs


Un engagement sociétal et environnemental reconnu






 Votre quotidien
 Le Campus de Gennevilliers est le cœur des activités de conception, de développement et de soutien des grands systèmes de défense : radiocommunications, réseaux et systèmes d’infrastructure résilients, communications par satellite, combat collaboratif et cybersécurité. Situé au nord de Paris, il est rapidement accessible en transports en commun.
 


Dans le cadre d’un fort accroissement d’activités au sein du groupe Equipements et Contrôles du service de R&D de nos produits à très haut niveau de criticité & de sensibilité pour la 
Dissuasion Française
 (sous-marins et avions de combat), nous recherchons activement 
un ingénieur 
système
 
en équipement électronique
. A ce titre, vous prenez en charge la responsabilité technique d’une nouvelle ligne de produits destinée à équiper le système de mise en œuvre à bord de sous-marins. Vous êtes hiérarchiquement regroupé au sein d’une équipe métier adressant les développements électroniques analogiques. Une grande importance est donnée au développement du groupe métier (sessions privilégiées d’échanges, …). Vous évoluez aussi au sein d’une équipe projet totalement intégrée & multi-métiers sous la responsabilité d’un chef de projet (métiers électronique analogique et numérique, mécanique, fiabiliste & sûreté de fonctionnement, SSI, IVVQ bancs de test, …).




A ce titre vos missions seront de :






Être le leader technique de l’équipe et l’interface technique d’ensemble avec le client,


Garantir la coopération technique entre les équipes multi métiers (électronique analogique et de puissance, logiciel embarqué, numérique FGPA, mécanique, sûreté de fonctionnement) pour garantir la conformité de la solution avec les besoins du client,


Être responsable de l’excellente qualité, au niveau technique, des produits et prestations livrés.


Valider tous les choix techniques,


Alerter sur les risques techniques du projet et de prendre des mesures correctives






 Votre profil :




Votre priorité est de travailler dans les systèmes embarqués en intégrant une équipe projet composé d''experts de haut niveau ?


Vous avez l''ambition de travailler sur des projets de hautes technologies ?


Vous avez une expérience d''au moins 5 ans sur des équipements Electroniques de haute fiabilité dans un domaine industriel ?




Vous disposez d''un Bac+5 et/ou Ingénieur électronique analogique et numériques et avez des compétences sur :




De la conception de cartes électroniques


Des tests de produits embarqués


De l''animation d''équipe technique*


Les phases d''intégration, test et mise au point de cartes électroniques.






"L’atout majeur de ce service est l’opportunité donnée au collaborateur d’intervenir sur toutes les phases du développement (des spécifications à la livraison, ainsi que le support au maintien en condition opérationnelle), permettant ainsi d’étendre son périmètre d’action continuellement. Le travail en équipe d’ingénierie pluridisciplinaire enrichit significativement."


La maitrise de l''anglais, la rigueur, l''organisation sont des atouts que l''on vous reconnait ?




Alors ce poste est fait pour vous !


 Thales, entreprise Handi-Engagée, reconnait tous les talents. La diversité est notre meilleur atout. Postulez et rejoignez nous !
 
 Le poste pouvant nécessiter d''accéder à des informations relevant du secret de la défense nationale, la personne retenue fera l''objet d''une procédure d’habilitation, conformément aux dispositions des articles R.2311-1 et suivants du Code de la défense et de l’IGI 1300 SGDSN/PSE du 09 août 2021.', 'Gennevilliers', 'CDI', 0.0, '', 5, NULL, '2026-03-31', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (5, 'Data Engineer (Databricks /Azure)', 'Description de l''entreprise


 Le Groupement Les Mousquetaires, ce sont 7 enseignes de la grande distribution portées haut et fort par plus de 3 000 chefs d’entreprise indépendants ! Ce sont aussi 150 000 collaborateurs mobilisés autour de notre modèle unique de producteurs et commerçants. Et nous en sommes fiers ! Dans toutes les fonctions au service des points de vente, de la logistique à l’immobilier, en passant par l’industrie agroalimentaire ou l’informatique, nos équipes font nos succès.


Rejoindre la Stime c’est contribuer à des projets à fort enjeu et être challengé dans ses missions au sein d''un environnement dynamique.


Notre volonté est d’ouvrir le champ des possibles et permettre à chacun de se réaliser. La Stime met donc en place un management qui favorise l’élaboration de solutions en commun, en s’appuyant sur des pratiques agiles.


Alors, prêts à relever ces défis avec nous ?
 Description du poste


 Contexte 


Au sein de la Direction des SI Mutualisés, l’équipe DataLab intervient sur les périmètres Data et Analytics, dans le cadre du programme de transformation du SI du Groupement Les Mousquetaires.


Vous intégrerez la 
Data Factory
, un dispositif réunissant les équipes Data de la Stime et des métiers. Sa mission : concevoir et déployer des produits Analytics innovants destinés aux fonctions support, aux équipes logistiques, aux magasins, ainsi qu’aux consommateurs.


Après les premiers succès et des attentes de plus en plus fortes, nous passons désormais à l’échelle avec une nouvelle organisation Agile en Domaine/Tribu/Squad et la nécessité d’industrialiser nos pratiques pour accélérer la livraison des produits, tout en capitalisant mieux sur le patrimoine de données constitué.


Vous rejoindrez l’une de nos squads, en charge du développement de cas d’usage 
BI, Analytics et Data Science
 sur notre plateforme Data Cloud 
Azure
/Databricks.


Le contexte vous plaît ? Découvrez votre quotidien au sein de votre future équipe.


En tant que Data Engineer, vous interviendrez sur le cycle complet de création de produits Data :


 Conception & Analyse




Participer aux ateliers de définition et de maturation des besoins avec les Product Owners et les métiers.




 Développement & Intégration




Construire des pipelines Data pour la collecte, la transformation et le traitement des données dans notre Data Lake Azure.


Développer des notebooks de traitements avancés sur 
Databricks
 (langues : SQL, Scala ou PySpark).


Concevoir et modéliser les données au sein du Data Lake (formats Parquet, Delta).




 Qualité, CI/CD & Documentation




Réaliser les tests unitaires, d’assemblage et d’intégration.


Rédiger la documentation technique (DAT, release notes…).


Préparer les packages de livraison en CI/CD en lien avec les équipes DataOps.




 Run & Amélioration Continue




Assurer la maintenance corrective et évolutive des produits data développées.


Participer aux cérémonies Agiles (Sprint Planning, Daily, Review, Demo…).


Contribuer à l’animation de la communauté Data : groupes de travail, meetups (Microsoft, Databricks…), partages de bonnes pratiques.


 
 Qualifications


 De formation supérieure en informatique, vous disposez d’une expérience significative (au moins 5 ans) dans une fonction similaire.


Vous disposez des compétences suivantes:




Expertise démontrée en BI, Big Data ou Analytics.


Expérience dans le développement et l’implémentation de solutions Big Data, idéalement sur le Cloud.


Très bonne connaissance du framework Spark.


Très bonne maîtrise des langages : SQL, Scala, Python.


Compréhension solide des concepts DevOps, CI/CD et de leurs outils.


Expérience en environnement Agile (idéalement JIRA).


Les certifications Spark, Azure ou Databricks sont un plus apprécié.




 Soft Skills




Excellentes capacités d’analyse et de vulgarisation.


Rigueur, curiosité et esprit de challenge.


Autonomie et sens du travail en équipe.




 Pourquoi nous rejoindre ?




Un management fondé sur la coopération et la co-construction


Un environnement dynamique et stimulant.


Une excellente ambiance d’équipe.


Intégration au sein d’une Data Factory composée de près de 120 experts.


Une communauté active de plus de 40 Data Engineers et Data Scientists


Participation possible à des hackathons internes et externes.


Accès à de nombreux e-learning partenaires (Microsoft, Databricks…).




 Informations supplémentaires


 Côté RH


En intégrant la Stime, vous pourrez bénéficier des avantages suivants :




Accord d’entreprise sur le télétravail


13ème mois


Prime Vacances


Accord d’intéressement


Restaurant d''entreprise




Pour faciliter la qualité de vie au travail de l’ensemble de nos équipes, nous proposons un service de conciergerie disponible même à domicile pour les journées en télétravail, une possibilité de Coworking dans divers espaces en Ile-de-France, une cantine dont la qualité fait moins regretter le télétravail, une salle de sport, et des locaux tout neufs, fonctionnels avec possibilité de pauses café en terrasse pour les chaudes journées ensoleillées !


De nombreuses formations sont proposées dès la prise de fonction pour favoriser l''apprentissage des nouvelles technologies, à la hauteur des projets ambitieux que connait la Stime.


Notre process de recrutement est simple et efficace : il se résume à un entretien RH, suivi d''un entretien opérationnel avec le responsable de Pôle et le responsable de Domaine.




 « Chez les Mousquetaires, seules les compétences font la différence. Le Groupement s''engage activement en faveur de la diversité, en créant un environnement de travail inclusif qui garantit l’égalité des opportunités pour chacun(e). »', 'Châtillon', 'CDI', 0.0, '', 5, NULL, '2026-03-31', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (6, 'Alternance Data Engineer (F/H)', 'Description :


L’ISCOD, spécialiste de la formation en Digital Learning, recherche pour son entreprise partenaire, un hypermarché, 
un(e) Data Engineer en contrat d''apprentissage, 
pour préparer l’une de nos formations diplômantes reconnues par l''Etat de niveau 5 à niveau 7 (Bac+2, Bachelor/Bac+3 ou Mastère/Bac+5).


 Choisissez l’alternance nouvelle génération avec l''ISCOD !




Missions :


Notre objectif est de digitaliser les activités commerciales et de marchandises dans le but de simplifier, d''harmoniser et d''automatiser les processus opérationnels de l''entreprise. Nous travaillons avec les équipes business, product management et design pour concevoir des outils ergonomiques et fiables.


Vous aurez pour mission de contribuer à des projets Data en apportant son expertise sur les tâches suivantes :




montée en compétence sur l''ETL BigL, participation à la réalisation de projets métier dans le cadre de la solution offline ELT in-House BigLoader et BDI/DBT


prise en charge des demandes de corrections provenant d''incidents ou d''anomalies, participation à l''auto-formation et à la montée en compétences de l''équipe de développement


application des bonnes pratiques et des normes de développement, mise en pratique des méthodes « devops »


contribution aux chiffrages des usages et à la constitution des releases, contribution à l''automatisation du delivery, développement et documentation du code,travail au sein d''une équipe Clients.










Profil :


 Environnement technique et expertises nécessaires :




Expérience dans le domaine de la Data et du Cloud, idéalement sur Google Cloud Platform (GCP)


Maîtrise de SQL pour la manipulation, l’analyse et la valorisation de données.


Maîtrise des outils de CI/CD, Docker Compose.


Bonne connaissance de l’environnement Linux et des outils de ligne de commande.


Expérience solide avec les systèmes de gestion de version (Git).




 Environnement technique et expertises nécessaires :




Excellente communication écrite et orale : Bonne communication écrite et orale en français pour des interactions fluides avec le métier.


Esprit d''analyse et d''amélioration continue : Capacité à évaluer le code et ses impacts, ainsi qu''à remettre en question les solutions existantes pour les améliorer.


Capacité de prise de recul : Aptitude à évaluer les problématiques avec objectivité et à proposer des solutions d''amélioration.


Capacité à respecter les délais tout en maintenant des standards élevés.


Esprit d''équipe : Capacité à collaborer efficacement avec les membres de l''équipe pour atteindre des objectifs communs Avantages : Vous aurez accès au infrastructures du campus (salle de sport, conciergerie, drive, parking et restauration) solution gratuite pour faire du sport grâce à l''application Egym Welpass.




 Avantages 
:




Vous aurez accès au infrastructures du campus (salle de sport, conciergerie, drive, parking et restauration) solution gratuite pour faire du sport grâce à l''application Egym Welpass.


Vous aurez accès au infrastructures du campus (salle de sport, conciergerie, drive, parking et restauration)






Vous êtes éligible à une formation Bac+2 à Bac+5 (diplôme validé ou en cours de validation)


Poste basé à Massy


Rémunération fixe selon niveau d’études + âge,


Vous êtes intéressé(e) par cette offre d’emploi en alternance ? 
Postulez dès maintenant !', 'Massy', 'Alternance', 0.0, '1 an', 0, NULL, '2026-03-31', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (7, 'Ingénieur système et réseau H/F', 'Notre entreprise


Fondé en 2003, Cosium est un éditeur de logiciel. Nos logiciels sont fournis en mode Saas sur le cloud privé que nous opérons de bout en bout. Cosium est détenu et dirigé par des ingénieurs.


Le département infrastructure


Le département infrastructure s''occupe de la gestion de l''intégralité du système d''information de Cosium. Ceci inclus l''hébergement haute dispo des solutions SaaS de l''entreprise, qui fournissent à des milliers de professionnels de santé l''accès à leur progiciel. Nous gérons également l''intégralité des outils internes, que ce soit les outils collaboratifs ou les plate-formes d''intégration continue pour nos développeurs.


Nous avons également une casquette DevOp en lien avec les développeurs afin d''optimiser la configuration des différents middleware tel que les bases de données et les serveurs applicatifs.


Le département infrastructure est composé d''experts techniques. Nous sommes tous passionnés et nous aimons ce que nous faisons. Cosium met à notre disposition les moyens pour réaliser des projets ambitieux et innovants.


Nous gérons une plate-forme souveraine hébergée en France sur plusieurs sites redondés. Nous sommes certifiés ISO 27001 et HDS pour l’hébergement et nous sommes LIR (Local Internet Registry), ce qui signifie que nous gérons nous-même notre réseau et nos peering (BGP).


L’équipe est à taille humaine (moins de 10 personnes) et ne s''occupe pas du support utilisateur niveau 1, qui est délégué à une autre équipe.


Votre mission


En rejoignant notre équipe en tant qu''administrateur systèmes et réseaux, vous rejoignez un groupe d''experts techniques. Notre objectif est de permettre à chaque membre de s''épanouir pleinement. Vos projets auront un impact direct et significatif tant sur nos clients que sur nos équipes internes.


Nous permettons le travail à domicile au besoin de façon occasionnelle, ce poste n''est pas un contrat en remote.


Dans le cadre de vos fonctions, vous serez chargé de :




Participer à l''évolution et la maintenance de l''infrastructure


Mener à bien des projets : R&D, phase de test, mise en production, documentation puis maintenance


Enrichir et maintenir la documentation technique


Respecter les processus et certifications de l''entreprise (ISO 27001 / HDS)


Traiter les demandes complexes (niveau 2 et 3)


Effectuer une veille technologique des dernières innovations


Mentorer les membres moins expérimentés




Profil recherché




Diplômes : BAC+5 ingénieur ou master informatique


Expérience : Ce poste est ouvert à des juniors




Qualités et expériences indispensables




Anglais technique


Volonté de travailler avec des produits Open Source


Gestion de serveurs Linux (Debian et Ubuntu)


Maîtrise du bash


Gestion de pare-feu


Compétence en réseaux : routage statique et dynamique, vlan, VPN


Gestion de base de bases de données (postgresql et/ou mysql ou dérivés)


Gestion de serveurs web


Gestion de reverse proxy


Gestion de virtualisation et containérisation


Monitoring et alerting avec des outils de supervisions


Préférer vim à emac (ou avoir des arguments pour nous faire changer d’avis ;-) )


Utilisation d’un outil d’automatisation




Qualités et expériences idéales




Expérience chez un hébergeur ou un éditeur de logiciel sur des socles Linux


Utilisation d’Ansible


Aisance de programmation en Python


Administration d’un service LDAP (OpenLDAP)


Connaissance du système de fichier ZFS


Expérience sur des équipements Juniper




Les plus du poste




Participation à plusieurs conférences techniques comme FOSDEM, PGconf Europe…


Possibilité de proposer des conférences en tant que Speaker


Un écran wide 34’’ résolution 3440*1440 pour voir chaque pixel du terminal en HD


Choix du PC portable


Choix de la distribution Linux pour votre poste


Choix du modèle de clavier externe et de la souris




Processus de recrutement




Entretien téléphonique ~30m


Entretien avec votre futur chef d’équipe ~1h


Entretien avec le CEO




Type d''emploi : CDI


Rémunération : 40 000,00€ à 50 000,00€ par an


Formation:




Bac +5 (Master / MBA) (Optionnel)




Lieu du poste : En présentiel', 'Versailles', 'CDI', 40000.0, '', 0, NULL, '2026-03-31', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (8, 'Junior Data Center Facility Engineer', 'Across the data center industry – from deployment, through operations and maintenance, to decommissioning – Salute Mission Critical is a global leader in delivering high-quality data center services. We are looking for a Junior Data Center Engineer to join our team in Paris, France.


At Salute, we don’t have employees — we have team members. Our culture is built on teamwork, open communication, continuous learning, and a strong commitment to safety and customer service.


 Role Overview
:


This is an entry-level opportunity designed for candidates with a technical background who are looking to start a career in the data center industry.


As a Junior Data Center Engineer, you will support the operation and maintenance of critical systems within the data center. You will work alongside experienced engineers to learn how to maintain high availability and reliability of essential infrastructure.




 Key Responsibilities:




Assist in monitoring and maintaining electrical and mechanical systems


Support preventive maintenance tasks under supervision


Help respond to basic system alarms and issues


Participate in routine inspections of equipment and facilities


Maintain clean and safe working environments in equipment rooms


Assist with tracking and updating work orders and tickets


Learn and follow operational procedures (SOPs, MOPs, EOPs)


Support site walks and basic system checks


Work with team members and contractors on daily tasks


Assist with basic IT or customer-related requests when required






 What We’re Looking For:




Basic technical training or education (e.g., electrical, mechanical, HVAC, or similar)


Strong interest in data centers or critical infrastructure


Willingness to learn and develop new technical skills


Good problem-solving and attention to detail


Ability to follow instructions and work as part of a team


Basic computer skills and familiarity with ticketing systems (a plus, not required)


Good communication skills in French and English






 Preferred (Not Required)




Internship, apprenticeship, or hands-on experience in a technical field


Basic understanding of electrical or mechanical systems


Exposure to environments such as facilities maintenance, or industrial settings






 What You’ll Gain:




Hands-on training in a fast-growing, high-demand industry


Mentorship from experienced data center engineers


Exposure to critical systems such as power, cooling, and automation


Clear career progression opportunities within the company






 Qualifications




A minimum of 1 year of directly related experience in the operation, installation and maintenance of building systems with technical understanding and knowledge of HVAC, electrical, plumbing, fire/life safety, and control systems


High school diploma or College Degree


Good observation skills and problem-solving ability.




The role is a full-time position and your base salary will be commensurate with experience but is expected to be highly competitive.


 What you’ll get from us:


Here, at Salute, we value our people and take great pride providing not just a job but fantastic career opportunities. In addition to the opportunity to work in a great team and earn a competitive salary - you''ll gain access to cutting edge industry training that aims to enhance your skills and propel your career forward. Not only will you receive valuable development in your current role, but for those who are ambitious and motivated, the possibilities are endless.


#EMEA', 'Paris', 'CDI', 0.0, '', 1, NULL, '2026-03-31', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (9, 'Data Engineer', 'Qui sommes-nous ?


Odysis est une Entreprise de Services du Numérique (ESN) spécialisée dans l’ingénierie et la gestion des données. Nous aidons les entreprises à transformer leurs données en leviers de performance et d''innovation.


 Nos valeurs chez Odysis :




 Service client avant tout :
 Nous nous engageons à fournir des solutions efficaces et documentées, sans chercher à nous rendre indispensables.


 Passion orientée valeur :
 Notre passion pour la technologie est au service de la création de valeur pour nos clients, en répondant précisément à leurs besoins.


 Fidélité aux fondamentaux :
 Face aux évolutions constantes du secteur de la data, nous privilégions des bases solides et pérennes pour assurer des solutions durables.




 Champs d''action :




 Conseil stratégique :
 Accompagnement en data gouvernance, data management et architecture pour définir des visions claires et des feuilles de route réalistes.


 Architecture et ingénierie des données :
 Conception et mise en œuvre de solutions adaptées aux besoins spécifiques de chaque client.


 Exploitation des données :
 Mise en place de solutions de data visualisation, storytelling et applications en data science/IA pour valoriser les données.




Rejoindre Odysis, c''est intégrer une équipe dynamique avec des perspectives d''évolution dans un secteur en pleine expansion.


 Description du poste


 Missions principales :




Concevoir, développer et maintenir des pipelines de données évolutifs et des architectures de données robustes.


Collaborer avec les équipes de data scientists, d''analystes et autres parties prenantes pour assurer une intégration et une utilisation efficaces des données.


Optimiser les processus de stockage et de récupération des données pour maximiser les performances et l''efficacité.


Mettre en œuvre des contrôles de qualité des données et résoudre les problèmes pour garantir l''exactitude et la fiabilité des données.


Assurer la conformité aux réglementations en matière de sécurité et de confidentialité des données.




 Compétences requises :




Expérience avérée en tant que Data Engineer ou dans un rôle similaire.


Maîtrise des outils et technologies de data engineering (par exemple, SQL, ETL, data warehousing).


Expérience avec des frameworks de pipelines de données et des plateformes de traitement de données (par exemple, Apache Kafka, Apache Spark).


Compétences en programmation avec des langages tels que Python, Java ou Scala.


Expérience avec des plateformes cloud (par exemple, AWS, Google Cloud Platform, Azure).


Connaissance de la modélisation des données, de la conception de bases de données et de la gouvernance des données.


Solides compétences analytiques et en résolution de problèmes.




 Profil recherché


 Profil recherché :




Diplôme en informatique, data engineering, technologies de l''information ou dans un domaine connexe.


3 à 5 ans d''expérience en tant que Data Engineer ou dans un rôle similaire.


Capacité à travailler en équipe et à communiquer efficacement avec des parties prenantes techniques et non techniques.


Esprit d''initiative et capacité à s''adapter dans un environnement en constante évolution.




Si vous êtes passionné par les données et souhaitez rejoindre une équipe dynamique en pleine croissance, nous serions ravis de recevoir votre candidature.


 
 > 3 ans', 'Paris', 'CDI', 0.0, '', 3, NULL, '2026-03-31', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (10, 'Ingénieur Système F/H', 'L’Institut national de la propriété industrielle (INPI) est un acteur majeur de l’innovation, de l’entreprenariat et de la création en France. Il délivre les titres de propriété industrielle (brevets, marques, dessins et modèles), assure l’homologation des indications géographiques artisanales et industrielles. L’INPI agit également en faveur du développement économique par ses actions de sensibilisation et de formation grâce à son réseau national et à ses représentations internationales.


L’INPI est l’opérateur du Guichet unique pour les formalités d’entreprises (immatriculations, modifications, cessations, dépôts de comptes) et du Registre national des entreprises. Il assure la diffusion des données sur les entreprises et la propriété industrielle.


L’INPI participe activement à l''élaboration du droit dans les domaines de la propriété intellectuelle, de la lutte contre la contrefaçon, du soutien à l’innovation et à la compétitivité des entreprises, en France et à l’international. A ce titre, l’INPI représente la France dans les instances internationales.


Nous recrutons en CDI un Ingénieur système Devops F/H.


Rattaché (e) au responsable du pôle systèmes et réseaux, et intégré(e) à une équipe d’une dizaine de collaborateurs, vos missions (ou principales activités) seront les suivantes :


- Assurer le maintien en condition opérationnelle et la sécurité des infrastructures des systèmes d’information ;
- Définir et faire évoluer les architectures systèmes ;
- Apporter un support et une expertise à toutes les équipes de la DSI (Build, Run) dans une optique devops ;
- Rédiger et maintenir les documentations techniques.


Profil recherché :


Bac +5 en Informatique avec compétences dans la production informatique et l’administration avancée de VMWARE et des systèmes Unix/linux (Architecture, installation ; configuration, et exploitation)


Vous êtes à l’aise pour élaborer et rédiger les cahiers des charges techniques et vous connaissez la conduite de projet.


Vous maîtrisez l’anglais technique.
Organisé(e) et rigoureux (se), vous avez une aisance rédactionnelle et un bon esprit d’équipe.
Vous serez amené(e) à travailler dans un environnement stimulant avec de nombreux projets à forte technicité en collaboration active avec les équipes de développements.


Les avantages à nous rejoindre :


Dès votre arrivée à l’INPI et tout au long de votre parcours d’intégration, votre responsable vous épaulera et suivra votre évolution professionnelle.


Vous pourrez profiter de mesures RH attractives (mutuelle & prévoyance, logement, crèche, etc.) et des activités de notre association culturelle et sportive. Vous évoluerez dans un environnement de travail agréable (locaux modernes) et convivial (cafétéria, restaurant d''entreprise). Nos locaux se situent à proximité de la gare de Bécon-les-Bruyères (accès direct via le transilien vers Paris et la Défense en moins de 10 minutes). Nos parkings véhicules et vélos sont disponibles pour nos collaborateurs. Différents commerces et le parc arboré de la ville sont accessibles à 5 minutes à pied.


Poste basé à Courbevoie (92) ouvert au télétravail.


Type d''emploi : Temps plein, CDI


Rémunération : 40 000,00€ à 55 000,00€ par an


Avantages :




Prise en charge du transport quotidien


Restaurant d''entreprise


RTT


Travail à domicile occasionnel




Lieu du poste : Télétravail hybride (92400 Courbevoie)', 'Courbevoie', 'CDI', 40000.0, '', 0, NULL, '2026-03-31', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (6, 'Alternance Data Engineer (F/H)', 'Description :


L’ISCOD, spécialiste de la formation en Digital Learning, recherche pour son entreprise partenaire,
 un Data Engineer en contrat d''apprentissage,
 pour préparer l’une de nos formations diplômantes reconnues par l''Etat de niveau 5 à niveau 7 (Bac+2, Bachelor/Bac+3 et Mastère/Bac+5)


 Optez pour l’alternance nouvelle génération avec l''ISCOD !




Missions :


Vous serez en charge de concevoir, développer et maintenir les infrastructures et les pipelines de données permettant de collecter, transformer et mettre à disposition les données de l’entreprise de manière fiable et performante.




Concevoir et maintenir les pipelines de données (ETL/ELT)


Intégrer des données provenant de différentes sources (API, bases de données, outils métiers, fichiers externes)


Assurer la qualité, la fiabilité et la disponibilité des données


Optimiser les performances des bases de données et des flux de données


Mettre en place et maintenir les data warehouses ou data lakes


Collaborer avec les Data Analysts, Data Scientists et équipes métiers pour répondre aux besoins en données


Documenter l’architecture et les flux de données


Participer à l’amélioration continue de l’architecture data










Profil :




Vous disposez de connaissances solides en analyse de données et vous êtes à l’aise pour manipuler, structurer et interpréter des jeux de données variés. Une sensibilité aux enjeux de Propriété Intellectuelle est un avantage supplémentaire.


Vous maîtrisez Power BI et savez utiliser efficacement la suite Microsoft Office, notamment Excel, Word et PowerPoint, dans le cadre de vos travaux d’analyse et de restitution.


Autonome, rigoureux(se), organisé(e), vous êtes reconnu(e) pour votre communication, votre relationnel et votre capacité d’analyse et de synthèse. Vous avez une bonne capacité d''adaptation et savez être force de proposition. Vous aimez travailler en équipe.




Poste basé en Ile de France


Rémunération selon niveau d’études + âge


 Poste à pourvoir dès que possible !', 'Paris', 'CDI', 0.0, '1 an', 0, '2026-03-31', '2026-03-31', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (11, 'Ingénieur Infrastructure Système Réseaux & Infrastructures - F/H', 'Description


Notre client est une entreprise de service numérique chargée d''accompagner un acteur de référence sur les 
technologies de communication critiques
 (Défense, armement, gourvenement, etc).
 
 Dans le cadre d''un appel d''offre stratégique remporté, notre client renforce ses effectifs à travers des recrutements structurants, dont un 
Ingénieur Infrastructure Système Réseaux & Infrastructures - F/H. 
 Votre rôle sera d''assurer la conception et le design d’architectures réseaux critiques. Vous ne gérez pas un parc informatique, vous concevez un produit industriel complexe.




Concevoir, déployer et administrer les infrastructures réseaux (LAN, WAN, Wi‑Fi, sécurité) en coordination avec les équipes systèmes, cybersécurité et exploitation


Définir, suivre et mettre en œuvre les plans d’évolution du réseau afin de garantir la performance, la disponibilité et la sécurité des services


Assurer l’interface technique avec les fournisseurs, opérateurs télécoms et intégrateurs, et piloter les phases de mise en production


Identifier, analyser et réduire les risques liés à l’architecture réseau, en lien avec les équipes projet et sécurité


 
 Localisation : Genneviliers 
 Rémunération envisagée : entre 55K€ et 80K€ - la proposition sera adaptée en fonction de vos capacités à apporter de la valeur ajoutée au projet
 


 Profil recherché




Vous êtes Ingénieur de formation


Vous êtes habilitable


Vous êtes capable d''apporter votre vision, structurer, améliorer notamment sur l''aspect Delivery de l''équipe.', 'Gennevilliers', 'CDI', 55000.0, '', 0, NULL, '2026-03-31', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (12, 'Ingénieur système CBTC h/f', 'D’ici 2050, près de 70 % de la population mondiale vivra en ville. Pour répondre aux enjeux de mobilité urbaine durable, Siemens Mobility conçoit les trains et systèmes de signalisation qui dessinent la mobilité de demain : connectée, décarbonée et fluide.


De la ligne 14 à Paris aux lignes de Riyadh ou New York, nos technologies rendent déjà les transports plus intelligents, sûrs et accessibles.


Chaque jour, nous réduisons l’empreinte carbone de millions de trajets, une réussite portée par la diversité des profils présents dans notre entreprise.


Et ce n’est qu’un début.


Rejoignez-nous et venez mettre votre talent au service des mobilités de demain et d’un futur plus responsable.


Au sein de Siemens Mobility, vous êtes le pilier technique de nos projets CBTC. Vous concevez et pilotez des systèmes de pilotage automatique de métro, contribuant à façonner la mobilité urbaine de demain. Votre expertise est essentielle pour des solutions innovantes et performantes.


 Principales missions




Définir la solution technique, y compris sur de nouveaux produits, de système de transport adaptée aux besoins du client grâce à la collaboration interne et externe.


Assurer l''interface avec nos clients et apporter un support technique jusqu’à la mise en service.


Personnaliser et paramétrer la solution en fonction des spécificités de chaque projet.


Élaborer le référentiel Système pour guider efficacement les équipes de développement, de configuration et de tests.


Coordonner votre lot technique avec les autres départements (développement, tests, réseau, radio, cybersécurité, etc.) pour une intégration harmonieuse.






 Profil attendu


Vous êtes titulaire d''une formation d''ingénieur ou d''un master, et justifiez d''au moins 3 ans d’expérience dans un domaine technique, idéalement ferroviaire. Vous possédez une excellente compréhension des systèmes critiques et des enjeux liés à l’automatisation des transports. Une première expérience en management serait un atout. Votre anglais est courant, indispensable pour évoluer dans notre environnement international. Nous recherchons une personne proactive, adaptable et dotée de solides qualités relationnelles.


 Avantages


Bénéficiez d''avantages qui font la différence :




Une carrière sans frontières : Développez votre potentiel au sein d''un groupe international présent dans plus de 200 pays. Profitez d''opportunités de mobilité internationale et d''un environnement multiculturel stimulant.


Développement et engagement durable : Nous investissons dans votre évolution professionnelle grâce à une formation continue personnalisée, tout en œuvrant ensemble pour un avenir plus responsable.


Un équilibre vie pro/perso : Bénéficiez d''une organisation flexible avec télétravail partiel, horaires adaptables et nombreux RTT, pour une meilleure qualité de vie.


Un package attractif et complet : Profitez d''une rémunération compétitive, complétée par un système d''intéressement, une mutuelle avantageuse, et de nombreux avantages sociaux via notre CSE dynamique.




L''aventure vous attend ! Postulez maintenant !


Nous valorisons la diversité des parcours, des identités et des talents comme moteur d''innovation et de performance. Nous nous engageons à offrir à chacun des opportunités équitables et un accès juste au développement professionnel, en supprimant toute barrière, quels que soient l’origine, le genre, l’âge ou la situation de handicap.


Pour les candidats en situation de handicap, nous adaptons notre processus de recrutement. Pour un accompagnement personnalisé lors de votre candidature, contactez notre référent Mission Handicap : diversite.fr@siemens.com', 'Châtillon', 'CDI', 0.0, '', 3, NULL, '2026-03-31', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (13, 'Ingénieur support systèmes industriels F/H (SIT/TSI)', 'Rejoignez-nous en tant qu’Ingénieur support des systèmes industriels !
 
 La Direction opérationnelle Digital & Innovation conçoit, déploie et exploite tous les systèmes d’information et solutions digitales nécessaires à l’ensemble des activités du Groupe (transport, gestion des espaces, sureté).
 
 Au sein de cette direction, l’unité Télécoms & Systèmes Industriels réalise, délivre, exploite, maintient et assure la pérennité des Services Télécoms et des Systèmes Industriels cœurs de métier s’adressant aux voyageurs, aux exploitants et aux mainteneurs.
 
 Vous intégrez une équipe d''une dizaine de personne qui assure le support et l’expertise pour la reprise en maintenance, l’exploitation, l’administration, le maintien en conditions opérationnelles et l’assistance à maitrise d’œuvre des systèmes d’aide à l’exploitation des modes de transport de la RATP (Métro, RER, BUS et Tramway).
 


 01. Poste et Missions


Quel sera votre quotidien ?




Votre rôle sera principalement de :




Réaliser, piloter et coordonner les actions de maintenance corrective et évolutive dans le cadre de la gestion d’incidents, problèmes et changement.


Assurer une expertise technique sur les applications SI/ systèmes téléphonie en production.


Analyser la performance des systèmes et la qualité du service offert, définir et mettre en œuvre des actions correctives ou d’amélioration.


Définir, concevoir et mettre en œuvre les méthodes, processus, moyens et outils techniques pour la supervision et la maintenance de ces systèmes.


Définir, mettre en place et alimenter les référentiels dans le cadre de la gestion de la configuration.


Tester, valider et déployer les nouvelles infrastructures, versions logicielles des systèmes, en assurant la gestion de configuration.


Piloter les marchés de sous-traitance : stratégie industrielle, démarches achat (renouvellement, nouveaux marchés) et gestion.


Être le support technique des équipes projet : élaboration et validation des cahiers des charges, partage de la connaissance et des contraintes d’exploitation et de maintenabilité des systèmes, etc.


Concevoir et dispenser les formations techniques et fonctionnelles à destination des équipes de maintenance et de supervision.






Pour en savoir plus, cliquez sur le lien suivant : https://www.ratp.fr/groupe-ratp




 02. Profil recherché


Vous êtes diplômé d''un bac +5 d''une école d''Ingénieur ou Master à l''université en ingénierie Informatique ou Télécom et vous avez acquis 3 années d’expérience dans l’exploitation et la maintenance des systèmes informatiques ou télécom complexes.






Pour relever ces défis, nous recherchons une personne :






Ayant des connaissances générales des architectures informatiques, applicatives et télécoms et des connaissances en bases de données (Oracle, Postgres, MySQL)


Maîtrisant des environnements Linux, Windows Server et VMWare (administration, scripting BASH/VBS)


Capable de s’approprier des systèmes complexes intégrant les technologies d’information modernes


Qui connait les métiers de la maintenance : supervision, maintenance, support d’expertise


Ayant connaissance des processus d’intégration technique et de qualification des systèmes


Capable d''évaluer et maîtriser l’impact des opérations sur le service fourni au client


Ayant connaissance des techniques de prescription et de pilotage des marchés de sous-traitance


Ayant des notions sur le clustering et le systèmes d’haute disponibilité et des notions de programmation (type Perl, Python ou PHP)






Nous recherchons aussi une personne :




Dynamique, rigoureuse, autonome avec une bonne aptitude relationnelle.


Ayant des capacités d’analyse et de synthèse à l’oral et à l’écrit.


Capable d''anticiper, de gérer les priorités, d''être force de proposition.


Capable de travailler en équipe dans des environnements impliquant de nombreux acteurs (Projets, Exploitation Transport, Maintenance, Fournisseurs industriels).






Vous vous reconnaissez ? N’hésitez pas à postuler directement en ligne




Tous nos métiers sont ouverts aux personnes en situation de handicap.




 Conditions de travail Lieu et horaires : 




Contrat CDI


Noisy le Grand


Horaires de bureau avec intégration au dispositif d’astreinte


Permis B demandé






 03. Informations complémentaires
 Région :Ile de France
 










































Type de contrat :










































 Durée Indéterminée', 'Noisy-le-Grand', 'CDI', 0.0, '', 3, NULL, '2026-03-31', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (14, 'Data Engineer (H/F)', 'Description de l''entreprise


 Inetum est un leader européen des services numériques. Pour les entreprises, les acteurs publics et la société dans son ensemble, les 28 000 consultants et spécialistes du groupe visent chaque jour l''impact digital : des solutions qui contribuent à la performance, à l''innovation et au bien commun.


Présent dans 19 pays au plus près des territoires, et avec ses grands partenaires éditeurs de logiciels, Inetum répond aux enjeux de la transformation digitale avec proximité et flexibilité.


Porté par son ambition de croissance et d''industrialisation, Inetum a généré en 2023 un chiffre d''affaires de 2,5 milliards d''€.


Pour répondre à un marché en croissance continue depuis plus de 30ans, Inetum a fait le choix délibéré de se recentrer sur 4 métiers afin de gagner en puissance et proposer des solutions sur mesure, adaptées aux besoins spécifiques de ses clients : le conseil (Inetum Consulting), la gestion des infrastructures et applications à façon (Inetum Technologies), l''implémentation de progiciels (Inetum Solutions) et sa propre activité d''éditeur de logiciels (Inetum Software). Inetum a conclu des partenariats stratégiques avec 4 grands éditeurs mondiaux - Salesforce, ServiceNow, Microsoft et SAP et poursuit une stratégie d''acquisitions dédiée afin d''entrer dans le top 5 européen sur ces technologies et proposer la meilleure expertise à ses clients.
 Description du poste


 Nous ne sommes pas seulement spécialisés dans le numérique. Nous intervenons également sur la 
data
. Nous possédons une Practice Data qui se développe fortement grâce à nos partenaires stratégiques comme 
Snowflake, Informatica, Talend, Microsoft Azure, AWS, GCP
, ou encore de gros éditeurs du marché comme Databricks, Dataiku, Microstrategy, Teradata, etc... Aujourd’hui, nous sommes capables d’asseoir notre expertise en accompagnant nos clients sur toute la chaîne de valorisation data (cas d’usage, développement, architecture, innovation, industrialisation).


A ce titre, vous rejoindrez un programme 
d’envergure internationale, d''ultraconcentration bancaire
 et contribuerez à la conception, au développement et à la maintenance de nos pipelines de données. Vous serez le garant de la bonne gestion des données, de la collaboration inter-équipes et de l’amélioration continue des processus et des technologies utilisées.


Missions principales :




 Conception et développement de pipelines de données : 
Élaborer et mettre en place des pipelines de données robustes et évolutifs pour garantir une gestion efficace des flux de données.


 Traitement et analyse des données : 
Utiliser des technologies telles que Spark, Scala ou Python pour le traitement et l''analyse des données, en assurant des performances optimales.


 Collaboration inter-équipes : 
Travailler en étroite collaboration avec les équipes de data science et de développement pour intégrer les solutions de données et assurer une synergie entre les différents départements.


 Optimisation des performances : 
Améliorer les performances des systèmes de traitement de données pour maximiser l''efficacité et la rapidité des opérations.


 Gestion des données : 
Mettre en œuvre les meilleures pratiques de gestion des données, en veillant à la qualité des données et à la gouvernance pour garantir la conformité et la fiabilité des informations.


 Participation aux cérémonies agiles : 
Participer activement aux rituels agiles, y compris les daily stand-ups, les sprint planning, les sprint reviews et les rétrospectives, pour assurer une gestion de projet agile et collaborative.


 Documentation technique : 
Rédiger et mettre à jour la documentation technique pour garantir la traçabilité et la compréhension des systèmes et des processus.




Compétences techniques recherchées :




Minimum 5 ans d''expérience en tant que Data Engineer.


Environnement cloud (AWS)


 Très bonne maîtrise de Scala est nécessaire


Bonne connaissance de 
Spark


Bonne connaissance des bases de données relationnelles et non relationnelles.


Maîtrise des 
outils de versioning (Git).


Capacité à travailler en équipe et à communiquer efficacement.


Esprit d''analyse et de résolution de problèmes.


Capacité à s''adapter à de nouvelles technologies


 
 Qualifications


 Profil :




Vous êtes issu(e) d’une formation Bac+5 en informatique, data science ou équivalent.


Vous justifiez de minimum 
5 ans d''expérience
 en traitement de données.


Vous maîtrisez parfaitement 
Scala


Vous avez une bonne connaissance de 
Spark


Vous êtes capable de travailler dans un environnement cloud


Vous faîtes preuve d''initiative et êtes proactif dans la suggestion d’améliorations.




Vos mots d’ordre sont :




Amélioration continue,


Travail en équipe et communication efficace avec les membres de l''équipe,


Partage des connaissances,


Travail dans un environnement dynamique et en constante évolution,


Résolution rapide et efficace des problèmes.


 
 Informations supplémentaires


 Vos avantages :


27 jours de congés payés + 10 RTT


Tickets restaurant : D''une valeur de 9€ (Prise en charge à 60% par Inetum)


‍ Suivi de carrière individualisé : avec votre manager, leader technique ou chef de projet en proximité tout au long de l''année en plus des entretiens annuels et professionnels.


Parcours d''intégration unique et personnalisé : Accompagnement, référent, rencontre avec les équipes pour vous familiariser avec les valeurs du groupe.


Les petits + Inetum :


Un accord télétravail flexible : 2 jours à 3 jours par semaine en fonction de notre client


Une prise en charge à 70% des frais de transport en commun dans le cadre de vos déplacements professionnels


Politique de formation avantageuse : Formations et Certifications techniques, fonctionnelles, testing, méthodologie et gestion de projet, développement personnel…)


Des animations d''agence régulière avec les équipes Inetum : Soirées jeux, Afterworks, activité teambuilding …


L''opportunité de transmettre votre savoir en tant qu''expert : Animation de Techlunch, participation à des meetup techniques, prise de parole sur des conférences, dans des écoles ou sur des événements.




 Notre processus de recrutement :


Un entretien avec une chargée de recrutement.


Un entretien avec un membre de l''équipe


Un entretien avec le client


Un retour rapide à la suite de nos échanges


Démarrage de la mission le plus tôt possible', 'Saint-Ouen', 'CDI', 0.0, '', 5, '2026-03-31', '2026-03-31', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (4, 'Ingénieur système Export (F/H)', 'Lieu : Rungis, France
 


 Construisons ensemble un avenir de confiance




Thales est un leader mondial des hautes technologies spécialisé dans trois secteurs d’activité : Défense & Sécurité, Aéronautique & Spatial, et Cyber & Digital. Il développe des produits et solutions qui contribuent à un monde plus sûr, plus respectueux de l’environnement et plus inclusif. Le Groupe investit près de 4 milliards d’euros par an en Recherche & Développement, notamment dans des domaines clés de l’innovation tels que l’IA, la cybersécurité, le quantique, les technologies du cloud et la 6G. Thales compte près de 81 000 collaborateurs dans 68 pays.




Nos engagements, vos avantages




Une réussite portée par notre excellence technologique, votre expérience et notre ambition partagée


Un package de rémunération attractif


Un développement des compétences en continu : parcours de formation, académies et communautés internes


Un environnement inclusif, bienveillant et respectant l’équilibre des collaborateurs


Un engagement sociétal et environnemental reconnu






 Votre quotidien
 Nous fournissons et soutenons des systèmes pour la gestion et la protection de l''espace aérien. Nous travaillons avec passion dans un cadre architectural moderne, et s''efforce de repousser les limites de la technologie dans nos secteurs clés. Au sud de Paris, notre site est facilement accessible en transport en commun.
 


Le GIE Eurosam (ES) est une co-entreprise associant Thales et MBDA (France et Italie) dont l’objet est d’être Prime et Design Authority (DA) des Systèmes de défense Terrestres et Navals mis en service au sein des Forces Françaises et Italiennes.




Le poste se situe au Département Technique d''Eurosam, dans l''équipe Ingénierie en charge des spécifications, développement et validation des développement.




Au sein de l''équipe Ingénierie, les missions sont les suivantes :






A partir du référentiel système du SAMP/T NG variante Fr, établir le référentiel système du SAMP/T NG Danemark en tenant compte des spécificités Danemark


Suivre le développement des sous-systèmes


Participer aux revues techniques


Définir les essais à mener pour valider les évolutions


Participer aux réunions techniques avec le client






Toutes ces missions sont assurées en étroite collaboration avec le (la) Responsable de l''équipe Ingénierie eurosam, les membres des équipes Ingénierie et Essais eurosam, et les membres des équipes Ingénierie de Thales, MBDA It et MBDA Fr.


 Votre profil




Vous avez des connaissances dans le domaine des systèmes air/ sol et dans le domaine du système et la gestion des exigences.


Vous avez la capacité à travailler en équipe dans un environnement international. Vous êtes ouvert d''esprit, vous êtes réactif et vous avez le sens du contrat client.


 Thales, entreprise Handi-Engagée, reconnait tous les talents. La diversité est notre meilleur atout. Postulez et rejoignez nous !
 
 Le poste pouvant nécessiter d''accéder à des informations relevant du secret de la défense nationale, la personne retenue fera l''objet d''une procédure d’habilitation, conformément aux dispositions des articles R.2311-1 et suivants du Code de la défense et de l’IGI 1300 SGDSN/PSE du 09 août 2021.', 'Rungis', 'CDI', 0.0, '', 0, NULL, '2026-03-31', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (15, 'Ingénieur système et réseau (F/H)', 'Chez Atos, nous contribuons à façonner un avenir numérique enrichi par l’intelligence artificielle. Notre mission : réunir les meilleurs talents, technologies et partenaires, pour faire progresser la transformation digitale au quotidien.
 



  Des environnements critiques aux services cloud et de cybersécurité, nous guidons nos clients pour les amener là où ils ont besoin d’aller.
 



  Nos technologies sont fluides, sécurisées et conçues pour être responsables. Avec l’innovation intégrée dans tout ce que nous faisons, nous réinventons l’avenir pour nos clients, nos collaborateurs et la société dans son ensemble.
 












Rejoignez une aventure qui a du sens:





    En tant qu’
Ingénieur Système et Réseau
, vous serez responsable de la conception, de la mise en œuvre et de la gestion de notre infrastructure informatique. Vous assurerez la disponibilité et la performance des systèmes et réseaux, tout en garantissant la sécurité des données.
   






 Vos missions à nos côtés:






Concevoir et déployer des architectures réseau et des systèmes informatiques adaptés aux besoins de l''entreprise ;


Installer, configurer et maintenir les serveurs, les équipements réseau et les systèmes de stockage ;


Assurer la surveillance et l’optimisation des performances des systèmes et réseaux ;


Diagnostiquer et résoudre les incidents techniques en garantissant un support de qualité aux utilisateurs ;


Mettre en œuvre des solutions de sécurité pour protéger les données et les infrastructures contre les menaces ;


Collaborer avec les équipes de développement et d''autres départements pour assurer l''intégration et le bon fonctionnement des applications


Participer à des projets d''amélioration continue et à l''innovation technologique








 Les atouts pour réussir:





    Vous êtes issu(e) d’une formation supérieure 
Bac+5
 Ecole d’ingénieur ou cursus universitaire, et justifiez d''au moins 
3 années
 d’expérience sur un poste similaire.
   



    Vous maîtrisez des environnements Windows et Linux, ainsi que des technologies de virtualisation (VMware, Hyper-V).
   



    Vous avez des connaissances en protocoles réseau (TCP/IP, DNS, DHCP, etc.) et en sécurité des systèmes d''information.
   



    Vous détenez des capacités à diagnostiquer des problèmes techniques et à proposer des solutions efficaces.
   



    Et si en plus vous avez une bonne communication et savez travailler en équipe, alors vous avez l’ensemble des atouts pour réussir à ce poste.
   






 Rémunération:





    Fourchette de salaire : entre 40k€ et 50k€
   






 Ce que nous proposons:






Possibilité de travailler de façon hybride (
télétravail 
jusqu’à 3 jours par semaine)


Tickets restaurant
 (valeur faciale de 10€, 60% pris en charge par l’employeur)


Évènements d''intégration et autres événements internes


Disponibilité de tous
 vos congés et RTT dès votre arrivée


Programme de cooptation jusqu’à 
2750 € de prime


Accès aux activités sociales et culturelles


Aide à la mobilité durable (vélo et covoiturage)








 Votre avenir chez Atos:






Des opportunités de développement professionnel et d’évolution de carrière


Plus de 600 formations certifiantes et plateforme e-learning


Un accompagnement de proximité








 Prêt(e) à faire partie de l’aventure ? Faites la différence et rejoignez la teams Atos !


























En savoir plus
 La diversité est un moteur au service de la créativité de nos clients, et nous nous efforçons chaque jour de créer un environnement où chacun se sent soutenu et encouragé.
 La « Tech for Good » s''inscrit au cœur de notre mission, que ce soit en matière de lutte contre le changement climatique, pour promouvoir l''inclusion numérique ou garantir la confiance dans la gestion des données.
 Nous sommes fiers des nombreuses reconnaissances mondiales pour nos pratiques environnementales, sociales et de gouvernance, et nous nous engageons à construire un avenir meilleur pour tous en exploitant le pouvoir de la technologie.', 'Bezons', 'CDI', 40000.0, '', 3, NULL, '2026-03-31', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (13, 'Ingénieur système ferroviaire H/F (INFRA/STF)', 'Rejoindre la RATP, c’est intégrer l’un des plus grands réseaux de transport urbain au monde et contribuer chaque jour à la mobilité de plus de 8 millions de voyageurs en Île-de-France. Nos 48 000 collaborateurs assurent la circulation des bus, métros, RER et tramways, modernisent nos infrastructures et développent des solutions innovantes pour une mobilité plus durable. Ici, vos compétences participent directement à un service public essentiel, tout en vous offrant de nombreuses perspectives d’évolution au sein d’une grande diversité de métiers. Vous intégrez la Business Unit RATP Infrastructures qui assure les missions de gestionnaire d''infrastructures. Elle est responsable de l''aménagement, de l''entretien et du renouvellement de l''infrastructure, et garantit dans la durée le maintien des conditions de sécurité, d''interopérabilité et de continuité du service public. 
 Dans le cadre des activités de maîtrise d’œuvre de l’unité, vous êtes en charge des activités d’études transverses, d’expertise concernant les systèmes de d''automatisme déployés par l’ingénierie de la RATP sur son domaine ferré.
 


 01. Poste et Missions


Vous intervenez principalement sur des systèmes d''automatisme de conduite déployés ou en cours de déploiement et serez amené à travailler sur le cohérence entre ces projets et les projets en cours de reprise en maintenance par le Gestionnaire d''Infrastructure du Grand Paris. Dans le cadre de votre mission, vous interviendrez sur la capacité d''intégrer sur ces projets les méthodes d''ingénierie système et d''intégration




Vous intervenez sur les 
missions suivantes
:




 En lien avec les équipes projet des entités métiers qui s''assurent de la bonne marche des projets, vous:






 Spécifiez, concevez, intégrez et validez les système d''automatisme ferroviaire,.


 Intégrer les systèmes d''automatisme ferroviaire dans les architectures des systèmes ferroviaires et assurez le suivi technique du fournisseur en charge de la fourniture de ces équipements.


 Veillez à la prise en compte des règles et des normes de sécurité des systèmes dans les architectures mises en place et participez aux analyses de risques liées à ce domaine et assurez la cohérence des architectures vis-à-vis de considérations liées à la résilience et à la sécurité informatique des systèmes.








Dans le cadre de ces projets, vous participerez en lien avec les équipes d''intégration :






 A la mise en place de méthode d''ingénierie système (modélisation système, use case,...)


 A la définition de l''apport de ces méthodes dans le cadre de l''amélioration de la qualité et de la performance de ces projets ainsi qu''a la définition de l''impact de ces méthodes sur les stratégies de d''Intégration, Validation, Vérification et Qualification








Au delà des projets vous interviendrez dans le cadre de la reprise en maintenance du Gestionnaire d''Infrastructure du Grand Paris:






 Vous participerez a des missions d''expertise système afin de faciliter la reprise en maintenance par la RATP


 Vous assurerez une veille sur ces projets ainsi que la transversalité des réflexions pour porter certaines méthodes/systèmes/technologie des systèmes du Grand Paris vers les projets en cours ou à venir








En tant qu''expert et de part votre position transverse vous devez également:






 Garantir l’homogénéité et l’atteinte de la performance globale des systèmes, leur maintenabilité et leur évolutivité (disponibilité, conformités aux besoins spécifiés, obsolescences, etc.).


 Apporter votre support aux services de maintenance dans leur appropriation du fonctionnement des systèmes d''automatismes ferroviaires, ainsi que dans leurs activités de maintien en condition opérationnelle (traitement préventif, prédictif, obsolescences).


 Conduire des études d''expertise dans le domaine des systèmes ferroviaires.


 Etre le garant du plan d''adressage des systèmes du transport ferroviaire et contribuer à l’Innovation/Recherche en étant force de proposition.


 Mettre en œuvre, superviser et participer à des activités terrain dans le cadre des projets ou des expertises.






 Conformément à la loi n°2016-339 du 22 mars 2016 et au décret n°2017-757 du 3 mai 2017 pris en son application, une enquête administrative sera sollicitée auprès des services du ministère de l’Intérieur pour tout candidat sur ce poste.




 02. Profil recherché


Diplômé d’un bac+5 , vous présentez une expérience d’au moins 5 ans dans l’ingénierie des systèmes ferroviaires. Vous maîtrisez par ailleurs les technologies et architectures télécoms et disposez de capacité d’analyse, de synthèse et d’une approche globale des problèmes. Une très bonne connaissance des méthodes d''ingénierie systèmes et d''intégration est souhaitée.




Pour cela, nous recherchons une personne qui a une :




Solide capacité d’analyse et de synthèse


Rigueur, organisation et sens des responsabilités


Aptitude à la gestion de projet et au travail en équipe


Excellentes compétences en communication écrite et orale






Tous nos métiers sont ouverts aux personnes en situation de handicap. Pour initier votre embauche, votre casier judiciaire B3 vous sera demandé.




 Informations complémentaires




Contrat : CDI


Localisation : Val de Fontenay


Télétravail : oui possible


Rémunération : à définir selon expérience (minimum à 52k BA fixe hors primes)






Avantages :




Possibilité d''évolution vers d’autres métiers y compris en filiales internationales


9 semaines de congés, soit 206 jours travaillés par an


Gratuité sur le réseau RATP et 90% de prise en charge sur le réseau IDF hors RATP


Prise en charge de 75% de l''abonnement hors IDF si concerné


Accès gratuit à une variété de spécialistes médicaux au sein de nos espaces santé, incluant des médecins généralistes, des dermatologues, des ophtalmologues






Pour en savoir plus sur le Groupe RATP, cliquez sur le lien suivant : https://ratpgroup.com/fr/




 03. Informations complémentaires
 Région :Ile de France
 










































Type de contrat :










































 Durée Indéterminée', 'Val de Fontenay', 'CDI', 52000.0, '', 5, NULL, '2026-03-31', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (16, 'Data Engineer - H/F', 'Description de l''entreprise


 Sia est un groupe international de conseil en management de nouvelle génération, fondé en 1999. Nés à l''ère du digital, nous sommes augmentés par la data, enrichis par la créativité et guidés par la responsabilité. Nous collaborons avec nos clients pour relever les défis et saisir les opportunités. Dans un monde en pleine mutation, nous croyons que l’optimisme est un puissant levier de transformation. Avec une expertise couvrant un large éventail de secteurs et de services, nos 3 000 consultants accompagnent des clients dans le monde entier, depuis 48 bureaux répartis dans 19 pays. Notre expertise produit des résultats concrets. Notre optimisme change la donne
 Description du poste


 Sia recrute un(e) Data Engineer pour accompagner le développement des activités de la Business Unit Data Science.


Vous serez amené(e) à participer aux missions Data Science de Sia chez nos clients.. Vous accompagnerez des Data Scientists, Software Engineers et DevOps Engineers dans des projets à forte composante Data, dans le but de répondre à des challenges techniques autour du 
stockage
, 
flux
 et 
traitement de données
. Vous contribuerez activement aux choix technologiques, architecturaux et de gouvernance pour faire face aux enjeux de la mise à l’échelle de projets Data.


Les travaux couvriront les thèmes suivants :




 Pipelines de données 
: développement de scripts d’ETL dans des écosystèmes Big Data


 Infrastructures & Services adaptés au Machine Learning
 : veille technologique et mise en place de solutions utiles aux Data Scientists dans l’entraînement et la mise à disposition de leurs modèles de Machine Learning


 Programmation en python 
: développement d''outils exécutés côté serveur (traitement de données en masse, exposition des données via des APIs, ...)


 Services Cloud
: choix d''architecture, utilisation de services de stockage & calcul


 
 Qualifications


 Diplômé(e) d''une formation en École d''Ingénieur ou d''une
 
formation de haut niveau dans le domaine des technologies de l’information, 
vous justifiez d''une
 première expérience d''au moins 2 ans
 en Data, DevOps, Cloud ou Software Engineering.




Vous disposez d''un 
bon niveau en Python
, vous permettant de qualifier, enrichir, et traiter de la donnée.
   


C’est un plus si vous maîtrisez un autre langage de programmation




Vous maîtrisez les bases de données 
relationnelles
 (PostgreSQL, SQLServer, …)
   


C’est un plus si vous maîtrisez un autre paradigme de base de données (Wide-column, Key-value, …)




Vous avez de l’expérience avec des outils de
 calcul distribué
, tels que Hadoop ou Spark ou vous avez de l’expérience avec des outils de Machine Learning, tels que Tensorflow ou Torch


C’est un plus si vous avez de l''expérience avec les services d’
au moins une plateforme de services Cloud
 (GCP, AWS, Azure)




Pour vous, il est essentiel…




d’aller 
au fond des choses 
: Il est important pour vous de comprendre toutes les nuances de votre dataset


d’avoir un état d’esprit “
Do it yourself
” : Monter en compétence sur une technologie en autonomie pour répondre à une problématique ne vous fait pas peur


d’être 
curieux(se) 
: Le monde de la data avance vite, mais vos capacités de veille vous permettent de rester à jour




Vous disposez d''une appétence pour les enjeux liés à la data et l''IA, d''une capacité à monter en compétences rapidement sur ces sujets et êtes enthousiaste à l''idée d''accompagner nos clients à en saisir les opportunités.


Vous êtes curieux(se) et aimez travailler en équipe ? Vous êtes reconnu(e) pour votre sens de l’analyse ?
 Vous souhaitez rejoindre un environnement professionnel dynamique et motivant ? Vous partagez nos valeurs que sont l''excellence, l''entrepreneuriat, l''innovation, le partage, la bienveillance et l''équilibre vie personnelle/vie professionnelle ?


Vous parlez français et anglais couramment dans un contexte professionnel ?


Alors rejoignez-nous !
 Informations supplémentaires


 Locaux situés en plein coeur de Paris


Découvrez notre site carrière et parcourez notre vitrine Welcome To The Jungle




Sia est un employeur qui souscrit au principe de l’égalité d’accès à l’emploi. Tous les aspects de l’emploi, tels que le recrutement, les promotions, la rémunération, ou les sanctions sont basés uniquement sur les performances, les compétences, et le comportement des employés ou les besoins de l’entreprise.', 'Paris', 'CDI', 0.0, '', 2, NULL, '2026-03-31', FALSE);

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
