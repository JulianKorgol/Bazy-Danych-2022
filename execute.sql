USE Sprawdzian4
GO

--6
CREATE PROC spFilmyRezysera AS
    BEGIN
        SELECT Rezyser, COUNT(*) FROM Filmy
        GROUP BY Rezyser
    end

-- SELECT * FROM Filmy
EXEC spFilmyRezysera

--7
CREATE PROC spPromocja @rok INT AS
    BEGIN
        UPDATE Filmy
        SET CenaBiletu = CenaBiletu - 5
        WHERE @rok > RokWydania
    end

SELECT * FROM Filmy
EXEC spPromocja 1995


--8
CREATE OR ALTER TRIGGER trgZmianaCeny ON Filmy AFTER UPDATE AS
    BEGIN
        DECLARE @staraCena money
        DECLARE @nowaCena money

        SET @staraCena = (SELECT CenaBiletu FROM deleted)
        SET @nowaCena = (SELECT CenaBiletu FROM inserted)

        PRINT 'Zmiana ceny z ' + CAST(@staraCena AS VARCHAR(10)) + ' na ' + CAST(@nowaCena AS VARCHAR(10))
    end

UPDATE Filmy
        SET CenaBiletu = CenaBiletu - 5
        WHERE RokWydania < 1995

--9 -> Nie działa
CREATE OR ALTER TRIGGER trgNowyFilm ON Filmy AFTER INSERT AS
    BEGIN
        DECLARE @tytul VARCHAR(100)
        DECLARE @wiadomosc VARCHAR(200)
        DECLARE @wBazie VARCHAR(100)

        SET @tytul = (SELECT Tytul FROM inserted)
        SET @wiadomosc = 'Film ' + CAST(@tytul AS VARCHAR(100)) + ' już istnieje'
        SET @wBazie = (SELECT Tytul FROM Filmy WHERE Tytul = @tytul)

        IF @tytul = @wBazie
            BEGIN
                RAISERROR(@wiadomosc, 16, 1)
                ROLLBACK
            end
    end

INSERT INTO Filmy VALUES
    (9, 'Nie', 'Ja', '2022', 20.00)

SELECT * FROM Filmy

--10
CREATE TABLE Student (
    id INT IDENTITY PRIMARY KEY NOT NULL,
    imie VARCHAR(30) NOT NULL CHECK(LEN(imie) >= 3),
    nazwisko VARCHAR(30) NOT NULL CHECK(LEN(nazwisko) >= 3),
    dataUrodzenia DATE NOT NULL CHECK(dataUrodzenia <= GETDATE()),
    przedmiotID INT REFERENCES Przedmiot(id)
)

CREATE TABLE Przedmiot (
    id INT IDENTITY PRIMARY KEY NOT NULL,
    nazwa VARCHAR(50) NOT NULL CHECK(LEN(nazwa) >= 3),
    numerSali SMALLINT NOT NULL,
)

--11
CREATE OR ALTER TRIGGER trgCena ON Filmy AFTER INSERT, UPDATE AS
    BEGIN
        DECLARE @cena money

        SET @cena = (SELECT CenaBiletu FROM inserted)

        IF (@cena % 5) = 0
        BEGIN
            RAISERROR('Dodanie lub Aktualizacja ceny biletu niemożliwa', 16, 2)
            ROLLBACK
        end
    end

INSERT INTO Filmy VALUES
    (11, 'nope', 'Władek', '2019', 13.00)

SELECT * FROM Filmy