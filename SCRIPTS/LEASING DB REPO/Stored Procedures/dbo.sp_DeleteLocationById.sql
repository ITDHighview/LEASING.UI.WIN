SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_DeleteLocationById] 
					@RecId INT
					
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	DELETE FROM tblLocationMstr WHERE RecId = @RecId

	if(@@ROWCOUNT > 0)
	BEGIN

	SELECT 'SUCCESS' AS Message_Code

	END
END
GO
