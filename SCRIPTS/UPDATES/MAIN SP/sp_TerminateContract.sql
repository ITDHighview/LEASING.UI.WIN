-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_TerminateContract]
    @ReferenceID  VARCHAR(50) = NULL,
    @EncodedBy    INT         = NULL,
    @ComputerName VARCHAR(20) = NULL
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
            [tblUnitReference].[IsTerminated] = 1,
            [tblUnitReference].[IsUnitMoveOut] = 1,
            [tblUnitReference].[LastCHangedBy] = @EncodedBy,
            [tblUnitReference].[UnitMoveOutDate] = GETDATE(),
            [tblUnitReference].[TerminationDate] = GETDATE()
        WHERE
            [tblUnitReference].[RefId] = @ReferenceID;

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
                        'Result From : sp_TerminateContract -(' + @ReferenceID
                        + ': IsTerminated= 1,IsDone=1) tblUnitReference updated successfully'
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
                        'ERROR', 'Result From : sp_TerminateContract -' + 'No rows affected in tblUnitReference table'
                    );

            END;

        UPDATE
            [dbo].[tblUnitMstr]
        SET
            [tblUnitMstr].[UnitStatus] = 'HOLD'
        --LastCHangedBy = @EncodedBy,
        --ComputerName = @ComputerName,
        --LastChangedDate = GETDATE()
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
                        'Result From : sp_TerminateContract -(UnitStatus= HOLD) tblUnitMstr updated successfully'
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
                        'ERROR', 'Result From : sp_TerminateContract -' + 'No rows affected in tblUnitMstr table'
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
                        'ERROR', 'From : sp_TerminateContract -' + @ErrorMessage
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
                        'sp_TerminateContract', @ErrorMessage, GETDATE()
                    );

                -- Return an error message				
                SET @Message_Code = @ErrorMessage;
            END;

        SELECT
            @Message_Code AS [Message_Code];

    END;
GO
