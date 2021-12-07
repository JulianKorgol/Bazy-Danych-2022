USE Sprawdzian2Hotel
GO

--Odpowiedzi do sprawdzianu:
--11.
SELECT count(*)
FROM Pokoje
LEFT OUTER JOIN Sprzatanie S on Pokoje.Id = S.PokojId
WHERE PracowinkId IS NULL
--12.
SELECT *
FROM Sprzatanie
FULL OUTER JOIN Pokoje P on P.Id = Sprzatanie.PokojId
FULL OUTER JOIN Goscie G on P.Id = G.PokojId
WHERE Sprzatanie.DzienTygodnia = 'œr' AND g.PokojId IS NULL