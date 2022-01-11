-- 7
SELECT * FROM Pokoje
WHERE Pietro = 2
UNION
SELECT * FROM Pokoje
WHERE Cena > 200

-- 10.
SELECT Imie, Nazwisko
FROM Goscie
JOIN Pokoje P on Goscie.PokojId = P.Id
WHERE Pietro = 2

--11. (Nie ma potwierdzenia, czy dobrze).
SELECT COUNT(*)
FROM Pokoje
JOIN Sprzatanie S on Pokoje.Id = S.PokojId
WHERE PracowinkId is null

--12.
SELECT Pokoje.Id
FROM Pokoje
FULL OUTER JOIN Sprzatanie S on Pokoje.Id = S.PokojId
FULL OUTER JOIN Goscie G on Pokoje.Id = G.PokojId
WHERE DzienTygodnia = '?r' AND (GETDATE() > g.KoniecPobytu OR g.PokojId = Pokoje.Id)

-- 13
SELECT Pokoje.Id, Pokoje.Pietro, COUNT(S.PokojId)
FROM Pokoje
JOIN Sprzatanie S on Pokoje.Id = S.PokojId
GROUP BY Pokoje.Id, Pokoje.Pietro