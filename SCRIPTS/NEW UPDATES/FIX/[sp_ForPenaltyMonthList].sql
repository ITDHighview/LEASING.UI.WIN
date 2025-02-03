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
            CONVERT(VARCHAR(20), [tblMonthLedger].[LedgMonth], 107)                 AS [LedgMonth],
            [tblMonthLedger].[LedgMonth]                                            AS [SelectLedgMonth],
            FORMAT(ISNULL(SUM([tblMonthLedger].[PenaltyAmount]), 0), 'N2')          AS [PenaltyAmount],
            IIF(ISNULL([tblMonthLedger].[IsForMonthlyPenalty], 0) = 1, 'YES', 'NO') AS [IsForMonthlyPenalty],
            IIF(ISNULL([tblMonthLedger].[IsPenaltyApplied], 0) = 1, 'YES', 'NO')    AS [IsPenaltyApplied],
            IIF(
                ISNULL([tblMonthLedger].[IsForMonthlyPenalty], 0) = 1
                AND ISNULL([tblMonthLedger].[IsPenaltyApplied], 0) = 1,
                'Generated',
                'Pending')                                                          AS [PenaltyIntegrationStatus]
        FROM
            [dbo].[tblMonthLedger]
        WHERE
            ISNULL([tblMonthLedger].[IsForMonthlyPenalty], 0) = 1
            AND [tblMonthLedger].[ReferenceID] = @ReferenceID
            AND [tblMonthLedger].[Remarks] <> 'PENALTY'
        GROUP BY
            [tblMonthLedger].[LedgMonth],
            [tblMonthLedger].[IsForMonthlyPenalty],
            [tblMonthLedger].[IsPenaltyApplied]
        ORDER BY
            [tblMonthLedger].[LedgMonth] ASC
    END
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO