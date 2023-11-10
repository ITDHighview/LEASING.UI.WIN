USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetSelecClient]    Script Date: 11/9/2023 10:02:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetSelecClient] 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 SELECT -1 AS RecId ,'--SELECT--' AS ClientName
	UNION
  SELECT 
	RecId,
    ISNULL(ClientName,'') AS ClientName
 FROM tblClientMstr WITH(NOLOCK) WHERE ISNULL(IsMap,0) = 0
END
