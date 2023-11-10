USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateUnitById]    Script Date: 11/9/2023 10:06:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_UpdateUnitById]
    @RecId INT,
    --@UnitDescription VARCHAR(300)= null,
    @FloorNo INT= null,
    @AreaSqm DECIMAL(18, 2)= null,
    @AreaRateSqm DECIMAL(18, 2)= null,
    @FloorType VARCHAR(50)= null,
    @BaseRental DECIMAL(18, 2)= null,
	--This will update during the generation of Transaction and set uisng the Rate settings table
    --@GenVat INT = null this ,
    --@SecurityAndMaintenance DECIMAL(18, 2)= null,
    --@SecurityAndMaintenanceVat INT = null,
    @UnitStatus VARCHAR(50)= null,
    @DetailsofProperty VARCHAR(300)= null,
    @UnitNo VARCHAR(20)= null,
    @UnitSequence INT= null,
    @LastChangedBy INT= null,
    --@IsActive BIT,
    @ComputerName VARCHAR(20)= null
    --@ClientID INT= null,
    --@Tenant VARCHAR(200)= null
AS
BEGIN
    UPDATE [dbo].[tblUnitMstr]
    SET
       
        --[UnitDescription] = @UnitDescription,
        [FloorNo] = @FloorNo,
        [AreaSqm] = @AreaSqm,
        [AreaRateSqm] = @AreaRateSqm,
        [FloorType] = @FloorType,
        [BaseRental] = @BaseRental,
        --[GenVat] = @GenVat,
        --[SecurityAndMaintenance] = @SecurityAndMaintenance,
        --[SecurityAndMaintenanceVat] = @SecurityAndMaintenanceVat,
        [UnitStatus] = @UnitStatus,
        [DetailsofProperty] = @DetailsofProperty,
        [UnitNo] = @UnitNo,
        [UnitSequence] = @UnitSequence,
        [LastChangedBy] = @LastChangedBy,
        [LastChangedDate] = GETDATE(),
        --[IsActive] = @IsActive,
        [ComputerName] = @ComputerName
        --[clientID] = @ClientID,
        --[Tennant] = @Tenant
    WHERE
        [RecId] = @RecId

		if(@@ROWCOUNT > 0)
		BEGIN
		SELECT 'SUCCESS' AS Message_Code
		END
END
