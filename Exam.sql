-- SQLite
/*
-- Création de la table Etudiants
CREATE TABLE Etudiants (
    numeroE INT PRIMARY KEY,
    nomE VARCHAR(50),
    prenomE VARCHAR(50)
);

-- Exemple de données pour la table Etudiants
INSERT INTO Etudiants (numeroE, nomE, prenomE)
VALUES
    (1, 'Dupont', 'Jean'),
    (2, 'Martin', 'Sophie'),
    (3, 'Lefevre', 'Paul'),
    (4, 'Girard', 'Luc');

-- Création de la table Formation
CREATE TABLE Formation (
    codeF INT PRIMARY KEY,
    nomFormation VARCHAR(100)
);

-- Exemple de données pour la table Formation
INSERT INTO Formation (codeF, nomFormation)
VALUES
    (101, 'Informatique'),
    (102, 'Mathématiques'),
    (103, 'Physique');

-- Création de la table Inscrit
CREATE TABLE Inscrit (
    numeroE INT,
    codeF INT,
    PRIMARY KEY (numeroE, codeF),
    FOREIGN KEY (numeroE) REFERENCES Etudiants(numeroE),
    FOREIGN KEY (codeF) REFERENCES Formation(codeF)
);

-- Exemple de données pour la table Inscrit
INSERT INTO Inscrit (numeroE, codeF)
VALUES
    (1, 101),
    (2, 102),
    (3, 103),
    (4, 101);

-- Création de la table UE
CREATE TABLE UE (
    codeUE INT PRIMARY KEY,
    nomUE VARCHAR(50),
    codeF INT,
    FOREIGN KEY (codeF) REFERENCES Formation(codeF)
);

-- Exemple de données pour la table UE
INSERT INTO UE (codeUE, nomUE, codeF)
VALUES
    (1001, 'Algorithmique', 101),
    (1002, 'Analyse Mathématique', 102),
    (1003, 'Mécanique Quantique', 103);

-- Création de la table Session
CREATE TABLE Session (
    numeroS INT PRIMARY KEY
);

-- Exemple de données pour la table Session
INSERT INTO Session (numeroS)
VALUES
    (1),
    (2),
    (3);

-- Création de la table NoteExamen
CREATE TABLE NoteExamen (
    numeroE INT,
    codeUE INT,
    numeroS INT,
    note FLOAT,
    PRIMARY KEY (numeroE, codeUE, numeroS),
    FOREIGN KEY (numeroE) REFERENCES Etudiants(numeroE),
    FOREIGN KEY (codeUE) REFERENCES UE(codeUE),
    FOREIGN KEY (numeroS) REFERENCES Session(numeroS)
);

-- Exemple de données pour la table NoteExamen
INSERT INTO NoteExamen (numeroE, codeUE, numeroS, note)
VALUES
    (1, 1001, 1, 16.5),
    (2, 1002, 1, 14.2),
    (3, 1003, 2, 18.9),
    (4, 1001, 2, 15.8);
*/
SELECT * FROM Etudiants;
SELECT * FROM Formation;
SELECT * FROM Inscrit;
SELECT * FROM UE;
SELECT * FROM Session;
SELECT * FROM NoteExamen;
/*
-- Question 1
SELECT e.prenomE AS Prénom, e.nomE AS Nom
FROM Etudiants e 
JOIN NoteExamen n ON n.numeroE = e.numeroE
JOIN UE u ON u.codeUE = n.codeUE
WHERE (n.note >= 10) AND (u.nomUE = 'Algorithmique') AND (n.numeroS = '1');

-- Question 2
SELECT e.numeroE, e.nomE, e.prenomE, i.codeF, f.nomFormation, n.note
FROM (
    Etudiants e 
    JOIN Inscrit i ON i.numeroE = e.numeroE
    JOIN Formation f ON f.codeF = i.codeF
    JOIN NoteExamen n ON n.numeroE = e.numeroE
    ) AS Subquery;

SELECT e.prenomE AS Prénom, e.nomE AS Nom
FROM (
    Etudiants e 
    JOIN Inscrit i ON i.numeroE = e.numeroE
    JOIN Formation f ON f.codeF = i.codeF
    JOIN NoteExamen n ON n.numeroE = e.numeroE
    )
WHERE 
    f.nomFormation = 'Informatique' 
    AND (e.prenomE, e.nomE) NOT IN (
        SELECT e.prenomE AS Prénom, e.nomE AS Nom 
        FROM Etudiants e 
        JOIN Inscrit i ON i.numeroE = e.numeroE
        JOIN Formation f ON f.codeF = i.codeF
        JOIN NoteExamen n ON n.numeroE = e.numeroE
        WHERE note < 10
        );

-- Question 3
SELECT e.prenomE AS Prénom, e.nomE AS Nom, AVG(note) AS Moyenne
FROM Etudiants e 
JOIN  Inscrit i ON i.numeroE = e.numeroE
JOIN Formation f ON f.codeF = i.codeF
JOIN NoteExamen n ON n.numeroE = e.numeroE
GROUP BY e.nomE
HAVING numeroS = '1';
*/
-- Question 4
