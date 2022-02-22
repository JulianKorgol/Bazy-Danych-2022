use master
GO

DROP DATABASE IF EXISTS Szpital
GO

CREATE DATABASE Szpital
GO

use Szpital
GO

DROP TABLE IF EXISTS Lekarze
GO

CREATE TABLE Lekarze (
    Id INT NOT NULL UNIQUE IDENTITY,
    Imie VARCHAR(30) NOT NULL CHECK(LEN(Imie) >= 3),
    Nazwisko VARCHAR(50) NOT NULL CHECK(LEN(Nazwisko) >= 5),
    Specjalizacja VARCHAR(20) CHECK(Specjalizacja IN ('INTERNISTA', 'KARDIOLOG', 'CHIRURG')),
    PoczatekDyzury TIME NOT NULL DEFAULT('7:00'),
    KoniecDyzuru TIME NOT NULL DEFAULT('13:30')
)

ALTER TABLE Lekarze
ADD LiczbaPacjentow TINYINT NOT NULL DEFAULT(0) CHECK(LEN(LiczbaPacjentow) <= 20)


INSERT INTO Lekarze (Imie, Nazwisko, Specjalizacja, PoczatekDyzury, KoniecDyzuru, LiczbaPacjentow) VALUES
('Adam', 'Silenus', 'CHIRURG', DEFAULT, DEFAULT, 5),
('Joanna', 'Brown', NULL, '9:00', '14:00', 13),
('Izabela', 'Kossak', 'INTERNISTA', '7:30', '12:00', 0),
('Zbigniew', 'Kasad', 'INTERNISTA', '8:00', '11:00', 1)

SELECT * FROM Lekarze

UPDATE Lekarze
SET KoniecDyzuru = DATEADD(hour, 1, KoniecDyzuru)
WHERE Specjalizacja = 'INTERNISTA'

DELETE FROM Lekarze
WHERE Specjalizacja IS NULL

SELECT Imie, Nazwisko, PoczatekDyzury, KoniecDyzuru FROM Lekarze
WHERE PoczatekDyzury < '12:15' AND '12:15' < KoniecDyzuru


CREATE TABLE Pacjenci (
    Imie VARCHAR(30) NOT NULL CHECK(LEN(Imie) >= 3),
    DrugieImie VARCHAR(30) CHECK(LEN(DrugieImie) >= 3),
    Nazwisko VARCHAR(50) NOT NULL CHECK(LEN(Nazwisko) >= 5),
    PESEL CHAR(11) NOT NULL UNIQUE CHECK(LEN(PESEL) = 11),
    Choroba VARCHAR(70) NOT NULL,
    DataPrzybycia DATETIME NOT NULL,
    DataWypisu DATETIME NOT NULL,
    DodatkoweInformacje VARCHAR(300),
)

INSERT INTO Pacjenci VALUES
('Julian', NULL, 'Korgol', '01234567890', 'JaNieMogeNieJestemChory', '2021-02-22 15:00', '2021-02-22 15:01', 'DUPA')

SELECT * FROM Pacjenci

SELECT Imie, Nazwisko FROM Lekarze
WHERE PoczatekDyzury < '12:15' AND '12:15' < KoniecDyzuru
