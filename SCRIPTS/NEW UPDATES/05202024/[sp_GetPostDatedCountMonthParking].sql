SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_GetPostDatedCountMonthParking]
    @FromDate VARCHAR(10) = NULL,
    @EndDate VARCHAR(10) = NULL,
    @Rental VARCHAR(10) = NULL,
    @SecMainRental VARCHAR(10) = NULL,
	    @XML XML
AS
BEGIN

    SET NOCOUNT ON;
	
    CREATE TABLE [#tblAdvancePayment]
    (
        [Months] VARCHAR(10)
    );
    IF (@XML IS NOT NULL)
    BEGIN
        INSERT INTO [#tblAdvancePayment]
        (
            [Months]
        )
        SELECT [ParaValues].[data].[value]('c1[1]', 'VARCHAR(10)')
        FROM @XML.[nodes]('/Table1') AS [ParaValues]([data]);
    END;


    DECLARE @MonthsCount INT = DATEDIFF(MONTH, CONVERT(DATE, @FromDate, 101), CONVERT(DATE, @EndDate, 101));

    CREATE TABLE [#GeneratedMonths]
    (
        [Month] DATE
    );
    WITH [MonthsCTE]
    AS (SELECT CONVERT(DATE, @FromDate) AS [Month]
        UNION ALL
        SELECT DATEADD(MONTH, 1, [MonthsCTE].[Month])
        FROM [MonthsCTE]
        WHERE DATEADD(MONTH, 1, [MonthsCTE].[Month]) <= DATEADD(MONTH, @MonthsCount - 1, CONVERT(DATE, @FromDate)))
    INSERT INTO [#GeneratedMonths]
    (
        [Month]
    )
    SELECT [MonthsCTE].[Month]
    FROM [MonthsCTE]
	OPTION (maxrecursion 0);


	DELETE FROM [#GeneratedMonths]
    WHERE [#GeneratedMonths].[Month] IN
          (
              SELECT [#tblAdvancePayment].[Months] FROM [#tblAdvancePayment]
          );
    SELECT ROW_NUMBER() OVER (ORDER BY [#GeneratedMonths].[Month] ASC) [seq],
           CONVERT(VARCHAR(20), [#GeneratedMonths].[Month], 107) AS [Dates],
           @Rental AS [Rental],
           @SecMainRental AS [SecMainRental],
           CAST(@Rental AS DECIMAL(18, 2)) + CAST(@SecMainRental AS DECIMAL(18, 2)) AS [TotalRental]
    FROM [#GeneratedMonths];

     DROP TABLE [#GeneratedMonths];
    DROP TABLE [#tblAdvancePayment];
END;
GO

