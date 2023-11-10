USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveLocation]    Script Date: 11/9/2023 10:04:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_SaveLocation] 
	@Description varchar(50) = null,
	@LocAddress varchar(500) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO tblLocationMstr (Descriptions,LocAddress,IsActive)VALUES  (@Description,@LocAddress,1)

	if(@@ROWCOUNT > 0)
		BEGIN
			SELECT 'SUCCESS' AS Message_Code
		END
	ELSE
		BEGIN
			SELECT 'FAIL' AS Message_Code
		END
END
