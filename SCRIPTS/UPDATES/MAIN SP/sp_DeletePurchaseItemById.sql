USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_DeletePurchaseItemById]    Script Date: 11/9/2023 9:55:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_DeletePurchaseItemById] 
					@RecId INT
					
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	DELETE FROM tblProjPurchItem WHERE RecId = @RecId

	if(@@ROWCOUNT > 0)
	BEGIN

	SELECT 'SUCCESS' AS Message_Code

	END
END
