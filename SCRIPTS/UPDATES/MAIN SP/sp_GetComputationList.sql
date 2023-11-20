USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetComputationList]    Script Date: 11/9/2023 9:58:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- UNION THE SELECT OF PARKING LIST LATER ON
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetComputationList] 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  SELECT 
	 tblUnitReference.RecId,
	tblUnitReference.RefId,
	tblUnitReference.ProjectId,
	ISNULL(tblProjectMstr.ProjectName,'') AS ProjectName,
	ISNULL(tblProjectMstr.ProjectAddress,'') AS ProjectAddress,
	ISNULL(tblProjectMstr.ProjectType,'') AS ProjectType,
	ISNULL(tblUnitReference.InquiringClient,'') AS InquiringClient,
	ISNULL(tblUnitReference.ClientID,'') AS ClientID,
	ISNULL(tblUnitReference.ClientMobile,'')  AS ClientMobile,
	tblUnitReference.UnitId,
	ISNULL(tblUnitReference.UnitNo,'') AS UnitNo,
	ISNULL(tblUnitMstr.FloorType,'') AS FloorType,
	ISNULL(CONVERT(VARCHAR(20),tblUnitReference.StatDate,107),'')  AS StatDate,
	ISNULL(CONVERT(VARCHAR(20),tblUnitReference.FinishDate,107),'') AS  FinishDate,
	ISNULL(CONVERT(VARCHAR(20),tblUnitReference.TransactionDate,107),'') AS  TransactionDate,
	CAST(ISNULL(tblUnitReference.Rental,0) AS DECIMAL(10,2)) AS Rental,
	CAST(ISNULL(tblUnitReference.SecAndMaintenance,0) AS DECIMAL(10,2)) AS SecAndMaintenance ,
	CAST(ISNULL(tblUnitReference.TotalRent,0) AS DECIMAL(10,2)) AS TotalRent,
	CAST(ISNULL(tblUnitReference.AdvancePaymentAmount,0) AS DECIMAL(10,2)) AS AdvancePaymentAmount,
	CAST(ISNULL(tblUnitReference.SecDeposit,0) AS DECIMAL(10,2)) AS SecDeposit,
	CAST(ISNULL(tblUnitReference.Total,0) AS DECIMAL(10,2)) AS Total,
	tblUnitReference.EncodedBy,
	tblUnitReference.EncodedDate,
	tblUnitReference.IsActive,
	tblUnitReference.ComputerName,
	IIF(ISNULL(tblUnitMstr.IsParking,0)=1,'TYPE OF PARKING','TYPE OF UNIT') as TypeOf
  FROm tblUnitReference  WITH(NOLOCK)
  INNER JOIN tblProjectMstr  WITH(NOLOCK)
  ON tblUnitReference.ProjectId = tblProjectMstr.RecId
  INNER JOIN tblUnitMstr  WITH(NOLOCK)
  ON tblUnitMstr.RecId = tblUnitReference.UnitId
  WHERE ISNULL(tblUnitReference.IsPaid,0) = 0
END
