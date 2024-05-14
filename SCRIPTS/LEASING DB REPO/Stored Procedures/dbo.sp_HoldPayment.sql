SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_HoldPayment]
    @ReferenceID VARCHAR(50) = NULL,
    @Recid       INT         = NULL
AS
    BEGIN TRY

        SET NOCOUNT ON;
        DECLARE @Message_Code VARCHAR(MAX) = '';
        DECLARE @ErrorMessage NVARCHAR(MAX) = N'';
        BEGIN TRANSACTION
        UPDATE
            [dbo].[tblMonthLedger]
        SET
            [tblMonthLedger].[IsHold] = 1
        WHERE
            [Recid] = @Recid
            AND [tblMonthLedger].[ReferenceID] =
                (
                    SELECT
                        [tblUnitReference].[RecId]
                    FROM
                        [dbo].[tblUnitReference]
                    WHERE
                        [tblUnitReference].[RefId] = @ReferenceID
                );

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
                'sp_HoldPayment', @ErrorMessage, GETDATE()
            );

        SELECT
            @ErrorMessage AS [ErrorMessage],
            @Message_Code AS [Message_Code];
    END CATCH
GO
