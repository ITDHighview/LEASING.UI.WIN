USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetMonthLedgerByRefIdAndClientId]    Script Date: 11/9/2023 9:59:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetMonthLedgerByRefIdAndClientId]
			@ReferenceID INT ,
			@ClientID  VARCHAR(50) = NULL,
			@Advancemonths1  VARCHAR(50) = NULL,
			@Advancemonths2  VARCHAR(50) = NULL
		
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
Select 0 as seq,
       (
           SELECT SecDeposit
           FROM tblUnitReference WITH (NOLOCK)
           WHERE RecId = @ReferenceID
       ) as LedgAmount,
       CONVERT(VARCHAR(20), GETDATE(), 107) as LedgMonth,
       'FOR 3 MONTHS SECURITY DEPOSIT' as Remarks
UNION
SELECT ROW_NUMBER() OVER (ORDER BY LedgMonth ASC) seq,
       LedgAmount,
       CONVERT(VARCHAR(20), LedgMonth, 107) AS LedgMonth,
       IIF(LedgMonth IN( @Advancemonths1 , @Advancemonths2), 'FOR ADVANCE PAYMENT', 'FOR POST DATED CHECK') AS Remarks
FROM tblMonthLedger WITH (NOLOCK)
WHERE ReferenceID = @ReferenceID
      AND ClientID = @ClientID
order by seq ASC
	
END
