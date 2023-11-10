USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetLocationById]    Script Date: 11/9/2023 9:59:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetLocationById] 
					@RecId INT
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  SELECT RecId,Descriptions,LocAddress,ISNULL(IsActive,0) AS IsActive  FROM tblLocationMstr WHERE RecId = @RecId AND ISNULL(IsActive,0) = 1
END
