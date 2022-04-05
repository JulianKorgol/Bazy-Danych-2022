CREATE TRIGGER trUsunAutora ON Autorzy AFTER DELETE
    AS
    BEGIN
        DECLARE @LiczbaUsuwanych INT
        SET @LiczbaUsuwanych = (SELECT(*) FROM deleted)

        IF @LiczbaUsuwanych > 1
        BEGIN
            DECLARE @komunikat VARCHAR(100)
            SET @komunikat = 'Próbujesz usunąć za ' + CAST(@LiczbaUsuwanych AS VARCHAR(MAX)) + ' wierszy'

                RAISERROR(@komunikat, 16,1)
            ROLLBACK
        end
    end