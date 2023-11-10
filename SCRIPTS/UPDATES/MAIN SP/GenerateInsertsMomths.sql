USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[GenerateInsertsMomths]    Script Date: 11/9/2023 9:51:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC [GenerateInsertsMomths] @StartDate = '07/31/2023',@MonthsCount = 3
ALTER PROCEDURE [dbo].[GenerateInsertsMomths]
    @StartDate DATE,
    @MonthsCount INT
AS
BEGIN

CREATE TABLE #GeneratedMonths (
    [Month] DATE
);
    WITH MonthsCTE AS (
        SELECT @StartDate AS [Month]
        UNION ALL
        SELECT DATEADD(MONTH, 1, [Month])
        FROM MonthsCTE
        WHERE DATEADD(MONTH, 1, [Month]) <= DATEADD(MONTH, @MonthsCount - 1, @StartDate)
    )
    INSERT INTO #GeneratedMonths ([Month])
    SELECT [Month] FROM MonthsCTE;

    -- Insert data into sample_table based on the generated months
    --INSERT INTO sample_table ([Month], [data])
    --SELECT FORMAT([Month], 'MMMM'),'test' 
    --FROM #GeneratedMonths;
   INSERT INTO sample_table ([Month], [data])
    SELECT [Month], 'test'
    FROM #GeneratedMonths;
    -- Clean up the temporary table
    DROP TABLE #GeneratedMonths;
	
END;




--CREATE TABLE tblMonthLedger (

--Recid INT IDENTITY(1,1),
--ReferenceID INT,
--ClientID VARCHAR(50),
--LedgMonth DATE,
--LedgAmount DECIMAL(18,2)
--)

--CREATE TABLE tblUnitReference(
--	RecId INT IDENTITY(1,1),
--	RefId  AS ('REF'+CONVERT(VARCHAR(MAX),RecId)),
--	ProjectId int,
--	InquiringClient VARCHAR(500),
--	ClientMobile VARCHAR(50),
--	UnitId INT,
--	UnitNo VARCHAR(50),
--	StatDate DATE,
--	FinishDate DATE,
--	TransactionDate DATE,
--	Rental DECIMAL(18,2),
--	SecAndMaintenance DECIMAL(18,2),
--	TotalRent DECIMAL(18,2),
--	Advancemonths1 DECIMAL(18,2),
--	Advancemonths2 DECIMAL(18,2),
--	SecDeposit DECIMAL(18,2),
--	Total DECIMAL (18,2),
--	EncodedBy INT,
--	EncodedDate DATETIME,
--	LastCHangedBy INT,
--	LastChangedDate DATETIME,
--	IsActive BIT,
--	ComputerName VARCHAR(30)
--)