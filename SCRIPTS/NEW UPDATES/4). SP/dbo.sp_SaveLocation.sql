SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_SaveLocation]
    @Description VARCHAR(50)  = NULL,
    @LocAddress  VARCHAR(500) = NULL
AS
    BEGIN TRY

        SET NOCOUNT ON;
        DECLARE @Message_Code VARCHAR(MAX) = '';
        DECLARE @ErrorMessage NVARCHAR(MAX) = N'';
        BEGIN TRANSACTION
        INSERT INTO [dbo].[tblLocationMstr]
            (
                [Descriptions],
                [LocAddress],
                [IsActive]
            )
        VALUES
            (
                @Description, @LocAddress, 1
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
                'sp_SaveLocation', @ErrorMessage, GETDATE()
            );

        SELECT
            @ErrorMessage AS [ErrorMessage],
            @Message_Code AS [Message_Code];
    END CATCH
GO
