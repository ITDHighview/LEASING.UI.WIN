USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetPaymentListByReferenceId]    Script Date: 11/9/2023 10:00:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetPaymentListByReferenceId]
	-- Add the parameters for the stored procedure here
	@RefId VARCHAR(50) = NULL 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
RecId
,PayID
,TranId
,Amount
,ISNULL(CONVERT(VARCHAR(20),ForMonth,107),'') AS ForMonth
,Remarks
,EncodedBy
,ISNULL(CONVERT(VARCHAR(20),EncodedDate,107),'') AS DatePayed
,LastChangedBy
,LastChangedDate
,ComputerName
,IsActive
,RefId
FROm tblPayment WHERE RefId = @RefId
END
