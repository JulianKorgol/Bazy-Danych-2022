USE master
GO

DROP DATABASE IF EXISTS Szkola
GO

CREATE DATABASE SZKOLA
GO

USE Szkola
GO

--1.
-- CREATE DATABASE Szkola

--2. -> Na sprawdzian
-- CREATE TABLE Uczen (ID INT NOT NULL IDENTITY(1,1),
-- Imie VARCHAR(30) NOT NULL CHECK(LEN(Imie) >= 3),
-- DrugieImie VARCHAR(30) CHECK(LEN(DrugieImie) >= 3),
-- Nazwisko VARCHAR(30) NOT NULL CHECK(LEN(Nazwisko) >= 3),
-- DataUrodzenia DATE NOT NULL)

-- OdpowiedŸ z tablicy:
-- CREATE TABLE Uczen (
--     Id INT NOT NULL IDENTITY UNIQUE,
--     Imie VARCHAR(30) NOT NULL CHECK(LEN(Imie) >= 3),
--     DrugieImie VARCHAR(30) CHECK(LEN(DrugieImie) >= 3),
--     Nazwisko VARCHAR(30) NOT NULL CHECK(LEN(Nazwisko) >= 3),
--     DataUrodzenia DATE NOT NULL
-- )

--3.
-- ALTER TABLE Uczen
-- ADD SredniaOcen NUMERIC(3,2) NOT NULL CHECK(SredniaOcen >= 1.0 AND SredniaOcen <= 6.0) DEFAULT(5.0)

--4.
-- ALTER Table Uczen
-- ALTER COLUMN Nazwisko VARCHAR(50) NOT NULL

--5.
-- ALTER Table Uczen
-- ALTER COLUMN DataUrodzenia DATE NOT NULL CHECK(DATEDIFF(YEAR, GETDATE(), DataUrodzenia) >= 16)

-- ALTER TABLE Uczen
-- ADD CONSTRAINT CK_DataUrodzenia CHECK(DATEDIFF(YEAR, DataUrodzenia, GETDATE()) >= 16)





--Druga lekcja

CREATE TABLE Adresy (
    Id INT PRIMARY KEY,
    Ulica VARCHAR(30) NOT NULL,
    Miasto VARCHAR(40) NOT NULL,
    UczenId INT NOT NULL FOREIGN KEY REFERENCES Uczen(ID)
)