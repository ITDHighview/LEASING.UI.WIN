SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_DeleteFile] @FilePath NVARCHAR(500)
AS
    BEGIN
        DELETE FROM
        [dbo].[Files]
        WHERE
            [Files].[FilePath] = @FilePath;
        -- Log a success event    
        IF (@@ROWCOUNT > 0)
            BEGIN
                -- Log a success event
                INSERT INTO [dbo].[LoggingEvent]
                    (
                        [EventType],
                        [EventMessage]
                    )
                VALUES
                    (
                        'SUCCESS', 'Result From : sp_DeleteFile -(' + @FilePath + ') File deleted successfully'
                    );

                SELECT
                    'SUCCESS' AS [Message_Code];
            END;
        ELSE
            BEGIN


                -- Log an error event
                INSERT INTO [dbo].[LoggingEvent]
                    (
                        [EventType],
                        [EventMessage]
                    )
                VALUES
                    (
                        'ERROR', 'Result From : sp_DeleteFile -' + 'No rows affected in Files table'
                    );
            END;
        -- Log the error message
        DECLARE @ErrorMessage NVARCHAR(MAX);
        SET @ErrorMessage = ERROR_MESSAGE();


        IF @ErrorMessage <> ''
            BEGIN
                -- Log an error event
                INSERT INTO [dbo].[LoggingEvent]
                    (
                        [EventType],
                        [EventMessage]
                    )
                VALUES
                    (
                        'ERROR', 'From : sp_DeleteFile -' + @ErrorMessage
                    );

                -- Insert into a logging table
                INSERT INTO [dbo].[ErrorLog]
                    (
                        [ProcedureName],
                        [ErrorMessage],
                        [LogDateTime]
                    )
                VALUES
                    (
                        'sp_DeleteFile', 'From : sp_DeleteFile -' + @ErrorMessage, GETDATE()
                    );

                -- Return an error message
                SELECT
                    'ERROR'       AS [Message_Code],
                    @ErrorMessage AS [ErrorMessage];
            END;
    END;
GO
