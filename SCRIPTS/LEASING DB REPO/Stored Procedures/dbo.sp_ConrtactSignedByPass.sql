SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_ConrtactSignedByPass]
    @ReferenceId      VARCHAR(500) = NULL
   
AS
    BEGIN                 
        -- Update the flag in tblUnitReference
        
            BEGIN
                UPDATE
                    [dbo].[tblUnitReference]
                SET
                    [tblUnitReference].[IsSignedContract] = 1,
                    [tblUnitReference].[SignedContractDate] = GETDATE()
                WHERE
                    [tblUnitReference].[RefId] = @ReferenceId;

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
                                'SUCCESS',
                                'Result From : sp_ConrtactSignedByPass -' + '(' + @ReferenceId
                                + ': IsSignedContract = 1 ) UnitReference updated successfully'
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
                                'ERROR', 'Result From : sp_ConrtactSignedByPass -' + 'No rows affected in UnitReference table'
                            );
                    END;
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
                        'ERROR', 'From : sp_ConrtactSignedByPass -' + @ErrorMessage
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
                        'sp_ConrtactSignedByPass', @ErrorMessage, GETDATE()
                    );

                -- Return an error message
                SELECT
                    'ERROR'       AS [Message_Code],
                    @ErrorMessage AS [ErrorMessage];
            END;
    END;
GO
