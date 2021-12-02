USE Sprawdzian2Hotel
GO

--7.
-- SELECT * FROM Pokoje
-- WHERE Pietro = 2
-- UNION
-- SELECT * FROM Pokoje
-- WHERE Cena > 200


--9.
-- SELECT g.Imie, g.Nazwisko, p.Cena * DATEDIFF(day, g.PoczatekPobytu, g.KoniecPobytu)
-- FROM Pokoje p JOIN Goscie G on p.Id = G.PokojId

--10.
-- SELECT g.Imie, g.Nazwisko FROM Goscie g
-- JOIN Pokoje P on g.PokojId = P.Id
-- WHERE p.Pietro = 2

--11.
-- SELECT COUNT(p.Id) AS liczbaPokoi FROM Sprzatanie s
-- JOIN Pokoje P on s.PokojId = P.Id
-- WHERE s.PokojId != p.Id

--12.
-- SELECT p.ID FROM Pokoje p
-- JOIN Sprzatanie S on p.Id = S.PokojId
-- JOIN Goscie G on p.Id = G.PokojId
-- WHERE S.DzienTygodnia = 'sr' AND GETDATE() > g.KoniecPobytu

--13.
-- SELECT DISTINCT p.ID, p.Pietro, (SELECT COUNT(*) FROM Sprzatanie WHERE PokojId = p.Id) AS LiczbaSprzatanWTygodniu FROM Pokoje p
-- JOIN Sprzatanie S on p.Id = S.PokojId

