-- Praca domowa
USE master
GO

DROP DATABASE IF EXISTS PracaDomowaERD
GO

CREATE DATABASE PracaDomowaERD
GO

USE PracaDomowaERD
GO

-- 1.
-- a
CREATE TABLE Policjant (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    imie VARCHAR(30) NOT NULL CHECK(LEN(imie) >= 3),
    nazwisko VARCHAR(30) NOT NULL CHECK(LEN(nazwisko) >= 3),
    nazwaStanowiska VARCHAR(50) NOT NULL
)

CREATE TABLE Sledztwo (
    numer INT NOT NULL IDENTITY PRIMARY KEY,
    nazwa VARCHAR(50) NOT NULL,
    opis VARCHAR(max) NOT NULL,
    przypisanyPolicjant INT REFERENCES Policjant(id)
)

CREATE TABLE PodejrzanyZSledstwa (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    sledztwoId INT NOT NULL REFERENCES Sledztwo(numer),
    podejrzanyId INT NOT NULL REFERENCES Podejrzany(id)
)

CREATE TABLE Podejrzany (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    imie VARCHAR(30) NOT NULL CHECK(LEN(imie) >= 3),
    nazwisko VARCHAR(30) NOT NULL CHECK(LEN(nazwisko) >= 3),
    wzrost NUMERIC(5,2) NOT NULL CHECK(wzrost < 350),
    kolorOczu VARCHAR(10) NOT NULL
)

-- b
CREATE TABLE Uzytkownik (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    login VARCHAR(30) NOT NULL UNIQUE PRIMARY KEY,
    hasło VARCHAR(100) NOT NULL CHECK(LEN(hasło) >= 8),
    email VARCHAR(70) NOT NULL CHECK(email LIKE '%.%')
)

CREATE TABLE Artykul (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    tytul VARCHAR(75) NOT NULL CHECK(LEN(tytul) >= 3),
    tresc VARCHAR(max) NOT NULL,
    dataPublikacji DATETIME NOT NULL CHECK(dataPublikacji <= GETDATE())
)

CREATE TABLE Komentarz (
    tresc VARCHAR(max) NOT NULL,
    dataDodania DATETIME NOT NULL CHECK(dataDodania <= GETDATE()),
    artykulId INT NOT NULL REFERENCES Artykul(id),
    uzytkownikId INT NOT NULL REFERENCES Uzytkownik(id)
)

--c
CREATE TABLE Zwierze (
    numer INT NOT NULL IDENTITY PRIMARY KEY,
    dataPrzyjecia DATETIME NOT NULL CHECK(dataPrzyjecia <= GETDATE()),
    gatunek VARCHAR(50) NOT NULL,
    rasa VARCHAR(50) NOT NULL
)