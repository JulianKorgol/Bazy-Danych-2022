-- Zad 1
CREATE OR ALTER PROC spWszystkieKsiazki AS
    BEGIN
        SELECT * FROM Ksiazki
        ORDER BY DataWydania ASC
    end

--Zad 2
CREATE OR ALTER PROC spKsiazkiAutora @Autor VARCHAR(50) AS
    BEGIN
        SELECT * FROM Ksiazki
        WHERE Autor LIKE '%' + @Autor + '%'
    end

-- Zad 3
CREATE OR ALTER PROC spKsiazkiZKategorii @Kategoria VARCHAR(50) = 'fantastyka' AS
    BEGIN
        SELECT COUNT(*) FROM Ksiazki
        WHERE Kategoria = @Kategoria
    end

-- Zad 4
CREATE OR ALTER PROC spCena @Operacja VARCHAR(10) = NULL AS
    IF @Operacja NOT IN ('MAX', 'MIN', 'AVG')
        BEGIN
            PRINT 'Nieznana operacja'
            RETURN
        END
    IF @Operacja = 'MAX'
        BEGIN
            SELECT MAX(Cena) FROM Ksiazki
            RETURN
        end
    IF @Operacja = 'MIN'
        BEGIN
            SELECT MIN(Cena) FROM Ksiazki
            RETURN
        end
    IF @Operacja = 'AVG'
        BEGIN
            SELECT AVG(Cena) FROM Ksiazki
            RETURN
        end


EXEC spCena 'Nie wiem'