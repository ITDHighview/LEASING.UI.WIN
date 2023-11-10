USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetProjectById]    Script Date: 11/9/2023 10:00:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetProjectById] 
					@RecId INT
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  SELECT 
  tblProjectMstr.RecId,
  tblProjectMstr.ProjectType,
  tblProjectMstr.ProjectName,
  tblProjectMstr.Descriptions,
  tblProjectMstr.ProjectAddress,
  ISNULL(tblProjectMstr.IsActive,0) AS IsActive ,
  tblLocationMstr.Descriptions AS LocationName,
  tblLocationMstr.RecId AS LocationId
  FROM tblProjectMstr 
  INNER JOIN tblLocationMstr
  ON tblLocationMstr.RecId = tblProjectMstr.LocId
  WHERE tblProjectMstr.RecId = @RecId
END

SELECT * FROm tblProjectMstr