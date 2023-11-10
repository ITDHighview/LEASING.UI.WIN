USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateProjectById]    Script Date: 11/9/2023 10:05:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_UpdateProjectById] 
					@RecId INT,
					@ProjectType VARCHAR(50) = NULL,
					@LocId INT,
					@ProjectName VARCHAR(50) = NULL,
					@Descriptions VARCHAR(500) = NULL,
					--@IsActive bit = NULL,
					@ProjectAddress VARCHAR(500) = NULL
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	UPDATE tblProjectMstr 
	SET LocId = @LocId,
		Descriptions = @Descriptions,
		ProjectName = @ProjectName,
		ProjectType = @ProjectType,
		--IsActive = @IsActive ,
		ProjectAddress = @ProjectAddress 
	WHERE RecId = @RecId

	if(@@ROWCOUNT > 0)
	BEGIN

	SELECT 'SUCCESS' AS Message_Code

	END
END

