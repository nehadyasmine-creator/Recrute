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
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('Institut Curie', 'Orsay', 'Santé', 'https://curie.fr', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('Elsys Design', 'Créteil', 'Électronique', 'https://www.elsys-design.com', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('ONSPARK', 'Paris', 'Informatique', 'https://onspark.fr/', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('Banque Française Mutualiste', 'Paris', 'Banque', 'https://www.banque-francaise-mutualiste.fr', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('Société Générale', 'La Défense', 'Finance', 'https://www.societegenerale.com', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('Thales', 'Gennevilliers', 'Défense', 'https://www.thalesgroup.com', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('Haute Autorité de Santé', 'Saint-Denis', 'Santé', 'https://www.has-sante.fr/', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('Collective.work', 'Paris', 'Informatique', 'https://collective.work', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('CS Instruments', 'Les Ulis', 'Nanotechnologie', 'https://csinstruments.com/', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('INPI', 'Courbevoie', 'Informatique', 'https://www.inpi.fr', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('ISOSKELE', 'Paris', 'Marketing', 'https://www.isoskele.fr/', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('BIOMEN', 'Levallois-Perret', 'Santé', 'https://www.biomen.fr', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('ALTEN', 'Boulogne-Billancourt', 'Aéronautique', 'https://www.alten.fr/', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('RIVAGE INVESTMENT', 'Paris', 'Finance', 'https://www.rivage-investment.com', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('IDEM for STUDIEL SERVICES', 'Île-de-France', 'Aéronautique', 'https://www.idem-group.com/', 'grand_groupe');
INSERT INTO Entreprise (nom, siegesocial,secteur, siteweb, taille) VALUES ('Withings', 'Issy-les-Moulineaux', 'Santé', 'https://www.withings.com', 'grand_groupe');
-- Recruteurs (Utilisateurs)
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Puiseux', 'Pierre', 'pierre.puiseux@gmail.com', '+33698549499', '$2b$10$/eFVi4D3NYGzk1G0SL7J9ePvPhtHdtNtzbZQHILGKUaYMpyhQN/EW', 'recruteur','2026-05-19');
INSERT INTO Recruteur (id_utilisateur, id_entreprise, poste) VALUES (1, 1, 'Responsable RH');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Puiseux', 'Gaetan', 'gaetan.puiseux@gmail.com', '+33743643860', '$2b$10$8V3O0WsgGMnk0Tkq/tYVuefD9FCAFbHzMtErO09FQ15o6BXi33ssC', 'recruteur','2026-05-19');
INSERT INTO Recruteur (id_utilisateur, id_entreprise, poste) VALUES (2, 2, 'Responsable RH');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Puiseux', 'Malo', 'malo.puiseux@gmail.com', '+33722841691', '$2b$10$rGjMIA8tusElq0U248t2zuHqN/vez7lax/HcxQaAUKafzSPZER0B6', 'recruteur','2026-05-19');
INSERT INTO Recruteur (id_utilisateur, id_entreprise, poste) VALUES (3, 3, 'Responsable RH');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Puiseux', 'Yasmine', 'yasmine.puiseux@gmail.com', '+33774552383', '$2b$10$o.mR90xhpVYNqfVDRPb/YeFrHf6rRp5wbJ5VnpTFP60.XUFLbp/hu', 'recruteur','2026-05-19');
INSERT INTO Recruteur (id_utilisateur, id_entreprise, poste) VALUES (4, 4, 'Responsable RH');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Puiseux', 'Clément', 'clément.puiseux@gmail.com', '+33624620132', '$2b$10$LGzb9DpsXmgrfdSx8Vk9EOlrpW2YPWeRta7LwpRAyZF2D4Ll5r3Su', 'recruteur','2026-05-19');
INSERT INTO Recruteur (id_utilisateur, id_entreprise, poste) VALUES (5, 5, 'Responsable RH');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Puiseux', 'Martin', 'martin.puiseux@gmail.com', '+33629280511', '$2b$10$eKi7bxDvW5E/eLr6HvTE9OKIP2tdQGmN6Nd8vsy7AMgpQ67JxZNuK', 'recruteur','2026-05-19');
INSERT INTO Recruteur (id_utilisateur, id_entreprise, poste) VALUES (6, 6, 'Responsable RH');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Ingrachen', 'Pierre', 'pierre.ingrachen@gmail.com', '+33691635670', '$2b$10$XpoXtT8LXBlOW6QY0.1JcOFwJ3ivalEwUWodrtY4Hhs87fg9lRx1m', 'recruteur','2026-05-19');
INSERT INTO Recruteur (id_utilisateur, id_entreprise, poste) VALUES (7, 7, 'Responsable RH');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Ingrachen', 'Gaetan', 'gaetan.ingrachen@gmail.com', '+33687209855', '$2b$10$4z4Yk6eaxNKmuKbBOM8qpOLs96NdWHYpz1jKlH5SstnYR13eeNIW2', 'recruteur','2026-05-19');
INSERT INTO Recruteur (id_utilisateur, id_entreprise, poste) VALUES (8, 8, 'Responsable RH');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Ingrachen', 'Malo', 'malo.ingrachen@gmail.com', '+33783016189', '$2b$10$il3zgu.IZuMogDahQ83xSOn5U9Ufb2Q0/18NxMACdv1LnWnIGaZb6', 'recruteur','2026-05-19');
INSERT INTO Recruteur (id_utilisateur, id_entreprise, poste) VALUES (9, 9, 'Responsable RH');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Ingrachen', 'Yasmine', 'yasmine.ingrachen@gmail.com', '+33685384041', '$2b$10$XAY6F1Exi.O8KXeVRR6rTeBKjMq8rc4E6ACAXrPITu7uA6BdCnjoK', 'recruteur','2026-05-19');
INSERT INTO Recruteur (id_utilisateur, id_entreprise, poste) VALUES (10, 10, 'Responsable RH');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Ingrachen', 'Clément', 'clément.ingrachen@gmail.com', '+33665282324', '$2b$10$p6MYEbIxxqmERFj8jDdSQO0ZxcdDMwkDJXXZ3c4lxdoM7LVKZM9u.', 'recruteur','2026-05-19');
INSERT INTO Recruteur (id_utilisateur, id_entreprise, poste) VALUES (11, 11, 'Responsable RH');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Ingrachen', 'Martin', 'martin.ingrachen@gmail.com', '+33645463034', '$2b$10$T7iOGbExlyQEHXPKZf23AO6mZJqrAksxxxMi0uOt/ie62aCGtQmnW', 'recruteur','2026-05-19');
INSERT INTO Recruteur (id_utilisateur, id_entreprise, poste) VALUES (12, 12, 'Responsable RH');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Ladan', 'Pierre', 'pierre.ladan@gmail.com', '+33622777301', '$2b$10$UrdD5lXHoc.h81xM3G7wiuNSln4Pj6dDF/k/zXG25J6tu1Vv6A.wu', 'recruteur','2026-05-19');
INSERT INTO Recruteur (id_utilisateur, id_entreprise, poste) VALUES (13, 13, 'Responsable RH');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Ladan', 'Gaetan', 'gaetan.ladan@gmail.com', '+33700336790', '$2b$10$LgKsRFu9qu42PJq4AAr8qOul74BIv4JNS5bTavXLQ2GdtuKk8In/q', 'recruteur','2026-05-19');
INSERT INTO Recruteur (id_utilisateur, id_entreprise, poste) VALUES (14, 14, 'Responsable RH');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Ladan', 'Malo', 'malo.ladan@gmail.com', '+33707410137', '$2b$10$nnrKK7HC3u9RFdXKxTBng.sXr.MhNCes7qwD7Zn39oG/OkBh4YAbq', 'recruteur','2026-05-19');
INSERT INTO Recruteur (id_utilisateur, id_entreprise, poste) VALUES (15, 15, 'Responsable RH');
INSERT INTO Utilisateur (nom, prenom, email, telephone, motDePasse, role, dateCreation) VALUES ('Ladan', 'Yasmine', 'yasmine.ladan@gmail.com', '+33778703037', '$2b$10$l3yU85K6mhlhjQVfayGvvuJikFCDTAhF.oTB1yFNfl4vSP8QFONP.', 'recruteur','2026-05-19');
INSERT INTO Recruteur (id_utilisateur, id_entreprise, poste) VALUES (16, 16, 'Responsable RH');

-- ==========================
-- Offres
-- ==========================
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (1, 'Ingénieur en Imagerie préclinique (H/F)', 'CDD
    



     Orsay
    




 Ingénieur en Imagerie préclinique (H/F)




Centre de Recherche

















      L''Institut Curie est un acteur majeur de la recherche et de la lutte contre le cancer. Il est constitué d''un hôpital et d''un Centre de recherche de plus de 1000 collaborateurs avec une forte représentativité internationale.


L’objectif du Centre de recherche de l’institut Curie est de développer la recherche fondamentale et d’utiliser les connaissances produites pour améliorer le diagnostic, le pronostic, la thérapeutique des cancers dans le cadre du continuum entre la recherche fondamentale et l’innovation au service du malade.









       Missions détaillées


Sous l’autorité du Responsable de la Plateforme, l’ingénieur.e devra :






Réaliser les acquisitions d’images (µTEP/ µTDM embarqué) ;




Assurer un suivi de maintenance, de fonctionnement et de gestion des appareillages de la plateforme intégrant les formations pratiques des utilisateurs ;




Participer à la mise en place et réaliser les contrôles qualité sur les systèmes d’imagerie et d’irradiation de la plateforme ;




Participer aux acquisitions d’images et/ou aux mises en place de protocoles pour l’imagerie multimodale ;




Participer aux irradiations sur les animaux et les cellules sur les systèmes d’irradiation de la plateforme et au Centre de Protonthérapie ;




Réaliser les développements technologiques pour l’utilisation des systèmes d’imagerie et d’irradiation ;




Exploiter et présenter les résultats des mesures pour rédiger des rapports d’expériences, notes techniques ;




Développer des activités de conseil et de formation auprès des utilisateurs et partenaires scientifiques ;




Se tenir informé des évolutions techniques et les mettre en œuvre au sein de la plateforme ;




Assurer un suivi de maintenance, de fonctionnement, de la formation et de gestion des appareillages de la plateforme ;




Assurer la gestion des animaux (dont rongeurs) inclus dans les projets (en animalerie : suivi (change, socialisation (rats), suivi de poids)), transfert des animaux, anesthésie et mise en place sur les équipements de la plateforme
.








 Formation et expérience






Bac +5/+8 en physique, physique médicale, imagerie ;




Poste ouvert aux personnels hospitaliers tels que manipulateurs en électroradiologie, aides physiciens, etc.




Expériences professionnelles souhaitées : 2 à 5 ans ;




Habilitations souhaitées : Expérimentation animale niveau I (Concepteur) ;




Avoir de bonnes connaissances associées à l’imagerie TEP.





       Compétences et qualités requises






Dosimétrie ;




Acquisition, interprétation d’images scanner et TEP ;




Analyse d’images ;




Utilisation des outils informatiques de bureautique ;




Sur le petit animal (rat, souris) : contention, anesthésie, injection ;




Compétences linguistiques : maitrise du français (non obligatoire) et de l’anglais.







        Toutes nos opportunités sont ouvertes à des personnes en situation de handicap.



       Type de contrat :
 CDD


 Date de démarrage :
 Dès que possible


 Durée du contrat :
 36 mois


 Temps de travail :
 Temps complet - 39 heures par semaine


 Rémunération :
 selon les grilles en vigueur


 Avantages :
 Restauration collective, prise en charge du titre de transport annuel à 70%, mutuelle d’entreprise


 Localisation du poste :
 Orsay





       Contact


Pour postuler, merci d’envoyer CV et lettre de motivation à


 Date de parution de l’offre : 16/10/2025


 Date limite des candidatures : Dès que pourvue





        L''Institut Curie est un employeur inclusif respectant l''égalité des chances.


 Il s’engage également à appliquer des normes exigeantes en matière d''intégrité de la recherche.


https://euraxess.ec.europa.eu/sites/default/files/brochures/eur_21620_en-fr.pdf', 'Orsay', 'CDD', 0.0, '36 mois', 2, '2026-05-12', '2026-05-12', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (2, 'Ingénieur Conception Électronique Analog/Power - H/F', 'Contexte


Dans le cadre du développement de systèmes électroniques embarqués critiques, nous recherchons un 
Ingénieur en électronique analogique et de puissance
 pour concevoir des convertisseurs haute fiabilité destinés à des applications spatiales.


Missions principales




Conception et dimensionnement de convertisseurs DC-DC / AC-DC (Forward, Flyback, Buck, DAB…)


Design de circuits analogiques de protection (OVP, UVP, OCP, thermique)


Simulation sous LT-Spice / PSpice et calculs sous Mathcad


Sélection de composants et conception des éléments magnétiques


Réalisation des analyses de fiabilité (Derating, WCA, PSA)


Mise au point, validation prototype et debugging


Rédaction des dossiers techniques et participation aux revues de conception




Profil recherché




Formation d’ingénieur en électronique/électrotechnique.


Expérience confirmée en électronique analogique ou puissance


Bonne compréhension des circuits analogiques / commande / magnétique.


Maîtrise des topologies SMPS et contraintes EMI/thermiques


Expérience en environnement exigeant (spatial, aéronautique ou défense appréciée)


Un bon sens pratique : oscillo, charge électronique, debug, sécurité… tu connais.


Une vraie rigueur technique (notes de calculs, justifications, doc).


Anglais technique




Type d''emploi : CDI


Rémunération : 45 000,00€ à 55 000,00€ par an


Avantages :




Flextime


Prise en charge du transport quotidien


RTT




Lieu du poste : En présentiel', 'Créteil', 'CDI', 45000.0, '', 0, NULL, '2026-05-12', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (3, 'Data Scientist', 'ContexteOnSpark est un cabinet spécialisé dans la GMAO/EAM et l''intégration SI, en forte croissance (40 collaborateurs, CA 3,3 M?). Dans le cadre de la diversification de son offre vers la Data et l''Intelligence Artificielle, nous recherchons un Data Scientist pour accompagner nos clients grands comptes. Vous travaillerez sur des données massives et complexes, et contribuerez à des cas d''usage à fort impact : modèles de prévision, simulateurs, analyses statistiques avancées, détection de tendances, dans un environnement Big Data on-premise (Cloudera CDP, Cloudera Machine Learning) avec accès à des IDE modernes (Jupyter, RStudio, VSCode). 




 ResponsabilitésConcevoir et entraîner des modèles de Machine Learning et Deep Learning 




 Analyser des jeux de données complexes et volumineux 




 Collaborer avec les Data Engineers pour la mise en production des modèles 




 Accompagner les équipes métier dans l''interprétation des résultats 




 Contribuer aux cas d''usage IA et NLP de la plateforme 



Profil candidat:



 Profil recherchéFormation Bac+5 (Data Science, Statistiques, Mathématiques ou équivalent) 




 Maîtrise de Python (Pandas, Scikit-learn?) et/ou R 




 Expérience en Machine Learning, Deep Learning, NLP 




 Connaissance des environnements Big Data (Spark, Hadoop, Cloudera?) 




 Connaissance du secteur public ou de la protection sociale appréciée 




 ConditionsPrésence physique requise à Paris 12ème (télétravail partiel possible, jusqu''à 2 jours/semaine) 




 Mission longue durée avec possibilité d''intégration en CDI', 'Paris', 'CDI', 0.0, '', 0, NULL, '2026-05-12', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (4, 'Product Owner Espaces Digitaux F/H', 'Créée en 1986, à l’initiative de mutuelles de la Fonction publique la Banque Française Mutualiste est la seule banque dédiée à l’ensemble des agents du secteur public dont le capital est détenu par 25 mutuelles sociétaires. La Banque Française Mutualiste propose des offres adaptées aux agents du secteur public avec son partenaires distributeur SG. Elle compte aujourd’hui près d’1,2 million de clients.


Guidées par ses valeurs que sont la responsabilité citoyenne, la solidarité, l’éthique et le respect de la personne, la Banque Française Mutualiste poursuit son développement dans le cadre de son nouveau Plan stratégique avec pour ambition d’accroitre son portefeuille clients, de digitaliser davantage son offre et de diversifier es canaux de distribution.


Afin de renforcer les équipes Marketing Digital et dans un contexte de forte transformation digitale, la Direction Marketing Communication recrute dans le cadre d’une création de poste un


Product Owner Espaces Digitaux F/H




 Vos Missions :




Rattaché à la Responsable Marketing Digital vous intégrez une équipe dynamique en qualité de Product Owner Espaces Digitaux F/H. Ce rôle clé s’inscrit au cœur des enjeux d’expérience utilisateur, de performance digitale et de déploiement de nouveaux outils digitaux structurants.


Vous êtes responsable de la vision produit, du pilotage et de l’évolution des 
espaces digitaux
 de la BFM. Véritable interface entre les équipes de développement et les utilisateurs, vous garantissez la cohérence, la performance et la valeur utilisateur des produits digitaux tout au long de leur cycle de vie.


En qualité de Product Owner Espaces Digitaux F/H, vous assurez notamment les missions suivantes :


Ø 
Pilotage produit digital & vision stratégique




Définir et porter la vision produit des espaces digitaux en lien avec la stratégie marketing et business ;


Recueillir, analyser et prioriser les besoins métiers et utilisateurs ;


Construire, prioriser et maintenir le backlog




Ø 
Delivery & coordination




Participer et/ou mener les rituels agiles (ateliers, refinements, sprint reviews) ;


Rédiger les US fonctionnelles


Participe à la définition des critères d’acceptation des livrables et veiller à leur respect (recettes)




Ø 
Amélioration continue




Analyser les usages et performances des parcours digitaux ;


Identifier les opportunités d’optimisation et d’innovation ;


Être force de proposition sur les évolutions fonctionnelles et technologiques.




Ø 
Projets structurants




Participer activement aux projets de refonte du site institutionnel, des parcours de souscription en ligne et de l’Espace Client


Contribuer au lancement du CRM et à sa bonne intégration dans les espaces digitaux







   Issu(e) d’une formation supérieure (école de commerce, ingénieur ou équivalent), vous justifiez d’une 
expérience confirmée en tant que Product Owner dans une organisation AGILE
.


Vous maîtrisez :




les méthodologies agiles,


les outils tels que : Jira / Confluence / ConstentSquare / Matomo / Google Analytics / Drupal


les enjeux UX/UI, parcours clients et performance digitale,


les projets de refonte de site web et/ou de déploiement de CRM.




Doté(e) d’un excellent sens de l’analyse et de la priorisation, vous savez concilier vision stratégique et approche opérationnelle. Vous êtes reconnu(e) pour votre capacité traduire des besoins fonctionnels en solutions concrètes.


Votre aisance relationnelle, votre esprit de synthèse et votre capacité à fédérer des équipes pluridisciplinaires feront la différence.


Curieux(se), structuré(e) et orienté(e) résultats, vous aimez évoluer dans des environnements en transformation et contribuer à la création de produits digitaux à fort impact.', 'Paris', 'CDI', 60000.0, '', 3, '2026-05-12', '2026-05-12', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (5, 'Data Scientist Paiements', 'Vos missions au quotidien 




La Direction des Paiements de la Banque de Détail SG en France (SGRF/PAY) recherche son futur Data Scientist pour compléter l’équipe du Pôle Produits Data Paiements au sein du Département Fraude, Etudes & Pilotage (PAY/FEP).


Le rôle de notre future recrue consistera à accompagner les départements métiers (équipes commerciales, produits et supports) de la Direction des Paiements, les Directions de Marchés de clientèle (entreprises, professionnels et particuliers) ainsi que le Réseau (agences et centre d’affaires) par l’exploitation des données au travers de la plateforme Big Data et des outils associés (Dataiku pour la data preparation et la modélisation, MicroStrategy pour la restitution des données sous forme de dashboard et de Self BI).


Concrètement, vous serez amené à développer des cas d’usage à même de contribuer aux objectifs stratégiques de conquête de flux, gain de PNB et de satisfaction client :






Construire des cas d’usage répondant à l’efficacité opérationnelle des équipes




Développer des scores d’appétence en vue de campagnes commerciales




Produire des listes de prospection de clients susceptibles d’être réactivés ou de contrats à renégocier




Faire des analyses relatives à la lutte contre la fraude (accompagnement à l’identification de cas de suspicion, profilage)




Mettre en évidence toutes sortes d’indicateurs à même de compléter le pilotage de l’activité des paiements (fragilisation de la relation client, attrition, risque frauduleux, etc.)












Et si c’était vous ? 




Compétences techniques :




Diplôme d’ingénieur de niveau Bac+5 dans le domaine des études statistiques et/ou mathématiques appliquées et/ou modélisation


Solides connaissances en mathématiques appliquées (statistiques, probabilités, logique)


Maîtrise des langages de programmation SQL et Python (librairies Pandas, NumPy, PySpark, outils VS Code, Jupyter Notebook)


Maîtrise de Dataiku (préparation des données, automatisation, industrialisation)


Maîtrise de MicroStrategy (en majeur chez SGRF, semblable à Tableau ou PowerBI)




Compétences comportementales :




Esprit analytique, rigueur


Curiosité, réactivité


Capacité d''écoute, force de proposition


Aisance relationnelle, orientation client










Plus qu’un poste, un tremplin 




Notre vision est de jouer un rôle moteur dans les transformations positives du monde et de contribuer à un avenir plus écologique, respectueux de la planète !


Choisir Société Générale, c’est intégrer un Groupe où la 
culture d’entreprise est tournée vers l’inclusion, la diversité et l’esprit d’équipe !


C’est construire une 
carrière dynamique
 avec la possibilité de changer de poste en moyenne tous les 4 ans, en France et à l''international tout en bénéficiant de 
formations régulières
 !


Au regard de vos compétences, une 
rémunération attractive
 revue annuellement, composée d’un salaire fixe, d’une part variable individuelle et d’une prime d’intéressement et de participation vous sera proposée.


Vous bénéficiez également de 
tarifs préférentiels sur vos services bancaires, d’un compte épargne temps monétisable et d’un Plan d’Epargne Entreprise abondé
.


Attentif à votre 
qualité de vie et conditions de travail
, vous bénéficiez de nombreux avantages complémentaires :




Télétravail possible selon le rythme de votre service


26 à 28 jours de congés payés par an et 14 à 18 jours de RTT (suivant les années), des congés liés aux événements de la vie


Prise en charge de 60% de votre titre de transport


Un Comité d’Entreprise (billetterie événements sportifs & culturels, primes et subventions vacances, garde d’enfants, chèque cadeaux à Noël)


Une offre variée de restaurants d’entreprise et de cafétérias à tarifs compétitifs ainsi que des titres restaurants dématérialisés quand vous êtes en télétravail










Pourquoi nous choisir ? 




Chez Société Générale, nous sommes convaincus que vous êtes le moteur du changement, et que le monde de demain sera fait de toutes vos initiatives, des plus petites aux plus ambitieuses.


Aux 4 coins du monde, que vous nous rejoigniez pour quelques mois, quelques années ou toute votre carrière, ensemble nous avons les moyens d’avoir un impact positif sur l’avenir. Créer, oser, innover, entreprendre font partie de notre ADN.


Si vous aussi vous souhaitez être dans l’action, évoluer dans un environnement stimulant et bienveillant, vous sentir utile au quotidien et développer ou renforcer votre expertise, nous sommes faits pour nous rencontrer !


Vous hésitez encore ?


Sachez que nos collaborateurs peuvent s’engager quelques jours par an pour des actions de solidarité sur leur temps de travail : parrainer des personnes en difficulté dans leur orientation ou leur insertion professionnelle, participer à l’éducation financière de jeunes en apprentissage ou encore partager leurs compétences avec une association. Les formats d’engagement sont multiples.











    Diversité et inclusion
   





    Nous sommes un 
employeur garantissant l''égalité des chances
 et nous sommes fiers de faire de la diversité une force pour notre entreprise. Le groupe s’engage à reconnaître et à 
promouvoir tous les talents
, quels que soient leurs croyances, âge, handicap, parentalité, origine ethnique, nationalité, identité de genre, orientation sexuelle, appartenance à une organisation politique, religieuse, syndicale ou à une minorité, ou toute autre caractéristique qui pourrait faire l’objet d’une discrimination.
   







    Transparence et responsabilité
   





    Le groupe Société Générale a à coeur que les personnes qui nous rejoignent agissent avec éthique et responsabilité pour une culture de performance durable. Les informations mentionnées dans votre candidature peuvent potentiellement être vérifiées dans le respect du cadre légal, à tout moment pendant le processus de recrutement.', 'La Défense', 'CDI', 0.0, '', 0, NULL, '2026-05-12', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (6, 'Ingénieur Système Equipements électroniques F/H', 'Lieu : Gennevilliers, France 
 


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
 
 Le poste pouvant nécessiter d''accéder à des informations relevant du secret de la défense nationale, la personne retenue fera l''objet d''une procédure d’habilitation, conformément aux dispositions des articles R.2311-1 et suivants du Code de la défense et de l’IGI 1300 SGDSN/PSE du 09 août 2021.', 'Gennevilliers', 'CDI', 0.0, '', 5, NULL, '2026-05-12', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (7, 'Chef de projet mission numérique en santé (H/F)', 'Date : 06/05/2026 
 









     Poste à pourvoir
    




Chef de projet scientifique (H/F) à la Mission Numérique en Santé (MNS)











     Emploi
    




Conduite de projet Stratégies d’amélioration


Filière : Expertise scientifique











     Emploi-repère
    




Chef de projet











     Catégorie d’emploi
    




Catégorie 1











     Type de contrat
    




Contrat à durée indéterminée / détachement Temps complet











     Localisation
    



     Saint-Denis (93)
    









     Rémunération
    



     Selon expérience et niveau de diplôme, par référence aux grilles indiciaires des agences sanitaires en application du décret n°2003-224 du 07 mars 2003 ou selon statut particulier si fonctionnaire (détachement)
    
















DESCRIPTION DU POSTE A POURVOIR
















Missions générales du poste






























































Direction et service d’affectation





     Rattaché(e) à la chefferie de service de la MNS, vous évoluerez au sein d’une équipe reconnue, dynamique et à taille humaine (13 personnes dont 9 chefs de projet). 
     



      Votre mission générale sera de contribuer aux différents travaux du service pour produire des avis, recommandations ou référentiels sur les thématiques diverses du service : 
     


Promotion du bon usage et de la qualité et de la pertinence des technologies numériques utilisés dans un contexte de soins (télésanté, dispositifs médicaux à usage professionnel, systèmes d’intelligence artificielle, etc.) ;




Evaluation de dispositifs médicaux numériques dans le cadre de dossiers de demandes de remboursement déposés par des industriels (guichet numérique) ;




Actions destinées à favoriser l’intégration des recommandations de la HAS dans les outils numériques utilisés par les professionnels.



      L’ensemble des travaux que vous réaliserez s’appuiera sur les données scientifiques disponibles que vous analyserez en mobilisant votre expertise méthodologique. Compte tenu de la nature évolutive et dynamique des missions de la MNS, vous pourrez être amené(e) à vous impliquer dans des activités nouvelles à développer. 
     



      En occupant ce poste, vous serez amené à : 
     


Mobiliser des experts et à animer des réunions de groupes de travail composés d’experts, d’utilisateurs et d’acteurs de l’écosystème du numérique en santé ;




Analyser et synthétiser les données scientifiques disponibles ;




Construite et entretenir des liens de qualité avec nos partenaires internes et externes, dans le cadre de vos travaux ;




Assurer une veille prospective et un reporting adéquat sur les travaux que vous portez ;




Contribuer à la communication externe des résultats et des productions : communication lors de congrès, rédaction d’articles scientifiques, diverses communications externes ou participation à des enseignements.




Participer à la construction du projet de service tant sur le plan fonctionnel que stratégique ;




Participer à la mise en place de programmes collaboratifs au sein de la HAS.







      Direction de l’Amélioration de la Qualité et de la Sécurité des Soins (DAQSS) & 
     

      Direction de l’évaluation et de l’accès à l’Innovation (DEAI) 
     

      Direction de la qualité de l''accompagnement social et médico-social 
     





      Mission Numérique en Santé (MNS) 
     



      Le numérique en santé est un levier majeur de la modernisation du système de santé qui transforme l’organisation des soins et l’accompagnement des personnes. Pour faire face aux multiples défis d''envergure associés au numérique en santé, la HAS s’est structurée en créant en 2021 un service dédié, la Mission Numérique en Santé (MNS), référent de l’institution pour toute question relative au numérique en santé. Les ambitions de ce service sont doubles : 
     




encourager l''intégration du numérique et de l’intelligence artificielle (IA) dans les pratiques professionnelles en instaurant un cadre de confiance pour une appropriation éclairée des technologies par les professionnels de santé et les usagers ;




Promouvoir le numérique comme vecteur de diffusion des recommandations professionnelles.





      Aujourd’hui reconnue pour son expertise au sein de l’écosystème, la MNS porte la voie de l’institution au niveau national et international dans le numérique en santé. Elle travaille sur des missions qui lui sont propres et également en transversalité avec de nombreux services de la HAS. Chaque année, elle produit des travaux, notamment en réponse aux sollicitations des directions ministérielles ou agences nationales. Parallèlement, la MNS a engagé et développe une approche exploratoire pour répondre aux enjeux du numérique, à la fois en proposant de nouveaux cadres et méthodes d’évaluation et en intégrant chaque fois que cela est pertinent des recommandations sur l’usage du numérique (aide à la décision, télésanté ou autre) dans tous les travaux de la HAS. 
     



      Pour toutes ses missions, l’axe de travail de la MNS est de construire un cadre de confiance favorisant la diffusion de technologies numériques utiles aux patients et aux professionnels et qui permettent d’améliorer la qualité, la sécurité et l’accès aux soins. 
     




















PROFIL RECHERCHÉ : 












Formation 





     Professionnel(le) de santé avec une forte appétence pour les sujets liés au numérique en santé (spécialisation ou expérience professionnelle en lien avec le numérique appréciée). 
     
ou



      Ingénieur(e), bac+5 ou diplômes supérieurs en lien avec le numérique en santé ayant une solide connaissance des enjeux métiers et de l’environnement sanitaire, social ou médico-social en France.
    














Expérience





     Votre cursus de formation et/ou votre parcours professionnel vous ont permis de disposer de connaissances et/ou de savoir-faire dans le domaine de la santé. 
     

      Expérience : institution ou conduite de projets dans d’autres contextes. 2 à 3 ans d’expérience dans un poste similaire. 
     












Compétences







      Eu égard aux missions qui vous seront confiées, il importe que vous ayez : 
     


une maîtrise des méthodes d’analyse critique et des études cliniques ;




un solide bagage de connaissances de l’environnement réglementaire en santé et des politiques de santé en France et à l’international ;




une capacité à animer des groupes de travail d’experts ;




des connaissances en bases de données des produits de santé (médicaments et dispositifs médicaux) et en modélisation de l''information et des terminologies du domaine médical seraient un plus pour certaines missions à développer.





      Passionné(e) par la transformation du système de santé grâce au numérique, vous disposez de fortes capacités à communiquer vous permettant d’animer des groupes de travail d’experts avec aisance et de travailler en réseau et en équipe. 
     



      Par ailleurs, compte tenu de la nature des productions attendues, vous faites preuve d’une grande rigueur tant dans l’analyse des dossiers qui vous sont confiés que dans la rédaction. Vous avez des compétences vous rendant autonome dans la conduite de projets (organisation, planification, gestion de groupes de travail, reporting …). Doté(e) d’une forte capacité d’initiative et d’un naturel positif, vous évoluerez au sein d’une institution qui prône des valeurs de respect, de solidarité et une dynamique de travail collective. 
     



      La maîtrise de l’anglais, tant à l’écrit qu’à l’oral et des outils informatiques (Word, Excel, PowerPoint, Internet) est indispensable. 
     














LA HAUTE AUTORITÉ DE SANTÉ





  Autorité publique indépendante à caractère scientifique, la Haute Autorité de santé (HAS) vise à développer la qualité dans les champs sanitaire, social et médico-social, au bénéfice des personnes. 
 

  Elle travaille au côté des pouvoirs publics dont elle éclaire la décision, avec les professionnels de santé pour optimiser leurs pratiques et organisations, et au bénéfice des usagers dont elle renforce la capacité à faire des choix. 
 

  Elle exerce trois missions principales : 
 




Evaluer les médicaments, dispositifs et actes en vue de leur remboursement ;


Recommander les bonnes pratiques professionnelles, élaborer des recommandations vaccinales et de santé publique ;


Mesurer et améliorer la qualité dans les hôpitaux, cliniques, en médecine de ville et dans les structures sociales et médico-sociales.





  La HAS exerce son activité dans le respect de trois valeurs : la rigueur scientifique, l''indépendance et la transparence. 
 

  Créée par la loi du 13 août 2004 relative à l’Assurance maladie, elle est organisée autour : 
 




D’un Collège de huit membres dont un président ;


De commissions spécialisées présidées par des membres du Collège :


 De services répartis en cinq directions opérationnelles. 
 
Ref : C157O98714', 'Saint-Denis', 'CDI', 0.0, '', 2, '2026-06-01', '2026-05-12', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (6, 'Ingénieur système IT F/H', 'Lieu : Gennevilliers, France 
 


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
 




GESA est le futur système de Gestion des Eléments Secrets des Armées. Il succède à l’actuel SELTIC. Bien plus qu’une rénovation de SELTIC, GESA repense de l’approche de la gestion des clés du MinArm.






















Basé sur une architecture cloud et tournée vers l’utilisateur GESA est conçu et réalisé de façon itérative en collaboration étroite avec le client DGA et les opérationnels de la filière chiffre des armées.


Dans ce contexte, vous évoluez au sein d’une équipe pluridisciplinaire composée d’architectes, d’ingénieur système, de développeurs, d’intégrateurs dédiée au sous-système IT de GESA.


Une partie des développements étant réalisés sur nos sites de Cholet et Labège (Toulouse) des déplacements occasionnels pourront avoir lieu sur différents sites Thales ou de partenaires en France.


A ce titre vos missions seront :




En tant Ingénieur Systeme IT, vous serez amené à participer aux activités d’ingénierie nécessaires pour développer le sous-système IT Central de GESA :




Analyser les besoins et des autres parties prenantes,


Décrire les missions, fonctions et les exigences sur la solution ou le produit,


Formaliser la spécification et l’architecture pour développer la solution ou le produit






Et plus précisément de :




Formaliser les besoins fonctionnels et non fonctionnelles d’architecture IaaS/PaaS en méthode Agile


Décliner les chaines fonctionnelles (IaaS, PaaS, Applicatifs enrôlement station, mise à jour des bases, etc.)


Décrire ces chaines fonctionnelles de manière détaillée, y compris pour les services communs (DNS, NTP, Log, Sauvegarde)


Décrire les architectures physiques et logiques


Etablir les exigences du socle technique (OS, Socle applicatif…) et assurer le suivi de l’implémentation de la solution auprès des parties prenantes.






 Votre profil :




Votre priorité est de travailler dans le monde de la cyberdéfense en intégrant une équipe projet composé d''experts de haut niveau ?


Vous avez l''ambition de travailler sur des produits de hautes technologies ?


Vous avez une capacité rédactionnelle solide pour décliner les architectures et les chaines fonctionnelles en exigences répondant au besoin ?




Vous disposez d''un Bac+5 et/ou Ingénieur en IT et/ou cybersécurité et avez au moins 3 ans d''expérience sur :






Les architectures cloud


L''ingenierie Iaas, Paas dans un environnement Opensource


Kubernetes


Les solutions IT, réseaux et des déploiements automatisés d’infrastructure






La maitrise de l''anglais, la rigueur, l''organisation sont des atouts que l''on vous reconnait ?




Alors ce poste est fait pour vous !




















 Thales, entreprise Handi-Engagée, reconnait tous les talents. La diversité est notre meilleur atout. Postulez et rejoignez nous ! 
 
 Le poste pouvant nécessiter d''accéder à des informations relevant du secret de la défense nationale, la personne retenue fera l''objet d''une procédure d’habilitation, conformément aux dispositions des articles R.2311-1 et suivants du Code de la défense et de l’IGI 1300 SGDSN/PSE du 09 août 2021.', 'Gennevilliers', 'CDI', 0.0, '', 3, NULL, '2026-05-12', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (8, 'Data enginer IA - Freelance H/F', 'Description du poste
 Taux journalier (TJM): 500/560 TJM 
 
Contexte du poste


Dans le cadre du développement de ses usages d’intelligence artificielle et d’analytics avancée, une organisation de référence renforce son équipe Data. Le ou la Data Ingénieur·e IA intervient au cœur de la plateforme data pour concevoir, industrialiser et opérer les pipelines de données qui alimentent les cas d’usage IA (machine learning, LLM, scoring, prévisions, etc.).


Le poste vise à garantir la disponibilité, la qualité, la traçabilité et la performance des données de bout en bout, depuis les sources jusqu’aux environnements d’entraînement et de production.


 Missions principales






Concevoir, développer et maintenir des pipelines de données fiables, scalables et automatisés (batch et streaming).




Collecter et intégrer des données hétérogènes (SI, APIs, fichiers, logs, événements).




Mettre en place des contrôles de qualité des données : validation, détection d’anomalies, déduplication, gestion des valeurs manquantes.




Préparer et exposer des jeux de données prêts pour l’IA : datasets d’entraînement/validation, tables de features, embeddings le cas échéant.




Contribuer à l’industrialisation des flux data en lien avec les équipes Data Science, Produit, DevOps et Sécurité.




Assurer la robustesse opérationnelle : gestion des incidents, mécanismes de reprise, optimisation des coûts et des performances.




Participer à la mise en œuvre des bonnes pratiques de gouvernance, sécurité et conformité (gestion des accès, traçabilité, RGPD).




Profil recherché


 Techniques






Solides bases en modélisation et architecture data (schémas, normalisation, performance).




Maîtrise de SQL et bonnes compétences en Python.




Expérience des pipelines de données, de l’orchestration et du monitoring.




Compréhension des contraintes liées aux projets IA et MLOps.




Connaissance des environnements cloud (stockage, IAM, réseau) et de la conteneurisation', 'Paris', 'Freelance', 6000.0, '', 0, NULL, '2026-05-12', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (9, 'Ingénieur/e concepteur/trice en mécatronique', 'CSI est une société française, basée aux Ulis (91), développant des produits innovants dans le domaine des nanotechnologies et plus particulièrement la microscopie en champ proche.


Nous recherchons un concepteur ou une conceptrice mécatronique à dominance mécanique passionné(e) et innovant(e) pour rejoindre notre équipe dynamique. Vous serez responsable de la conception et du développement de systèmes mécatronique complexe pour garantir des solutions efficaces et performantes dédiées à la recherche scientifique.


Objectifs :




Renforcer l''équipe de R&D de l''entreprise.


Participer au développement de nouveaux systèmes et à l''amélioration des systèmes existants.


Participer au montage et aux tests des équipements




Vos principales missions :




En collaboration avec notre équipe en place vous participerez à la conception, la réalisation et la fabrication de nos produits.


Prise d''initiative, force de proposition.




· Le candidat devra faire preuve de réflexion, de rigueur, d''autonomie, mais aussi d''un sens manuel ; Polyvalent, celui-ci sera amené à faire l''étude, le développement et la fabrication de prototypes (petites séries d''appareils pluri-technologiques).


Le candidat devra être à la fois capable de se servir de sa tête comme de ses mains, passionné par ce qu’il fait, être un touche-à-tout.


· La manipulation de machines à commande numérique ou conventionnelles est parfois nécessaire.


· De formation Ingénieur ou bac +5 en Mécatronique, à dominante mécanique justifiant déjà d''une expérience significative.




Vous connaissez SolidWorks ou un autre logiciel de modélisation 3D


Altium


Des connaissances en optique seraient un plus




L’anglais courant et technique est nécessaire pour ce poste


Type d''emploi : Temps plein, CDI


Statut : Cadre


Expérience :




Conception mécatronique : 5 ans (Requis)




Lieu du poste : En présentiel


Type d''emploi : Temps plein, CDI


Rémunération : 40 000,00€ à 50 000,00€ par an


Expérience:




Conception micromécanique: 5 ans (Requis)




Lieu du poste : En présentiel', 'Les Ulis', 'CDI', 40000.0, '', 5, NULL, '2026-05-12', FALSE);
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




Lieu du poste : Télétravail hybride (92400 Courbevoie)', 'Courbevoie', 'CDI', 40000.0, '', 0, NULL, '2026-05-12', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (6, 'Ingénieur Système Equipements électroniques F/H', 'Lieu : Gennevilliers, France 
 


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
 
 Le poste pouvant nécessiter d''accéder à des informations relevant du secret de la défense nationale, la personne retenue fera l''objet d''une procédure d’habilitation, conformément aux dispositions des articles R.2311-1 et suivants du Code de la défense et de l’IGI 1300 SGDSN/PSE du 09 août 2021.', 'Gennevilliers', 'CDI', 0.0, '', 5, NULL, '2026-05-12', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (6, 'Ingénieur système IT F/H', 'Lieu : Gennevilliers, France 
 


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
 




GESA est le futur système de Gestion des Eléments Secrets des Armées. Il succède à l’actuel SELTIC. Bien plus qu’une rénovation de SELTIC, GESA repense de l’approche de la gestion des clés du MinArm.






















Basé sur une architecture cloud et tournée vers l’utilisateur GESA est conçu et réalisé de façon itérative en collaboration étroite avec le client DGA et les opérationnels de la filière chiffre des armées.


Dans ce contexte, vous évoluez au sein d’une équipe pluridisciplinaire composée d’architectes, d’ingénieur système, de développeurs, d’intégrateurs dédiée au sous-système IT de GESA.


Une partie des développements étant réalisés sur nos sites de Cholet et Labège (Toulouse) des déplacements occasionnels pourront avoir lieu sur différents sites Thales ou de partenaires en France.


A ce titre vos missions seront :




En tant Ingénieur Systeme IT, vous serez amené à participer aux activités d’ingénierie nécessaires pour développer le sous-système IT Central de GESA :




Analyser les besoins et des autres parties prenantes,


Décrire les missions, fonctions et les exigences sur la solution ou le produit,


Formaliser la spécification et l’architecture pour développer la solution ou le produit






Et plus précisément de :




Formaliser les besoins fonctionnels et non fonctionnelles d’architecture IaaS/PaaS en méthode Agile


Décliner les chaines fonctionnelles (IaaS, PaaS, Applicatifs enrôlement station, mise à jour des bases, etc.)


Décrire ces chaines fonctionnelles de manière détaillée, y compris pour les services communs (DNS, NTP, Log, Sauvegarde)


Décrire les architectures physiques et logiques


Etablir les exigences du socle technique (OS, Socle applicatif…) et assurer le suivi de l’implémentation de la solution auprès des parties prenantes.






 Votre profil :




Votre priorité est de travailler dans le monde de la cyberdéfense en intégrant une équipe projet composé d''experts de haut niveau ?


Vous avez l''ambition de travailler sur des produits de hautes technologies ?


Vous avez une capacité rédactionnelle solide pour décliner les architectures et les chaines fonctionnelles en exigences répondant au besoin ?




Vous disposez d''un Bac+5 et/ou Ingénieur en IT et/ou cybersécurité et avez au moins 3 ans d''expérience sur :






Les architectures cloud


L''ingenierie Iaas, Paas dans un environnement Opensource


Kubernetes


Les solutions IT, réseaux et des déploiements automatisés d’infrastructure






La maitrise de l''anglais, la rigueur, l''organisation sont des atouts que l''on vous reconnait ?




Alors ce poste est fait pour vous !




















 Thales, entreprise Handi-Engagée, reconnait tous les talents. La diversité est notre meilleur atout. Postulez et rejoignez nous ! 
 
 Le poste pouvant nécessiter d''accéder à des informations relevant du secret de la défense nationale, la personne retenue fera l''objet d''une procédure d’habilitation, conformément aux dispositions des articles R.2311-1 et suivants du Code de la défense et de l’IGI 1300 SGDSN/PSE du 09 août 2021.', 'Gennevilliers', 'CDI', 0.0, '', 3, NULL, '2026-05-12', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (11, 'Data scientist F/H/X', 'Élu Groupe Data marketing de l’année, Isoskèle figure dans le top 20 des 500 agences françaises du classement Stratégies. ISOSKELE compte environ 450 collaborateurs pour 100M€ de CA.


Pionnière dans le mariage réussi entre marketing et communication, Isoskèle – racine grecque de l’équilibre – repousse les limites de la créativité associée aux dernières innovations de la data et des technologies.


Ce positionnement visionnaire lui a permis d’obtenir, depuis sa création en 2019, plus de 100 récompenses créatives, labels RGPD et certifications multiplateformes (Adobe, Salesforce, Acoustic…)


Isoskèle propose un accompagnement global autour de 5 marques hyper-expertes.






St Johns Isoskèle, stratégies créatives, publicitaires et réputationnelles : 
https://stjohns.fr/




CyberCité Isoskèle, Search, social et medias : 
https://www.cybercite.fr/




TimeOne, acquisition et marketing à la performance : 
https://www.timeonegroup.com/




Datamark martech & data : 
https://datamark.isoskele.fr/




LineUp7, data marketing : 
https://www.lineup7.fr/




OnlySo social media, marketing conversationnel et influence : 
https://www.onlyso.fr/




 Description du poste


Intégré.e au département Intelligence Marketing (composé d’experts en Études et DataScience) vous aurez pour mission de réaliser des projets de Data Science variés, dsur des sujets transverses stratégiques ou axés sur la connaissance client dans les secteurs caritatif et marchand, et de mener à bien le développement d’outils d’analyse innovants impliquant des technologies avancées comme le machine learning et l’intelligence artificielle.


 Vos principales missions seront les suivantes :




Réaliser les projets d’analyse, de la conception à la formalisation et présentation des résultats


Compréhension du besoin client et proposition de méthodologies adaptées


Import et retraitement des bases de données


Suivi des KPI annuels des clients réguliers d’Isoskèle : bilan de collecte sur le secteur associatif, mesure de performance des campagnes publicitaires…


Réalisation d’analyses ad hoc et rédaction des présentations client : modélisation des comportements d’achats/navigation, des parcours et cycles de vie, analyse des combinaisons de produits, impact d’un programme relationnel…


Rédaction de recommandations pertinentes en fonction des résultats de l’analyse des bases de données


Mise en place de nouveaux outils visuels / statistiques à l’aide des logiciels adéquats (Python)




 Profil recherché


Diplômé.e d’un master en Datascience/Statistiques/Econométrie vous avez une première expérience significative (minimum 2 ans) sur un poste similaire.


 Compétences :




Maîtrise de Python


Compétences mathématiques/économétriques avancées (statistiques, modèles de prévision/clustering)


Maîtrise de la suite Office (Excel indispensable, PPT)


Facilités écrites et orales


Une sensibilité aux sujets marketing et de communication publicitaire est un plus




Qualités :




Rigueur, esprit de synthèse et capacités analytiques


Capacité à travailler en équipe : agilité/réactivité dans la gestion des dossiers, avec des interlocuteurs différents


Prise d’initiative et proactivité', 'Paris', 'CDI', 0.0, '', 2, NULL, '2026-05-12', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (12, 'Ingénieur DATA & IA', 'BIOMEN propose aux industriels de la Santé des compétences du meilleur niveau pour renforcer leurs équipes d’analyse Marketing/Ventes.


 Autour de nos valeurs : Efficacité, Engagement, Esprit d’équipe, nous proposons des missions riches et opérationnelles, avec de réelles responsabilités qui vous permettront de développer des expertises pointues au sein d’un secteur ultra dynamique.


 Prenez part à cet écosystème passionnant de la Santé et de la création du médicament !


 Rejoindre BIOMEN, c’est intégrer une équipe solidaire d’une trentaine de personnes qui mise beaucoup sur l’intelligence collective ! C’est notre façon de répondre à ce besoin de chacun de donner du sens à notre travail.


 Description du poste


Piloter, structurer et faire évoluer les initiatives Data et IA de l’organisation, aussi bien sur les projets internes que sur les projets clients, en assurant la cohérence technique, méthodologique et stratégique.


Le poste joue un rôle de 
référent technique
, de 
chef d’orchestre data
, et de 
conseiller stratégique
 sur les usages de l’IA.
Missions principales


1. Stratégie Data & IA




Contribuer à la définition et à la mise en œuvre de la stratégie Data & IA


Identifier les opportunités d’usage de la data et de l’IA à forte valeur ajoutée


Prioriser les cas d’usage selon leur impact métier, faisabilité et maturité


Assurer une veille technologique continue (data, IA, automatisation)




2. Pilotage de projets (internes & externes)




Cadrer et piloter des projets data / IA de bout en bout


Coordonner les parties prenantes métiers, IT et data


Garantir le respect des objectifs, délais et standards techniques


Intervenir sur des projets internes structurants (outils, plateformes, méthodes)




3. Référent technique Data & IA




Définir les bonnes pratiques techniques et méthodologiques


Valider les choix d’architecture, de modélisation et d’outillage


Apporter un support et un accompagnement technique aux équipes


Garantir la qualité, la robustesse et la maintenabilité des solutions




4. Données & solutions analytiques




Superviser la collecte, la structuration et la valorisation des données


Concevoir ou challenger des pipelines data, modèles analytiques et IA


Participer à la conception de POC et à leur industrialisation


Veiller à la gouvernance des données (qualité, sécurité, conformité)




5. Acculturation & accompagnement




Diffuser la culture data et IA au sein de l’organisation


Former, sensibiliser et accompagner les équipes sur les usages data et analytiques


Jouer un rôle de conseil et d’expertise, en interne comme auprès des clients




 Profil recherché


 Compétences techniques attendues




Solides bases en data engineering et data analytics


Connaissances en IA / machine learning (approche pragmatique)


Maîtrise d’au moins un langage data (Python, SQL, etc.)


Compréhension des architectures data et des flux de données


Expérience avec des outils BI / reporting / visualisation


Notions de cloud, automatisation et MLOps appréciées




 Compétences fonctionnelles & soft skills




Capacité à comprendre des enjeux métier complexes


Esprit analytique et structuré


Autonomie et force de proposition


Aisance dans les échanges avec des interlocuteurs non techniques


Capacité à formaliser et vulgariser





    Profil recherché




Formation ingénieur ou équivalent


Expérience confirmée sur des projets data et analytiques


Appétence pour l’innovation et la transformation


Capacité à évoluer dans un environnement en construction


Une expérience dans l’environnement pharmaceutique constitue un atout majeur', 'Levallois-Perret', 'CDI', 0.0, '', 0, NULL, '2026-05-12', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (13, 'Ingénieur Conception Mécanique (H/F)', 'Description de l''entreprise



   “ALTEN joue un rôle crucial dans l''accompagnement des secteurs Aéronautique, Spatial, Défense (ASD), en relevant des défis technologiques et en soutenant les enjeux clés de développement durable, de décarbonation et de sécurité. Nous investissons dans le recrutement des meilleurs talents, la structuration de nos Centres d’Excellence, la formation pour le développement de nouvelles compétences et l''innovation”, Stéphane Dahan, Directeur du Recrutement des Ingénieurs.


ALTEN, Leader mondial de l’Ingénierie et des IT Services, recherche des ingénieurs audacieux pour rejoindre nos équipes spécialisées dans les secteurs de l''ASD.


Grâce à nos référencements préférentiels, nous vous garantissons un accès à des projets à forte valeur ajoutée, qu’il s’agisse de développer des technologies de vol innovantes, de participer à des missions spatiales révolutionnaires, ou de contribuer à des avancées critiques en matière de défense.


Vous êtes fasciné par l''aviation, rêvez de conquérir l''espace, ou souhaitez renforcer la sécurité de nos nations ? Faites décoller votre carrière avec ALTEN !




Description du poste



    Missions principales




Concevoir et dimensionner des pièces et sous-ensembles mécaniques en tenant compte des contraintes thermiques, vibratoires et environnementales


Réaliser la modélisation 3D et les plans 2D associés


Participer aux analyses de faisabilité, aux revues techniques et aux choix de solutions


Contribuer aux études de tenue mécanique (statique, dynamique, calculs de tolérances, chaines de cotes)


Collaborer avec les équipes électroniques, industrialisation et qualité afin d’assurer la cohérence globale du produit


Rédiger la documentation technique (spécifications, dossiers de justification, dossiers de définition)


Assurer le suivi des prototypes, des essais et de la mise en production


Proposer des améliorations de conception visant à optimiser les performances, la fiabilité ou les coûts




 Qualifications



    Formation / Expérience




Diplôme d’ingénieur ou équivalent en mécanique, mécatronique ou conception de produits industriels


Expérience de 1 à 5 ans en conception mécanique, idéalement dans un secteur exigeant (aéronautique, défense, énergie…)




 Compétences Techniques




Maîtrise du logiciel CATIA V5




 Qualités personnelles




Autonomie, rigueur, esprit d’analyse et de synthèse


Bonne communication écrite et orale




 Langues et mobilité




Maîtrise professionnelle de l''Anglais (Lu, écrit et oral)




 Informations supplémentaires







     RTT




Tickets restaurant (60% pris en charge par ALTEN)




Participation aux frais de transports (Pass Navigo pris en charge à 90%...)




Avantages sociaux : chèques vacances, tarifs préférentiels, 1% logement




ALTEN Solidaire : bénévolats auprès d’associations caritatives (Les Restos du Cœur, Emmaüs...)




Evènements : soirées annuelles, afterworks, team building, ALTEN Awards...




Qualité de vie au travail : activités bien-être', 'Boulogne-Billancourt', 'CDI', 0.0, '', 1, NULL, '2026-05-12', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (14, 'Responsable Administrateur Systèmes et Réseaux', 'La société :


Rivage Investment
 est une société de gestion d’actifs indépendante à dimension internationale, spécialisée dans la dette privée d’infrastructure. Fondée en 2010, elle intervient en Europe et en Amérique du Nord, à la croisée de la finance, des actifs réels et des besoins économiques de long terme.


Notre conviction est claire : la dette privée d’infrastructure constitue l’une des classes d’actifs les plus résilientes et essentielles de nos économies modernes. Elle offre une performance régulière tout en contribuant au financement de fonctions économiques et sociétales fondamentales.


Indépendants par nature et globaux dans notre développement, nous conjuguons l’agilité d’une structure entrepreneuriale avec la discipline, la gouvernance et les standards exigés par les investisseurs internationaux en dette privée.


Nous agissons comme des partenaires de long terme, tant auprès des investisseurs que des porteurs de projets, en instruisant, structurant et assurant le suivi des solutions de financement avec rigueur, responsabilité et continuité tout au long de la durée de vie des investissements.


Notre différence ?


Rivage Investment combine des capacités différenciantes de sourcing et de structuration avec une discipline de crédit sans compromis. Cet équilibre permet de construire la performance tout en assurant la résilience sur l’ensemble des cycles.


Les valeurs qui nous animent




Réflexion disciplinée, processus robustes et standards exigeants.


Connaissance approfondie des infrastructures et capacité d’évaluation continuellement renforcée.


Engagement, agilité et culture de création de valeur.


Cadre ESG exigeant et engagement de long terme en faveur d’infrastructures durables.


Intelligence collective et relations fondées sur la proximité et la transparence avec les investisseurs et les parties prenantes.


Exigence intellectuelle nourrie par une remise en question permanente de nos hypothèses et de nos cadres d’analyse.




Le poste et les missions :


Rattaché(e) à la fonction IT / Systèmes d’Information, le Manager Systèmes & Réseaux garantit la performance, la disponibilité et la sécurité du système d’information de la société, dans un contexte d’exigence élevée propre aux activités financières.


Le poste vise à :


- Répondre efficacement aux besoins des utilisateurs internes


- Assurer une résilience maximale de l’infrastructure (continuité et reprise d’activité)


- Maintenir un niveau de cybersécurité élevé et conforme aux exigences réglementaires


- Accompagner la croissance rapide et les transformations technologiques de la société


- Piloter et optimiser les coûts, performances et évolutions du SI.


1. Management & Gouvernance IT


- Encadrer, animer et faire monter en compétence l’équipe systèmes et réseaux.


- Définir la stratégie IT en lien avec la direction :


· Responsable des comités de décision et validation des choix techniques


· Responsable des comités de décision et validation des choix de sécurité


- Assurer la permanence du service Systèmes et Réseaux (gestion des congés/absences, programmation des interruptions nécessaires de service (Maj)


- Mettre en place des indicateurs de performance (KPI) et de qualité de service (SLA)


- Gérer les budgets IT et optimiser les coûts


- Piloter les prestataires, fournisseurs et partenaires IT


- Assurer une veille technologique et réglementaire


2. Administration des systèmes & réseaux


- Superviser l’ensemble des infrastructures :


· Serveurs (on-premise et cloud)


· Réseaux (LAN, WAN, VPN)


· Systèmes de stockage et sauvegarde


- Garantir la performance, la disponibilité et la scalabilité des systèmes.


- Gérer les environnements virtualisés et cloud (AWS, Azure, etc.)


- Maintenir la documentation technique à jour :


· Schéma hardware de l’infrastructure IT


· Plan IP complet de l’infrastructure IT


· Bible technique des choix (« settings ») techniques en production


3. Support utilisateurs & qualité de service


- Organiser et superviser le support IT (niveau 1 à 3).


- Répondre aux incidents critiques et demandes urgentes.


- Améliorer l’expérience utilisateur et les outils internes.


- Mettre en place des processus ITIL (gestion des incidents, changements, problèmes).


- Former et sensibiliser les utilisateurs aux bonnes pratiques IT.


4. Cybersécurité (priorité stratégique)


- Définir et mettre en œuvre la politique de sécurité du SI.


- Assurer la protection contre les cyberattaques et les fuites de données (EDR, firewall, SIEM, etc.).


- Gérer les accès, identités et droits (IAM).


- Piloter les audits de sécurité et tests d’intrusion (avec auditeur externe) et suivre le cycle « audits, recommandations, implémentations/corrections ».


- Assurer la conformité réglementaire (ex : RGPD, exigences AMF).


- Sensibiliser les collaborateurs aux risques cyber (ex : test de phishing en interne) en lien avec l’équipe RH (ex : formations (obligatoires) pour utilisateurs en échec).


5. Résilience & continuité d’activité


- Concevoir et maintenir les plans de continuité (PCA) et de reprise (PRA).


- Garantir la redondance des systèmes critiques.


- Tester régulièrement les dispositifs de continuité (ex : test de shut-down serveur principal et relai serveur secondaire) et PRA (bascule remote datacenter), et conclusion par PV


- Assurer la sauvegarde (objectif d’immuabilité) et la restauration des données, tests de restauration des données et maintien de la procédure de restauration (ex : cartographie de la data dans chaque sauvegarde, quel process utiliser, mot de passe de désencryption, pour chaque jeu de sauvegarde)


- Optimiser l’infrastructure pour améliorer le PRA (RTO/RPO) : actuellement RTO [2h] et RPO [2h]


6. Projets IT & transformation


- Piloter les projets d’évolution du SI (migration cloud, nouveaux outils métiers, automatisation, IA, architecture multisites, architecture d’applications on-site/off-site).


- Accompagner la croissance de l’entreprise (scalabilité des infrastructures).


- Participer à la digitalisation et/ou « IA-isation » des processus métiers.


- Intégrer de nouvelles technologies (DevOps, cybersécurité avancée, SOC interne).


- Collaborer avec les équipes métiers pour anticiper les besoins.


7. Conformité & environnement réglementaire


- Garantir la conformité aux normes du secteur financier.


- Préparer les audits internes et externes.


- Documenter les procédures et politiques IT.


- Assurer la traçabilité et la gouvernance des données.


Positionnement dans l’organisation 




Rattachement hiérarchique: Head of IT


Interactions :




· Équipe IT (support et admins)


· Équipes métiers


· Prestataires techniques


Indicateurs de performance (KPI)




Taux de disponibilité du SI


Temps moyen de résolution des incidents (MTTR)


Nombre d’incidents de sécurité


Satisfaction utilisateurs


Respect et maintien des politiques et procédures


Maintien de la documentation technique


Succès des tests PRA/PCA




Profil recherché


Formation




Bac+5 en informatique, systèmes et réseaux ou équivalent.


6/10 ans d’expérience confirmée sur un poste similaire en environnement professionnel structuré et procédurier (finance)




Compétences techniques


Expertise :




Ecosystème M365 (Azure, Defender, Intune, Entra)


Maîtrise des systèmes Windows/Linux


Réseaux (TCP/IP, VLAN, VPN, firewall)


Sauvegarde et PRA/PCA




Autres compétences techniques appréciées :




Cybersécurité (SIEM, EDR, IAM, SOC)


Virtualisation (VMware, Hyper-V)


Cloud computing (AWS, Azure, GCP)


Outils de supervision santé (Nagios, Zabbix, etc.)


Scripting (PowerShell, Python)




Compétences organisationnelles et opérationnelles 




Rigueur et sens des responsabilités


Réactivité et sang-froid


Esprit d’analyse et de synthèse


Excellente communication


Proactivité et capacité d’anticipation




Langues




Français


Anglais professionnel indispensable (écrit et oral).




Qualités personnelles




Rigueur et sens des responsabilités


Réactivité et sang-froid


Esprit d’analyse et de synthèse


Excellente communication


Proactivité et capacité d’anticipation




Rémunération : 60 000,00€ à 75 000,00€ par an


Avantages :




Crèche d''entreprise


Intéressement et participation


Prise en charge du transport quotidien


RTT


Travail à domicile occasionnel




Lieu du poste : En présentiel', 'Paris', 'CDI', 60000.0, '', 6, NULL, '2026-05-12', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (8, 'Product Owner - Freelance H/F', 'Description du poste


Un client localisé à Paris recherche un product owner disponible rapidement d''au moins 8/10 ans d''expérience. 

   2/3 jours de télétravail par semaine.', 'Paris', 'Freelance', 0.0, '', 8, '2026-05-12', '2026-05-12', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (15, 'INGENIEUR CONCEPTION MECANIQUE EXPERIMENTE F/H', 'À propos du poste

  Dans le cadre d’un projet in situ client, nous recherchons un(e) Ingénieur(e) Conception Mécanique pour réaliser des activités d’études et de pilotage de la conception de systèmes aéroportés.


Missions principales : 


- Consolider l''architecture système mécanique.


- Préparer la conception détaillée.


- Contribuer à la rédaction du plan d’essais du système complet.


- Assurer la cohérence entre les exigences et le déroulé des essais.


- Rédiger les notes de justification mécanique système.


- Consolider le dossier de définition sur MyPLM (Product Life Management) sous 3DExperience.


- Rédiger les procédures d’essais détaillées en tenant compte des contraintes produits et essais (types et méthodes d’essais selon les dimensions/contraintes de charge).


- Identifier et consulter les laboratoires d’essais en définissant les spécifications nécessaires.


- Lister les moyens et outillages requis pour les essais.


- Mettre à jour les procédures associées.


- Rédiger les notes d’analyse et les documents de justification à la définition (DJD).


- Coordonner les activités avec les intervenants du projet, qu’ils soient internes ou externes.


Profil recherché




Vous disposez d’une expérience significative en études et conception de systèmes mécaniques ainsi qu’en gestion et suivi d’essais.


Vous maîtrisez MyPLM (3DExperience) et Catia.


Vous possédez une excellente capacité rédactionnelle, garantissant la clarté et la précision des documents techniques.


Vous êtes force de proposition, notamment pour définir les détails de certains essais.




Avantages 
:


Au-delà de la rémunération fixe, nous vous offrons une expérience professionnelle enrichissante, alignée sur nos valeurs en matière de Responsabilité Sociale des Entreprises (RSE) et de Qualité de Vie et Conditions de Travail (QVCT). Rejoindre notre équipe, c''est intégrer un environnement où votre développement est au coeur de nos préoccupations.


- Prime Vacances : Profitez d''une prime vacances distribuée deux fois par an.

  - Mutuelle d''entreprise : Choisissez parmi trois formules de garanties pour une couverture santé adaptée à vos besoins.

  - Carte SWILE : Bien plus qu''une carte restaurant, c''est une application dédiée, qui vous permettre d''accéder à des réductions ainsi qu''à des bons d''achat pour les fêtes.


#Studielrecrute


Type d''emploi : Temps plein, CDI


Rémunération : 40 000,00€ à 45 000,00€ par an


Lieu du poste : En présentiel', 'Île-de-France', 'CDI', 40000.0, '', 0, NULL, '2026-05-12', FALSE);
INSERT INTO Offre (id_recruteur, titre, description, lieu, type_contrat, salaire, duree, experience_requise, date_debut, date_publication, teletravail) VALUES (16, 'Ingénieur Assurance Qualité et Affaires Réglementaires (H/F)', 'Chez Withings, nous souhaitons redonner aux individus le contrôle de leur santé.


Nous avons l’obsession de créer des produits beaux et intuitifs, afin que chacun puisse les utiliser facilement au quotidien; nos balances connectées, montres hybrides, tensiomètres, moniteurs de sommeil et tous les dispositifs de notre gamme sont aujourd’hui utilisés par des millions d’utilisateurs.


Notre objectif : permettre la prévention, le dépistage et l’accompagnement d’un certain nombre de maladies chroniques via des produits et des services innovants, afin de révolutionner la manière dont on prend soin de notre santé.


Dans le cadre de notre développement, nous renforçons notre équipe Qualité et Affaires Réglementaires.


Missions


Rattaché.e à la direction qualité et affaires réglementaires, vous êtes le référent réglementaire et qualité au sein des projets de développement de nouveaux produits et d’amélioration de produits existants à forte composante logicielle. En étroite collaboration avec les autres équipes en interne (recherche appliquée, développement produit, qualité produit, marketing, études cliniques, commerciaux), vous secondez plus particulièrement les product managers afin de mener à bien vos missions :




Contribuer à l’élaboration de stratégies réglementaires et qualité optimisant la mise sur le marché des dispositifs et logiciels développés dans les différents marchés visés


Être le référent qualité et réglementaire au sein des équipes projets et assurer le lien avec le reste de l’équipe qualité et réglementaire


Assister les équipes de développement dans l’organisation et la constitution des dossiers de conception et de fabrication (DHF, DMR & medical device file) conformément aux exigences applicables dont ISO 13485 et 21 CFR part 820


Contribuer activement à la constitution des dossiers de gestion des risques tout au long du cycle de vie des produits conformément à l’ISO 14971


Rédiger et tenir à jour les dossiers d’enregistrement dans l’ensemble des marchés de distribution dont dossiers techniques de marquage CE conformément aux exigences du MDR 2017/745 ou de l’IVDR 2017/746 et dossiers de soumission US 510(k) ou De Novo


Mettre à jour les bases de données et enregistrements locaux suite à l’obtention d’une autorisation de commercialisation


Contribuer à la définition et mise en oeuvre du Système de Management de la Qualité (SMQ) et plus particulièrement des processus de développement produit, gestion des risques, contrôle des modifications, traitement des réclamations clients et suivi de la matériovigilance - conformément aux référentiels applicables


Participer aux activités d’évaluation réglementaire dans le cadre de l’application des processus au sens de l’ISO 13485, notamment lors d’audits (internes et de tierce partie)


Assurer la veille réglementaire et accompagner les équipes de développement tout au long du cycle de vie d’un produit dans la mise en œuvre des normes applicables au dispositif


Evaluer la conformité réglementaire et normative de l’étiquetage, des notices d’utilisation et des supports promotionnels


Interagir avec l’organisme notifié et les autorités compétentes pertinentes selon les besoins


Contribuer à véhiculer la culture qualité au sein de l’entreprise, notamment en organisant voire en animant les formations requises








Requirements






De formation Bac+5, de type école d’ingénieur généraliste ou biomédical, vous êtes à l’aise dans les domaines de l’électronique, de la mécanique et plus particulièrement du logiciel.


Habitué.e à œuvrer au sein d’un système de management de la qualité construit autour de la conformité à l’ISO 13485 ou des exigences des 21 CFR, vous savez interpréter et faciliter la mise en œuvre de référentiels réglementaires et connaissez les normes applicables aux dispositifs électromédicaux tels que l’IEC 60601-1 et collatérales, l’IEC 62304, l’ISO 62366-1 et l’ISO 14971.


Vous justifiez d''une première expérience réussie dans une fonction technique ou réglementaire dans le domaine des dispositifs médicaux, dont au moins une première expérience concerne le développement de logiciels médicaux.


Vous avez une réelle appétence pour les produits high-tech et l’innovation, et vous souhaitez rejoindre une équipe à taille humaine dont la mission est de donner aux individus les outils technologiques qui leur permettront de prendre soin de leur santé. Vous êtes curieux, rigoureux, organisé, et vous inscrivez dans une démarche constante d’amélioration de l’existant.


Vous faites preuve d''un très bon esprit d’analyse et d''une grande curiosité qui vous pousse à comprendre et résoudre les problématiques issues d''un environnement complexe.


Vous appréciez les interactions pluridisciplinaires et multiculturelles au sein d’un environnement fortement évolutif et dynamique.


Vous souhaitez pouvoir transmettre vos compétences actuelles et en développer de nouvelles.


Vous avez une excellente maîtrise de l’anglais aussi bien à l’oral qu’à l’écrit.








Benefits



   Rejoindre l’aventure Withings, c’est :






Intégrer un des pionniers et leaders mondiaux de la santé connectée, plusieurs fois primé au Consumer Electronic Show


Contribuer à des projets innovants et ambitieux pour la santé de demain dans un environnement agile et en constante évolution


Intégrer une entreprise internationale, membre de la FrenchTech 120, dont les équipes sont basées à Issy-les-Moulineaux, Boston, Hong-Kong et Shenzhen


Participer à l’amélioration continue de nos produits et services en les bêta-testant avant leur sortie, notamment lors de nos nombreuses sessions sportives entre collègues


Bénéficier de nombreux avantages : Stock Options, smartphone et ordinateur de votre choix, réductions pour des activités culturelles et sportives, restaurant d’entreprise, et bien plus encore


Participer à la Withings Med Academy en assistant à des conférences de professionnels de santé afin de renforcer ses connaissances dans le domaine médical


Collaborer avec des collègues passionnés et célébrer ensemble chacune de nos réussites !








Toutes les candidatures reçues sont étudiées indépendamment de l’origine ethnique, des opinions, des croyances, de la religion, du genre, de l’orientation sexuelle ou de la santé des candidats. Withings aspire à offrir et garantir l’égalité des chances aux candidats et seules les personnes habilitées (RH et Management) auront accès aux informations concernant votre candidature.', 'Issy-les-Moulineaux', 'CDI', 0.0, '', 1, NULL, '2026-05-12', FALSE);

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
