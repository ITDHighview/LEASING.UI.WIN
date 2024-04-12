USE [LEASINGDB]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetUserCompleteName]    Script Date: 4/11/2024 9:07:00 AM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_GetUserGroupName]    Script Date: 4/11/2024 9:07:00 AM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fn_GetUserName]    Script Date: 4/11/2024 9:07:00 AM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnGetAdvanceMonthCount]    Script Date: 4/11/2024 9:07:00 AM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnGetAdvancePeriodCover]    Script Date: 4/11/2024 9:07:00 AM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnGetBaseRentalAmount]    Script Date: 4/11/2024 9:07:00 AM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnGetBaseSecAmount]    Script Date: 4/11/2024 9:07:00 AM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnGetClientIsRenewal]    Script Date: 4/11/2024 9:07:00 AM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnGetPostDatedMonthCount]    Script Date: 4/11/2024 9:07:00 AM ******/
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
        SELECT
            @counts = (COUNT(*)/2)
        FROM
            [dbo].[tblMonthLedger]
        WHERE
            [dbo].[tblMonthLedger].[ReferenceID] = @RefId
            AND [tblMonthLedger].[LedgMonth] NOT IN
                    (
                        SELECT
                            [tblAdvancePayment].[Months]
                        FROM
                            [dbo].[tblAdvancePayment]
                        WHERE
                            [tblAdvancePayment].[RefId] = 'REF' + CAST(@RefId AS VARCHAR(50))
                    )


        RETURN @counts

    END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetPostDatedPeriodCover]    Script Date: 4/11/2024 9:07:00 AM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnGetProjectNameById]    Script Date: 4/11/2024 9:07:00 AM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnGetProjectTypeByUnitId]    Script Date: 4/11/2024 9:07:00 AM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnGetSecVatAmount]    Script Date: 4/11/2024 9:07:00 AM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnGetTaxAmountRentalNetVat]    Script Date: 4/11/2024 9:07:00 AM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnGetTotalMonthAdvanceAmount]    Script Date: 4/11/2024 9:07:00 AM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnGetTotalMonthPostDatedAmount]    Script Date: 4/11/2024 9:07:00 AM ******/
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
    SELECT @Amount = SUM([dbo].[tblMonthLedger].[LedgRentalAmount])
    FROM [dbo].[tblMonthLedger]
    WHERE [tblMonthLedger].[ReferenceID] = @RefId


    RETURN @Amount

END
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetTotalSecDepositAmountCount]    Script Date: 4/11/2024 9:07:00 AM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnGetUnitCategoryByUnitId]    Script Date: 4/11/2024 9:07:00 AM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnGetVatAmountRental]    Script Date: 4/11/2024 9:07:00 AM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnNumberToWords]    Script Date: 4/11/2024 9:07:00 AM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnNumberToWordsWithDecimal]    Script Date: 4/11/2024 9:07:00 AM ******/
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
/****** Object:  UserDefinedFunction [dbo].[fnNumberToWordsWithDecimalMain]    Script Date: 4/11/2024 9:07:00 AM ******/
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
/****** Object:  UserDefinedFunction [dbo].[NumberToWords]    Script Date: 4/11/2024 9:07:00 AM ******/
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
/****** Object:  UserDefinedFunction [SQLCop].[DmOsPerformanceCountersPermissionErrors]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [SQLCop].[DmOsPerformanceCountersPermissionErrors]()
RETURNS VARCHAR(MAX)
AS
BEGIN
    DECLARE @Result VARCHAR(MAX)
    SET @Result = ''

    IF (SERVERPROPERTY('EngineEdition') = 5)
        BEGIN
            IF (DATABASEPROPERTYEX(DB_NAME(), 'Edition') = 'Premium')
                BEGIN
                    IF NOT EXISTS(SELECT 1 FROM sys.fn_my_permissions(NULL, 'DATABASE') WHERE permission_name = 'VIEW DATABASE STATE')
                        SET @Result = 'You do not have VIEW DATABASE STATE permissions for this database.'
                END
            ELSE
                BEGIN
                    IF NOT EXISTS(SELECT 1 FROM sys.fn_my_permissions('sys.dm_os_performance_counters', 'OBJECT') WHERE permission_name = 'EXECUTE')
                        SET @Result = 'You do not have server admin or Azure active directory admin permissions.'
                END
        END
    ELSE
        BEGIN
            IF NOT EXISTS(SELECT 1 FROM sys.fn_my_permissions(NULL, 'SERVER') WHERE permission_name = 'VIEW SERVER STATE')
                SET @Result = 'You do not have VIEW SERVER STATE permissions within this instance.'
        END
    RETURN @Result
END
GO
/****** Object:  UserDefinedFunction [tSQLt].[GetTestResultFormatter]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[GetTestResultFormatter]()
RETURNS NVARCHAR(MAX)
AS
BEGIN
    DECLARE @FormatterName NVARCHAR(MAX);
    
    SELECT @FormatterName = CAST(value AS NVARCHAR(MAX))
    FROM sys.extended_properties
    WHERE name = N'tSQLt.ResultsFormatter'
      AND major_id = OBJECT_ID('tSQLt.Private_OutputTestResults');
      
    SELECT @FormatterName = COALESCE(@FormatterName, 'tSQLt.DefaultResultFormatter');
    
    RETURN @FormatterName;
END;
GO
/****** Object:  UserDefinedFunction [tSQLt].[Private_GetCleanObjectName]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[Private_GetCleanObjectName](@ObjectName NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
AS
BEGIN
    RETURN (SELECT OBJECT_NAME(OBJECT_ID(@ObjectName)));
END;
GO
/****** Object:  UserDefinedFunction [tSQLt].[Private_GetCleanSchemaName]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*******************************************************************************************/
/*******************************************************************************************/
/*******************************************************************************************/
CREATE FUNCTION [tSQLt].[Private_GetCleanSchemaName](@SchemaName NVARCHAR(MAX), @ObjectName NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
AS
BEGIN
    RETURN (SELECT SCHEMA_NAME(schema_id) 
              FROM sys.objects 
             WHERE object_id = CASE WHEN ISNULL(@SchemaName,'') in ('','[]')
                                    THEN OBJECT_ID(@ObjectName)
                                    ELSE OBJECT_ID(@SchemaName + '.' + @ObjectName)
                                END);
END;
GO
/****** Object:  UserDefinedFunction [tSQLt].[Private_GetCommaSeparatedColumnList]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[Private_GetCommaSeparatedColumnList] (@Table NVARCHAR(MAX), @ExcludeColumn NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
AS 
BEGIN
  RETURN STUFF((
     SELECT ',' + CASE WHEN system_type_id = TYPE_ID('timestamp') THEN ';TIMESTAMP columns are unsupported!;' ELSE QUOTENAME(name) END 
       FROM sys.columns 
      WHERE object_id = OBJECT_ID(@Table) 
        AND name <> @ExcludeColumn 
      ORDER BY column_id
     FOR XML PATH(''), TYPE).value('.','NVARCHAR(MAX)')
    ,1, 1, '');
        
END;
GO
/****** Object:  UserDefinedFunction [tSQLt].[Private_GetLastTestNameIfNotProvided]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
----------------------------------------------------------------------
CREATE FUNCTION [tSQLt].[Private_GetLastTestNameIfNotProvided](@TestName NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
AS
BEGIN
  IF(LTRIM(ISNULL(@TestName,'')) = '')
  BEGIN
    SELECT @TestName = TestName 
      FROM tSQLt.Run_LastExecution le
      JOIN sys.dm_exec_sessions es
        ON le.SessionId = es.session_id
       AND le.LoginTime = es.login_time
     WHERE es.session_id = @@SPID;
  END

  RETURN @TestName;
END
GO
/****** Object:  UserDefinedFunction [tSQLt].[Private_GetOriginalTableName]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*******************************************************************************************/
/*******************************************************************************************/
/*******************************************************************************************/
CREATE FUNCTION [tSQLt].[Private_GetOriginalTableName](@SchemaName NVARCHAR(MAX), @TableName NVARCHAR(MAX)) --DELETE!!!
RETURNS NVARCHAR(MAX)
AS
BEGIN
  RETURN (SELECT CAST(value AS NVARCHAR(4000))
    FROM sys.extended_properties
   WHERE class_desc = 'OBJECT_OR_COLUMN'
     AND major_id = OBJECT_ID(@SchemaName + '.' + @TableName)
     AND minor_id = 0
     AND name = 'tSQLt.FakeTable_OrgTableName');
END;
GO
/****** Object:  UserDefinedFunction [tSQLt].[Private_GetQuotedFullName]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[Private_GetQuotedFullName](@Objectid INT)
RETURNS NVARCHAR(517)
AS
BEGIN
    DECLARE @QuotedName NVARCHAR(517);
    SELECT @QuotedName = QUOTENAME(OBJECT_SCHEMA_NAME(@Objectid)) + '.' + QUOTENAME(OBJECT_NAME(@Objectid));
    RETURN @QuotedName;
END;
GO
/****** Object:  UserDefinedFunction [tSQLt].[Private_GetSchemaId]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[Private_GetSchemaId](@SchemaName NVARCHAR(MAX))
RETURNS INT
AS
BEGIN
  RETURN (
    SELECT TOP(1) schema_id
      FROM sys.schemas
     WHERE @SchemaName IN (name, QUOTENAME(name), QUOTENAME(name, '"'))
     ORDER BY 
        CASE WHEN name = @SchemaName THEN 0 ELSE 1 END
  );
END;
GO
/****** Object:  UserDefinedFunction [tSQLt].[Private_IsTestClass]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[Private_IsTestClass](@TestClassName NVARCHAR(MAX))
RETURNS BIT
AS
BEGIN
  RETURN 
    CASE 
      WHEN EXISTS(
             SELECT 1 
               FROM tSQLt.TestClasses
              WHERE SchemaId = tSQLt.Private_GetSchemaId(@TestClassName)
            )
      THEN 1
      ELSE 0
    END;
END;
GO
/****** Object:  UserDefinedFunction [tSQLt].[Private_QuoteClassNameForNewTestClass]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[Private_QuoteClassNameForNewTestClass](@ClassName NVARCHAR(MAX))
  RETURNS NVARCHAR(MAX)
AS
BEGIN
  RETURN 
    CASE WHEN @ClassName LIKE '[[]%]' THEN @ClassName
         ELSE QUOTENAME(@ClassName)
     END;
END;
GO
/****** Object:  UserDefinedFunction [tSQLt].[Private_SqlVariantFormatter]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[Private_SqlVariantFormatter](@Value SQL_VARIANT)
RETURNS NVARCHAR(MAX)
AS
BEGIN
  RETURN CASE UPPER(CAST(SQL_VARIANT_PROPERTY(@Value,'BaseType')AS sysname))
           WHEN 'FLOAT' THEN CONVERT(NVARCHAR(MAX),@Value,2)
           WHEN 'REAL' THEN CONVERT(NVARCHAR(MAX),@Value,1)
           WHEN 'MONEY' THEN CONVERT(NVARCHAR(MAX),@Value,2)
           WHEN 'SMALLMONEY' THEN CONVERT(NVARCHAR(MAX),@Value,2)
           WHEN 'DATE' THEN CONVERT(NVARCHAR(MAX),@Value,126)
           WHEN 'DATETIME' THEN CONVERT(NVARCHAR(MAX),@Value,126)
           WHEN 'DATETIME2' THEN CONVERT(NVARCHAR(MAX),@Value,126)
           WHEN 'DATETIMEOFFSET' THEN CONVERT(NVARCHAR(MAX),@Value,126)
           WHEN 'SMALLDATETIME' THEN CONVERT(NVARCHAR(MAX),@Value,126)
           WHEN 'TIME' THEN CONVERT(NVARCHAR(MAX),@Value,126)
           WHEN 'BINARY' THEN CONVERT(NVARCHAR(MAX),@Value,1)
           WHEN 'VARBINARY' THEN CONVERT(NVARCHAR(MAX),@Value,1)
           ELSE CAST(@Value AS NVARCHAR(MAX))
         END;
END
GO
/****** Object:  UserDefinedFunction [tSQLt].[Private_SqlVersion]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[Private_SqlVersion]()
RETURNS TABLE
AS
RETURN
  SELECT CAST(SERVERPROPERTY('ProductVersion')AS NVARCHAR(128)) ProductVersion,
         CAST(SERVERPROPERTY('Edition')AS NVARCHAR(128)) Edition;
GO
/****** Object:  UserDefinedFunction [tSQLt].[Info]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[Info]()
RETURNS TABLE
AS
RETURN
SELECT Version = '1.0.5873.27393',
       ClrVersion = (SELECT tSQLt.Private::Info()),
       ClrSigningKey = (SELECT tSQLt.Private::SigningKey()),
       V.SqlVersion,
       V.SqlBuild,
       V.SqlEdition
  FROM
  (
    SELECT CAST(VI.major+'.'+VI.minor AS NUMERIC(10,2)) AS SqlVersion,
           CAST(VI.build+'.'+VI.revision AS NUMERIC(10,2)) AS SqlBuild,
           SqlEdition
      FROM
      (
        SELECT PARSENAME(PSV.ProductVersion,4) major,
               PARSENAME(PSV.ProductVersion,3) minor, 
               PARSENAME(PSV.ProductVersion,2) build,
               PARSENAME(PSV.ProductVersion,1) revision,
               Edition AS SqlEdition
          FROM tSQLt.Private_SqlVersion() AS PSV
      )VI
  )V;
GO
/****** Object:  UserDefinedFunction [tSQLt].[Private_GetForeignKeyParColumns]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[Private_GetForeignKeyParColumns](
    @ConstraintObjectId INT
)
RETURNS TABLE
AS
RETURN SELECT STUFF((
                 SELECT ','+QUOTENAME(pci.name) FROM sys.foreign_key_columns c
                   JOIN sys.columns pci
                   ON pci.object_id = c.parent_object_id
                  AND pci.column_id = c.parent_column_id
                   WHERE @ConstraintObjectId = c.constraint_object_id
                   FOR XML PATH(''),TYPE
                   ).value('.','NVARCHAR(MAX)'),1,1,'')  AS ColNames
GO
/****** Object:  UserDefinedFunction [tSQLt].[Private_GetForeignKeyRefColumns]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[Private_GetForeignKeyRefColumns](
    @ConstraintObjectId INT
)
RETURNS TABLE
AS
RETURN SELECT STUFF((
                 SELECT ','+QUOTENAME(rci.name) FROM sys.foreign_key_columns c
                   JOIN sys.columns rci
                  ON rci.object_id = c.referenced_object_id
                  AND rci.column_id = c.referenced_column_id
                   WHERE @ConstraintObjectId = c.constraint_object_id
                   FOR XML PATH(''),TYPE
                   ).value('.','NVARCHAR(MAX)'),1,1,'')  AS ColNames;
GO
/****** Object:  UserDefinedFunction [tSQLt].[Private_GetForeignKeyDefinition]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[Private_GetForeignKeyDefinition](
    @SchemaName NVARCHAR(MAX),
    @ParentTableName NVARCHAR(MAX),
    @ForeignKeyName NVARCHAR(MAX),
    @NoCascade BIT
)
RETURNS TABLE
AS
RETURN SELECT 'CONSTRAINT ' + name + ' FOREIGN KEY (' +
              parCols + ') REFERENCES ' + refName + '(' + refCols + ')'+
              CASE WHEN @NoCascade = 1 THEN ''
                ELSE delete_referential_action_cmd + ' ' + update_referential_action_cmd 
              END AS cmd,
              CASE 
                WHEN RefTableIsFakedInd = 1
                  THEN 'CREATE UNIQUE INDEX ' + tSQLt.Private::CreateUniqueObjectName() + ' ON ' + refName + '(' + refCols + ');' 
                ELSE '' 
              END CreIdxCmd
         FROM (SELECT QUOTENAME(SCHEMA_NAME(k.schema_id)) AS SchemaName,
                      QUOTENAME(k.name) AS name,
                      QUOTENAME(OBJECT_NAME(k.parent_object_id)) AS parName,
                      QUOTENAME(SCHEMA_NAME(refTab.schema_id)) + '.' + QUOTENAME(refTab.name) AS refName,
                      parCol.ColNames AS parCols,
                      refCol.ColNames AS refCols,
                      'ON UPDATE '+
                      CASE k.update_referential_action
                        WHEN 0 THEN 'NO ACTION'
                        WHEN 1 THEN 'CASCADE'
                        WHEN 2 THEN 'SET NULL'
                        WHEN 3 THEN 'SET DEFAULT'
                      END AS update_referential_action_cmd,
                      'ON DELETE '+
                      CASE k.delete_referential_action
                        WHEN 0 THEN 'NO ACTION'
                        WHEN 1 THEN 'CASCADE'
                        WHEN 2 THEN 'SET NULL'
                        WHEN 3 THEN 'SET DEFAULT'
                      END AS delete_referential_action_cmd,
                      CASE WHEN e.name IS NULL THEN 0
                           ELSE 1 
                       END AS RefTableIsFakedInd
                 FROM sys.foreign_keys k
                 CROSS APPLY tSQLt.Private_GetForeignKeyParColumns(k.object_id) AS parCol
                 CROSS APPLY tSQLt.Private_GetForeignKeyRefColumns(k.object_id) AS refCol
                 LEFT JOIN sys.extended_properties e
                   ON e.name = 'tSQLt.FakeTable_OrgTableName'
                  AND e.value = OBJECT_NAME(k.referenced_object_id)
                 JOIN sys.tables refTab
                   ON COALESCE(e.major_id,k.referenced_object_id) = refTab.object_id
                WHERE k.parent_object_id = OBJECT_ID(@SchemaName + '.' + @ParentTableName)
                  AND k.object_id = OBJECT_ID(@SchemaName + '.' + @ForeignKeyName)
               )x;
GO
/****** Object:  UserDefinedFunction [tSQLt].[Private_GetOriginalTableInfo]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[Private_GetOriginalTableInfo](@TableObjectId INT)
RETURNS TABLE
AS
  RETURN SELECT CAST(value AS NVARCHAR(4000)) OrgTableName,
                OBJECT_ID(QUOTENAME(OBJECT_SCHEMA_NAME(@TableObjectId)) + '.' + QUOTENAME(CAST(value AS NVARCHAR(4000)))) OrgTableObjectId
    FROM sys.extended_properties
   WHERE class_desc = 'OBJECT_OR_COLUMN'
     AND major_id = @TableObjectId
     AND minor_id = 0
     AND name = 'tSQLt.FakeTable_OrgTableName';
GO
/****** Object:  UserDefinedFunction [tSQLt].[Private_FindConstraint]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[Private_FindConstraint]
(
  @TableObjectId INT,
  @ConstraintName NVARCHAR(MAX)
)
RETURNS TABLE
AS
RETURN
  SELECT TOP(1) constraints.object_id AS ConstraintObjectId, type_desc AS ConstraintType
    FROM sys.objects constraints
    CROSS JOIN tSQLt.Private_GetOriginalTableInfo(@TableObjectId) orgTbl
   WHERE @ConstraintName IN (constraints.name, QUOTENAME(constraints.name))
     AND constraints.parent_object_id = orgTbl.OrgTableObjectId
   ORDER BY LEN(constraints.name) ASC;
GO
/****** Object:  UserDefinedFunction [tSQLt].[Private_ResolveApplyConstraintParameters]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[Private_ResolveApplyConstraintParameters]
(
  @A NVARCHAR(MAX),
  @B NVARCHAR(MAX),
  @C NVARCHAR(MAX)
)
RETURNS TABLE
AS 
RETURN
  SELECT ConstraintObjectId, ConstraintType
    FROM tSQLt.Private_FindConstraint(OBJECT_ID(@A), @B)
   WHERE @C IS NULL
   UNION ALL
  SELECT *
    FROM tSQLt.Private_FindConstraint(OBJECT_ID(@A + '.' + @B), @C)
   UNION ALL
  SELECT *
    FROM tSQLt.Private_FindConstraint(OBJECT_ID(@C + '.' + @A), @B);
GO
/****** Object:  UserDefinedFunction [tSQLt].[Private_GetFullTypeName]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[Private_GetFullTypeName](@TypeId INT, @Length INT, @Precision INT, @Scale INT, @CollationName NVARCHAR(MAX))
RETURNS TABLE
AS
RETURN SELECT X.SchemaName + '.' + X.Name + X.Suffix + X.Collation AS TypeName, X.SchemaName, X.Name, X.Suffix, X.is_table_type AS IsTableType
FROM(
  SELECT QUOTENAME(SCHEMA_NAME(T.schema_id)) SchemaName, QUOTENAME(T.name) Name,
              CASE WHEN T.max_length = -1
                    THEN ''
                   WHEN @Length = -1
                    THEN '(MAX)'
                   WHEN T.name LIKE 'n%char'
                    THEN '(' + CAST(@Length / 2 AS NVARCHAR) + ')'
                   WHEN T.name LIKE '%char' OR T.name LIKE '%binary'
                    THEN '(' + CAST(@Length AS NVARCHAR) + ')'
                   WHEN T.name IN ('decimal', 'numeric')
                    THEN '(' + CAST(@Precision AS NVARCHAR) + ',' + CAST(@Scale AS NVARCHAR) + ')'
                   ELSE ''
               END Suffix,
              CASE WHEN @CollationName IS NULL OR T.is_user_defined = 1 THEN ''
                   ELSE ' COLLATE ' + @CollationName
               END Collation,
               T.is_table_type
          FROM tSQLt.Private_SysTypes AS T WHERE T.user_type_id = @TypeId
          )X;
GO
/****** Object:  UserDefinedFunction [tSQLt].[Private_GetDataTypeOrComputedColumnDefinition]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[Private_GetDataTypeOrComputedColumnDefinition](@UserTypeId INT, @MaxLength INT, @Precision INT, @Scale INT, @CollationName NVARCHAR(MAX), @ObjectId INT, @ColumnId INT, @ReturnDetails BIT)
RETURNS TABLE
AS
RETURN SELECT 
              COALESCE(cc.IsComputedColumn, 0) AS IsComputedColumn,
              COALESCE(cc.ComputedColumnDefinition, GFTN.TypeName) AS ColumnDefinition
        FROM (SELECT @UserTypeId, @MaxLength, @Precision, @Scale, @CollationName, @ObjectId, @ColumnId, @ReturnDetails) 
             AS V(UserTypeId, MaxLength, Precision, Scale, CollationName, ObjectId, ColumnId, ReturnDetails)
       CROSS APPLY tSQLt.Private_GetFullTypeName(V.UserTypeId, V.MaxLength, V.Precision, V.Scale, V.CollationName) AS GFTN
        LEFT JOIN (SELECT 1 AS IsComputedColumn,
                          ' AS '+ cci.definition + CASE WHEN cci.is_persisted = 1 THEN ' PERSISTED' ELSE '' END AS ComputedColumnDefinition,
                          cci.object_id,
                          cci.column_id
                     FROM sys.computed_columns cci
                  )cc
               ON cc.object_id = V.ObjectId
              AND cc.column_id = V.ColumnId
              AND V.ReturnDetails = 1;
GO
/****** Object:  UserDefinedFunction [tSQLt].[Private_GetUniqueConstraintDefinition]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[Private_GetUniqueConstraintDefinition]
(
    @ConstraintObjectId INT,
    @QuotedTableName NVARCHAR(MAX)
)
RETURNS TABLE
AS
RETURN
  SELECT 'ALTER TABLE '+
         @QuotedTableName +
         ' ADD CONSTRAINT ' +
         QUOTENAME(OBJECT_NAME(@ConstraintObjectId)) +
         ' ' +
         CASE WHEN KC.type_desc = 'UNIQUE_CONSTRAINT' 
              THEN 'UNIQUE'
              ELSE 'PRIMARY KEY'
           END +
         '(' +
         STUFF((
                 SELECT ','+QUOTENAME(C.name)
                   FROM sys.index_columns AS IC
                   JOIN sys.columns AS C
                     ON IC.object_id = C.object_id
                    AND IC.column_id = C.column_id
                  WHERE KC.unique_index_id = IC.index_id
                    AND KC.parent_object_id = IC.object_id
                    FOR XML PATH(''),TYPE
               ).value('.','NVARCHAR(MAX)'),
               1,
               1,
               ''
              ) +
         ');' AS CreateConstraintCmd,
         CASE WHEN KC.type_desc = 'UNIQUE_CONSTRAINT' 
              THEN ''
              ELSE (
                     SELECT 'ALTER TABLE ' +
                            @QuotedTableName +
                            ' ALTER COLUMN ' +
                            QUOTENAME(C.name)+
                            cc.ColumnDefinition +
                            ' NOT NULL;'
                       FROM sys.index_columns AS IC
                       JOIN sys.columns AS C
                         ON IC.object_id = C.object_id
                        AND IC.column_id = C.column_id
                      CROSS APPLY tSQLt.Private_GetDataTypeOrComputedColumnDefinition(C.user_type_id, C.max_length, C.precision, C.scale, C.collation_name, C.object_id, C.column_id, 0) cc
                      WHERE KC.unique_index_id = IC.index_id
                        AND KC.parent_object_id = IC.object_id
                        FOR XML PATH(''),TYPE
                   ).value('.','NVARCHAR(MAX)')
           END AS NotNullColumnCmd
    FROM sys.key_constraints AS KC
   WHERE KC.object_id = @ConstraintObjectId;
GO
/****** Object:  UserDefinedFunction [tSQLt].[Private_ResolveSchemaName]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[Private_ResolveSchemaName](@Name NVARCHAR(MAX))
RETURNS TABLE 
AS
RETURN
  WITH ids(schemaId) AS
       (SELECT tSQLt.Private_GetSchemaId(@Name)
       ),
       idsWithNames(schemaId, quotedSchemaName) AS
        (SELECT schemaId,
         QUOTENAME(SCHEMA_NAME(schemaId))
         FROM ids
        )
  SELECT schemaId, 
         quotedSchemaName,
         CASE WHEN EXISTS(SELECT 1 FROM tSQLt.TestClasses WHERE TestClasses.SchemaId = idsWithNames.schemaId)
               THEN 1
              ELSE 0
         END AS isTestClass, 
         CASE WHEN schemaId IS NOT NULL THEN 1 ELSE 0 END AS isSchema
    FROM idsWithNames;
GO
/****** Object:  UserDefinedFunction [tSQLt].[Private_ResolveObjectName]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[Private_ResolveObjectName](@Name NVARCHAR(MAX))
RETURNS TABLE 
AS
RETURN
  WITH ids(schemaId, objectId) AS
       (SELECT SCHEMA_ID(OBJECT_SCHEMA_NAME(OBJECT_ID(@Name))),
               OBJECT_ID(@Name)
       ),
       idsWithNames(schemaId, objectId, quotedSchemaName, quotedObjectName) AS
        (SELECT schemaId, objectId,
         QUOTENAME(SCHEMA_NAME(schemaId)) AS quotedSchemaName, 
         QUOTENAME(OBJECT_NAME(objectId)) AS quotedObjectName
         FROM ids
        )
  SELECT schemaId, 
         objectId, 
         quotedSchemaName,
         quotedObjectName,
         quotedSchemaName + '.' + quotedObjectName AS quotedFullName, 
         CASE WHEN LOWER(quotedObjectName) LIKE '[[]test%]' 
               AND objectId = OBJECT_ID(quotedSchemaName + '.' + quotedObjectName,'P') 
              THEN 1 ELSE 0 END AS isTestCase
    FROM idsWithNames;
GO
/****** Object:  UserDefinedFunction [tSQLt].[Private_ResolveName]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[Private_ResolveName](@Name NVARCHAR(MAX))
RETURNS TABLE 
AS
RETURN
  WITH resolvedNames(ord, schemaId, objectId, quotedSchemaName, quotedObjectName, quotedFullName, isTestClass, isTestCase, isSchema) AS
  (SELECT 1, schemaId, NULL, quotedSchemaName, NULL, quotedSchemaName, isTestClass, 0, 1
     FROM tSQLt.Private_ResolveSchemaName(@Name)
    UNION ALL
   SELECT 2, schemaId, objectId, quotedSchemaName, quotedObjectName, quotedFullName, 0, isTestCase, 0
     FROM tSQLt.Private_ResolveObjectName(@Name)
    UNION ALL
   SELECT 3, NULL, NULL, NULL, NULL, NULL, 0, 0, 0
   )
   SELECT TOP(1) schemaId, objectId, quotedSchemaName, quotedObjectName, quotedFullName, isTestClass, isTestCase, isSchema
     FROM resolvedNames
    WHERE schemaId IS NOT NULL 
       OR ord = 3
    ORDER BY ord
GO
/****** Object:  UserDefinedFunction [tSQLt].[F_Num]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[F_Num](
       @N INT
)
RETURNS TABLE 
AS 
RETURN WITH C0(c) AS (SELECT 1 UNION ALL SELECT 1),
            C1(c) AS (SELECT 1 FROM C0 AS A CROSS JOIN C0 AS B),
            C2(c) AS (SELECT 1 FROM C1 AS A CROSS JOIN C1 AS B),
            C3(c) AS (SELECT 1 FROM C2 AS A CROSS JOIN C2 AS B),
            C4(c) AS (SELECT 1 FROM C3 AS A CROSS JOIN C3 AS B),
            C5(c) AS (SELECT 1 FROM C4 AS A CROSS JOIN C4 AS B),
            C6(c) AS (SELECT 1 FROM C5 AS A CROSS JOIN C5 AS B)
       SELECT TOP(CASE WHEN @N>0 THEN @N ELSE 0 END) ROW_NUMBER() OVER (ORDER BY c) no
         FROM C6;
GO
/****** Object:  UserDefinedFunction [tSQLt].[Private_Bin2Hex]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[Private_Bin2Hex](@vb VARBINARY(MAX))
RETURNS TABLE
AS
RETURN
  SELECT X.S AS bare, '0x'+X.S AS prefix
    FROM (SELECT LOWER(CAST('' AS XML).value('xs:hexBinary(sql:variable("@vb") )','VARCHAR(MAX)')))X(S);
GO
/****** Object:  UserDefinedFunction [tSQLt].[Private_GetConfiguration]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[Private_GetConfiguration](
  @Name NVARCHAR(100)
)
RETURNS TABLE
AS
RETURN
  SELECT PC.Name,
         PC.Value 
    FROM tSQLt.Private_Configurations AS PC
   WHERE PC.Name = @Name;
GO
/****** Object:  UserDefinedFunction [tSQLt].[Private_GetConstraintType]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[Private_GetConstraintType](@TableObjectId INT, @ConstraintName NVARCHAR(MAX))
RETURNS TABLE
AS
RETURN
  SELECT object_id,type,type_desc
    FROM sys.objects 
   WHERE object_id = OBJECT_ID(SCHEMA_NAME(schema_id)+'.'+@ConstraintName)
     AND parent_object_id = @TableObjectId;
GO
/****** Object:  UserDefinedFunction [tSQLt].[Private_GetDefaultConstraintDefinition]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[Private_GetDefaultConstraintDefinition](@ObjectId INT, @ColumnId INT, @ReturnDetails BIT)
RETURNS TABLE
AS
RETURN SELECT 
              COALESCE(IsDefault, 0) AS IsDefault,
              COALESCE(DefaultDefinition, '') AS DefaultDefinition
        FROM (SELECT 1) X(X)
        LEFT JOIN (SELECT 1 AS IsDefault,' DEFAULT '+ definition AS DefaultDefinition,parent_object_id,parent_column_id
                     FROM sys.default_constraints
                  )dc
               ON dc.parent_object_id = @ObjectId
              AND dc.parent_column_id = @ColumnId
              AND @ReturnDetails = 1;
GO
/****** Object:  UserDefinedFunction [tSQLt].[Private_GetExternalAccessKeyBytes]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[Private_GetExternalAccessKeyBytes]()
RETURNS TABLE
AS
RETURN
  SELECT 0x4D5A90000300000004000000FFFF0000B800000000000000400000000000000000000000000000000000000000000000000000000000000000000000800000000E1FBA0E00B409CD21B8014CCD21546869732070726F6772616D2063616E6E6F742062652072756E20696E20444F53206D6F64652E0D0D0A2400000000000000504500004C0103005419AD560000000000000000E00002210B010B00000400000006000000000000CE2300000020000000400000000000100020000000020000040000000000000004000000000000000080000000020000817000000300408500001000001000000000100000100000000000001000000000000000000000007C2300004F00000000400000E002000000000000000000000000000000000000006000000C00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200000080000000000000000000000082000004800000000000000000000002E74657874000000D4030000002000000004000000020000000000000000000000000000200000602E72737263000000E0020000004000000004000000060000000000000000000000000000400000402E72656C6F6300000C0000000060000000020000000A00000000000000000000000000004000004200000000000000000000000000000000B0230000000000004800000002000500D0200000AC0200000900000000000000000000000000000050200000800000000000000000000000000000000000000000000000000000000000000000000000213462F5B9EF260060DE50E40053E6687E4C3CB839148A25A72ED4644D1DB6A8835FE0C2D5FDD8B91073B9C39F7A8FCD4BE43786C9306E73D060E389A18E678E8BF334A1C46DCD33B21D6986A0DDEF92A7C1CD14E1D25582B177CF24DFBE14AB8845A657360F13F7E75792FFBC48D5C7FB979E2E480BFDB7B8AEEB16FB394A3A42534A4201000100000000000C00000076322E302E35303732370000000005006C0000009C000000237E000008010000AC00000023537472696E677300000000B40100000800000023555300BC010000100000002347554944000000CC010000E000000023426C6F620000000000000002000001071400000900000000FA2533001600000100000002000000010000000200000002000000010000000100000000000A0001000000000006004E002E00060074002E00000000000100000000000100010009006E000A0011006E000F002E000B00B5002E001300BE000480000000000000000000000100000013009200000002000000000000000000000001002500000000000000003C4D6F64756C653E007453514C7445787465726E616C4163636573734B65792E646C6C006D73636F726C69620053797374656D2E52756E74696D652E436F6D70696C6572536572766963657300436F6D70696C6174696F6E52656C61786174696F6E73417474726962757465002E63746F720052756E74696D65436F6D7061746962696C697479417474726962757465007453514C7445787465726E616C4163636573734B6579000000000003200000000000FA9D540989B0294FAE952438919E8F450008B77A5C561934E08904200101080320000180A00024000004800000940000000602000000240000525341310004000001000100F7D9A45F2B508C2887A8794B053CE5DEB28743B7C748FF545F1F51218B684454B785054629C1417D1D3542B095D80BA171294948FCF978A502AA03240C024746B563BC29B4D8DCD6956593C0C425446021D699EF6FB4DC2155DE7E393150AD6617EDC01216EA93FCE5F8F7BE9FF605AD2B8344E8CC01BEDB924ED06FD368D1D00801000800000000001E01000100540216577261704E6F6E457863657074696F6E5468726F777301000000A42300000000000000000000BE230000002000000000000000000000000000000000000000000000B0230000000000000000000000005F436F72446C6C4D61696E006D73636F7265652E646C6C0000000000FF2500200010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100100000001800008000000000000000000000000000000100010000003000008000000000000000000000000000000100000000004800000058400000840200000000000000000000840234000000560053005F00560045005200530049004F004E005F0049004E0046004F0000000000BD04EFFE00000100000000000000000000000000000000003F000000000000000400000002000000000000000000000000000000440000000100560061007200460069006C00650049006E0066006F00000000002400040000005400720061006E0073006C006100740069006F006E00000000000000B004E4010000010053007400720069006E006700460069006C00650049006E0066006F000000C001000001003000300030003000300034006200300000002C0002000100460069006C0065004400650073006300720069007000740069006F006E000000000020000000300008000100460069006C006500560065007200730069006F006E000000000030002E0030002E0030002E003000000058001B00010049006E007400650072006E0061006C004E0061006D00650000007400530051004C007400450078007400650072006E0061006C004100630063006500730073004B00650079002E0064006C006C00000000002800020001004C006500670061006C0043006F00700079007200690067006800740000002000000060001B0001004F0072006900670069006E0061006C00460069006C0065006E0061006D00650000007400530051004C007400450078007400650072006E0061006C004100630063006500730073004B00650079002E0064006C006C0000000000340008000100500072006F006400750063007400560065007200730069006F006E00000030002E0030002E0030002E003000000038000800010041007300730065006D0062006C0079002000560065007200730069006F006E00000030002E0030002E0030002E003000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000000C000000D03300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 AS ExternalAccessKeyBytes, 0x7722217D36028E4C AS ExternalAccessKeyThumbPrint;
GO
/****** Object:  UserDefinedFunction [tSQLt].[Private_GetIdentityDefinition]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[Private_GetIdentityDefinition](@ObjectId INT, @ColumnId INT, @ReturnDetails BIT)
RETURNS TABLE
AS
RETURN SELECT 
              COALESCE(IsIdentity, 0) AS IsIdentityColumn,
              COALESCE(IdentityDefinition, '') AS IdentityDefinition
        FROM (SELECT 1) X(X)
        LEFT JOIN (SELECT 1 AS IsIdentity,
                          ' IDENTITY(' + CAST(seed_value AS NVARCHAR(MAX)) + ',' + CAST(increment_value AS NVARCHAR(MAX)) + ')' AS IdentityDefinition, 
                          object_id, 
                          column_id
                     FROM sys.identity_columns
                  ) AS id
               ON id.object_id = @ObjectId
              AND id.column_id = @ColumnId
              AND @ReturnDetails = 1;
GO
/****** Object:  UserDefinedFunction [tSQLt].[Private_GetQuotedTableNameForConstraint]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[Private_GetQuotedTableNameForConstraint](@ConstraintObjectId INT)
RETURNS TABLE
AS
RETURN
  SELECT QUOTENAME(SCHEMA_NAME(newtbl.schema_id)) + '.' + QUOTENAME(OBJECT_NAME(newtbl.object_id)) QuotedTableName,
         SCHEMA_NAME(newtbl.schema_id) SchemaName,
         OBJECT_NAME(newtbl.object_id) TableName,
         OBJECT_NAME(constraints.parent_object_id) OrgTableName
      FROM sys.objects AS constraints
      JOIN sys.extended_properties AS p
      JOIN sys.objects AS newtbl
        ON newtbl.object_id = p.major_id
       AND p.minor_id = 0
       AND p.class_desc = 'OBJECT_OR_COLUMN'
       AND p.name = 'tSQLt.FakeTable_OrgTableName'
        ON OBJECT_NAME(constraints.parent_object_id) = CAST(p.value AS NVARCHAR(4000))
       AND constraints.schema_id = newtbl.schema_id
       AND constraints.object_id = @ConstraintObjectId;
GO
/****** Object:  UserDefinedFunction [tSQLt].[Private_ResolveFakeTableNamesForBackwardCompatibility]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[Private_ResolveFakeTableNamesForBackwardCompatibility] 
 (@TableName NVARCHAR(MAX), @SchemaName NVARCHAR(MAX))
RETURNS TABLE AS 
RETURN
  SELECT QUOTENAME(OBJECT_SCHEMA_NAME(object_id)) AS CleanSchemaName,
         QUOTENAME(OBJECT_NAME(object_id)) AS CleanTableName
     FROM (SELECT CASE
                    WHEN @SchemaName IS NULL THEN OBJECT_ID(@TableName)
                    ELSE COALESCE(OBJECT_ID(@SchemaName + '.' + @TableName),OBJECT_ID(@TableName + '.' + @SchemaName)) 
                  END object_id
          ) ids;
GO
/****** Object:  UserDefinedFunction [tSQLt].[Private_ScriptIndex]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[Private_ScriptIndex]
(
  @object_id INT,
  @index_id INT
)
RETURNS TABLE
AS
RETURN
  SELECT I.index_id,
         I.name AS index_name,
         I.is_primary_key,
         I.is_unique,
         I.is_disabled,
         'CREATE ' +
         CASE WHEN I.is_unique = 1 THEN 'UNIQUE ' ELSE '' END +
         CASE I.type
           WHEN 1 THEN 'CLUSTERED'
           WHEN 2 THEN 'NONCLUSTERED'
           WHEN 5 THEN 'CLUSTERED COLUMNSTORE'
           WHEN 6 THEN 'NONCLUSTERED COLUMNSTORE'
           ELSE '{Index Type Not Supported!}' 
         END +
         ' INDEX ' +
         QUOTENAME(I.name)+
         ' ON ' + QUOTENAME(OBJECT_SCHEMA_NAME(@object_id)) + '.' + QUOTENAME(OBJECT_NAME(@object_id)) +
         CASE WHEN I.type NOT IN (5)
           THEN
             '('+ 
             CL.column_list +
             ')'
           ELSE ''
         END +
         CASE WHEN I.has_filter = 1
           THEN 'WHERE' + I.filter_definition
           ELSE ''
         END +
         CASE WHEN I.is_hypothetical = 1
           THEN 'WITH(STATISTICS_ONLY = -1)'
           ELSE ''
         END +
         ';' AS create_cmd
    FROM tSQLt.Private_SysIndexes AS I
   CROSS APPLY
   (
     SELECT
      (
        SELECT 
          CASE WHEN OIC.rn > 1 THEN ',' ELSE '' END +
          CASE WHEN OIC.rn = 1 AND OIC.is_included_column = 1 AND I.type NOT IN (6) THEN ')INCLUDE(' ELSE '' END +
          QUOTENAME(OIC.name) +
          CASE WHEN OIC.is_included_column = 0
            THEN CASE WHEN OIC.is_descending_key = 1 THEN 'DESC' ELSE 'ASC' END
            ELSE ''
          END
          FROM
          (
            SELECT C.name,
                   IC.is_descending_key, 
                   IC.key_ordinal,
                   IC.is_included_column,
                   ROW_NUMBER()OVER(PARTITION BY IC.is_included_column ORDER BY IC.key_ordinal, IC.index_column_id) AS rn
              FROM sys.index_columns AS IC
              JOIN sys.columns AS C
                ON IC.column_id = C.column_id
               AND IC.object_id = C.object_id
             WHERE IC.object_id = I.object_id
               AND IC.index_id = I.index_id
          )OIC
         ORDER BY OIC.is_included_column, OIC.rn
           FOR XML PATH(''),TYPE
      ).value('.','NVARCHAR(MAX)') AS column_list
   )CL
   WHERE I.object_id = @object_id
     AND I.index_id = ISNULL(@index_id,I.index_id);
GO
/****** Object:  UserDefinedFunction [tSQLt].[TestCaseSummary]    Script Date: 4/11/2024 9:07:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [tSQLt].[TestCaseSummary]()
RETURNS TABLE
AS
RETURN WITH A(Cnt, SuccessCnt, FailCnt, ErrorCnt) AS (
                SELECT COUNT(1),
                       ISNULL(SUM(CASE WHEN Result = 'Success' THEN 1 ELSE 0 END), 0),
                       ISNULL(SUM(CASE WHEN Result = 'Failure' THEN 1 ELSE 0 END), 0),
                       ISNULL(SUM(CASE WHEN Result = 'Error' THEN 1 ELSE 0 END), 0)
                  FROM tSQLt.TestResult
                  
                )
       SELECT 'Test Case Summary: ' + CAST(Cnt AS NVARCHAR) + ' test case(s) executed, '+
                  CAST(SuccessCnt AS NVARCHAR) + ' succeeded, '+
                  CAST(FailCnt AS NVARCHAR) + ' failed, '+
                  CAST(ErrorCnt AS NVARCHAR) + ' errored.' Msg,*
         FROM A;
GO
