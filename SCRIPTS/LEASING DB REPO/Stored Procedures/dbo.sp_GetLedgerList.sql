SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetLedgerList]
    @ReferenceID BIGINT = NULL,
    @ClientID VARCHAR(50) = NULL
-- Add the parameters for the stored procedure here

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
    --	Select 0 as seq,
    --       (
    --           SELECT SecDeposit
    --           FROM tblUnitReference WITH (NOLOCK)
    --           WHERE RecId = @ReferenceID
    --       ) as LedgAmount,
    --       CONVERT(VARCHAR(20), GETDATE(), 107) as LedgMonth,
    --       'FOR 3 MONTHS SECURITY DEPOSIT' as Remarks
    --UNION
    SELECT ROW_NUMBER() OVER (ORDER BY [tblMonthLedger].[LedgMonth] ASC) [seq],
           [tblMonthLedger].[Recid],
           [tblMonthLedger].[ReferenceID],
           [tblMonthLedger].[ClientID],
           [tblMonthLedger].[LedgAmount],
           ISNULL([tblMonthLedger].[TransactionID], '') AS [TransactionID],
           CONVERT(VARCHAR(20), [tblMonthLedger].[LedgMonth], 107) AS [LedgMonth],
           '' AS [Remarks],
           --IIF(ISNULL(IsPaid, 0) = 1,
           --    'PAID',
           --    IIF(CONVERT(VARCHAR(20), LedgMonth, 107) = CONVERT(VARCHAR(20), GETDATE(), 107), 'FOR PAYMENT', 'PENDING')) As PaymentStatus,
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
           END AS [PaymentStatus]
    FROM [dbo].[tblMonthLedger]
    WHERE [tblMonthLedger].[ReferenceID] = @ReferenceID
          AND [tblMonthLedger].[ClientID] = @ClientID
    ORDER BY [seq] ASC;
END;
GO
