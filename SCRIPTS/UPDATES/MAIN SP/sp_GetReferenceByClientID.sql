USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetReferenceByClientID]    Script Date: 11/9/2023 10:01:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetReferenceByClientID]
	-- Add the parameters for the stored procedure here
	@ClientID VARCHAR(50) = NULL
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
		RecId
		,RefId
		,ProjectId
		,InquiringClient
		,ClientMobile
		,UnitId
		,UnitNo
		,StatDate
		,FinishDate
		,TransactionDate
		,Rental
		,SecAndMaintenance
		,TotalRent
		,Advancemonths1
		,Advancemonths2
		,SecDeposit
		,Total
		,EncodedBy
		,EncodedDate
		,LastCHangedBy
		,LastChangedDate
		,IsActive
		,ComputerName
		,ClientID
		,Applicabledate1
		,Applicabledate2
		,IsPaid
		,IsDone
		,HeaderRefId
		,IsSignedContract
		,IsUnitMove
		,IIF( ISNULL(Advancemonths1,0)=0 and ISNULL(Advancemonths2,0)=0 and ISNULL(SecDeposit,0)=0,'TYPE OF PARKING','TYPE OF UNIT') AS TypeOf
FROM tblUnitReference WHERE ClientID = @ClientID and ISNULL(IsPaid,0)=1 and  ISNULL(IsTerminated,0)=0 and ISNULL(IsDone,0)=0
END
