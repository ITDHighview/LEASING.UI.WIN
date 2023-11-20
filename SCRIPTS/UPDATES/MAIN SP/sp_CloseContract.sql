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
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE sp_CloseContract
    @ReferenceID VARCHAR(50) = null,
    @EncodedBy INT = NULL,
    @ComputerName VARCHAR(20) = null
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

	DECLARE @Message_Code NVARCHAR(MAX);

    -- Insert statements for procedure here
    update tblUnitReference
    set IsDone = 1,
        LastCHangedBy = @EncodedBy,       
        ContactDoneDate = GETDATE()
       
    where RefId = @ReferenceID

	 IF (@@ROWCOUNT > 0)
    BEGIN
        -- Log a success event
        INSERT INTO LoggingEvent
        (
            EventType,
            EventMessage
        )
        VALUES
        ('SUCCESS',
         'Result From : sp_CloseContract -(' + @ReferenceID
         + ': IsDone=1) tblUnitReference updated successfully'
        );

        SET @Message_Code = 'SUCCESS'
    END
    ELSE
    BEGIN
        -- Log an error event
        INSERT INTO LoggingEvent
        (
            EventType,
            EventMessage
        )
        VALUES
        ('ERROR', 'Result From : sp_CloseContract -' + 'No rows affected in tblUnitReference table');

    END

    update tblUnitMstr
    set UnitStatus = 'HOLD'
        --LastChangedBy = @EncodedBy,
        --ComputerName = @ComputerName,
        --LastChangedDate = GETDATE()
    where RecId =
    (
        select UnitId from tblUnitReference WITH(NOLOCK) where RefId = @ReferenceID
    )
      IF (@@ROWCOUNT > 0)
    BEGIN
        -- Log a success event
        INSERT INTO LoggingEvent
        (
            EventType,
            EventMessage
        )
        VALUES
        ('SUCCESS', 'Result From : sp_CloseContract -(UnitStatus= HOLD) tblUnitMstr updated successfully');

        SET @Message_Code = 'SUCCESS'
    END
    ELSE
    BEGIN
        -- Log an error event
        INSERT INTO LoggingEvent
        (
            EventType,
            EventMessage
        )
        VALUES
        ('ERROR', 'Result From : sp_CloseContract -' + 'No rows affected in tblUnitMstr table');

    END
    -- Log the error message
    DECLARE @ErrorMessage NVARCHAR(MAX);
    SET @ErrorMessage = ERROR_MESSAGE();

    if @ErrorMessage <> ''
    begin
        -- Log an error event
        INSERT INTO LoggingEvent
        (
            EventType,
            EventMessage
        )
        VALUES
        ('ERROR', 'From : sp_CloseContract -' + @ErrorMessage);

        -- Insert into a logging table
        INSERT INTO ErrorLog
        (
            ProcedureName,
            ErrorMessage,
            LogDateTime
        )
        VALUES
        ('sp_CloseContract', @ErrorMessage, GETDATE());

        -- Return an error message				
        SET @Message_Code = @ErrorMessage
    end

    SELECT @Message_Code AS Message_Code;

END
GO
