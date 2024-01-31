SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MovedOut]
    -- Add the parameters for the stored procedure here
    @ReferenceID VARCHAR(20) = NULL
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        DECLARE @Message_Code NVARCHAR(MAX);

        -- Insert statements for procedure here
        UPDATE
            [dbo].[tblUnitReference]
        SET
            [tblUnitReference].[IsUnitMoveOut] = 1,
            [tblUnitReference].[UnitMoveOutDate] = GETDATE()
        WHERE
            [tblUnitReference].[RefId] = @ReferenceID;
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
                        'SUCCESS',
                        'Result From : sp_MovedOut -(' + @ReferenceID
                        + ': IsUnitMoveOut= 1) tblUnitReference updated successfully'
                    );

                SET @Message_Code = N'SUCCESS';
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
                        'ERROR', 'Result From : sp_MovedOut -' + 'No rows affected in tblUnitReference table'
                    );

            END;

        UPDATE
            [dbo].[tblUnitMstr]
        SET
            [tblUnitMstr].[UnitStatus] = 'HOLD'
        WHERE
            [RecId] =
            (
                SELECT
                    [tblUnitReference].[UnitId]
                FROM
                    [dbo].[tblUnitReference]
                WHERE
                    [tblUnitReference].[RefId] = @ReferenceID
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
                        'SUCCESS', 'Result From : sp_MovedOut -(UnitStatus= HOLD) tblUnitMstr updated successfully'
                    );

                SET @Message_Code = N'SUCCESS';
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
                        'ERROR', 'Result From : sp_MovedOut -' + 'No rows affected in tblUnitMstr table'
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
                        'ERROR', 'From : sp_MovedOut -' + @ErrorMessage
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
                        'sp_MovedOut', @ErrorMessage, GETDATE()
                    );

                -- Return an error message
                SET @Message_Code = @ErrorMessage;
            END;

        SELECT
            @Message_Code AS [Message_Code];
    END;
GO
