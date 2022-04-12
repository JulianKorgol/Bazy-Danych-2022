USE WyzwalaczeCwiczenia15
GO

-- SELECT * FROM HistoriaZamowienia
-- SELECT * FROM Klient
-- SELECT * FROM Pracownik
-- SELECT * FROM Zamowienie

-- Wyświetlanie Checka
-- SELECT DISTINCT Status FROM Zamowienie
-- Lub w środowisku

-- Ćwiczenia #15

-- 1, 2, 3
CREATE OR ALTER TRIGGER trgNowyKlient ON Klient AFTER INSERT AS
    BEGIN
        DECLARE @Imie VARCHAR(50)
        DECLARE @LiczbaKlientow INT
        SET @Imie = (SELECT Imie FROM inserted)
        SET @LiczbaKlientow = (SELECT COUNT(*) FROM Klient)
        PRINT 'Dodano klienta o imieniu: ' + @Imie
        PRINT 'Obecna liczba klientów to: ' + CAST(@LiczbaKlientow AS VARCHAR(50))
        IF @LiczbaKlientow > 10
            BEGIN
                RAISERROR('Nie można dodać następnego klienta', 16, 1)
                ROLLBACK
            end
    end
--
-- -- INSERT INTO Klient (Id, Imie, Nazwisko) VALUES
-- -- --     (70, 'Nope', 'Yup')
-- -- --     (80, 'Ni', 'Tak')
-- -- --     (90, 'Ja', 'No')
-- --     (110, 'Nie', 'TikTak')
--
--
-- SELECT * FROM KLient

-- 4
CREATE OR ALTER TRIGGER trgNoweZamowienie ON Zamowienie AFTER INSERT AS
    BEGIN
        DECLARE @KwotaZamowien INT
        SET @KwotaZamowien = (SELECT SUM(Wartosc) FROM Zamowienie WHERE Status != 'ZAKONCZONE')
        IF @KwotaZamowien > 2000
        BEGIN
            RAISERROR('Nie można dodać nowego zamówienia', 16, 2)
            ROLLBACK
        end
    end
--
-- SELECT * FROM Zamowienie
--
-- INSERT INTO Zamowienie (Id, KlientId, Wartosc) VALUES
--     (7, 50, 800)

-- 5
CREATE OR ALTER TRIGGER trgNowyPracownik ON Pracownik AFTER INSERT AS
    BEGIN
        DECLARE @Imie VARCHAR(30)
        DECLARE @Id INT
        SET @Imie = (SELECT UPPER(Imie) FROM inserted)
        SET @Id = (SELECT Id FROM inserted)
        UPDATE Pracownik SET Imie = @Imie WHERE Id = @Id
    end
--
-- INSERT INTO Pracownik (Id, Imie, StazPracy, Zarobki) VALUES
--     (110, 'Marek', 7, 5000)
--
-- SELECT * FROM Pracownik

-- 6
CREATE OR ALTER TRIGGER trgNowyPracownik ON Pracownik AFTER INSERT AS
    BEGIN
        DECLARE @StazPracy INT
        DECLARE @Wynagrodzenie MONEY
        DECLARE @Id INT
        SET @StazPracy = (SELECT StazPracy FROM inserted)
        SET @Id = (SELECT Id FROM inserted)
        IF @StazPracy <= 2
        BEGIN
            SET @Wynagrodzenie = 2000
        end
        IF @StazPracy > 2 AND @StazPracy < 5
        BEGIN
            SET @Wynagrodzenie = 3000
        end
        IF @StazPracy > 5
        BEGIN
            SET @Wynagrodzenie = 5000
        end
        UPDATE Pracownik SET Zarobki = @Wynagrodzenie WHERE Id = @Id
    end
--
-- INSERT INTO Pracownik (Id, Imie, StazPracy) VALUES
--     (140, 'Marek', 3)
--
-- SELECT * FROM Pracownik

-- 7
CREATE OR ALTER TRIGGER trgZmianaZamowienia ON Zamowienie AFTER INSERT, UPDATE AS
    BEGIN
        DECLARE @Id INT
        DECLARE @StatusPrzed VARCHAR(30)
        DECLARE @StatusPo VARCHAR(30)
        SET @Id = (SELECT Id FROM inserted)
        SET @StatusPrzed = (SELECT Status FROM deleted)
        SET @StatusPo = (SELECT Status FROM inserted)
        UPDATE HistoriaZamowienia SET StatusPrzed = @StatusPrzed WHERE ZamowienieId = @Id
        UPDATE HistoriaZamowienia SET StatusPo = @StatusPo WHERE ZamowienieId = @Id
        UPDATE HistoriaZamowienia SET DataZmiany = GETDATE() WHERE ZamowienieId = @Id
    end
--
-- SELECT * FROM HistoriaZamowienia
-- SELECT * FROM Zamowienie

-- 8
CREATE OR ALTER TRIGGER trgUsunZamowienie ON Zamowienie AFTER DELETE AS
    BEGIN
        DECLARE @LiczbaUsuwanychWierszy INT
        SET @LiczbaUsuwanychWierszy = (SELECT COUNT(*) FROM deleted)
        IF @LiczbaUsuwanychWierszy > 5
        BEGIN
            RAISERROR('Nie można usunąć powyżej 5 wierszy.', 16, 3)
            ROLLBACK
        end
    end

-- 9
CREATE OR ALTER TRIGGER trgUsunHistorie ON HistoriaZamowienia AFTER DELETE AS
    BEGIN
        RAISERROR('Nie można usuwać wierszy z tej tabeli.', 16, 4)
        ROLLBACK
    end