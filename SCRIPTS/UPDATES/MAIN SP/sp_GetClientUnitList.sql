USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetClientUnitList]    Script Date: 11/9/2023 9:57:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetClientUnitList]
	-- Add the parameters for the stored procedure here
	@ClientID VARCHAR(50) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
tblUnitReference.RecId,
tblUnitReference.UnitNo,
ISNULL(tblProjectMstr.ProjectName,'') +'-'+ ISNULL(tblProjectMstr.ProjectType,'') as ProjectName,
ISNULL(tblUnitMstr.DetailsofProperty,'N/A') +  ' - Type (' + ISNULL(tblUnitMstr.FloorType,'N/A') + ')' AS DetailsofProperty,
IIF(ISNULL(tblUnitMstr.IsParking,0)=1,'TYPE OF PARKING','TYPE OF UNIT') AS TypeOf
FROm tblUnitReference WITH(NOLOCK)
INNER JOIN tblUnitMstr WITH(NOLOCK)
ON tblUnitReference.UnitId = tblUnitMstr.RecId
INNER JOIN tblProjectMstr 
ON tblUnitReference.ProjectId = tblProjectMstr.RecId
	
	WHERE tblUnitReference.ClientID = @ClientID
END
