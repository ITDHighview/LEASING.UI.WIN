SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_SaveFloorType] @TypeName VARCHAR(50) = NULL
AS
    BEGIN TRY

        SET NOCOUNT ON;
        DECLARE @Message_Code VARCHAR(MAX) = '';
        DECLARE @ErrorMessage NVARCHAR(MAX) = N'';

        BEGIN TRANSACTION
        IF NOT EXISTS
            (
                SELECT
                    [tblFloorTypes].[FloorTypesDescription]
                FROM
                    [dbo].[tblFloorTypes]
                WHERE
                    [tblFloorTypes].[FloorTypesDescription] = @TypeName
            )
            BEGIN
                INSERT INTO [dbo].[tblFloorTypes]
                    (
                        [FloorTypesDescription]
                    )
                VALUES
                    (
                        UPPER(@TypeName)
                    );
                IF (@@ROWCOUNT > 0)
                    BEGIN
                        SET @Message_Code = 'SUCCESS'
                        SET @ErrorMessage = N''
                    END
            END
        ELSE
            BEGIN

                SET @Message_Code = 'THIS FLOOR TYPE IS ALREADY EXISTST!'
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
                'sp_SaveFloorType', @ErrorMessage, GETDATE()
            );

        SELECT
            @ErrorMessage AS [ErrorMessage],
            @Message_Code AS [Message_Code];
    END CATCH
GO

