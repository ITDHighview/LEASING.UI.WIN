SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetLedgerListOnQue]
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
        SELECT [ParaValues].[data].[value]('c1[1]', 'VARCHAR(10)')
        FROM @XML.[nodes]('/Table1') AS [ParaValues]([data])
    END


    SELECT ROW_NUMBER() OVER (ORDER BY [tblMonthLedger].[LedgMonth] ASC) [seq],
           [tblMonthLedger].[Recid],
           [tblMonthLedger].[ReferenceID],
           [tblMonthLedger].[ClientID],
           [tblMonthLedger].[LedgAmount],
           ISNULL([tblMonthLedger].[PenaltyAmount], 0) AS [PenaltyAmount],
           ISNULL([tblMonthLedger].[TransactionID], '') AS [TransactionID],
           CONVERT(VARCHAR(20), [tblMonthLedger].[LedgMonth], 107) AS [LedgMonth],
           '' AS [Remarks],
           CASE
               WHEN ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                    AND ISNULL([tblMonthLedger].[IsHold], 0) = 0 THEN
                   'PAID'
               WHEN ISNULL([tblMonthLedger].[IsPaid], 0) = 0
                    AND ISNULL([tblMonthLedger].[IsHold], 0) = 1 THEN
                   'HOLD'
               WHEN CONVERT(VARCHAR(20), [tblMonthLedger].[LedgMonth], 107) = CONVERT(VARCHAR(20), GETDATE(), 107) THEN
                   'FOR PAYMENT'
               ELSE
                   'PENDING'
           END AS [PaymentStatus],
           IIF(
               ISNULL([tblMonthLedger].[IsPaid], 0) = 1
               OR
               (
                   ISNULL([tblMonthLedger].[IsHold], 0) = 1
                   AND [tblMonthLedger].[BalanceAmount] > 0
               ),
               ([tblMonthLedger].[LedgAmount] - ISNULL([tblMonthLedger].[BalanceAmount], 0)),
               0) AS [AmountPaid],
           CAST(ABS(ISNULL([tblMonthLedger].[BalanceAmount], 0)) AS DECIMAL(18, 2)) AS [BalanceAmount]
         
    FROM [dbo].[tblMonthLedger]
    WHERE [tblMonthLedger].[Recid] IN
          (
              SELECT [#tblBulkPostdatedMonth].[Recid] FROM [#tblBulkPostdatedMonth]
          )
    ORDER BY [seq] ASC


    DROP TABLE [#tblBulkPostdatedMonth]
END;
GO
