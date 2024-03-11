SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_GeneralReport]
AS
BEGIN




    CREATE TABLE [#Temp]
    (
        [Dates] VARCHAR(500),
        [ORNumber] VARCHAR(500),
        [PRNumber] VARCHAR(500),
        [ApplicableMonth] VARCHAR(500),
        [Tenant] VARCHAR(500),
        [Unit] VARCHAR(500),
        [SecurityDeposit] VARCHAR(500),
        [BaseRental] VARCHAR(500),
        [Penalty] VARCHAR(500),
        [Vat] VARCHAR(500),
        [SecurityMaintenance] VARCHAR(500),
        [Tax] VARCHAR(500),
        [Total] VARCHAR(500),
        [Remarks] VARCHAR(500)
    )


	INSERT INTO [#Temp]
	(
	    [Dates],
	    [ORNumber],
	    [PRNumber],
	    [ApplicableMonth],
	    [Tenant],
	    [Unit],
	    [SecurityDeposit],
	    [BaseRental],
	    [Penalty],
	    [Vat],
	    [SecurityMaintenance],
	    [Tax],
	    [Total],
	    [Remarks]
	)
	VALUES
	(   NULL, -- Dates - varchar(500)
	    NULL, -- ORNumber - varchar(500)
	    NULL, -- PRNumber - varchar(500)
	    NULL, -- ApplicableMonth - varchar(500)
	    NULL, -- Tenant - varchar(500)
	    NULL, -- Unit - varchar(500)
	    NULL, -- SecurityDeposit - varchar(500)
	    NULL, -- BaseRental - varchar(500)
	    NULL, -- Penalty - varchar(500)
	    NULL, -- Vat - varchar(500)
	    NULL, -- SecurityMaintenance - varchar(500)
	    NULL, -- Tax - varchar(500)
	    NULL, -- Total - varchar(500)
	    NULL  -- Remarks - varchar(500)
	    )

--		SELECT CONVERT(VARCHAR(20), [tblTransaction].[EncodedDate], 103) AS [Dates],
--       [tblTransaction].[TranID] AS [TransactionNumber],
--       [tblTransaction].[ReceiveAmount] AS [Amount],
--       ISNULL([MonthLedger].[ActualAmountReceivePerMonth], [tblTransaction].[ReceiveAmount]) AS [ActualAmountReceivePerMonth],
--       [tblClientMstr].[ClientName] AS [Tenant]
--FROM [dbo].[tblTransaction]
--    CROSS APPLY
--(
--    SELECT SUM([tblMonthLedger].[ActualAmount]) AS [ActualAmountReceivePerMonth]
--    FROM [dbo].[tblMonthLedger]
--    WHERE [tblTransaction].[TranID] = [tblMonthLedger].[TransactionID]
--    GROUP BY [tblMonthLedger].[TransactionID]
--) [MonthLedger]
--    INNER JOIN [dbo].[tblUnitReference]
--        ON [tblTransaction].[RefId] = [tblUnitReference].[RefId]
--    INNER JOIN [dbo].[tblClientMstr]
--        ON [tblUnitReference].[ClientID] = [tblClientMstr].[ClientID]
--WHERE [tblUnitReference].[RefId] = 'REF10000000'


SELECT *
FROM [dbo].[tblUnitReference]
SELECT *
FROM [dbo].[tblTransaction]
SELECT *
FROM [dbo].[tblMonthLedger]


	SELECT [#Temp].[Dates],
       [#Temp].[ORNumber],
       [#Temp].[PRNumber],
       [#Temp].[ApplicableMonth],
       [#Temp].[Tenant],
       [#Temp].[Unit],
       [#Temp].[SecurityDeposit],
       [#Temp].[BaseRental],
       [#Temp].[Penalty],
       [#Temp].[Vat],
       [#Temp].[SecurityMaintenance],
       [#Temp].[Tax],
       [#Temp].[Total],
       [#Temp].[Remarks]
FROM [#Temp]


END
GO
