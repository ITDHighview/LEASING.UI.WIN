SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_HoldPDCPayment]
    @CompanyORNo       VARCHAR(30)  = NULL,
    @CompanyPRNo       VARCHAR(30)  = NULL,
    @BankAccountName   VARCHAR(30)  = NULL,
    @BankAccountNumber VARCHAR(30)  = NULL,
    @BankName          VARCHAR(30)  = NULL,
    @SerialNo          VARCHAR(30)  = NULL,
    @PaymentRemarks    VARCHAR(100) = NULL,
    @REF               VARCHAR(100) = NULL,
    @BankBranch        VARCHAR(100) = NULL,
    @ModeType          VARCHAR(20)  = NULL,
    @XML               XML
AS
    BEGIN TRY

        SET NOCOUNT ON;
        DECLARE @Message_Code VARCHAR(MAX) = '';
        DECLARE @ErrorMessage NVARCHAR(MAX) = N'';
        BEGIN TRANSACTION
        CREATE TABLE [#tblBulkPostdatedMonth]
            (
                [Recid] VARCHAR(10)
            )
        IF (@XML IS NOT NULL)
            BEGIN
                INSERT INTO [#tblBulkPostdatedMonth]
                    (
                        [Recid]
                    )
                            SELECT
                                [ParaValues].[data].[value]('c1[1]', 'VARCHAR(10)')
                            FROM
                                @XML.[nodes]('/Table1') AS [ParaValues]([data])
            END

        -- Insert statements for procedure here
        UPDATE
            [dbo].[tblMonthLedger]
        SET
            [tblMonthLedger].[IsHold] = 1,
            [tblMonthLedger].[CompanyORNo] = @CompanyORNo,
            [tblMonthLedger].[CompanyPRNo] = @CompanyPRNo,
            [tblMonthLedger].[REF] = @REF,
            [tblMonthLedger].[BNK_ACCT_NAME] = @BankAccountName,
            [tblMonthLedger].[BNK_ACCT_NUMBER] = @BankAccountNumber,
            [tblMonthLedger].[BNK_NAME] = @BankName,
            [tblMonthLedger].[SERIAL_NO] = @SerialNo,
            [tblMonthLedger].[ModeType] = @ModeType,
            [tblMonthLedger].[BankBranch] = @BankBranch
        WHERE
            [tblMonthLedger].[Recid] IN
                (
                    SELECT
                        [#tblBulkPostdatedMonth].[Recid]
                    FROM
                        [#tblBulkPostdatedMonth] WITH (NOLOCK)
                )


        IF (@@ROWCOUNT > 0)
            BEGIN
                SET @Message_Code = 'SUCCESS'
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
                'sp_HoldPDCPayment', @ErrorMessage, GETDATE()
            );

        SELECT
            @ErrorMessage AS [ErrorMessage],
            @Message_Code AS [Message_Code];
    END CATCH
    DROP TABLE [#tblBulkPostdatedMonth]
GO
