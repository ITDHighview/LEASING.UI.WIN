USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUnitAvailableByProjectId]    Script Date: 11/9/2023 2:10:00 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC [sp_GetUnitAvailableByProjectId] @ProjectId = 1
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetParkingAvailableByProjectId] 
			@ProjectId INT 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  SELECT 
		RecId
		,ISNULL(UnitNo,'') AS UnitNo
  FROm tblUnitMstr WITH(NOLOCK)
  WHERE ProjectId = @ProjectId
  AND ISNULL(IsActive,0) = 1 and UnitStatus = 'VACANT' AND ISNULL(IsParking,0) = 1
  ORDER BY tblUnitMstr.UnitSequence DESC
END
