USE [LEASINGDB]
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
--EXEC [sp_IsContractHaveMonthlyPenalty] 10000000
CREATE OR ALTER PROCEDURE [sp_IsContractHaveMonthlyPenalty] @ReferenceID AS BIGINT
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
    BEGIN

        DECLARE @PenaltyApplyInMonth INT = 0
        DECLARE @PenaltyApplyInYear INT = 0
        DECLARE @TotalPenaltyAmount DECIMAL(18, 2) = 0

        SELECT
            @PenaltyApplyInMonth = ISNULL([tblMonthlyPenaltySetting].[PenaltyApplyInMonth], 0),
            @PenaltyApplyInYear  = ISNULL([tblMonthlyPenaltySetting].[PenaltyApplyInYear], 0)
        FROM
            [dbo].[tblMonthlyPenaltySetting]

        SELECT
            @TotalPenaltyAmount
            = SUM([dbo].[fnGetPenaltyResultAmount](
                                                      [tblMonthLedger].[LedgMonth], @ReferenceID,
                                                      [tblMonthLedger].[LedgRentalAmount]
                                                  )
                 )
        FROM
            [dbo].[tblMonthLedger]
        WHERE
            [tblMonthLedger].[ReferenceID] = @ReferenceID
            AND ISNULL([tblMonthLedger].[IsPaid], 0) = 0
            AND ISNULL([tblMonthLedger].[IsHold], 0) = 0
            AND MONTH([tblMonthLedger].[EncodedDate]) >= @PenaltyApplyInMonth
            AND YEAR([tblMonthLedger].[EncodedDate]) >= @PenaltyApplyInYear
            AND [tblMonthLedger].[Remarks] <> 'PENALTY'
            AND ISNULL([tblMonthLedger].[IsForMonthlyPenalty], 0) = 0
            AND ISNULL([tblMonthLedger].[IsPenaltyApplied], 0) = 0
            AND ISNULL([tblMonthLedger].[IsFreeMonth], 0) = 0
        GROUP BY
            [tblMonthLedger].[ReferenceID]

        SELECT TOP 1
               IIF(
                   DATEDIFF(DAY, [tblMonthLedger].[LedgMonth], CAST(GETDATE() AS DATE)) >=
                      (
                          SELECT
                              MIN([tblPenaltySetup].[DayCount]) AS DayCount
                          FROM
                              [dbo].[tblPenaltySetup]
                          WHERE
                              [tblPenaltySetup].[IsForPenalty] = 1
                      ),
                   1,
                   0)                                                  AS [IsHasPenalty],
               CONVERT(VARCHAR(20), [tblMonthLedger].[LedgMonth], 107) AS [MonthHavePenalty],
               CAST(@TotalPenaltyAmount AS VARCHAR(150))               AS [AmountOfPenalty]
        FROM
               [dbo].[tblMonthLedger]
        WHERE
               [tblMonthLedger].[ReferenceID] = @ReferenceID
               AND ISNULL([tblMonthLedger].[IsPaid], 0) = 0
               AND ISNULL([tblMonthLedger].[IsHold], 0) = 0
               AND MONTH([tblMonthLedger].[EncodedDate]) >= @PenaltyApplyInMonth
               AND YEAR([tblMonthLedger].[EncodedDate]) >= @PenaltyApplyInYear
               AND [tblMonthLedger].[Remarks] <> 'PENALTY'
               AND ISNULL([tblMonthLedger].[IsForMonthlyPenalty], 0) = 0
               AND ISNULL([tblMonthLedger].[IsPenaltyApplied], 0) = 0
               AND ISNULL([tblMonthLedger].[IsFreeMonth], 0) = 0
    END
GO

