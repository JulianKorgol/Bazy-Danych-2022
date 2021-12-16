-- USE master
-- GO

-- ZAD 1
-- DROP DATABASE IF EXISTS Panek
-- CREATE DATABASE Panek

-- USE Panek
-- GO
--
-- Zad 2
-- CREATE TABLE Samochody (
--     NumerRej VARCHAR(10) NOT NULL PRIMARY KEY,
--     Marka VARCHAR(30) NOT NULL CHECK(LEN(Marka) >= 3),
--     RokProdukcji SMALLINT NOT NULL CHECK((RokProdukcji - GETDATE() <= 6)),
--     CenaZaKm MONEY NOT NULL CHECK(CenaZaKm >= 1 AND 9999.99 >= CenaZaKm),
--     Klimatyzacja CHAR(3) NOT NULL DEFAULT('TAK') CHECK(Klimatyzacja IN ('TAK', 'NIE')),
-- )
--Zad 3
-- ALTER TABLE Samochody
-- ADD DataBadanTech DATE CHECK(DataBadanTech >= GETDATE())
--ZAD 4
-- ALTER TABLE Samochody
-- ALTER COLUMN Klimatyzacja CHAR(3)
--ZAD 5
ALTER TABLE Samochody
ADD CONSTRAINT CH_Marka CHECK(Marka IN ('FORD','TOYOTA','SEAT','BMW'))
--ZAD 6
-- ALTER TABLE Samochody
-- DROP CONSTRAINT CK__Samochody__CenaZ__267ABA7A --Uwielbiam takie nazwy :D
--

--ZAD 7
CREATE TABLE Klienci (
    ID INT NOT NULL IDENTITY PRIMARY KEY,
    Imie VARCHAR(30) NOT NULL,
    Nazwisko VARCHAR(30) NOT NULL,
    KartaKredytowa VARCHAR(25) NOT NULL,
    NumerRej VARCHAR(10) NOT NULL FOREIGN KEY REFERENCES Samochody(NumerRej),
    DataWypozyczenia DATETIME NOT NULL,
    DataZwrotu DATETIME NOT NULL,
)