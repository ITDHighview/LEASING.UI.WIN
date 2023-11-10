USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_ProjectAddress]    Script Date: 11/9/2023 10:03:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_ProjectAddress]
     @projectId INT
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
		

	select ProjectAddress,ProjectType FROM tblProjectMstr

	WHERE ISNULL(IsActive,0) = 1 and RecId = @projectId
END
