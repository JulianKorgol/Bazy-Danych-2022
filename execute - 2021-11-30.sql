USE Sprawdzian2Trening
GO

-- SELECT Tytul, RokWydania
-- FROM Ksiazki
-- WHERE LEN(Tytul) > 12 AND NOT (YEAR(GETDATE()) - Ksiazki.RokWydania > 5)

-- SELECT K.Nazwa, COUNT(*)
-- FROM Ksiazki
-- JOIN Kategorie K on Ksiazki.KategoriaId = K.Id
-- GROUP BY K.Nazwa

-- SELECT TOP(1) Tytul
-- FROM Ksiazki
-- JOIN Autorzy A on Ksiazki.AutorId = A.Id
-- JOIN Kategorie K on Ksiazki.KategoriaId = K.Id
-- WHERE A.Imie = 'Dan' AND A.Nazwisko = 'Brown' AND K.Nazwa = 'przygoda'
-- ORDER BY RokWydania DESC

-- SELECT Imie, Nazwisko, MAX(RokWydania)
-- FROM Autorzy
-- JOIN Ksiazki K on Autorzy.Id = K.AutorId
-- GROUP BY Imie, Nazwisko