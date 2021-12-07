USE Szkola
GO

--1.
-- CREATE DATABASE Szkola

--2. -> Na sprawdzian
CREATE TABLE Uczen (ID INT NOT NULL IDENTITY(1,1),
Imie VARCHAR(30) NOT NULL CHECK(LEN(Imie) >= 3),
DrugieImie VARCHAR(30) CHECK(LEN(DrugieImie) >= 3),
Nazwisko VARCHAR(30) NOT NULL CHECK(LEN(Nazwisko) >= 3),
DataUrodzenia DATE NOT NULL)

--3.
ALTER TABLE Uczen
ADD SredniaOcen NUMERIC(3,2) NOT NULL CHECK(1.0 >= SredniaOcen AND SredniaOcen >= 6.0) DEFAULT(5.0)

--4.
ALTER Table Uczen
ALTER COLUMN Nazwisko VARCHAR(50)

--5.
-- ALTER Table Uczen
-- ALTER COLUMN DataUrodzenia DATE NOT NULL CHECK(DATEDIFF(YEAR, GETDATE(), DataUrodzenia) >= 16)

ALTER TABLE Uczen
ADD CONSTRAINT DataUrodzenia CHECK(DATEDIFF(YEAR, GETDATE(), DataUrodzenia) >= 16)