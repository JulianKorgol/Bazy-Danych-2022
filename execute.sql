USE master
GO

USE WyzwalaczeCwiczenia12
GO


--Wyzwalacze
--1
CREATE TRIGGER trgNowyKlient
    ON Klient AFTER INSERT AS
    BEGIN
        PRINT 'Dodano nowego klienta'
    end

-- INSERT INTO Klient (Id, Imie, Nazwisko) VALUES
--     (60, 'Julian', 'Korgol')

--2
CREATE OR ALTER TRIGGER trgNoweZamowienie ON Zamowienie AFTER INSERT AS
    BEGIN
        DECLARE @Id VARCHAR(50)
        SET @Id = (SELECT Id FROM inserted)
        PRINT 'Dodano zamówienie o Id: ' + CAST(@Id AS VARCHAR(max))
    end
--
-- INSERT INTO Zamowienie (KlientId, Wartosc, Status) VALUES
--     (60, 25, 'NOWE')
--
-- SELECT * FROM Zamowienie


--3
CREATE OR ALTER TRIGGER trgUsunZamowienie ON Zamowienie AFTER DELETE AS
    BEGIN
        DECLARE @Status VARCHAR(30)
        SET @Status = (SELECT Status FROM deleted)
        IF @Status != 'ZAKONCZONE'
            BEGIN
                ROLLBACK TRANSACTION
                RAISERROR('NIE MOŻNA USUNĄĆ ZAMÓWIENIA O STATUSIE INNYM NIŻ "ZAKONCZONE', 16, 2)
            end
    end
--
-- DELETE FROM Zamowienie
-- WHERE Id = 4
--
-- SELECT * FROM Zamowienie

--4
CREATE OR ALTER TRIGGER trgPodwyzka ON Pracownik AFTER UPDATE AS
    BEGIN
        DECLARE @ZarobkiPo FLOAT
        DECLARE @ZarobkiPrzed FLOAT
        SET @ZarobkiPo = (SELECT Zarobki FROM inserted)
        SET @ZarobkiPrzed = (SELECT Zarobki FROM deleted)
        IF (@ZarobkiPo > (@ZarobkiPrzed * 1.3))
            BEGIN
                ROLLBACK TRANSACTION
                RAISERROR('Zbyt wysoka podwyżka', 16, 3)
            end
    end
--
-- UPDATE Pracownik
-- SET Zarobki = Zarobki * 1.29
-- WHERE Id = 91
--
-- SELECT * FROM Pracownik
--5
CREATE TRIGGER trgUsuwanieTabel ON DATABASE AFTER DROP_TABLE AS
    BEGIN
        ROLLBACK TRANSACTION
        RAISERROR('Usuwanie tabel zabronione', 16, 1)
    end