USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_ActivatePojectById]    Script Date: 11/9/2023 9:53:30 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_ActivatePojectById] 
					@RecId INT
					
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	--DELETE FROM tblProjectMstr WHERE RecId = @RecId


	UPDATE tblProjectMstr SEt IsActive = 1 WHERE RecId = @RecId

	if(@@ROWCOUNT > 0)
	BEGIN

	SELECT 'SUCCESS' AS Message_Code

	END
END
