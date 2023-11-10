USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetClientID]    Script Date: 11/9/2023 9:57:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetClientID] 
@ClientID VARCHAR(50) = NULL
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

IF EXISTS(SELECT 1 FROM tblClientMstr WHERE ClientID = @ClientID)
	BEGIN
	  SELECT 
		ClientID,
		'' AS Message_Code
	 FROM tblClientMstr WITH(NOLOCK) WHERE ISNULL(ClientID,'') = @ClientID
	END
ELSE
	BEGIN

	  SELECT 
	   '' AS ClientID,
		'THIS ID IS NOT EXIST ' AS Message_Code
	END


END
