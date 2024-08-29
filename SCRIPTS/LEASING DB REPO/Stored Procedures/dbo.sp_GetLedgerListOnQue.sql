SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [dbo].[sp_GetLedgerListOnQue]
    --@ReferenceID BIGINT = NULL,
    --@ClientID VARCHAR(50) = NULL
    @XML XML = NULL
AS
    BEGIN

        SET NOCOUNT ON;

        CREATE TABLE [#tblBulkPostdatedMonth]
            (
                [Recid] VARCHAR(10)
            )
        IF (@XML IS NOT NULL)
            BEGIN
                INSERT INTO [#tblBulkPostdatedMonth]
                    (
                        [Recid]
                    )
                            SELECT
                                [ParaValues].[data].[value]('c1[1]', 'VARCHAR(10)')
                            FROM
                                @XML.[nodes]('/Table1') AS [ParaValues]([data])
            END


        SELECT
            ROW_NUMBER() OVER (ORDER BY
                                   [tblMonthLedger].[LedgMonth] ASC
                              )                                                                    [seq],
            [tblMonthLedger].[Recid],
            [tblMonthLedger].[ReferenceID],
            [tblMonthLedger].[ClientID],
            FORMAT(ISNULL([tblMonthLedger].[LedgRentalAmount], 0), 'N2')                           AS [LedgAmount],
            FORMAT(ISNULL([tblMonthLedger].[PenaltyAmount], 0), 'N2')                              AS [PenaltyAmount],
            ISNULL([tblMonthLedger].[TransactionID], '')                                           AS [TransactionID],
            CONVERT(VARCHAR(20), [tblMonthLedger].[LedgMonth], 107)                                AS [LedgMonth],
            ''                                                                                     AS [Remarks],
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
                                 [tblAdvancePayment].[RefId] = 'REF'
                                                               + CAST([tblMonthLedger].[ReferenceID] AS VARCHAR(150))
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
            END                                                                                    AS [PaymentStatus],
            IIF(
                ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                OR
                    (
                        ISNULL([tblMonthLedger].[IsHold], 0) = 1
                        AND [tblMonthLedger].[BalanceAmount] > 0
                    ),
                ([tblMonthLedger].[LedgRentalAmount] - ISNULL([tblMonthLedger].[BalanceAmount], 0)),
                0)                                                                                 AS [AmountPaid],
            FORMAT(CAST(ABS(ISNULL([tblMonthLedger].[BalanceAmount], 0)) AS DECIMAL(18, 2)), 'N2') AS [BalanceAmount],
            --ISNULL([tblMonthLedger].[PaymentMode], '') AS [PaymentMode],
            --ISNULL([tblMonthLedger].[RcptID], '') AS [RcptID],
            ISNULL([tblMonthLedger].[CompanyORNo], '')                                             AS [CompanyORNo],
            ISNULL([tblMonthLedger].[CompanyPRNo], '')                                             AS [CompanyPRNo],
            ISNULL([tblMonthLedger].[REF], '')                                                     AS [REF],
            ISNULL([tblMonthLedger].[BNK_ACCT_NAME], '')                                           AS [BNK_ACCT_NAME],
            ISNULL([tblMonthLedger].[BNK_ACCT_NUMBER], '')                                         AS [BNK_ACCT_NUMBER],
            ISNULL([tblMonthLedger].[BNK_NAME], '')                                                AS [BNK_NAME],
            ISNULL([tblMonthLedger].[SERIAL_NO], '')                                               AS [SERIAL_NO],
            ISNULL([tblMonthLedger].[ModeType], '')                                                AS [ModeType],
            ISNULL([tblMonthLedger].[BankBranch], '')                                              AS [BankBranch]
        FROM
            [dbo].[tblMonthLedger]
        WHERE
            [tblMonthLedger].[Recid] IN
                (
                    SELECT
                        [#tblBulkPostdatedMonth].[Recid]
                    FROM
                        [#tblBulkPostdatedMonth]
                )
        ORDER BY
            [seq] ASC


        DROP TABLE [#tblBulkPostdatedMonth]
    END;
GO
