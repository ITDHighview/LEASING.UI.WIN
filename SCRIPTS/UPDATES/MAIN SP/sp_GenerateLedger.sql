USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_GenerateLedger]    Script Date: 11/9/2023 9:56:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC [GenerateInsertsMomths] @StartDate = '07/31/2023',@MonthsCount = 3
ALTER PROCEDURE [dbo].[sp_GenerateLedger]
    --@StartDate DATE,--Start of Post Dated Checks
     @FromDate VARCHAR(10) = NULL,
	 @EndDate VARCHAR(10) = NULL,
	 @LedgAmount DECIMAL(18,2)=NULL,
	 @ComputationID INT = NULL,
	 @ClientID VARCHAR(30)=NULL,
	 @EncodedBy INT = NULL,
	 @ComputerName VARCHAR(30)=NULL
AS
BEGIN

--DECLARE @StartDate VARCHAR(10) = '08/02/2023';
--DECLARE @EndDate VARCHAR(10) = '05/02/2024';
--SELECT DATEDIFF(MONTH, CONVERT(DATE, @StartDate, 101), CONVERT(DATE, @EndDate, 101)) AS NumberOfMonths;

DECLARE @MonthsCount INT = DATEDIFF(MONTH, CONVERT(DATE, @FromDate, 101), CONVERT(DATE, @EndDate, 101))

CREATE TABLE #GeneratedMonths (
    [Month] DATE
);
    WITH MonthsCTE AS (
        SELECT CONVERT(DATE,@FromDate) AS [Month]
        UNION ALL
        SELECT DATEADD(MONTH, 1, [Month])
        FROM MonthsCTE
        WHERE DATEADD(MONTH, 1, [Month]) <= DATEADD(MONTH, @MonthsCount -1, CONVERT(DATE,@FromDate))
    )
    INSERT INTO #GeneratedMonths ([Month])
    SELECT [Month] FROM MonthsCTE

 --DELETE FROM #GeneratedMonths where [Month] BETWEEN @ApplicableDate1 and @ApplicableDate2 

   INSERT INTO tblMonthLedger (LedgMonth, LedgAmount,ReferenceID,ClientID,IsPaid,EncodedBy,EncodedDate,ComputerName)
    SELECT  [Month], @LedgAmount,@ComputationID,@ClientID,0,@EncodedBy,GETDATE(),@ComputerName
    FROM #GeneratedMonths

	IF (@@ROWCOUNT > 0)
	BEGIN
	UPDATE tblUnitReference SET ClientID = @ClientID,LastCHangedBy =@EncodedBy,LastChangedDate = GETDATE(),ComputerName = @ComputerName  WHERE RecId = @ComputationID

	--No need for IsMap
	--UPDATE tblClientMstr SET IsMap = 1 WHERE RecId = @ClientID

	--no need only in generate transaction once paid will flag the unit as OCCUPIED
	--update tblUnitMstr set UnitStatus = 'OCCUPIED',clientID = @ClientID WHERE RecId =(SELECT UnitId FROM tblUnitReference WHERE RecId = @ComputationID)

		SELECT 'SUCCESS' AS Message_Code
	END
    -- Clean up the temporary table
    DROP TABLE #GeneratedMonths
	
END;
