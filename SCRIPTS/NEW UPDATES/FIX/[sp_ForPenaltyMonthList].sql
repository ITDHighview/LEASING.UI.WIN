USE [LEASINGDB]
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--exec [sp_ForPenaltyMonthList] @ReferenceID =10000000
GO
CREATE OR ALTER PROCEDURE [sp_ForPenaltyMonthList] @ReferenceID BIGINT = NULL

-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
    BEGIN
        SELECT
            CONVERT(VARCHAR(20), [Main].[LedgMonth], 107)                 AS [LedgMonth],
            [Main].[LedgMonth]                                            AS [SelectLedgMonth],
            FORMAT(ISNULL(SUM([Main].[PenaltyAmount]), 0), 'N2')          AS [PenaltyAmount],
            IIF(ISNULL([Main].[IsForMonthlyPenalty], 0) = 1, 'YES', 'NO') AS [IsForMonthlyPenalty],
            IIF(ISNULL([Main].[IsPenaltyApplied], 0) = 1, 'YES', 'NO')    AS [IsPenaltyApplied],
            IIF(
                ISNULL([Main].[IsForMonthlyPenalty], 0) = 1
                AND ISNULL([Main].[IsPenaltyApplied], 0) = 1,
                'Generated',
                'Pending')                                                AS [PenaltyIntegrationStatus],
            IIF(ISNULL([Penalty].[paid], 0) = 1, 'YES', 'NO')             AS [Ispaid],
            IIF(ISNULL([Penalty].[paid], 0) = 1, 'Done', 'Pending')       AS [Payment]
        FROM
            [dbo].[tblMonthLedger] [Main]
            OUTER APPLY
            (
                SELECT
                    1 AS [paid]
                FROM
                    [dbo].[tblMonthLedger]
                WHERE
                    [tblMonthLedger].[LedgMonth] = [Main].[LedgMonth]
                    AND [tblMonthLedger].[ReferenceID] = [Main].[ReferenceID]
                    AND [tblMonthLedger].[Remarks] = 'PENALTY'
                    AND ISNULL([tblMonthLedger].[IsPaid], 0) = 1
            )                      AS [Penalty]
        WHERE
            ISNULL([Main].[IsForMonthlyPenalty], 0) = 1
            AND [Main].[ReferenceID] = @ReferenceID
            AND [Main].[Remarks] <> 'PENALTY'
        GROUP BY
            [Main].[LedgMonth],
            [Main].[IsForMonthlyPenalty],
            [Main].[IsPenaltyApplied],
            [Penalty].[paid]
        ORDER BY
            [Main].[LedgMonth] ASC
    END
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO