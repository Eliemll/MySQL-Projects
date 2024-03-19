-- SQLite
-- SQLite
-- Création d'un base 
/*
CREATE TABLE Opérateur (
    numero CHAR(4),
    nom VARCHAR(15),
    age INT,
    PRIMARY KEY (numero)
);

CREATE TABLE Machine (
    referenceM CHAR(4),
    designationP VARCHAR(25),
    PRIMARY KEY (referenceM)
);

CREATE TABLE Pièce (
    referenceP CHAR(2) ,
    designationP VARCHAR(25),
    reference_machine REFERENCES Machine(referenceM),
    numero_operateur REFERENCES Opérateur(numero),
    quantité INT,
    PRIMARY KEY (referenceP)
);

CREATE TABLE Qualifié_sur (
    numero_operateur REFERENCES Opérateur(numero),
    reference_machine REFERENCES Machine(referenceM),
    date DATE,
    PRIMARY KEY (numero_operateur, reference_machine)
);

-- SUPRESSION DE TABLES
DROP TABLE nomTable;
DROP TABLE IF EXISTS Qualifié_sur;

-- Insertion des valeurs 
INSERT INTO Opérateur VALUES 
    ('OP42', 'Robert', 32),
    ('OP10', 'Sophie', 41),
    ('OP78', 'Lucette', 25),
    ('OP22', 'Albert', 25),
    ('OP57', 'Marc', 38)
    ;

INSERT INTO Machine VALUES 
    ('M12', 'Perçeuse'),
    ('M13', 'Ponçeuse'),
    ('M14', 'Tour Numérique')
    ;

INSERT INTO Pièce VALUES 
    ('P1', 'Pièce1', 'M12', 'OP10', 250),
    ('P2', 'Pièce2', 'M12', 'OP22', 600),
    ('P3', 'Pièce3', 'M14', 'OP22', 200),
    ('P4', 'Pièce4', 'M13', 'OP78', 150)
    ;

INSERT INTO Qualifié_sur VALUES 
    ('OP10', 'M12', 2000/01/15),
    ('OP22', 'M12', 2001/05/20),
    ('OP10', 'M13', 1999/10/10),
    ('OP42', 'M13', 2002/01/17),
    ('OP78', 'M12', 1998/07/19),
    ('OP10', 'M14', 2001/05/04)
    ;

-- AFFICHAGE DES TABLES
SELECT * FROM Opérateur;
SELECT * FROM Machine;
SELECT * FROM Pièce;
SELECT * FROM Qualifié_sur;
-- TD4
-- 1
SELECT referenceP, designationP
FROM Pièce;

-- 2
SELECT referenceP, designationP
FROM Pièce
WHERE (numero_operateur = 'OP22');

-- 3
SELECT designationP 
FROM Pièce
WHERE (quantité >= 200);

-- 4
SELECT numero_operateur
FROM Qualifié_sur
WHERE (reference_machine = 'M12');

-- 5
SELECT numero_operateur
FROM Pièce
WHERE (referenceP = 'P1');

-- 6
SELECT Pièce.designationP, Machine.designationM
FROM Machine, Pièce
WHERE (Machine.referenceM = Pièce.reference_machine);

-- 7
SELECT numero
FROM Opérateur
WHERE (age >= 30 AND age <= 40);

-- 8
SELECT MIN(age) AS Minimum, MAX(age) AS Maximum, AVG(age) AS Moyenne 
FROM Opérateur;
-- 9
SELECT numero
FROM Opérateur
WHERE 
    (
    Opérateur.numero IN 
        (
        SELECT numero_operateur
        FROM Pièce
        )
    )
;

-- 10
SELECT SUM(quantité) AS Quantité_Totale
FROM Pièce;

-- 11
SELECT 6*SUM(quantité) AS Chiffre_d_affaires
FROM Pièce;

--12
SELECT COUNT(*) AS Nb_de_Qualifiés, reference_machine
FROM Qualifié_sur
GROUP BY reference_machine;

-- 13
SELECT COUNT(*) AS Nb_de_ref_machine, reference_machine
FROM Pièce
GROUP BY reference_machine;

-- 14
SELECT SUM(quantité) AS Quantité_tot, numero_operateur
FROM Pièce
GROUP BY numero_operateur;

-- 15
SELECT AVG(quantité) AS Moyenne_pièce, reference_machine
FROM Pièce
GROUP BY reference_machine;

-- 16
SELECT DISTINCT numero_operateur
FROM Qualifié_sur
GROUP BY reference_machine
HAVING COUNT(*) >= 2;

--17
SELECT Qualifié_sur.numero_operateur
FROM Qualifié_sur
WHERE strftime('%Y', Qualifié_sur.date) >= '2000'
GROUP BY Qualifié_sur.numero_operateur
HAVING COUNT(DISTINCT Qualifié_sur.numero_operateur) >= 2;

-- TD5
-- Création des tables
-- Table acteur
CREATE TABLE acteur (
    idA INT PRIMARY KEY,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    nationalite VARCHAR(50)
);

-- Exemple de données pour la table acteur
INSERT INTO acteur (idA, nom, prenom, nationalite)
VALUES
    (1, 'Doe', 'John', 'Américain'),
    (2, 'Smith', 'Emma', 'Britannique'),
    (3, 'Choi', 'Ji-Won', 'Coréen');

-- Table film
CREATE TABLE film (
    idF INT PRIMARY KEY,
    titre VARCHAR(100),
    annee INT,
    nbspectateurs INT,
    idRealisateur INT,
    idGenre INT,
    FOREIGN KEY (idRealisateur) REFERENCES realisateur(idR),
    FOREIGN KEY (idGenre) REFERENCES genre(idG)
);

-- Exemple de données pour la table film
INSERT INTO film (idF, titre, annee, nbspectateurs, idRealisateur, idGenre)
VALUES
    (1, 'Inception', 2010, 1000000, 1, 1),
    (2, 'La La Land', 2016, 800000, 2, 2),
    (3, 'Parasite', 2019, 1200000, 3, 3);

-- Table jouer
CREATE TABLE jouer (
    idActeur INT,
    idFilm INT,
    salaire DECIMAL(10, 2),
    PRIMARY KEY (idActeur, idFilm),
    FOREIGN KEY (idActeur) REFERENCES acteur(idA),
    FOREIGN KEY (idFilm) REFERENCES film(idF)
);

-- Exemple de données pour la table jouer
INSERT INTO jouer (idActeur, idFilm, salaire)
VALUES
    (1, 1, 500000),
    (2, 2, 700000),
    (3, 3, 600000);

-- Table realisateur
CREATE TABLE realisateur (
    idR INT PRIMARY KEY,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    nationalite VARCHAR(50)
);

-- Exemple de données pour la table realisateur
INSERT INTO realisateur (idR, nom, prenom, nationalite)
VALUES
    (1, 'Nolan', 'Christopher', 'Américain'),
    (2, 'Chazelle', 'Damien', 'Américain'),
    (3, 'Bong', 'Joon-ho', 'Coréen');

-- Table genre
CREATE TABLE genre (
    idG INT PRIMARY KEY,
    description VARCHAR(50)
);

-- Exemple de données pour la table genre
INSERT INTO genre (idG, description)
VALUES
    (1, 'Science-fiction'),
    (2, 'Musical'),
    (3, 'Drame');
   
-- Afficher les tables 
SELECT * FROM acteur;
SELECT * FROM film;
SELECT * FROM jouer;
SELECT * FROM realisateur;
SELECT * FROM genre;

DROP TABLE IF EXISTS acteur;
DROP TABLE IF EXISTS film;
DROP TABLE IF EXISTS jouer;
DROP TABLE IF EXISTS realisateur;
DROP TABLE IF EXISTS genre;

-- 1
SELECT film.titre 
FROM film
WHERE ( film.idGenre IN 
        ( 
        SELECT genre.idG
        FROM genre
        WHERE (genre.description = 'Musical')
        )
    )
ORDER BY film.annee 
;

-- 2
SELECT nom, prenom
FROM acteur
WHERE (nationalite = 'Britannique') 
AND (
    acteur.idA IN 
        (
        SELECT jouer.idActeur
        FROM jouer
        WHERE 
            (
                jouer.idFilm IN 
                    (
                        SELECT film.idF
                        FROM film
                        WHERE 
                            (
                            film.idGenre IN 
                                (
                                    SELECT genre.idG
                                    FROM genre 
                                    WHERE 
                                    (
                                        description = 'Musical'
                                    )
                                )
                            )
                    )
            )
        )
    );

-- 3


-- 4
SELECT MIN(film.nbspectateurs) AS Miniumum, MAX(film.nbspectateurs) AS Maximum, AVG(film.nbspectateurs) AS Moyenne
FROM film
WHERE (film.idGenre 
IN (
    SELECT genre.idG
    FROM genre
    WHERE ( description = 'Science-fiction')
    )
)
;

-- INNER JOIN
SELECT * 
FROM film
INNER JOIN genre ON film.idGenre = genre.idG;

-- 5
SELECT SUM(film.nbspectateurs) AS popularité
FROM film
WHERE (film.idRealisateur IN (SELECT realisateur.idR FROM realisateur WHERE (nom = 'Nolan')));

-- 6
SELECT 6*film.nbspectateurs AS Recette
FROM film
WHERE (annee = '2010')
AND (film.idRealisateur IN (SELECT realisateur.idR FROM realisateur WHERE (nationalite = 'Américain')));

-- 7
SELECT nationalite, COUNT(*) AS nb_nationalité
FROM acteur
GROUP BY nationalite;

-- 8
SELECT g.description, COUNT(*) AS nb_films
FROM film f
JOIN genre g ON g.idG = f.idGenre
GROUP BY g.description;

-- 9
SELECT g.idG AS Identifiant, COUNT(*) AS nb_films
FROM film f
JOIN genre g ON g.idG = f.idGenre
GROUP BY g.idG;

-- 10
SELECT r.nom AS Nom, r.prenom AS Prénom, MIN(f.nbspectateurs) AS Minimum, MAX(f.nbspectateurs) AS Maximum, AVG(f.nbspectateurs) AS Moyenne 
FROM realisateur r 
JOIN film f ON r.idR = f.idRealisateur
GROUP BY r.nom;

-- 11
SELECT a.nom AS Nom, a.prenom AS Prénom
FROM acteur a 
JOIN jouer j ON j.idActeur = a.idA
GROUP BY a.nom
HAVING (AVG(j.salaire) > 650000);
*/
-- TD 6
-- EXERCICE 1
/*
CREATE TABLE personne (
    id CHAR(10), 
    nom VARCHAR(25), 
    prenom VARCHAR(25), 
    dateNaiss DATE,
    PRIMARY KEY(id)
    );

CREATE TABLE voiture (
    immatriculation CHAR(9), 
    marque VARCHAR(25),
    annee INT, 
    prix FLOAT, 
    idProp REFERENCES personne(id),
    PRIMARY KEY(immatriculation)
    );

-- Insertion de données dans la table personne
INSERT INTO personne (id, nom, prenom, dateNaiss)
VALUES
    ('P001', 'Dupont', 'Jean', '1990-05-15'),
    ('P002', 'Martin', 'Sophie', '1985-08-22'),
    ('P003', 'Lefevre', 'Paul', '1978-11-10'),
    ('P004', 'Dubois', 'Isabelle', '1995-02-28'),
    ('P005', 'Girard', 'Luc', '1980-07-12'),
    ('P006', 'Leclerc', 'Marie', '1992-09-05');

-- Insertion de données dans la table voiture
INSERT INTO voiture (immatriculation, marque, annee, prix, idProp)
VALUES
    ('AB123CD', 'Toyota', 2019, 25000.50, 'P001'),
    ('XY987ZP', 'Honda', 2020, 28000.75, 'P002'),
    ('LM456KJ', 'Ford', 2018, 20000.25, 'P003'),
    ('JK789LM', 'Chevrolet', 2021, 30000.00, 'P005'),
    ('NO456YZ', 'Volkswagen', 2017, 18000.90, 'P006');
*/
/*
SELECT * FROM personne;
SELECT * FROM voiture;
*/
-- 1
/*
SELECT p.nom AS Nom, p.prenom AS Prénom
FROM personne p
WHERE (p.id NOT IN (SELECT idProp FROM voiture));

-- 2
SELECT p.nom AS Nom, p.prenom AS Prénom
FROM personne p
WHERE (p.id IN (SELECT idProp FROM voiture WHERE (prix < 20000)));

-- 3
SELECT p.nom AS Nom, p.prenom AS Prénom
FROM personne p
JOIN voiture v ON v.idProp = p.id
WHERE (v.prix IN (SELECT MAX(prix) FROM voiture));

-- 4
SELECT p.nom AS Nom, p.prenom AS Prénom
FROM personne p
JOIN voiture v ON V.idProp = p.id
WHERE ( SELECT COUNT(*)
        FROM voiture v
        GROUP BY v.idProp
) = ( 
    SELECT MAX(nb_voiture)
    FROM ( 
        SELECT COUNT(*) AS nb_voiture
        FROM voiture v
        GROUP BY v.idProp
        ) AS subquery
    );
*/
-- EXERCICE 2
/*
-- Création de la table Avion
CREATE TABLE Avion (
    NumAvion INT PRIMARY KEY,
    Nom VARCHAR(50),
    Capacite INT,
    Localite VARCHAR(50)
);

-- Insertion de valeurs dans la table Avion
INSERT INTO Avion (NumAvion, Nom, Capacite, Localite)
VALUES
    (1, 'Airbus A320', 150, 'Paris'),
    (2, 'Boeing 737', 120, 'New York'),
    (3, 'Embraer E190', 100, 'London');

-- Création de la table Pilote
CREATE TABLE Pilote (
    NumPilote INT PRIMARY KEY,
    Nom VARCHAR(50),
    Adresse VARCHAR(100)
);

-- Insertion de valeurs dans la table Pilote
INSERT INTO Pilote (NumPilote, Nom, Adresse)
VALUES
    (101, 'Smith', '123 Main St, City1'),
    (102, 'Johnson', '456 Oak St, City2'),
    (103, 'Williams', '789 Pine St, City3');

-- Création de la table Vol
CREATE TABLE Vol (
    NumVol INT PRIMARY KEY,
    NumPilote INT,
    NumAvion INT,
    VilleDepart VARCHAR(50),
    VilleArrivee VARCHAR(50),
    HeureDepart DATETIME,
    HeureArrivee DATETIME,
    FOREIGN KEY (NumPilote) REFERENCES Pilote(NumPilote),
    FOREIGN KEY (NumAvion) REFERENCES Avion(NumAvion)
);

-- Insertion de valeurs dans la table Vol
INSERT INTO Vol (NumVol, NumPilote, NumAvion, VilleDepart, VilleArrivee, HeureDepart, HeureArrivee)
VALUES
    (1001, 101, 1, 'Paris', 'New York', '2024-01-01 08:00:00', '2024-01-01 12:00:00'),
    (1002, 102, 2, 'New York', 'London', '2024-01-02 10:00:00', '2024-01-02 15:00:00'),
    (1003, 103, 3, 'London', 'Paris', '2024-01-03 14:00:00', '2024-01-03 18:00:00');

SELECT * FROM Avion; 
SELECT * FROM Pilote;
SELECT * FROM Vol;

-- 1
SELECT NumAVion 
FROM Avion 
WHERE (Capacite = (SELECT MIN(Capacite) FROM Avion));

-- 2
SELECT Nom 
FROM Avion
WHERE (Capacite >= (SELECT AVG(Capacite) FROM Avion));

-- 3
Oui 

--4 
SELECT p.NumPilote AS NumPilote
FROM Pilote p 
INNER JOIN Vol v on v.NumPilote = p.NumPilote
WHERE ((
    SELECT COUNT(*)
    FROM Vol v
    GROUP BY v.NumPilote
) = ( 
    SELECT MAX(Nb_Vols) AS Nb_Vols
    FROM (
        SELECT COUNT(*) AS Nb_Vols
        FROM Vol v
        GROUP BY v.NumPilote
        ) AS subquery 
    )
);
*/
-- TD 8 
/*
SELECT * FROM acteur;
SELECT * FROM film;
SELECT * FROM jouer;
SELECT * FROM realisateur;
SELECT * FROM genre;*/
/*
-- 1
SELECT a.prenom AS Prénom, a.nom AS Nom
FROM acteur a
JOIN jouer j ON j.idActeur = a.idA
JOIN film f ON j.idFilm = f.idF
ORDER BY f.nbspectateurs DESC
LIMIT 1;

-- 2
SELECT a.prenom AS Prénom, a.nom AS Nom, f.titre AS Titre, f.nbspectateurs AS Succès
FROM acteur a
JOIN jouer j ON a.idA = j.idActeur
JOIN film f ON f.idF = j.idFilm
WHERE (a.nom, j.salaire) IN (SELECT a.nom, MAX(j.salaire) FROM acteur a JOIN jouer j ON j.idActeur = a.idA GROUP BY j.idActeur, a.idA );

-- 3
SELECT r.prenom AS Prénom, r.nom AS Nom, f.nbspectateurs AS Succès
FROM realisateur r
JOIN film f ON f.idRealisateur = r.idR
WHERE (f.nbspectateurs, f.idRealisateur) IN (SELECT MAX(f.nbspectateurs), f.idRealisateur FROM film f GROUP BY f.idRealisateur);
*/

