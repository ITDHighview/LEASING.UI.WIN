USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetInActiveProjectList]    Script Date: 11/9/2023 9:58:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetInActiveProjectList]
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT tblProjectMstr.RecId,
	tblProjectMstr.LocId,
	tblProjectMstr.ProjectAddress,
	tblLocationMstr.Descriptions AS LocationName,
	tblProjectMstr.ProjectName,
	tblProjectMstr.Descriptions,
	IIF(ISNULL(tblProjectMstr.IsActive,0) = 1,'ACTIVE','IN-ACTIVE') AS IsActive 
	FROM tblProjectMstr WITh(NOLOCK)
	INNER JOIN tblLocationMstr WITh(NOLOCK)
	ON tblLocationMstr.RecId = tblProjectMstr.LocId
	WHERE ISNULL(tblProjectMstr.IsActive,0) = 0
	
END
