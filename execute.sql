-- Trening przed sprawdzianem

USE master
GO

CREATE DATABASE Ksiegarnia
GO

USE Ksiegarnia
GO

CREATE TABLE Ksiazki (
    Id INT IDENTITY PRIMARY KEY,
    Tytul VARCHAR(30) NOT NULL CHECK(LEN(Tytul) >= 3),
    Autor VARCHAR(50) NOT NULL CHECK(LEN(Autor) >= 10),
    DataWypozyczenia DATE,
    LiczbaWypozyczen SMALLINT NOT NULL DEFAULT(0)
)

ALTER TABLE Ksiazki
ADD Stan VARCHAR(10) NOT NULL CHECK(Stan IN ('Z£Y', 'DOBRY', 'BARDZO DOBRY'))

INSERT INTO Ksiazki (Tytul, Autor, DataWypozyczenia, LiczbaWypozyczen, Stan) VALUES
('Mistrz i Ma³gorzata', 'Mikhail Bulgakov', NULL, 0, 'DOBRY'),
('Hyperion', 'Dan Simons', '2020-05-30', 15, 'DOBRY'),
('Lód', 'Jacek Dukaj', '2019-12-22', 2, 'DOBRY'),
('Paragraf 22', 'Joseph Heller', '2020-10-14', 33, 'DOBRY')

UPDATE Ksiazki
SET DataWypozyczenia = GETDATE(), LiczbaWypozyczen += 1
WHERE Tytul = 'Hyperion'


SELECT COUNT(*) FROM Ksiazki
WHERE YEAR(DataWypozyczenia) = YEAR(GETDATE())


CREATE TABLE Czytelnicy (
    IdKarty INT PRIMARY KEY,
    Imie VARCHAR(30) NOT NULL CHECK(LEN(Imie) >= 2),
    DrugieImie VARCHAR(30) CHECK(LEN(DrugieImie) >= 2),
    Nazwisko VARCHAR(30) NOT NULL CHECK(LEN(Nazwisko) >= 2),
    LiczbaWypozyczen INT NOT NULL DEFAULT(0),
)

INSERT INTO Czytelnicy (IdKarty, Imie, DrugieImie, Nazwisko) VALUES
(1, 'Julian', NULL, 'Korgol')

SELECT * FROM Czytelnicy

CREATE TABLE TEST (
    Test DECIMAL(4, 3),
)

INSERT INTO TEST VALUES
-- (4)
-- (6.5)
-- (9.9999)
-- (57.1)
-- (0.001)

SELECT * FROM TEST