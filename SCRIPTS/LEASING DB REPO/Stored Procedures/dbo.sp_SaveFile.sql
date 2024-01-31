SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_SaveFile]
    @FilePath         NVARCHAR(MAX),
    @FileData         VARBINARY(MAX),
    @ClientName       VARCHAR(100),
    @FileNames        VARCHAR(100),
    @Files            VARCHAR(200),
    @Notes            VARCHAR(500) = NULL,
    @ReferenceId      VARCHAR(500) = NULL,
    @IsSignedContract BIT          = 0
AS
    BEGIN
        INSERT INTO [dbo].[Files]
            (
                [ClientName],
                [FilePath],
                [FileData],
                [FileNames],
                [Notes],
                [Files],
                [RefId]
            )
        VALUES
            (
                @ClientName, @FilePath, @FileData, @FileNames, @Notes, @Files, @ReferenceId
            );

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
                        'SUCCESS', 'Result From : sp_SaveFile -(' + @FilePath + ') File saved successfully'
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
                        'ERROR', 'Result From : sp_SaveFile -' + 'No rows affected in Files table'
                    );

            END;
        -- Update the flag in tblUnitReference
        IF (@IsSignedContract = 1)
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
                                'Result From : sp_SaveFile -' + '(' + @ReferenceId
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
                                'ERROR', 'Result From : sp_SaveFile -' + 'No rows affected in UnitReference table'
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
                        'ERROR', 'From : sp_SaveFile -' + @ErrorMessage
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
                        'sp_SaveFile', @ErrorMessage, GETDATE()
                    );

                -- Return an error message
                SELECT
                    'ERROR'       AS [Message_Code],
                    @ErrorMessage AS [ErrorMessage];
            END;
    END;
GO
