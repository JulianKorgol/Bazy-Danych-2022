USE master
GO

CREATE DATABASE Diagramy
GO

USE Diagramy
GO

-- Zadanie 1
-- a

CREATE TABLE KlubSportowy (
    ID INT NOT NULL IDENTITY PRIMARY KEY,
    Nazwa VARCHAR(50) NOT NULL CHECK(LEN(Nazwa) >= 3),
    LiczbaGraczy INT CHECK(LiczbaGraczy >= 2),
    RokZalozenia SMALLINT CHECK(RokZalozenia <= YEAR(GETDATE())),
    Imie VARCHAR(30) NOT NULL CHECK(LEN(Imie) >= 3),
    Nazwisko VARCHAR(30) NOT NULL CHECK(LEN(Nazwisko) >= 3),
    Wynagrodzenie CHAR(9) NOT NULL,
)

-- b

CREATE TABLE Samochod (
    ID INT NOT NULL IDENTITY PRIMARY KEY,
    Marka VARCHAR(20) NOT NULL,
    Model VARCHAR(20) NOT NULL,
    RokProdukcji SMALLINT NOT NULL CHECK(RokProdukcji <= YEAR(GETDATE())),
    NumerRejestracyjny VARCHAR(10) NOT NULL
)

CREATE TABLE Naprawa (
    DataNaprawy DATE NOT NULL CHECK(DataNaprawy <= GETDATE()),
    Opis VARCHAR(max),
    Koszt INT NOT NULL,
    ID_Samochodu INT REFERENCES Samochod(ID)
)

-- c

CREATE TABLE Film (
    ID INT NOT NULL IDENTITY PRIMARY KEY,
    Tytuł VARCHAR(50) NOT NULL,
    RokProdukcji SMALLINT NOT NULL CHECK(RokProdukcji <= YEAR(GETDATE())),
    Kategoria VARCHAR(20) NOT NULL,
    Rezyser_ID INT NOT NULL REFERENCES Rezyser(ID),
    Nazwa VARCHAR(50),
    RokPrzyznania SMALLINT CHECK(RokPrzyznania <= YEAR(GETDATE()))
)

CREATE TABLE Rezyser (
    ID INT NOT NULL IDENTITY PRIMARY KEY,
    Imie VARCHAR(30) NOT NULL CHECK(LEN(Imie) >= 3),
    Nazwisko VARCHAR(30) NOT NULL CHECK(LEN(Nazwisko) >= 3),
)

-- d

CREATE TABLE Klasa (
    ID INT NOT NULL IDENTITY PRIMARY KEY,
    Rocznik SMALLINT NOT NULL CHECK(Rocznik <= YEAR(GETDATE())),
    NumerKlasy SMALLINT NOT NULL,
    Profil VARCHAR(30) NOT NULL,
    Wychowawca_ID SMALLINT REFERENCES Wychowawca(ID)
)

CREATE TABLE Wychowawca (
    ID INT NOT NULL IDENTITY PRIMARY KEY,
    Imie VARCHAR(30) NOT NULL CHECK(LEN(Imie) >= 3),
    Nazwisko VARCHAR(30) NOT NULL CHECK(LEN(Nazwisko) >= 3),
    Przedmiot VARCHAR(30) NOT NULL
)

CREATE TABLE Wycieczka (
    ID INT NOT NULL IDENTITY PRIMARY KEY,
    DataWyjazdu DATETIME NOT NULL CHECK(DataWyjazdu > GETDATE()),
    DataPowrotu DATETIME NOT NULL CHECK(DataPowrotu > Wycieczka.DataWyjazdu),
    Cel VARCHAR(70) NOT NULL,
    Klasa_ID INT NOT NULL REFERENCES Klasa(ID)
)

-- Zadanie 2

CREATE TABLE Klient (
    id INT IDENTITY PRIMARY KEY NOT NULL,
    imie VARCHAR(30) NOT NULL CHECK(LEN(imie) >= 3),
    nazwisko VARCHAR(30) NOT NULL CHECK(LEN(nazwisko) >= 3),
    dataUrodzenia DATE NOT NULL CHECK(dataUrodzenia <= GETDATE()),
    narodowosc VARCHAR(15) NOT NULL CHECK(narodowosc IN ('Polak', 'Niemiec', 'Francuz', 'Hiszpan') OR narodowosc IN ('Polka', 'Niemka', 'Francuska', 'Hiszpanka')),
    typKonta VARCHAR(8) NOT NULL CHECK(typKonta IN ('firmowe', 'osobiste')),
)

CREATE TABLE RachunekBankowy (
    numerRachunku CHAR(10) NOT NULL IDENTITY PRIMARY KEY CHECK(LEN(numerRachunku) = 10),
    saldo BIGINT NOT NULL,
    waluta CHAR(10) NOT NULL,
    numerKlienta INT NOT NULL REFERENCES Klient(id),
    dataOstatniegoLogowania DATETIME NOT NULL CHECK(dataOstatniegoLogowania <= GETDATE()),
    NIP CHAR(10) CHECK(LEN(NIP) = 10),
    nazwaFirmy VARCHAR(50)
)

CREATE TABLE Przelew (
    id INT NOT NULL IDENTITY PRIMARY KEY,
    numerKontaZrodlowego CHAR(10) NOT NULL REFERENCES RachunekBankowy(numerRachunku),
    numerkontaDocelowego CHAR(10) NOT NULL REFERENCES RachunekBankowy(numerRachunku),
    kwota BIGINT NOT NULL REFERENCES RachunekBankowy(saldo),
    waluta CHAR(10) NOT NULL
)