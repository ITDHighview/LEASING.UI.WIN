USE [LEASINGDB]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetUserCompleteName]    Script Date: 3/25/2024 2:48:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fn_GetUserCompleteName]
    (
        -- Add the parameters for the function here
        @UserId INT
    )
RETURNS VARCHAR(100)
AS
    BEGIN
        -- Declare the return variable here
        DECLARE @UserName VARCHAR(100);

        -- Add the T-SQL statements to compute the return value here
        SELECT
            @UserName = [tblUser].[StaffName] + ' ' + [tblUser].[Middlename] + ' ' + [tblUser].[Lastname]
        FROM
            [dbo].[tblUser]
        WHERE
            [tblUser].[UserId] = @UserId;

        -- Return the result of the function
        RETURN @UserName;

    END;
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetUserGroupName]    Script Date: 3/25/2024 2:48:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fn_GetUserGroupName]
    (
        -- Add the parameters for the function here
        @UserId INT
    )
RETURNS VARCHAR(100)
AS
    BEGIN
        -- Declare the return variable here
        DECLARE @GroupName VARCHAR(100);

        -- Add the T-SQL statements to compute the return value here
        SELECT
                @GroupName = [tblGroup].[GroupName]
        FROM
                [dbo].[tblUser] WITH (NOLOCK)
            INNER JOIN
                [dbo].[tblGroup] WITH (NOLOCK)
                    ON [tblUser].[GroupId] = [tblGroup].[GroupId]
        WHERE
                [tblUser].[UserId] = @UserId;

        -- Return the result of the function
        RETURN @GroupName;

    END;
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetUserName]    Script Date: 3/25/2024 2:48:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fn_GetUserName]
    (
        -- Add the parameters for the function here
        @UserId INT
    )
RETURNS VARCHAR(100)
AS
    BEGIN
        -- Declare the return variable here
        DECLARE @UserName VARCHAR(100);

        -- Add the T-SQL statements to compute the return value here
        SELECT
            @UserName = [tblUser].[StaffName]
        FROM
            [dbo].[tblUser]
        WHERE
            [tblUser].[UserId] = @UserId;

        -- Return the result of the function
        RETURN @UserName;

    END;
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetAdvanceMonthCount]    Script Date: 3/25/2024 2:48:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
--SELECT [dbo].[fnGetAdvanceMonthCount]('REF10000000')
-- =============================================
CREATE FUNCTION [dbo].[fnGetAdvanceMonthCount]
(
    -- Add the parameters for the function here
    @RefId AS VARCHAR(50)
)
RETURNS int
AS
BEGIN
    -- Declare the return variable here
    DECLARE @counts int


    -- Add the T-SQL statements to compute the return value here
    SELECT @counts = count(*)       
    FROM [dbo].[tblAdvancePayment]
    WHERE [dbo].[tblAdvancePayment].[RefId] = @RefId


    RETURN @counts

END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetAdvancePeriodCover]    Script Date: 3/25/2024 2:48:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
--SELECT [dbo].[fnGetAdvancePeriodCover]('REF10000000')
-- =============================================
CREATE FUNCTION [dbo].[fnGetAdvancePeriodCover]
(
    -- Add the parameters for the function here
    @RefId AS VARCHAR(50)
)
RETURNS VARCHAR(500)
AS
BEGIN
    -- Declare the return variable here
    DECLARE @dates VARCHAR(500)


    -- Add the T-SQL statements to compute the return value here
    SELECT @dates
        = MIN(CONVERT(VARCHAR(20), [tblAdvancePayment].[Months], 107))
          +' - '+ MAX(CONVERT(VARCHAR(20), [tblAdvancePayment].[Months], 107))
    FROM [dbo].[tblAdvancePayment]
    WHERE [dbo].[tblAdvancePayment].[RefId] = @RefId


    RETURN @dates

END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetBaseRentalAmount]    Script Date: 3/25/2024 2:48:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
--SELECT [dbo].[fnGetVatAmountRental](1004)
-- =============================================
CREATE FUNCTION [dbo].[fnGetBaseRentalAmount]
(
    -- Add the parameters for the function here
    @UnitId AS INT
)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    -- Declare the return variable here
    DECLARE @BaseRentalAmount DECIMAL(18, 2)




    SELECT @BaseRentalAmount = [tblUnitMstr].[BaseRental]
    FROM [dbo].[tblUnitMstr]
    WHERE [tblUnitMstr].[RecId] = @UnitId



    RETURN @BaseRentalAmount


END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetBaseSecAmount]    Script Date: 3/25/2024 2:48:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
--SELECT [dbo].[fnGetVatAmountRental](1004)
-- =============================================
CREATE FUNCTION [dbo].[fnGetBaseSecAmount]
(
    -- Add the parameters for the function here
    @UnitId AS INT
)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    -- Declare the return variable here
    DECLARE @BaseSecAmount DECIMAL(18, 2)


    -- Add the T-SQL statements to compute the return value here
    SELECT @BaseSecAmount = [tblRatesSettings].[SecurityAndMaintenance]
    FROM [dbo].[tblRatesSettings]
    WHERE [tblRatesSettings].[ProjectType] = [dbo].[fnGetProjectTypeByUnitId](@UnitId)
    -- Return the result of the function



    RETURN @BaseSecAmount

END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetClientIsRenewal]    Script Date: 3/25/2024 2:48:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
--SELECT [dbo].[fnGetClientIsRenewal]('INDV10000000',3)
-- =============================================
CREATE FUNCTION [dbo].[fnGetClientIsRenewal]
(
    -- Add the parameters for the function here
    @ClientID AS VARCHAR(100),
    @ProjectID AS INT
)
RETURNS VARCHAR(100)
AS
BEGIN
    -- Declare the return variable here
    DECLARE @Message VARCHAR(100);

    -- Add the T-SQL statements to compute the return value here
    IF 
    (
        SELECT COUNT(*)
        FROM [dbo].[tblUnitReference]
        WHERE [tblUnitReference].[ClientID] = @ClientID
              AND [tblUnitReference].[ProjectId] = @ProjectID
    )>1
    BEGIN
        SET @Message = 'RENEWAL'
    END
    ELSE
    BEGIN
        SET @Message = ''
    END

    -- Return the result of the function
    RETURN @Message;

END;
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetPostDatedMonthCount]    Script Date: 3/25/2024 2:48:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
--SELECT [dbo].[fnGetPostDatedMonthCount](10000000)
-- =============================================
CREATE FUNCTION [dbo].[fnGetPostDatedMonthCount]
(
    -- Add the parameters for the function here
    @RefId AS BIGINT
)
RETURNS INT
AS
BEGIN
    -- Declare the return variable here
    DECLARE @counts INT


    -- Add the T-SQL statements to compute the return value here
    SELECT @counts = COUNT(*)
    FROM [dbo].[tblMonthLedger]
    WHERE [dbo].[tblMonthLedger].[ReferenceID] = @RefId
          AND [tblMonthLedger].[LedgMonth] NOT IN
              (
                  SELECT [tblAdvancePayment].[Months]
                  FROM [dbo].[tblAdvancePayment]
                  WHERE [tblAdvancePayment].[RefId] = 'REF' + CAST(@RefId AS VARCHAR(50))
              )


    RETURN @counts

END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetPostDatedPeriodCover]    Script Date: 3/25/2024 2:48:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
--SELECT [dbo].[fnGetPostDatedPeriodCover](10000000)
-- =============================================
CREATE FUNCTION [dbo].[fnGetPostDatedPeriodCover]
(
    -- Add the parameters for the function here
    @RefId AS BIGINT
)
RETURNS VARCHAR(500)
AS
BEGIN
    -- Declare the return variable here
    DECLARE @dates VARCHAR(500)
    --DATEADD(day, 1, '2017/08/25')

    -- Add the T-SQL statements to compute the return value here
    SELECT @dates
        = MIN(CONVERT(VARCHAR(20), DATEADD(DAY, 1, [tblMonthLedger].[LedgMonth]), 107)) + ' - '
          + MAX(CONVERT(VARCHAR(20), [tblMonthLedger].[LedgMonth], 107))
    FROM [dbo].[tblMonthLedger]
    WHERE [dbo].[tblMonthLedger].[ReferenceID] = @RefId
          AND [tblMonthLedger].[LedgMonth] NOT IN
              (
                  SELECT [tblAdvancePayment].[Months]
                  FROM [dbo].[tblAdvancePayment]
                  WHERE [tblAdvancePayment].[RefId] = 'REF' + CAST(@RefId AS VARCHAR(50))
              )


    RETURN @dates

END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetProjectNameById]    Script Date: 3/25/2024 2:48:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnGetProjectNameById]
(
    -- Add the parameters for the function here
    @ProjectId AS INT
)
RETURNS VARCHAR(50)
AS
BEGIN
    -- Declare the return variable here
    DECLARE @ProjectName VARCHAR(150)

    -- Add the T-SQL statements to compute the return value here
    SELECT @ProjectName = [tblProjectMstr].[ProjectName]
    FROM [dbo].[tblProjectMstr]
    WHERE [dbo].[tblProjectMstr].[RecId] = @ProjectId
    -- Return the result of the function
    RETURN @ProjectName

END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetProjectTypeByUnitId]    Script Date: 3/25/2024 2:48:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnGetProjectTypeByUnitId]
(
    -- Add the parameters for the function here
    @UnitId AS INT
)
RETURNS VARCHAR(50)
AS
BEGIN
    -- Declare the return variable here
    DECLARE @ProjectType VARCHAR(50)

    -- Add the T-SQL statements to compute the return value here
    SELECT @ProjectType = [tblProjectType].[ProjectTypeName]
    FROM [dbo].[tblUnitMstr]
        INNER JOIN [dbo].[tblProjectMstr]
            ON [tblUnitMstr].[ProjectId] = [tblProjectMstr].[RecId]
        INNER JOIN [dbo].[tblProjectType]
            ON [tblProjectMstr].[ProjectType] = [tblProjectType].[ProjectTypeName]
    WHERE [dbo].[tblUnitMstr].[RecId] = @UnitId
    -- Return the result of the function
    RETURN @ProjectType

END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetSecVatAmount]    Script Date: 3/25/2024 2:48:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
--SELECT [dbo].[fnGetSecVatAmount](1004)
-- =============================================
CREATE FUNCTION [dbo].[fnGetSecVatAmount]
(
    -- Add the parameters for the function here
    @UnitId AS INT
)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    -- Declare the return variable here
    DECLARE @SecVatAmount DECIMAL(18, 2)
	DECLARE @SecBaseAmount DECIMAL(18, 2)
    DECLARE @Vat DECIMAL(18, 2)

    -- Add the T-SQL statements to compute the return value here
    SELECT @Vat = [tblRatesSettings].[GenVat],
	@SecBaseAmount = [tblRatesSettings].[SecurityAndMaintenance]
    FROM [dbo].[tblRatesSettings]
    WHERE [tblRatesSettings].[ProjectType] = [dbo].[fnGetProjectTypeByUnitId](@UnitId)
    -- Return the result of the function


    SELECT @SecVatAmount = CAST((@SecBaseAmount * @Vat) / 100 AS DECIMAL(18, 2))
    FROM [dbo].[tblUnitMstr]
    WHERE [tblUnitMstr].[RecId] = @UnitId
    RETURN @SecVatAmount

END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetTaxAmountRentalNetVat]    Script Date: 3/25/2024 2:48:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
--SELECT [dbo].[fnGetVatAmountRental](1004)
-- =============================================
CREATE FUNCTION [dbo].[fnGetTaxAmountRentalNetVat]
(
    -- Add the parameters for the function here
    @UnitId AS INT
)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    -- Declare the return variable here
    DECLARE @AmountWithVat DECIMAL(18, 2)
    DECLARE @TaxAmount DECIMAL(18, 2)
    DECLARE @Vat DECIMAL(18, 2)
    DECLARE @Tax DECIMAL(18, 2)

    -- Add the T-SQL statements to compute the return value here
    SELECT @Tax = ISNULL([tblRatesSettings].[WithHoldingTax], 0),
           @Vat = ISNULL([tblRatesSettings].[GenVat], 0)
    FROM [dbo].[tblRatesSettings]
    WHERE [tblRatesSettings].[ProjectType] = [dbo].[fnGetProjectTypeByUnitId](@UnitId)
    -- Return the result of the function


    SELECT @AmountWithVat = (([tblUnitMstr].[BaseRental] * @Vat) / 100) + [tblUnitMstr].[BaseRental]
    FROM [dbo].[tblUnitMstr]
    WHERE [tblUnitMstr].[RecId] = @UnitId

    SET @TaxAmount = ((@AmountWithVat * @Tax) / 100)

    RETURN @TaxAmount

END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetTotalMonthAdvanceAmount]    Script Date: 3/25/2024 2:48:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
--SELECT [dbo].[fnGetTotalMonthAdvanceAmount]('REF10000000')
-- =============================================
CREATE FUNCTION [dbo].[fnGetTotalMonthAdvanceAmount]
(
    -- Add the parameters for the function here
    @RefId AS VARCHAR(50)
)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    -- Declare the return variable here
    DECLARE @Amount DECIMAL(18, 2)


    -- Add the T-SQL statements to compute the return value here
    SELECT @Amount = SUM([tblAdvancePayment].[Amount])
    FROM [dbo].[tblAdvancePayment]
    WHERE [tblAdvancePayment].[RefId] = @RefId



    RETURN @Amount

END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetTotalMonthPostDatedAmount]    Script Date: 3/25/2024 2:48:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
--SELECT [dbo].[fnGetTotalMonthAdvanceAmount]('REF10000000')
-- =============================================
CREATE FUNCTION [dbo].[fnGetTotalMonthPostDatedAmount]
(
    -- Add the parameters for the function here
    @RefId AS BIGINT
)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    -- Declare the return variable here
    DECLARE @Amount DECIMAL(18, 2)


    -- Add the T-SQL statements to compute the return value here
    SELECT @Amount = SUM([dbo].[tblMonthLedger].[LedgAmount])
    FROM [dbo].[tblMonthLedger]
    WHERE [tblMonthLedger].[ReferenceID] = @RefId


    RETURN @Amount

END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetTotalSecDepositAmountCount]    Script Date: 3/25/2024 2:48:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
--SELECT [dbo].[fnGetTotalSecDepositAmountCount]('REF10000000')
-- =============================================
CREATE FUNCTION [dbo].[fnGetTotalSecDepositAmountCount]
(
    -- Add the parameters for the function here
    @RefId AS VARCHAR(50)
)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    -- Declare the return variable here
    DECLARE @Amount DECIMAL(18, 2)


    -- Add the T-SQL statements to compute the return value here
    SELECT @Amount = ([tblUnitReference].[SecDeposit] / [tblUnitReference].[TotalRent])
    FROM [dbo].[tblUnitReference]
    WHERE [tblUnitReference].[RefId] = @RefId



    RETURN @Amount

END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetUnitCategoryByUnitId]    Script Date: 3/25/2024 2:48:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnGetUnitCategoryByUnitId]
(
    -- Add the parameters for the function here
    @UnitId AS INT
)
RETURNS VARCHAR(50)
AS
BEGIN
    -- Declare the return variable here
    DECLARE @CategoryName VARCHAR(50)

    -- Add the T-SQL statements to compute the return value here
    SELECT @CategoryName = IIF(ISNULL([tblUnitMstr].[IsParking], 0) = 1, 'PARKING', 'UNIT')
    FROM [dbo].[tblUnitMstr]
    WHERE [dbo].[tblUnitMstr].[RecId] = @UnitId
    -- Return the result of the function
    RETURN @CategoryName

END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetVatAmountRental]    Script Date: 3/25/2024 2:48:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
--SELECT [dbo].[fnGetVatAmountRental](1004)
-- =============================================
CREATE FUNCTION [dbo].[fnGetVatAmountRental]
(
    -- Add the parameters for the function here
    @UnitId AS INT
)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    -- Declare the return variable here
    DECLARE @VatAmount DECIMAL(18, 2)
    DECLARE @Vat DECIMAL(18, 2)

    -- Add the T-SQL statements to compute the return value here
    SELECT @Vat = [tblRatesSettings].[GenVat]
    FROM [dbo].[tblRatesSettings]
    WHERE [tblRatesSettings].[ProjectType] = [dbo].[fnGetProjectTypeByUnitId](@UnitId)
    -- Return the result of the function


    SELECT @VatAmount = CAST(([tblUnitMstr].[BaseRental] * @Vat) / 100 AS DECIMAL(18,2))
    FROM [dbo].[tblUnitMstr]
    WHERE [tblUnitMstr].[RecId] = @UnitId
    RETURN @VatAmount

END
GO
/****** Object:  UserDefinedFunction [dbo].[fnNumberToWords]    Script Date: 3/25/2024 2:48:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnNumberToWords](@Number DECIMAL(17,2))
RETURNS NVARCHAR(MAX)
AS 
BEGIN
	SET @Number = ABS(@Number)
	DECLARE @vResult NVARCHAR(MAX) = ''

	-- pre-data
	DECLARE @tDict		TABLE (Num INT NOT NULL, Nam NVARCHAR(255) NOT NULL)
	INSERT 
	INTO	@tDict (Num, Nam)
	VALUES	(1,'one'),(2,'two'),(3,'three'),(4,'four'),(5,'five'),(6,'six'),(7,'seven'),(8,'eight'),(9,'nine'),
			(10,'ten'),(11,'eleven'),(12,'twelve'),(13,'thirteen'),(14,'fourteen'),(15,'fifteen'),(16,'sixteen'),(17,'seventeen'),(18,'eighteen'),(19,'nineteen'),
			(20,'twenty'),(30,'thirty'),(40,'fourty'),(50,'fifty'),(60,'sixty'),(70,'seventy'),(80,'eighty'),(90,'ninety')
	
	DECLARE @ZeroWord		NVARCHAR(10) = 'zero'
	DECLARE @DotWord		NVARCHAR(10) = 'point'
	DECLARE @AndWord		NVARCHAR(10) = 'and'
	DECLARE @HundredWord	NVARCHAR(10) = 'hundred'
	DECLARE @ThousandWord	NVARCHAR(10) = 'thousand'
	DECLARE @MillionWord	NVARCHAR(10) = 'million'
	DECLARE @BillionWord	NVARCHAR(10) = 'billion'
	DECLARE @TrillionWord	NVARCHAR(10) = 'trillion'

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
					SELECT @vSubResult = FORMATMESSAGE('%s-%s', Nam, @vSubResult) FROM @tDict WHERE Num = @v00Num 
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
/****** Object:  UserDefinedFunction [dbo].[fnNumberToWordsWithDecimal]    Script Date: 3/25/2024 2:48:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  UserDefinedFunction [dbo].[fnNumberToWordsWithDecimalMain]    Script Date: 3/25/2024 2:48:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[fnNumberToWordsWithDecimalMain](@Number AS DECIMAL(18,2))
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
        SET @English = @English + ' Point '
                      + (CASE
                            WHEN @DecimalPart BETWEEN 1 AND 19
                                THEN (SELECT Word FROM @Below20 WHERE ID = @DecimalPart)
                            WHEN @DecimalPart BETWEEN 20 AND 99
                                THEN (SELECT Word FROM @Below100 WHERE ID = @DecimalPart / 10) + '-' + dbo.fnNumberToWords(@DecimalPart % 10)
                            ELSE dbo.fnNumberToWords(@DecimalPart)
                        END)
		        --SET @English = @English + '  '
          --            + (CASE
          --                  WHEN @DecimalPart BETWEEN 1 AND 19
          --                      THEN CAST(@DecimalPart AS VARCHAR(20))
          --                  WHEN @DecimalPart BETWEEN 20 AND 99
          --                      THEN ( CASt(@DecimalPart AS VARCHAR(30))+ '/100') 
          --                  ELSE ''
          --              END)

    END

    RETURN @English
END
GO
/****** Object:  UserDefinedFunction [dbo].[NumberToWords]    Script Date: 3/25/2024 2:48:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[NumberToWords](@Number DECIMAL(17,2))
RETURNS NVARCHAR(MAX)
AS 
BEGIN
	SET @Number = ABS(@Number)
	DECLARE @vResult NVARCHAR(MAX) = ''

	-- pre-data
	DECLARE @tDict		TABLE (Num INT NOT NULL, Nam NVARCHAR(255) NOT NULL)
	INSERT 
	INTO	@tDict (Num, Nam)
	VALUES	(1,'one'),(2,'two'),(3,'three'),(4,'four'),(5,'five'),(6,'six'),(7,'seven'),(8,'eight'),(9,'nine'),
			(10,'ten'),(11,'eleven'),(12,'twelve'),(13,'thirteen'),(14,'fourteen'),(15,'fifteen'),(16,'sixteen'),(17,'seventeen'),(18,'eighteen'),(19,'nineteen'),
			(20,'twenty'),(30,'thirty'),(40,'fourty'),(50,'fifty'),(60,'sixty'),(70,'seventy'),(80,'eighty'),(90,'ninety')
	
	DECLARE @ZeroWord		NVARCHAR(10) = 'zero'
	DECLARE @DotWord		NVARCHAR(10) = 'point'
	DECLARE @AndWord		NVARCHAR(10) = 'and'
	DECLARE @HundredWord	NVARCHAR(10) = 'hundred'
	DECLARE @ThousandWord	NVARCHAR(10) = 'thousand'
	DECLARE @MillionWord	NVARCHAR(10) = 'million'
	DECLARE @BillionWord	NVARCHAR(10) = 'billion'
	DECLARE @TrillionWord	NVARCHAR(10) = 'trillion'

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
					SELECT @vSubResult = FORMATMESSAGE('%s-%s', Nam, @vSubResult) FROM @tDict WHERE Num = @v00Num 
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
