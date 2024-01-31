SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_getControlPermission_Debug] 
@GroupId INT =NULL
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
		tblForm.FormName,
		tblFormControlsMaster.ControlName AS ControlName,
		ISNULL(tblGroupFormControls.IsVisible,0) AS Permission  
	FROM tblGroupFormControls
		INNER JOIN tblFormControlsMaster
			ON tblGroupFormControls.ControlId = tblFormControlsMaster.ControlId
		INNER JOIN tblForm
			ON tblFormControlsMaster.FormId = tblForm.FormId 
	WHERE ISNULL(tblFormControlsMaster.IsBackRoundControl,0)=0
	AND tblGroupFormControls.GroupId = @GroupId
END
GO
