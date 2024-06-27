SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
CREATE OR ALTER FUNCTION [dbo].[fnNumberToWords](@Number DECIMAL(17,2))
RETURNS NVARCHAR(MAX)
AS 
BEGIN
	SET @Number = ABS(@Number)
	DECLARE @vResult NVARCHAR(MAX) = ''

	-- pre-data
	DECLARE @tDict		TABLE (Num INT NOT NULL, Nam NVARCHAR(255) NOT NULL)
	INSERT 
	INTO	@tDict (Num, Nam)
	VALUES	(1,'One'),(2,'Two'),(3,'Three'),(4,'Four'),(5,'Five'),(6,'Six'),(7,'Seven'),(8,'Eight'),(9,'Nine'),
			(10,'Ten'),(11,'Eleven'),(12,'Twelve'),(13,'Thirteen'),(14,'Fourteen'),(15,'Fifteen'),(16,'Sixteen'),(17,'Seventeen'),(18,'Eighteen'),(19,'Nineteen'),
			(20,'Twenty'),(30,'Thirty'),(40,'Fourty'),(50,'Fifty'),(60,'Sixty'),(70,'Seventy'),(80,'Eighty'),(90,'Ninety')
	
	DECLARE @ZeroWord		NVARCHAR(10) = 'Zero'
	DECLARE @DotWord		NVARCHAR(10) = 'Point'
	DECLARE @AndWord		NVARCHAR(10) = 'And'
	DECLARE @HundredWord	NVARCHAR(10) = 'Hundred'
	DECLARE @ThousandWord	NVARCHAR(10) = 'Thousand'
	DECLARE @MillionWord	NVARCHAR(10) = 'Million'
	DECLARE @BillionWord	NVARCHAR(10) = 'Billion'
	DECLARE @TrillionWord	NVARCHAR(10) = 'Trillion'

	-- decimal number	
	DECLARE @vDecimalNum INT = (@Number - FLOOR(@Number)) * 100
	DECLARE @vLoop SMALLINT = CONVERT(SMALLINT, SQL_VARIANT_PROPERTY(@Number, 'Scale'))
	DECLARE @vSubDecimalResult	NVARCHAR(MAX) = N''
	IF @vDecimalNum > 0
	BEGIN
		WHILE @vLoop > 0
		BEGIN
			IF @vDecimalNum % 10 = 0
				SET @vSubDecimalResult = FORMATMESSAGE('%s %s', @ZeroWord, @vSubDecimalResult)
			ELSE
				SELECT	@vSubDecimalResult = FORMATMESSAGE('%s %s', Nam, @vSubDecimalResult)
				FROM	@tDict
				WHERE	Num = @vDecimalNum%10

			SET @vDecimalNum = FLOOR(@vDecimalNum/10)
			SET @vLoop = @vLoop - 1
		END
	END
	
	-- main number
	SET @Number = FLOOR(@Number)
	IF @Number = 0
		SET @vResult = @ZeroWord
	ELSE
	BEGIN
		DECLARE @vSubResult	NVARCHAR(MAX) = ''
		DECLARE @v000Num DECIMAL(15,0) = 0
		DECLARE @v00Num DECIMAL(15,0) = 0
		DECLARE @v0Num DECIMAL(15,0) = 0
		DECLARE @vIndex SMALLINT = 0
		
		WHILE @Number > 0
		BEGIN
			-- from right to left: take first 000
			SET @v000Num = @Number % 1000
			SET @v00Num = @v000Num % 100
			SET @v0Num = @v00Num % 10
			IF @v000Num = 0
			BEGIN
				SET @vSubResult = ''
			END
			ELSE 
			BEGIN 
				--00
				IF @v00Num < 20
				BEGIN
					-- less than 20
					SELECT @vSubResult = Nam FROM @tDict WHERE Num = @v00Num
					IF @v00Num < 10 AND @v00Num > 0 AND (@v000Num > 99 OR FLOOR(@Number / 1000) > 0)--e.g 1 001: 1000 AND 1; or 201 000: (200 AND 1) 000
						SET @vSubResult = FORMATMESSAGE('%s %s', @AndWord, @vSubResult)
				END
				ELSE 
				BEGIN
					-- greater than or equal 20
					SELECT @vSubResult = Nam FROM @tDict WHERE Num = @v0Num 
					SET @v00Num = FLOOR(@v00Num/10)*10
					--SELECT @vSubResult = FORMATMESSAGE('%s-%s', Nam, @vSubResult) FROM @tDict WHERE Num = @v00Num 
					SELECT @vSubResult = FORMATMESSAGE('%s %s', Nam, @vSubResult) FROM @tDict WHERE Num = @v00Num 
				END

				--000
				IF @v000Num > 99
					SELECT @vSubResult = FORMATMESSAGE('%s %s %s', Nam, @HundredWord, @vSubResult) FROM @tDict WHERE Num = CONVERT(INT,@v000Num / 100)
			END
			
			--000xxx
			IF @vSubResult <> ''
			BEGIN

				SET @vSubResult = FORMATMESSAGE('%s %s', @vSubResult, CASE 
																		WHEN @vIndex=1 THEN @ThousandWord
																		WHEN @vIndex=2 THEN @MillionWord
																		WHEN @vIndex=3 THEN @BillionWord
																		WHEN @vIndex=4 THEN @TrillionWord
																		WHEN @vIndex>3 AND @vIndex%3=2 THEN @MillionWord + ' ' + LTRIM(REPLICATE(@BillionWord + ' ',@vIndex%3))
																		WHEN @vIndex>3 AND @vIndex%3=0 THEN LTRIM(REPLICATE(@BillionWord + ' ',@vIndex%3))
																		ELSE ''
																	END)

				SET @vResult = FORMATMESSAGE('%s %s', @vSubResult, @vResult)
			END

			-- next 000 (to left)
			SET @vIndex = @vIndex + 1
			SET @Number = FLOOR(@Number / 1000)
		END
	END

	SET @vResult = FORMATMESSAGE('%s %s', LTRIM(@vResult), COALESCE(@DotWord + ' ' + NULLIF(@vSubDecimalResult,''), ''))
	
	-- result
    RETURN @vResult
END
GO

