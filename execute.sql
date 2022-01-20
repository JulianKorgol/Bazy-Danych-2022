USE master
GO

DROP DATABASE IF EXISTS Poczta
GO

CREATE DATABASE Poczta
GO

USE Poczta
GO

--Zad 1
CREATE TABLE Adresy (
    ID INT PRIMARY KEY,
    Ulica VARCHAR(30) NOT NULL CHECK(LEN(Ulica) >= 5),
    NumerDomu VARCHAR(4) NOT NULL CHECK(LEN(NumerDomu) >= 1),
    NumerLokalu VARCHAR(4),
    KodPocztowy CHAR(6) NOT NULL CHECK(KodPocztowy LIKE '__-___')
)

CREATE TABLE Paczki (
    ID INT PRIMARY KEY,
    Waga DECIMAL(3,1) NOT NULL CHECK(Waga >= 1),
    DataNadania DATETIME NOT NULL,
    Dostarczona CHAR(3) NOT NULL DEFAULT('NIE') CHECK(Dostarczona IN ('TAK', 'Nie')),
    AdresId INT NOT NULL FOREIGN KEY REFERENCES Adresy (Id),
)

--Zad 2
INSERT INTO Adresy (ID, Ulica, NumerDomu, NumerLokalu, KodPocztowy)
VALUES
(1, 'Leœna', '1', '3', '00-123'),
(2,'Sasankowe', '10A', NULL, '10-001'),
(3,'Chabrowa', '12', NULL, '99-777'),
(4,'Lipowa', '44', '55', '60-006'),
(5,'Sasankowa', '6H', '891', '00-123'),
(6,'Cement', '2', '101', '17-120')

INSERT INTO Paczki
VALUES
(10, 1.3, 2022-01-12, 'NIE', 3),
(20, 2.7, 2022-01-20, 'NIE', 4),
(30, 3.0, 2022-01-19, 'NIE', 1),
(40, 1.3, 2022-01-12, 'NIE', 3),
(50, 5.4, 2022-01-01, 'NIE', 6),
(60, 2.2, 2022-01-09, 'NIE', 4)

--ZAD 3
UPDATE Paczki
SET Dostarczona = 'TAK'
WHERE DataNadania < 2022-01-15

--ZAD 4
-- Poniewa¿ data dostarczenia nie mo¿e byæ nullem.
-- Adres ID nie mo¿e siê odwo³aæ do elementu, który nie istniejê.
-- Data jest za du¿a, nie ma 15 miesi¹ca.
-- Primary Key musi byæ unikalne.

--Zad 5
DELETE Adresy
WHERE Id IN ((SELECT Adresy.ID FROM Adresy LEFT OUTER JOIN Paczki P on Adresy.ID = P.AdresId WHERE P.id IS NULL))

--Zad 6
DELETE Adresy
WHERE ID = 6
--Poniewa¿ jest zarejestrowana na niego paczka i przez co odwo³uje siê do niego klucz obcy.

--Zad 7
SELECT a.Id, a.Ulica, a.NumerDomu, a.NumerLokalu, a.KodPocztowy,
       (SELECT COUNT(p2.ID) FROM Paczki p2 FULL OUTER JOIN Adresy A2 on A2.ID = p2.AdresId WHERE Dostarczona = 'TAK' AND A2.ID = a.ID) AS Dostarczona,
       (SELECT COUNT(p2.ID) FROM Paczki p2 FULL OUTER JOIN Adresy A2 on A2.ID = p2.AdresId WHERE Dostarczona = 'NIE' AND A2.ID = a.ID) AS Niedostarczona
FROM Adresy a
--Drugi sposób (Pana sposób)
SELECT *,
       (SELECT COUNT(*) FROM Paczki p WHERE p.AdresId = a.ID AND Dostarczona = 'TAK') LiczbaDostarczonych,
       (SELECT COUNT(*) FROM Paczki p WHERE p.AdresId = a.ID AND Dostarczona = 'NIE') LiczbaNiedostarczonych
FROM Adresy a