SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[fnNumberToWordsWithDecimal](@Number AS DECIMAL(18,2))
    RETURNS VARCHAR(3000)
AS
BEGIN
    DECLARE @Below20 TABLE (ID INT IDENTITY(0,1), Word VARCHAR(32))
    DECLARE @Below100 TABLE (ID INT IDENTITY(2,1), Word VARCHAR(32))

    INSERT @Below20 (Word) VALUES
        ('Zero'), ('One'), ('Two'), ('Three'),
        ('Four'), ('Five'), ('Six'), ('Seven'),
        ('Eight'), ('Nine'), ('Ten'), ('Eleven'),
        ('Twelve'), ('Thirteen'), ('Fourteen'),
        ('Fifteen'), ('Sixteen'), ('Seventeen'),
        ('Eighteen'), ('Nineteen')

    INSERT @Below100 VALUES ('Twenty'), ('Thirty'), ('Forty'), ('Fifty'),
                            ('Sixty'), ('Seventy'), ('Eighty'), ('Ninety')

    DECLARE @English VARCHAR(2048) = ''

    IF @Number = 0
        RETURN 'Zero'

    DECLARE @IntegerPart INT = CONVERT(INT, FLOOR(@Number))
    DECLARE @DecimalPart INT = CONVERT(INT, (@Number - @IntegerPart) * 100)

    IF @IntegerPart > 0
    BEGIN
        IF @IntegerPart BETWEEN 1 AND 19
            SET @English = (SELECT Word FROM @Below20 WHERE ID = @IntegerPart)
        ELSE IF @IntegerPart BETWEEN 20 AND 99
            SET @English = (SELECT Word FROM @Below100 WHERE ID = @IntegerPart / 10) + '-' + dbo.fnNumberToWords(@IntegerPart % 10)
        ELSE
            SET @English = dbo.fnNumberToWords(@IntegerPart)
    END

    IF @DecimalPart > 0
    BEGIN
        --SET @English = @English + ' Point '
        --              + (CASE
        --                    WHEN @DecimalPart BETWEEN 1 AND 19
        --                        THEN (SELECT Word FROM @Below20 WHERE ID = @DecimalPart)
        --                    WHEN @DecimalPart BETWEEN 20 AND 99
        --                        THEN (SELECT Word FROM @Below100 WHERE ID = @DecimalPart / 10) + '-' + dbo.fnNumberToWords(@DecimalPart % 10)
        --                    ELSE dbo.fnNumberToWords(@DecimalPart)
        --                END)
		        SET @English = @English + '  '
                      + (CASE
                            WHEN @DecimalPart BETWEEN 1 AND 19
                                THEN CAST(@DecimalPart AS VARCHAR(20))
                            WHEN @DecimalPart BETWEEN 20 AND 99
                                THEN ('& '+ CASt(@DecimalPart AS VARCHAR(30))+ '/100') 
                            ELSE ''
                        END)

    END

    RETURN @English
END
GO
