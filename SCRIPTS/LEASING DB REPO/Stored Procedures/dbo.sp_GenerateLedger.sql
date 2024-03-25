SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--EXEC [sp_GenerateLedger] 
CREATE PROCEDURE [dbo].[sp_GenerateLedger]
    @FromDate VARCHAR(10) = NULL,
    @EndDate VARCHAR(10) = NULL,
    @LedgAmount DECIMAL(18, 2) = NULL,
    @Rental DECIMAL(18, 2) = NULL,
    @SecAndMaintenance DECIMAL(18, 2) = NULL,
    @ComputationID INT = NULL,
    @ClientID VARCHAR(30) = NULL,
    @EncodedBy INT = NULL,
    @ComputerName VARCHAR(30) = NULL
AS
BEGIN

    --DECLARE @StartDate VARCHAR(10) = '08/02/2023';
    --DECLARE @EndDate VARCHAR(10) = '05/02/2024';
    --SELECT DATEDIFF(MONTH, CONVERT(DATE, @StartDate, 101), CONVERT(DATE, @EndDate, 101)) AS NumberOfMonths;

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
    FROM [MonthsCTE];



    INSERT INTO [dbo].[tblMonthLedger]
    (
        [LedgMonth],
        [LedgAmount],
        [LedgRentalAmount],
        [ReferenceID],
        [ClientID],
        [IsPaid],
        [EncodedBy],
        [EncodedDate],
        [ComputerName],
        [Remarks]
    )
    SELECT [#GeneratedMonths].[Month],
           @LedgAmount,
           @Rental,
           @ComputationID,
           @ClientID,
           0,
           @EncodedBy,
           GETDATE(),
           @ComputerName,
           'RENTAL NET OF VAT'
    FROM [#GeneratedMonths]
    UNION
    SELECT [#GeneratedMonths].[Month],
           @LedgAmount,
           @SecAndMaintenance,
           @ComputationID,
           @ClientID,
           0,
           @EncodedBy,
           GETDATE(),
           @ComputerName,
           'SECURITY AND MAINTENANCE NET OF VAT'
    FROM [#GeneratedMonths]
    WHERE @SecAndMaintenance IS NOT NULL
    IF (@@ROWCOUNT > 0)
    BEGIN
        UPDATE [dbo].[tblUnitReference]
        SET [tblUnitReference].[ClientID] = @ClientID,
            [tblUnitReference].[LastCHangedBy] = @EncodedBy,
            [tblUnitReference].[LastChangedDate] = GETDATE(),
            [tblUnitReference].[ComputerName] = @ComputerName
        WHERE [tblUnitReference].[RecId] = @ComputationID;


        SELECT 'SUCCESS' AS [Message_Code];
    END;

    DROP TABLE [#GeneratedMonths];


END;
GO
