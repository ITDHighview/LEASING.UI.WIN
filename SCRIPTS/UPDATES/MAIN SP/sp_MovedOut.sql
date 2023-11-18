USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_MovedIn]    Script Date: 11/18/2023 9:34:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_MovedOut] 
	-- Add the parameters for the stored procedure here
	@ReferenceID VARCHAR(20)= NULL
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @Message_Code NVARCHAR(MAX);

    -- Insert statements for procedure here
	update tblUnitReference set  IsUnitMoveOut = 1,UnitMoveOutDate = GETDATE() where RefId = @ReferenceID
	  -- Log a success event    
        IF (@@ROWCOUNT > 0)
        BEGIN         
            -- Log a success event
            INSERT INTO LoggingEvent
            (
                EventType,
                EventMessage
            )
            VALUES
            ('SUCCESS', 'Result From : sp_MovedOut -('+@ReferenceID+': IsUnitMoveOut= 1) tblUnitReference updated successfully');

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
            ('ERROR', 'Result From : sp_MovedOut -' + 'No rows affected in tblUnitReference table');
        
        END

	update tblUnitMstr set UnitStatus = 'HOLD' where RecId = (SELECT UnitId FROM tblUnitReference where RefId = @ReferenceID)
		  -- Log a success event    
        IF (@@ROWCOUNT > 0)
        BEGIN         
            -- Log a success event
            INSERT INTO LoggingEvent
            (
                EventType,
                EventMessage
            )
            VALUES
            ('SUCCESS', 'Result From : sp_MovedOut -(UnitStatus= HOLD) tblUnitMstr updated successfully');

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
            ('ERROR', 'Result From : sp_MovedOut -' + 'No rows affected in tblUnitMstr table');
        
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
				('ERROR', 'From : sp_MovedOut -' + @ErrorMessage);

				-- Insert into a logging table
				INSERT INTO ErrorLog
				(
					ProcedureName,
					ErrorMessage,
					LogDateTime
				)
				VALUES
				('sp_MovedOut',@ErrorMessage, GETDATE());

				-- Return an error message
				SET @Message_Code =  @ErrorMessage
	   end

	   SELECT @Message_Code AS Message_Code;
END
