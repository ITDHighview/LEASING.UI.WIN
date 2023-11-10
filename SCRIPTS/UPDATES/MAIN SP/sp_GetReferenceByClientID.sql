USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetReferenceByClientID]    Script Date: 11/9/2023 10:01:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetReferenceByClientID]
	-- Add the parameters for the stored procedure here
	@ClientID VARCHAR(50) = NULL
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM tblUnitReference WHERE ClientID = @ClientID
END
