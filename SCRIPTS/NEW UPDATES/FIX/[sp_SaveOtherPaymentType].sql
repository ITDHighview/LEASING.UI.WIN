USE [LEASINGDB]
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_SaveOtherPaymentType]
    @OtherPaymentTypeName VARCHAR(150)   = NULL,
    @OtherPaymentVatPCT   DECIMAL(18, 2) = NULL,
    @OtherPaymentTaxPCT   DECIMAL(18, 2) = NULL,
    @EncodedBy            INT            = NULL,
    @ComputerName         VARCHAR(50)    = NULL
AS
    BEGIN TRY

        SET NOCOUNT ON;
        DECLARE @Message_Code VARCHAR(MAX) = '';
        DECLARE @ErrorMessage NVARCHAR(MAX) = N'';

        BEGIN TRANSACTION
        IF NOT EXISTS
            (
                SELECT
                    [tblOtherPaymentTypes].[OtherPaymentTypeName]
                FROM
                    [dbo].[tblOtherPaymentTypes]
                WHERE
                    [tblOtherPaymentTypes].[OtherPaymentTypeName] = @OtherPaymentTypeName
            )
            BEGIN
                INSERT INTO [dbo].[tblOtherPaymentTypes]
                    (
                        [OtherPaymentTypeName],
                        [OtherPaymentVatPCT],
                        [OtherPaymentTaxPCT],
                        [Remarks],
                        [EncodedBy],
                        [EncodedDate],
                        [ComputerName],
                        [IsActive]
                    )
                VALUES
                    (
                        UPPER(@OtherPaymentTypeName), -- OtherPaymentTypeName - varchar(100)
                        @OtherPaymentVatPCT,          -- OtherPaymentVatPCT - decimal(18, 2)
                        @OtherPaymentTaxPCT,          -- OtherPaymentTaxPCT - decimal(18, 2)
                        NULL,                         -- Remarks - varchar(500)
                        @EncodedBy,                   -- EncodedBy - int
                        GETDATE(),                    -- EncodedDate - datetime
                        @ComputerName,                -- ComputerName - varchar(50)
                        1                             -- IsActive - bit
                    )

                IF (@@ROWCOUNT > 0)
                    BEGIN
                        SET @Message_Code = 'SUCCESS'
                        SET @ErrorMessage = N''
                    END
            END
        ELSE
            BEGIN

                SET @Message_Code = 'THIS PAYMENT TYPE IS ALREADY EXISTST!'
                SET @ErrorMessage = N''

            END

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
                'sp_OtherPaymentType', @ErrorMessage, GETDATE()
            );

        SELECT
            @ErrorMessage AS [ErrorMessage],
            @Message_Code AS [Message_Code];
    END CATCH
GO

