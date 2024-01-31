SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_GetPenaltyResult] @LedgerId AS INT = NULL
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN



    DECLARE @DateHold AS DATE = NULL;
    DECLARE @DayCount AS INT = 0;
    DECLARE @RefRecID AS INT = 0;

    SELECT @DateHold = [tblMonthLedger].[LedgMonth],
           @RefRecID = [tblMonthLedger].[ReferenceID]
    FROM [dbo].[tblMonthLedger]
    WHERE [tblMonthLedger].[Recid] = @LedgerId;
    SELECT @DayCount = DATEDIFF(DAY, @DateHold, CAST(GETDATE() AS DATE));

    IF @DayCount < 30
    BEGIN

        SELECT
            (
                SELECT [tblUnitReference].[TotalRent]
                FROM [dbo].[tblUnitReference]
                WHERE [tblUnitReference].[RecId] = @RefRecID
            ) AS [AmountToPay],
            0.00 AS [PenaltyAmount],
            @DayCount AS [DayCount],
            '(No Penalty)' AS [PenaltyStatus];
    END;
    ELSE IF @DayCount = 30
    BEGIN
        --return total rental plus 3 percent penalty
        SELECT
            (
                SELECT [tblUnitReference].[TotalRent]
                       + (([tblUnitReference].[TotalRent] * [tblUnitReference].[PenaltyPct]) / 100)
                FROM [dbo].[tblUnitReference]
                WHERE [tblUnitReference].[RecId] = @RefRecID
            ) AS [AmountToPay],
            (
                SELECT (([tblUnitReference].[TotalRent] * [tblUnitReference].[PenaltyPct]) / 100)
                FROM [dbo].[tblUnitReference]
                WHERE [tblUnitReference].[RecId] = @RefRecID
            ) AS [PenaltyAmount],
            @DayCount AS [DayCount],
            '(With Penalty:(' + @DayCount + ') days' AS [PenaltyStatus];
    END;
    ELSE IF @DayCount >= 31
    BEGIN
        --return total rental plus 3 percent x2 penalty
        SELECT
            (
                SELECT [tblUnitReference].[TotalRent]
                       + ((([tblUnitReference].[TotalRent] * [tblUnitReference].[PenaltyPct]) / 100) * 2)
                FROM [dbo].[tblUnitReference]
                WHERE [tblUnitReference].[RecId] = @RefRecID
            ) AS [AmountToPay],
            (
                SELECT ((([tblUnitReference].[TotalRent] * [tblUnitReference].[PenaltyPct]) / 100) * 2)
                FROM [dbo].[tblUnitReference]
                WHERE [tblUnitReference].[RecId] = @RefRecID
            ) AS [PenaltyAmount],
            @DayCount AS [DayCount],
            '(With Penalty x2:(' + @DayCount + ') days' AS [PenaltyStatus];
    END;
END;
GO
