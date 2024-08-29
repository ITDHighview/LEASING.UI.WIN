SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC [sp_GetLedgerList] @ReferenceID =10000000, @ClientID='INDV10000000'
-- =============================================
CREATE   PROCEDURE [dbo].[sp_GetLedgerList]
    @ReferenceID BIGINT       = NULL,
    @ClientID    VARCHAR(150) = NULL
AS
    BEGIN
        SET NOCOUNT ON;
        DECLARE @TotalRent DECIMAL(18, 2) = NULL
        DECLARE @PenaltyPct DECIMAL(18, 2) = NULL
        DECLARE @RefId VARCHAR(150) = ''

        SELECT
            @RefId =
            (
                SELECT
                    [tblUnitReference].[RefId]
                FROM
                    [dbo].[tblUnitReference]
                WHERE
                    [tblUnitReference].[RecId] = @ReferenceID
            )
        SELECT
            @TotalRent  = [tblUnitReference].[TotalRent],
            @PenaltyPct = [tblUnitReference].[PenaltyPct]
        FROM
            [dbo].[tblUnitReference] WITH (NOLOCK)
        WHERE
            [tblUnitReference].[RecId] = @ReferenceID

        /*Check if the penalty stop when it reach the specific date to penalty*/
        --UPDATE
        --    [dbo].[tblMonthLedger]
        --SET
        --    [tblMonthLedger].[PenaltyAmount] = IIF([tblMonthLedger].[PenaltyAmount] > 0,
        --                                           [tblMonthLedger].[PenaltyAmount],
        --                                           CASE
        --                                               WHEN DATEDIFF(
        --                                                                DAY, [tblMonthLedger].[LedgMonth],
        --                                                                CAST(GETDATE() AS DATE)
        --                                                            ) < 30
        --                                                   THEN
        --                                                   0
        --                                               WHEN DATEDIFF(
        --                                                                DAY, [tblMonthLedger].[LedgMonth],
        --                                                                CAST(GETDATE() AS DATE)
        --                                                            ) = 30
        --                                                   THEN
        --                                                   --CAST(((@TotalRent * @PenaltyPct) / 100) AS DECIMAL(18, 2))
        --                                                   CAST((([tblMonthLedger].[LedgRentalAmount] * @PenaltyPct)
        --                                                         / 100
        --                                                        ) AS DECIMAL(18, 2))
        --                                               WHEN DATEDIFF(
        --                                                                DAY, [tblMonthLedger].[LedgMonth],
        --                                                                CAST(GETDATE() AS DATE)
        --                                                            ) >= 31
        --                                                    AND DATEDIFF(
        --                                                                    DAY, [tblMonthLedger].[LedgMonth],
        --                                                                    CAST(GETDATE() AS DATE)
        --                                                                --) <= 31 THEN
        --                                                                ) <= 60
        --                                                   THEN
        --                                                   --CAST((((@TotalRent * @PenaltyPct) / 100) * 2) AS DECIMAL(18, 2))
        --                                                   CAST(((([tblMonthLedger].[LedgRentalAmount] * @PenaltyPct)
        --                                                          / 100
        --                                                         ) * 2
        --                                                        ) AS DECIMAL(18, 2))
        --                                               WHEN DATEDIFF(
        --                                                                DAY, [tblMonthLedger].[LedgMonth],
        --                                                                CAST(GETDATE() AS DATE)
        --                                                            ) = 60
        --                                                   THEN
        --                                                   --CAST((((@TotalRent * @PenaltyPct) / 100) * 3) AS DECIMAL(18, 2))
        --                                                   CAST(((([tblMonthLedger].[LedgRentalAmount] * @PenaltyPct)
        --                                                          / 100
        --                                                         ) * 3
        --                                                        ) AS DECIMAL(18, 2))
        --                                               WHEN DATEDIFF(
        --                                                                DAY, [tblMonthLedger].[LedgMonth],
        --                                                                CAST(GETDATE() AS DATE)
        --                                                            ) >= 61
        --                                                   THEN
        --                                                   --CAST((((@TotalRent * @PenaltyPct) / 100) * 4) AS DECIMAL(18, 2))
        --                                                   CAST(((([tblMonthLedger].[LedgRentalAmount] * @PenaltyPct)
        --                                                          / 100
        --                                                         ) * 4
        --                                                        ) AS DECIMAL(18, 2))
        --                                               ELSE
        --                                                   0
        --                                           END)
        --WHERE
        --    [tblMonthLedger].[ReferenceID] = @ReferenceID
        --    AND
        --        (
        --            ISNULL([tblMonthLedger].[IsPaid], 0) = 0
        --            OR ISNULL([tblMonthLedger].[IsHold], 0) = 1
        --        )
        --    AND MONTH([tblMonthLedger].[EncodedDate]) > 4
        --    AND YEAR([tblMonthLedger].[EncodedDate]) = 2024

        --UPDATE
        --    [dbo].[tblMonthLedger]
        --SET
        --    [tblMonthLedger].[ActualAmount] = [tblMonthLedger].[LedgRentalAmount]
        --                                      + ISNULL([tblMonthLedger].[PenaltyAmount], 0)
        --WHERE
        --    [tblMonthLedger].[ReferenceID] = @ReferenceID
        --    AND
        --        (
        --            ISNULL([tblMonthLedger].[IsPaid], 0) = 0
        --            OR ISNULL([tblMonthLedger].[IsHold], 0) = 1
        --        )


        SELECT
            ROW_NUMBER() OVER (ORDER BY
                                   [tblMonthLedger].[LedgMonth] ASC
                              )                                                                                          [seq],
            [tblMonthLedger].[Recid],
            [tblMonthLedger].[ReferenceID],
            [tblMonthLedger].[ClientID],
            --[tblMonthLedger].[LedgAmount]  + ISNULL([tblMonthLedger].[PenaltyAmount], 0) AS [LedgAmount],
            FORMAT((ISNULL([tblMonthLedger].[LedgRentalAmount], 0) + ISNULL([tblMonthLedger].[PenaltyAmount], 0)), 'N2') AS [LedgAmount],
            FORMAT(ISNULL([tblMonthLedger].[PenaltyAmount], 0), 'N2')                                                    AS [PenaltyAmount],
            ISNULL([tblMonthLedger].[TransactionID], '')                                                                 AS [TransactionID],
            CONVERT(VARCHAR(20), [tblMonthLedger].[LedgMonth], 107)                                                      AS [LedgMonth],
            [tblMonthLedger].[Remarks]                                                                                   AS [Remarks],
            --IIF(ISNULL(IsPaid, 0) = 1,
            --    'PAID',
            --    IIF(CONVERT(VARCHAR(20), LedgMonth, 107) = CONVERT(VARCHAR(20), GETDATE(), 107), 'FOR PAYMENT', 'PENDING')) As PaymentStatus,
            CASE
                WHEN ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                     AND ISNULL([tblMonthLedger].[IsHold], 0) = 0
                    THEN
                    'PAID'
                WHEN ISNULL([tblMonthLedger].[IsPaid], 0) = 0
                     AND ISNULL([tblMonthLedger].[IsHold], 0) = 1
                    THEN
                    'HOLD'
                WHEN [tblMonthLedger].[LedgMonth] IN
                         (
                             SELECT
                                 [tblAdvancePayment].[Months]
                             FROM
                                 [dbo].[tblAdvancePayment]
                             WHERE
                                 [tblAdvancePayment].[RefId] = @RefId
                         )
                     AND ISNULL([tblMonthLedger].[IsPaid], 0) = 0
                     AND ISNULL([tblMonthLedger].[IsHold], 0) = 0
                    THEN
                    'FOR PAYMENT'
                WHEN CONVERT(VARCHAR(20), [tblMonthLedger].[LedgMonth], 107) = CONVERT(VARCHAR(20), GETDATE(), 107)
                     AND ISNULL([tblMonthLedger].[IsPaid], 0) = 0
                     AND ISNULL([tblMonthLedger].[IsHold], 0) = 0
                    THEN
                    'FOR PAYMENT'
                ELSE
                    'PENDING'
            END                                                                                                          AS [PaymentStatus],
            --IIF(
            --    [tblMonthLedger].[BalanceAmount] <= 0
            --    AND [tblMonthLedger].[IsPaid] = 0,
            --    0,
            --    [tblMonthLedger].[LedgAmount] - [tblMonthLedger].[BalanceAmount]) AS [AmountPaid],
            IIF(
                ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                OR
                    (
                        ISNULL([tblMonthLedger].[IsHold], 0) = 1
                        AND [tblMonthLedger].[BalanceAmount] > 0
                    ),
                ([tblMonthLedger].[ActualAmount]
                 - (ISNULL([tblMonthLedger].[BalanceAmount], 0) + ISNULL([tblMonthLedger].[PenaltyAmount], 0))
                ),
                0)                                                                                                       AS [AmountPaid],
            FORMAT(CAST(ABS(ISNULL([tblMonthLedger].[BalanceAmount], 0)) AS DECIMAL(18, 2)), 'N2')                       AS [BalanceAmount]

        --'0.00' [PenaltyAmount]
        FROM
            [dbo].[tblMonthLedger]
        WHERE
            [tblMonthLedger].[ReferenceID] = @ReferenceID
            AND [tblMonthLedger].[ClientID] = @ClientID
        ORDER BY
            [seq] ASC;
    END;
GO
