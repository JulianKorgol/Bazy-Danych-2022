USE Sprawdzian2Poprawa
GO


--ZAD 5
-- SELECT Nazwa, Gatunek
-- FROM Zwierzeta
-- WHERE LiczbaNog > 3
-- EXCEPT
-- SELECT Nazwa, Gatunek
-- FROM Zwierzeta
-- WHERE KrajWystepowania != 'Chiny'

--Zad 6
-- SELECT * FROM Eksperymenty
-- SELECT * FROM Pracownicy
-- SELECT * FROM Przydzialy

-- SELECT Imie
-- FROM Pracownicy
-- JOIN Przydzialy P on Pracownicy.Id = P.PracownikId
-- WHERE KodEksperymentu = 'MMM77'

--ZAD 7
-- SELECT E.Kod
-- FROM Pracownicy
-- FULL OUTER JOIN Przydzialy P on Pracownicy.Id = P.PracownikId
-- FULL OUTER JOIN Eksperymenty E on P.KodEksperymentu = E.Kod
-- WHERE Pracownicy.Id IS NULL

--ZAD 8
-- SELECT Imie, (SELECT COUNT(*) FROM Eksperymenty
--     JOIN Przydzialy P on Eksperymenty.Kod = P.KodEksperymentu
--     JOIN Pracownicy P2 on P2.Id = P.PracownikId
--     WHERE P.PracownikId = Pracownicy.Id)
-- FROM Pracownicy

--Zad 9
-- SELECT Imie
-- FROM Pracownicy
-- WHERE Zarobki < (SELECT AVG(Zarobki) FROM Pracownicy)

--Zad 10
-- SELECT e.Kod, (SELECT SUM(Zarobki) FROM Pracownicy JOIN Przydzialy P3 on Pracownicy.Id = P3.PracownikId WHERE P3.KodEksperymentu = e.Kod)
-- FROM Eksperymenty AS e
-- JOIN Przydzialy P on e.Kod = P.KodEksperymentu
-- JOIN Pracownicy P2 on P2.Id = P.PracownikId
-- GROUP BY e.Kod
--
-- SELECT Zarobki FROM Pracownicy

--ZAD 11
-- SELECT Imie, StopienNaukowy
-- FROM Pracownicy
-- WHERE Zarobki > (SELECT MIN(Zarobki)
--     FROM Przydzialy prz
--     JOIN Eksperymenty e ON prz.KodEksperymentu = e.Kod
--     JOIN Pracownicy pra ON pra.ID = prz.PracownikId
--     WHERE e.Dziedzina = 'Botanika')

--ZAD 12
-- SELECT Imie
-- FROM Pracownicy
-- JOIN Przydzialy P on Pracownicy.Id = P.PracownikId
-- JOIN Eksperymenty E on E.Kod = P.KodEksperymentu
-- WHERE DATEDIFF(month, E.DataRozpoczecia, E.DataZakonczenia) > 20