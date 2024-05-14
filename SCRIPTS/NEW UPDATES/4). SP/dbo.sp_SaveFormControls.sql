SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_SaveFormControls]
    @FormId             INT         = NULL,
    @MenuId             INT         = NULL,
    @ControlName        VARCHAR(50) = NULL,
    @ControlDescription VARCHAR(50) = NULL,
    @IsBackRoundControl BIT         = 0,
    @IsHeaderControl    BIT         = 0
AS
    BEGIN TRY

        SET NOCOUNT ON;
        DECLARE @Message_Code VARCHAR(MAX) = '';
        DECLARE @ErrorMessage NVARCHAR(MAX) = N'';
        BEGIN TRANSACTION
        IF NOT EXISTS
            (
                SELECT
                    [tblFormControlsMaster].[ControlName]
                FROM
                    [dbo].[tblFormControlsMaster] WITH (NOLOCK)
                WHERE
                    [tblFormControlsMaster].[ControlName] = @ControlName
                    AND [tblFormControlsMaster].[FormId] = @FormId
                    AND [tblFormControlsMaster].[MenuId] = @MenuId
            )
            BEGIN
                INSERT INTO [dbo].[tblFormControlsMaster]
                    (
                        [FormId],
                        [MenuId],
                        [ControlName],
                        [ControlDescription],
                        [IsBackRoundControl],
                        [IsHeaderControl],
                        [IsDelete]
                    )
                VALUES
                    (
                        @FormId, @MenuId, @ControlName, @ControlDescription, @IsBackRoundControl, @IsHeaderControl, 0
                    );
                IF (@@ROWCOUNT > 0)
                    BEGIN
                        SET @Message_Code = 'SUCCESS'
                        SET @ErrorMessage = N''
                    END;
            END;
        ELSE
            BEGIN
                SET @Message_Code = N'CONTROL NAME ALREADY EXISTS';
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
                'sp_SaveFormControls', @ErrorMessage, GETDATE()
            );

        SELECT
            @ErrorMessage AS [ErrorMessage],
            @Message_Code AS [Message_Code];
    END CATCH
GO
