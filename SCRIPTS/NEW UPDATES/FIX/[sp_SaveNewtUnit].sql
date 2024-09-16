SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_SaveNewtUnit]
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
    @IsNotRoundOff           BIT            = NULL,
    @IsNonTax                BIT            = NULL,
    @IsNonCusa               BIT            = NULL,
    @IsOverrideSecAndMain    BIT            = NULL,
    @EndodedBy               INT            = NULL,
    @ComputerName            VARCHAR(20)    = NULL
AS
    BEGIN TRY

        SET NOCOUNT ON;
        DECLARE @Message_Code VARCHAR(MAX) = '';
        DECLARE @ErrorMessage NVARCHAR(MAX) = N'';
        BEGIN TRANSACTION
        IF NOT EXISTS
            (
                SELECT
                    1
                FROM
                    [dbo].[tblUnitMstr]
                WHERE
                    [tblUnitMstr].[ProjectId] = @ProjectId
                    AND [tblUnitMstr].[UnitNo] = @UnitNo
                    AND [tblUnitMstr].[FloorType] = @FloorType
                    AND [tblUnitMstr].[IsParking] = @IsParking
            )
            BEGIN
                INSERT INTO [dbo].[tblUnitMstr]
                    (
                        [ProjectId],
                        [IsParking],
                        [FloorNo],
                        [AreaSqm],
                        [AreaRateSqm],
                        [AreaTotalAmount],
                        [FloorType],
                        [BaseRental],
                        [UnitStatus],
                        [DetailsofProperty],
                        [UnitNo],
                        [UnitSequence],
                        [EndodedBy],
                        [EndodedDate],
                        [IsActive],
                        [ComputerName],
                        [BaseRentalVatAmount],
                        [BaseRentalWithVatAmount],
                        [BaseRentalTax],
                        [IsNonVat],
                        [TotalRental],
                        [SecAndMainAmount],
                        [SecAndMainVatAmount],
                        [SecAndMainWithVatAmount],
                        [Vat],
                        [Tax],
                        [TaxAmount],
                        [IsNotRoundOff],
                        [IsNonTax],
                        [IsNonCusa],
                        [IsOverrideSecAndMain]
                    )
                VALUES
                    (
                        @ProjectId, @IsParking, @FloorNo, @AreaSqm, @AreaRateSqm, @AreaTotalAmount, @FloorType,
                        @BaseRental, 'VACANT', @DetailsofProperty, @UnitNo, @UnitSequence, @EndodedBy, GETDATE(), 1,
                        @ComputerName, @BaseRentalVatAmount, @BaseRentalWithVatAmount, @BaseRentalTax, @IsNonVat,
                        @TotalRental, @SecAndMainAmount, @SecAndMainVatAmount, @SecAndMainWithVatAmount, @Vat, @Tax,
                        @TaxAmount, @IsNotRoundOff, @IsNonTax, @IsNonCusa, @IsOverrideSecAndMain
                    );

                IF (@@ROWCOUNT > 0)
                    BEGIN
                        SET @Message_Code = 'SUCCESS'
                        SET @ErrorMessage = N''
                    END;
            END;
        ELSE
            BEGIN
                SET @Message_Code = 'UNIT NUMBER ALREADY TAKEN.';
                SET @ErrorMessage = N''
            END;


        SELECT
            @ErrorMessage AS [ErrorMessage],
            @Message_Code AS [Message_Code];


        COMMIT TRANSACTION

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        SET @Message_Code = 'ERROR'
        SET @ErrorMessage = ERROR_MESSAGE()

        INSERT INTO [dbo].[ErrorLog]
            (
                [ProcedureName],
                [ErrorMessage],
                [LogDateTime]
            )
        VALUES
            (
                'sp_SaveNewtUnit', @ErrorMessage, GETDATE()
            );

        SELECT
            @ErrorMessage AS [ErrorMessage],
            @Message_Code AS [Message_Code];
    END CATCH
GO

