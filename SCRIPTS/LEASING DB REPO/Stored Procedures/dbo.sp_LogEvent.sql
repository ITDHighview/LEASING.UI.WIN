SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_LogEvent]
    @EventType    VARCHAR(150)  = NULL,
    @EventMessage NVARCHAR(MAX) = NULL,
    @UserId       INT           = NULL,
    @ComputerName NVARCHAR(150) = NULL
AS
    BEGIN
        INSERT INTO [dbo].[LoggingEvent]
            (
                [EventDateTime],
                [EventType],
                [EventMessage],
                [UserId],
                [ComputerName]
            )
        VALUES
            (
                GETDATE(),     -- EventDateTime - datetime
                @EventType,    -- EventType - nvarchar(500)
                @EventMessage, -- EventMessage - nvarchar(max),
                @UserId,       -- UserId - int
                @ComputerName  -- ComputerName nvarchar(150)
            )
    END;


GO
