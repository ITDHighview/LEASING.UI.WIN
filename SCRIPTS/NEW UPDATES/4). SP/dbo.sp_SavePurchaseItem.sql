SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_SavePurchaseItem]
    @ProjectId    INT            = NULL,
    @Descriptions VARCHAR(200)   = NULL,
    @DatePurchase DATETIME       = NULL,
    @UnitAmount   INT            = NULL,
    @Amount       DECIMAL(18, 2) = NULL,
    @TotalAmount  DECIMAL(18, 2) = NULL,
    @Remarks      VARCHAR(200)   = NULL,
    @UnitNumber   VARCHAR(50)    = NULL,
    @UnitID       INT            = NULL,
    @EncodedBy    INT            = NULL,
    @ComputerName VARCHAR(50)    = NULL
AS
    BEGIN TRY

        SET NOCOUNT ON;
        DECLARE @Message_Code VARCHAR(MAX) = '';
        DECLARE @ErrorMessage NVARCHAR(MAX) = N'';
        BEGIN TRANSACTION

        IF NOT EXISTS
            (
                SELECT
                    *
                FROM
                    [dbo].[tblProjPurchItem]
                WHERE
                    [tblProjPurchItem].[Descriptions] = @Descriptions
                    AND [tblProjPurchItem].[ProjectId] = @ProjectId
            )
            BEGIN
                INSERT INTO [dbo].[tblProjPurchItem]
                    (
                        [ProjectId],
                        [Descriptions],
                        [DatePurchase],
                        [UnitAmount],
                        [Amount],
                        [TotalAmount],
                        [Remarks],
                        [UnitNumber],
                        [UnitID],
                        [EncodedBy],
                        [EncodedDate],
                        [ComputerName],
                        [IsActive]
                    )
                VALUES
                    (
                        @ProjectId, @Descriptions, @DatePurchase, @UnitAmount, @Amount, @TotalAmount, @Remarks,
                        @UnitNumber, @UnitID, @EncodedBy, GETDATE(), @ComputerName, 1
                    );

                IF (@@ROWCOUNT > 0)
                    BEGIN

                        SET @Message_Code = 'SUCCESS'
                        SET @ErrorMessage = N''
                    END;
            END;
        ELSE
            BEGIN

                SET @Message_Code = 'PROJECT NAME ALREADY EXISTS'
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
                'sp_SavePurchaseItem', @ErrorMessage, GETDATE()
            );

        SELECT
            @ErrorMessage AS [ErrorMessage],
            @Message_Code AS [Message_Code];
    END CATCH
GO
