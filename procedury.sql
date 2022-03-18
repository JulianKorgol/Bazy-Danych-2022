-- 2022-03-18 -> Procedury składowane
-- Przykładowa procedura
-- CREATE PROC spWszystkieGry AS
--     BEGIN
--         SELECT * FROM Gry
--     END
--

-- Procedura do bazy danych z książkami
-- USE Sprawdzian2Trening
-- GO
--
-- CREATE PROC spWszystkieKsiazki AS
--     BEGIN
--         SELECT * FROM Ksiazki
--     end

-- Wywoływanie procedury
-- EXEC spWszystkieKsiazki

-- Tworzenie lub modyfikowanie procedury
-- CREATE OR ALTER PROC spWszystkieKsiazki AS
--     BEGIN
--         SELECT * FROM Ksiazki
--     end

-- Procedura z parametrem
-- CREATE OR ALTER PROC spKsiazkiZRoku
-- @rok SMALLINT AS
--     BEGIN
--         SELECT *
--         FROM Ksiazki
--         WHERE RokWydania = @rok
--     end
--
-- EXEC spKsiazkiZRoku 2000
-- -- lub
-- EXEC spKsiazkiZRoku @rok = 2000


-- Wiele parametrów
-- CREATE OR ALTER PROC spDodajGre
-- @Nazwa VARCHAR(50),
-- @Wydawca VARCHAR(50) AS
--     BEGIN
--         INSERT INTO Gry (Nazwa, Wydawca)
--         VALUES (@Nazwa, @Wydawca)
--     end
--
-- EXEC spDodajGre
-- @Nazwa = 'Mario World',
--     @Wydawca = 'Nintendo'

-- Domyślne wartości
-- CREATE OR ALTER PROC spKsiazkiZRoku
-- @rok SMALLINT = 1999 AS -- = 1999 domyślne wartości
--     BEGIN
--         SELECT *
--         FROM Ksiazki
--         WHERE RokWydania = @rok
--     end


-- Zadanie 1 od Pana
-- CREATE OR ALTER PROC spProcedura
--     @wydawca VARCHAR(50) AS
--     BEGIN
--         SET @Imie = @wydawca
--
--         PRINT 'Imie: ' + @Imie
--     end