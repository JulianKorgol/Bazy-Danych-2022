--1
CREATE PROC spLiczbaKsiazek AS
    BEGIN
        SELECT COUNT(*) FROM Ksiazki
    end

EXEC spLiczbaKsiazek

--2
CREATE PROC spKsiazkiZKategorii @kategoria VARCHAR(30) = 'fantastyka' AS
    BEGIN
        SELECT * FROM Ksiazki
        WHERE Kategoria = @kategoria
    end

EXEC  spKsiazkiZKategorii horror

--3
CREATE OR ALTER TRIGGER trgUsunKsiazke ON Ksiazki AFTER DELETE AS
    BEGIN
        DECLARE @LiczbaKsiazek INT
        SET @LiczbaKsiazek = (SELECT COUNT(*) FROM Ksiazki)

        PRINT 'W tabeli pozostało ' + CAST(@LiczbaKsiazek AS VARCHAR(10)) + ' książek'
    end

DELETE FROM Ksiazki
WHERE Cena = '21.34'

--4
CREATE OR ALTER TRIGGER trgNowaKsiazka ON Ksiazki AFTER INSERT AS
    BEGIN
        DECLARE @Cena FLOAT

        SET @Cena = (SELECT Cena FROM inserted)

        IF @Cena > 100
            BEGIN
                RAISERROR('Książka zbyt droga', 16, 1)
                ROLLBACK
            end
    end

INSERT INTO Ksiazki (Tytul, Autor, Wydawca, Ocena, LiczbaOcen, LiczbaStron, DataWydania, Cena, Kategoria) VALUES
    ('Siema', 'Julian Korgol', 'Techni Schools', 5.0, 8000, 10000, GETDATE(), 190.0, 'BESTSELLER')