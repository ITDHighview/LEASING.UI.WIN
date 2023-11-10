USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetLocationList]    Script Date: 11/9/2023 9:59:34 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetLocationList] 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  SELECT RecId,Descriptions,LocAddress,IIF(ISNULL(IsActive,0) = 1,'ACTIVE','IN-ACTIVE') AS IsActive  FROM tblLocationMstr WHERE ISNULL(IsActive,0) = 1
END
