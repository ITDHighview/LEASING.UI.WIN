USE [LEASINGDB]
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_SaveOtherPayment]
    @ClientID                 VARCHAR(150)   = NULL,
    @OtherPaymentTypeName     VARCHAR(150)   = NULL,
    @OtherPaymentAmount       DECIMAL(18, 2) = NULL,
    @OtherPaymentVatPCT       DECIMAL(18, 2) = NULL,
    @OtherPaymentVatAmount    DECIMAL(18, 2) = NULL,
    @OtherPaymentIsVatApplied BIT            = NULL,
    @OtherPaymentTaxPCT       DECIMAL(18, 2) = NULL,
    @OtherPaymentTaxAmount    DECIMAL(18, 2) = NULL,
    @OtherPaymentTaxIsApplied BIT            = NULL,
    @EncodedBy                INT            = NULL,
    @ComputerName             VARCHAR(50)    = NULL
AS
    BEGIN TRY

        SET NOCOUNT ON;
        DECLARE @Message_Code VARCHAR(MAX) = '';
        DECLARE @ErrorMessage NVARCHAR(MAX) = N'';


        DECLARE @TranRecId BIGINT = 0;
        DECLARE @TranID VARCHAR(150) = '';
        DECLARE @RcptRecId BIGINT = 0;
        DECLARE @RcptID VARCHAR(50) = '';

        BEGIN TRANSACTION

        BEGIN
            BEGIN
                INSERT INTO [dbo].[tblTransaction]
                    (
                        [OtherPaymentClientID],
                        [PaidAmount],
                        [ReceiveAmount],
                        [ActualAmountPaid],
                        [ChangeAmount], ---Not Assigned
                        [Remarks],
                        [EncodedBy],
                        [EncodedDate],
                        [ComputerName],
                        [IsActive]
                    )
                VALUES
                    (
                        @ClientID, @OtherPaymentAmount, @OtherPaymentAmount, @OtherPaymentAmount, NULL,
                        'OTHER PAYMENT', @EncodedBy, GETDATE(), @ComputerName, 1
                    );

                SET @TranRecId = @@IDENTITY;
                SELECT
                    @TranID = [tblTransaction].[TranID]
                FROM
                    [dbo].[tblTransaction]
                WHERE
                    [tblTransaction].[RecId] = @TranRecId;


            END

            INSERT INTO [dbo].[tblPayment]
                (
                    [TranId],
                    [Remarks],
                    [EncodedBy],
                    [EncodedDate],
                    [ComputerName],
                    [IsActive],
                    [Notes],
                    [ClientID],
                    [OtherPaymentTypeName],
                    [OtherPaymentAmount],
                    [OtherPaymentVatPCT],
                    [OtherPaymentVatAmount],
                    [OtherPaymentIsVatApplied],
                    [OtherPaymentTaxPCT],
                    [OtherPaymentTaxAmount],
                    [OtherPaymentTaxIsApplied]
                )
            VALUES
                (
                    @TranID,                                                  -- TranId - varchar(500)    
                    'OTHER PAYMENT',                                          -- Remarks - varchar(500)
                    @EncodedBy,                                               -- EncodedBy - int
                    GETDATE(),                                                -- EncodedDate - datetime      
                    @ComputerName,                                            -- ComputerName - varchar(50)
                    1,                                                        -- IsActive - bit      
                    CONCAT('OTHER PAYMENT - ', UPPER(@OtherPaymentTypeName)), -- Notes - varchar(200) 
                    @ClientID,                                                -- ClientID - varchar(500)
                    @OtherPaymentTypeName,                                    -- OtherPaymentTypeName - varchar(150)
                    @OtherPaymentAmount,                                      -- OtherPaymentAmount - decimal(18, 2)
                    @OtherPaymentVatPCT,                                      -- OtherPaymentVatPCT - decimal(18, 2)
                    @OtherPaymentVatAmount,                                   -- OtherPaymentVatAmount - decimal(18, 2)
                    @OtherPaymentIsVatApplied,                                -- OtherPaymentIsVatApplied - bit
                    @OtherPaymentTaxPCT,                                      -- OtherPaymentTaxPCT - decimal(18, 2)
                    @OtherPaymentTaxAmount,                                   -- OtherPaymentTaxAmount - decimal(18, 2)
                    @OtherPaymentTaxIsApplied                                 -- OtherPaymentTaxIsApplied - bit
                )

            INSERT INTO [dbo].[tblReceipt]
                (
                    [TranId],
                    [Amount],
                    [Description],
                    [EncodedBy],
                    [EncodedDate],
                    [ComputerName],
                    [IsActive]
                )
            VALUES
                (
                    @TranID, @OtherPaymentAmount, CONCAT('OTHER PAYMENT - ', UPPER(@OtherPaymentTypeName)), @EncodedBy,
                    GETDATE(), @ComputerName, 1
                )

            SET @RcptRecId = @@IDENTITY;
            SELECT
                @RcptID = [tblReceipt].[RcptID]
            FROM
                [dbo].[tblReceipt] WITH (NOLOCK)
            WHERE
                [tblReceipt].[RecId] = @RcptRecId;
            IF (@@ROWCOUNT > 0)
                BEGIN
                    SET @Message_Code = 'SUCCESS'
                    SET @ErrorMessage = N''
                END
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
                'sp_SaveOtherPayment', @ErrorMessage, GETDATE()
            );

        SELECT
            @ErrorMessage AS [ErrorMessage],
            @Message_Code AS [Message_Code],
            @RcptID       AS [ReceiptID],
            @TranID       AS [TranID]
    END CATCH
GO

