USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetLedgerList]    Script Date: 11/9/2023 9:59:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetLedgerList]	
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
	SELECT ROW_NUMBER() OVER (ORDER BY LedgMonth ASC) seq,
       Recid,
       ReferenceID,
       ClientID,
       LedgAmount,
       CONVERT(VARCHAR(20), LedgMonth, 107) AS LedgMonth,
       '' AS Remarks,
       --IIF(ISNULL(IsPaid, 0) = 1,
       --    'PAID',
       --    IIF(CONVERT(VARCHAR(20), LedgMonth, 107) = CONVERT(VARCHAR(20), GETDATE(), 107), 'FOR PAYMENT', 'PENDING')) As PaymentStatus,
       case
           when ISNULL(IsPaid, 0) = 1 and ISNULL(IsHold, 0) = 0 then
               'PAID'
           when ISNULL(IsPaid, 0) = 0 and ISNULL(IsHold, 0) = 1 then
               'HOLD'
           when CONVERT(VARCHAR(20), LedgMonth, 107) = CONVERT(VARCHAR(20), GETDATE(), 107) then
               'FOR PAYMENT'
           else
               'PENDING'
       end as PaymentStatus
FROM tblMonthLedger
WHERE ReferenceID = @ReferenceID
      AND ClientID = @ClientID
order by seq ASC
END
