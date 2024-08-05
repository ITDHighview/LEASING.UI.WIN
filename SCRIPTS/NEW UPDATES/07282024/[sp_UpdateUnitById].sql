SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_UpdateUnitById]
    @RecId                   INT,
    @ProjectId               INT            = NULL,
    @IsParking               BIT            = NULL,
    @FloorNo                 INT            = NULL,
    @AreaSqm                 DECIMAL(18, 2) = NULL,
    @AreaRateSqm             DECIMAL(18, 2) = NULL,
    @AreaTotalAmount         DECIMAL(18, 2) = NULL,
    @FloorType               VARCHAR(50)    = NULL,
    @BaseRental              DECIMAL(18, 2) = NULL,
    @DetailsofProperty       VARCHAR(300)   = NULL,
    @UnitNo                  VARCHAR(20)    = NULL,
    @UnitSequence            INT            = NULL,
    @BaseRentalVatAmount     DECIMAL(18, 2) = NULL,
    @BaseRentalWithVatAmount DECIMAL(18, 2) = NULL,
    @BaseRentalTax           DECIMAL(18, 2) = NULL,
    @IsNonVat                BIT            = NULL,
    @TotalRental             DECIMAL(18, 2) = NULL,
    @SecAndMainAmount        DECIMAL(18, 2) = NULL,
    @SecAndMainVatAmount     DECIMAL(18, 2) = NULL,
    @SecAndMainWithVatAmount DECIMAL(18, 2) = NULL,
    @Vat                     DECIMAL(18, 2) = NULL,
    @Tax                     DECIMAL(18, 2) = NULL,
    @TaxAmount               DECIMAL(18, 2) = NULL,
    @LastChangedBy           INT            = NULL,
    @ComputerName            VARCHAR(20)    = NULL,
    @UnitStatus              VARCHAR(300)   = NULL,
    @IsNotRoundOff           BIT            = NULL,
    @IsNonTax                BIT            = NULL,
    @IsNonCusa               BIT            = NULL,
    @IsOverrideSecAndMain    BIT            = NULL
AS
    BEGIN
        DECLARE @Message_Code VARCHAR(100) = '';

        INSERT INTO [dbo].[tblPrevLogUnitMstr]
            (
                [RecId],
                [ProjectId],
                [UnitDescription],
                [FloorNo],
                [AreaSqm],
                [AreaRateSqm],
                [FloorType],
                [BaseRental],
                [GenVat],
                [SecurityAndMaintenance],
                [SecurityAndMaintenanceVat],
                [UnitStatus],
                [DetailsofProperty],
                [UnitNo],
                [UnitSequence],
                [LogBy],
                [LogDate],
                [ComputerName],
                [clientID],
                [Tennant],
                [IsParking],
                [IsNonVat],
                [BaseRentalVatAmount],
                [BaseRentalWithVatAmount],
                [BaseRentalTax],
                [TotalRental],
                [SecAndMainAmount],
                [SecAndMainVatAmount],
                [SecAndMainWithVatAmount],
                [Vat],
                [Tax],
                [TaxAmount],
                [AreaTotalAmount],
                [IsNotRoundOff],
                [IsNonTax],
                [IsNonCusa],
                [IsOverrideSecAndMain]
            )
                    SELECT
                        [tblUnitMstr].[RecId],
                        [tblUnitMstr].[ProjectId],
                        [tblUnitMstr].[UnitDescription],
                        [tblUnitMstr].[FloorNo],
                        [tblUnitMstr].[AreaSqm],
                        [tblUnitMstr].[AreaRateSqm],
                        [tblUnitMstr].[FloorType],
                        [tblUnitMstr].[BaseRental],
                        [tblUnitMstr].[GenVat],
                        [tblUnitMstr].[SecurityAndMaintenance],
                        [tblUnitMstr].[SecurityAndMaintenanceVat],
                        [tblUnitMstr].[UnitStatus],
                        [tblUnitMstr].[DetailsofProperty],
                        [tblUnitMstr].[UnitNo],
                        [tblUnitMstr].[UnitSequence],
                        @LastChangedBy,
                        GETDATE(),
                        @ComputerName,
                        [tblUnitMstr].[clientID],
                        [tblUnitMstr].[Tennant],
                        [tblUnitMstr].[IsParking],
                        [tblUnitMstr].[IsNonVat],
                        [tblUnitMstr].[BaseRentalVatAmount],
                        [tblUnitMstr].[BaseRentalWithVatAmount],
                        [tblUnitMstr].[BaseRentalTax],
                        [tblUnitMstr].[TotalRental],
                        [tblUnitMstr].[SecAndMainAmount],
                        [tblUnitMstr].[SecAndMainVatAmount],
                        [tblUnitMstr].[SecAndMainWithVatAmount],
                        [tblUnitMstr].[Vat],
                        [tblUnitMstr].[Tax],
                        [tblUnitMstr].[TaxAmount],
                        [tblUnitMstr].[AreaTotalAmount],
                        [tblUnitMstr].[IsNotRoundOff],
                        [tblUnitMstr].[IsNonTax],
                        [tblUnitMstr].[IsNonCusa],
                        [tblUnitMstr].[IsOverrideSecAndMain]
                    FROM
                        [dbo].[tblUnitMstr]
                    WHERE
                        [tblUnitMstr].[RecId] = @RecId


        UPDATE
            [dbo].[tblUnitMstr]
        SET
            [tblUnitMstr].[ProjectId] = @ProjectId,
            [tblUnitMstr].[IsParking] = @IsParking,
            [tblUnitMstr].[FloorNo] = @FloorNo,
            [tblUnitMstr].[AreaSqm] = @AreaSqm,
            [tblUnitMstr].[AreaRateSqm] = @AreaRateSqm,
            [tblUnitMstr].[AreaTotalAmount] = @AreaTotalAmount,
            [tblUnitMstr].[FloorType] = @FloorType,
            [tblUnitMstr].[BaseRental] = @BaseRental,
            [tblUnitMstr].[DetailsofProperty] = @DetailsofProperty,
            [tblUnitMstr].[UnitNo] = @UnitNo,
            [tblUnitMstr].[UnitSequence] = @UnitSequence,
            [tblUnitMstr].[BaseRentalVatAmount] = @BaseRentalVatAmount,
            [tblUnitMstr].[BaseRentalWithVatAmount] = @BaseRentalWithVatAmount,
            [tblUnitMstr].[BaseRentalTax] = @BaseRentalTax,
            [tblUnitMstr].[IsNonVat] = @IsNonVat,
            [tblUnitMstr].[TotalRental] = @TotalRental,
            [tblUnitMstr].[SecAndMainAmount] = @SecAndMainAmount,
            [tblUnitMstr].[SecAndMainVatAmount] = @SecAndMainVatAmount,
            [tblUnitMstr].[SecAndMainWithVatAmount] = @SecAndMainWithVatAmount,
            [tblUnitMstr].[Vat] = @Vat,
            [tblUnitMstr].[Tax] = @Tax,
            [tblUnitMstr].[TaxAmount] = @TaxAmount,
            [tblUnitMstr].[LastChangedBy] = @LastChangedBy,
            [tblUnitMstr].[LastChangedDate] = GETDATE(),
            [tblUnitMstr].[ComputerName] = @ComputerName,
            [tblUnitMstr].[UnitStatus] = @UnitStatus,
            [tblUnitMstr].[IsNotRoundOff] = @IsNotRoundOff,
            [tblUnitMstr].[IsNonTax] = @IsNonTax,
            [tblUnitMstr].[IsNonCusa] = @IsNonCusa,
            [tblUnitMstr].[IsOverrideSecAndMain] = @IsOverrideSecAndMain
        WHERE
            [tblUnitMstr].[RecId] = @RecId
            AND
                (
                    [tblUnitMstr].[UnitStatus] = 'VACANT'
                    OR [tblUnitMstr].[UnitStatus] = 'DISABLED'
                )

        IF (@@ROWCOUNT > 0)
            BEGIN
                SET @Message_Code = 'SUCCESS';
            END
        ELSE
            BEGIN
                SET @Message_Code = 'THIS UNIT CURRENTLY OPEN IN CONTRACT, MODIFICATION IS NOT PERMITTED';
            END
        SELECT
            @Message_Code AS [Message_Code];
    END
GO

