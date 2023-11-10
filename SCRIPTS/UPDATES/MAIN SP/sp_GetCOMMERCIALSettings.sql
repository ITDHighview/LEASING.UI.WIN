USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCOMMERCIALSettings]    Script Date: 11/9/2023 9:57:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetCOMMERCIALSettings] 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
		SELECT 
			ProjectType,
			ISNULL(GenVat,0) AS GenVat,
			ISNULL(SecurityAndMaintenance,0) AS SecurityAndMaintenance,
			--ISNULL(SecurityAndMaintenanceVat,0) AS SecurityAndMaintenanceVat,
			--ISNULL(IsSecAndMaintVat,0) AS IsSecAndMaintVat,
			ISNULL(WithHoldingTax,0) AS WithHoldingTax,
			EncodedBy,
			EncodedDate,
			ComputerName
		FROM tblRatesSettings WHERE ProjectType = 'COMMERCIAL'

END
