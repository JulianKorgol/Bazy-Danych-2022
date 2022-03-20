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
    rasa VARCHAR(50) NOT NULL,
    numerKojca SMALLINT,
    dataSprzatania DATE,
    wolontariuszID INT REFERENCES Wolontariusz(id)
)

CREATE TABLE Wolontariusz (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    imie VARCHAR(30) NOT NULL CHECK(LEN(imie) >= 3),
    nazwisko VARCHAR(30) NOT NULL CHECK(LEN(nazwisko) >= 3),
    dataUrodzenia DATE NOT NULL CHECK(dataUrodzenia <= GETDATE()),
    liczbaGodzin INT NOT NULL
)

--d
CREATE TABLE Pracownik (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    imie VARCHAR(30) NOT NULL CHECK(LEN(imie) >= 3),
    nazwisko VARCHAR(30) NOT NULL CHECK(LEN(nazwisko) >= 3),
    stanowisko VARCHAR(50) NOT NULL,
    numerPokoju SMALLINT,
    pietroPokoju SMALLINT
)

CREATE TABLE Zadanie (
    nazwa VARCHAR(50) NOT NULL,
    opis VARCHAR(max) NOT NULL,
    dataRozpoczecia DATETIME NOT NULL,
    dataZakonczenia DATETIME NOT NULL,
    pracownikID INT REFERENCES Pracownik(id)
)

CREATE TABLE Projekt (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    nazwa VARCHAR(50) NOT NULL,
    dataRozpoczecia DATETIME NOT NULL,
    dataZakonczenia DATETIME NOT NULL,
    budzet BIGINT NOT NULL CHECK(budzet > 0)
)


-- Zadanie 2
CREATE TABLE Magazyn (
    numer CHAR(6) NOT NULL UNIQUE PRIMARY KEY,
    szerokoscGeograficzna float NOT NULL,
    wysokoscGeograficzna float NOT NULL,
)

CREATE TABLE Przesylka (
    numer BIGINT NOT NULL UNIQUE IDENTITY PRIMARY KEY,
    magazynId CHAR(6) REFERENCES Magazyn(numer),
    waga SMALLINT NOT NULL CHECK(waga > 0),
    szerokoscPaczki SMALLINT NOT NULL CHECK(szerokoscPaczki > 0),
    dlugoscPaczki SMALLINT NOT NULL CHECK(dlugoscPaczki > 0),
    wysokoscPaczki SMALLINT NOT NULL CHECK(wysokoscPaczki > 0),
    krajNadania VARCHAR(30) NOT NULL,
    ulicaNadania VARCHAR(50) NOT NULL,
    numerBudynkuNadania SMALLINT NOT NULL,
    kodPocztowyNadawcy VARCHAR(6) NOT NULL CHECK(kodPocztowyNadawcy LIKE '%-%'),
    krajOdbiorcy VARCHAR(30) NOT NULL,
    ulicaOdbiorcy VARCHAR(50) NOT NULL,
    numerBudynkuOdbiorcy SMALLINT NOT NULL,
    kodPocztowyOdbiorcy VARCHAR(6) NOT NULL CHECK(kodPocztowyOdbiorcy LIKE '%-%'),
    status VARCHAR(30) NOT NULL CHECK(status IN ('w realizacji', 'doręczona', 'w drodze')),
    nastepnyMagazyn CHAR(6) REFERENCES Magazyn(numer),
    samochodDostawczy VARCHAR(10) REFERENCES SamochodDostawczy(numerRejestracyjny)
)

CREATE TABLE SamochodDostawczy (
    numerRejestracyjny VARCHAR(10) NOT NULL UNIQUE PRIMARY KEY,
    najblizszyWyjazd DATETIME,
    zMagazynu CHAR(6) REFERENCES Magazyn(numer),
    doMagazynu CHAR(6) REFERENCES Magazyn(numer),
    status VARCHAR(30) NOT NULL,
    dodatkoweInformacje VARCHAR(max),
    kierowca INT REFERENCES Kierowca(id)
)

CREATE TABLE Serwis (
    samochod VARCHAR(10) NOT NULL REFERENCES SamochodDostawczy(numerRejestracyjny),
    ostatniaData DATE NOT NULL,
    kategoria VARCHAR(17) NOT NULL CHECK(kategoria IN ('badaniaTechniczne', 'serwis', 'awaria')),
    opis VARCHAR(max)
)

CREATE TABLE Kierowca (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    imie VARCHAR(30) NOT NULL CHECK(LEN(imie) >= 3),
    nazwisko VARCHAR(30) NOT NULL CHECK(LEN(nazwisko) >= 3),
    dataOstanichBadańLekarskich DATE NOT NULL CHECK(dataOstanichBadańLekarskich <= GETDATE()),
    kraj VARCHAR(30) NOT NULL,
    ulica VARCHAR(50) NOT NULL,
    numerBudynku SMALLINT NOT NULL,
    kodPocztowy VARCHAR(6) NOT NULL CHECK(kodPocztowy LIKE '%-%'),
    dodatkoweInformacje VARCHAR(max),
    punktyKarne SMALLINT NOT NULL
)