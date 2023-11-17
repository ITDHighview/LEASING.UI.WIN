USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateWAREHOUSESettings]    Script Date: 11/9/2023 10:06:23 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_UpdateWAREHOUSESettings] 
				@GenVat DECIMAL(18,2) = NULL,
				@SecurityAndMaintenance DECIMAL(18,2) = NULL,
				@SecurityAndMaintenanceVat INT = 0,
				@IsSecAndMaintVat BIT = 0,
				@WithHoldingTax DECIMAL(18,2) = NULL
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	UPDATE tblRatesSettings 
	SET GenVat = @GenVat,
	SecurityAndMaintenance = @SecurityAndMaintenance,
	--SecurityAndMaintenanceVat = @SecurityAndMaintenanceVat,
	--IsSecAndMaintVat = @IsSecAndMaintVat ,
	WithHoldingTax = @WithHoldingTax
	WHERE ProjectType = 'WAREHOUSE'

	IF(@@ROWCOUNT > 0)
	BEGIN
		SELECT 'SUCCESS' AS Message_Code
	END
    -- Insert statements for procedure here
		--SELECT 
		--	ProjectType,
		--	ISNULL(GenVat,0) AS GenVat,
		--	ISNULL(SecurityAndMaintenance,0) AS SecurityAndMaintenance,
		--	ISNULL(SecurityAndMaintenanceVat,0) AS SecurityAndMaintenanceVat,
		--	ISNULL(IsSecAndMaintVat,0) AS IsSecAndMaintVat,
		--	ISNULL(WithHoldingTax,0) AS WithHoldingTax,
		--	EncodedBy,
		--	EncodedDate,
		--	ComputerName
		--FROM tblRatesSettings WHERE ProjectType = 'RESIDENTIAL'

END
