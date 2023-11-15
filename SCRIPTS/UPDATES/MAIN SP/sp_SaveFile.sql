USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveFile]    Script Date: 11/9/2023 10:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_SaveFile]
    @FilePath NVARCHAR(MAX),
    @FileData VARBINARY(MAX),
    @ClientName VARCHAR(100),
    @FileNames VARCHAR(100),
    @Files VARCHAR(200),
    @Notes VARCHAR(500) = NULL,
    @ReferenceId VARCHAR(500) = NULL
AS
BEGIN
        INSERT INTO Files
        (
            ClientName,
            FilePath,
            FileData,
            FileNames,
            Notes,
            Files,
            RefId
        )
        VALUES
        (@ClientName, @FilePath, @FileData, @FileNames, @Notes, @Files, @ReferenceId);

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
            ('SUCCESS', 'Result From : sp_SaveFile -(' + @FilePath +') File saved successfully');

            SELECT 'SUCCESS' AS Message_Code;
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
            ('ERROR', 'Result From : sp_SaveFile -' + 'No rows affected in Files table');
        
        END
        -- Update the flag in tblUnitReference
        UPDATE tblUnitReference
        SET IsSignedContract = 1
        WHERE RefId = @ReferenceId;

        IF (@@ROWCOUNT > 0)
        BEGIN           
            -- Log a success event
            INSERT INTO LoggingEvent
            (
                EventType,
                EventMessage
            )
            VALUES
            ('SUCCESS', 'Result From : sp_SaveFile -' + '('+@ReferenceId+': IsSignedContract = 1 ) UnitReference updated successfully');

            SELECT 'SUCCESS' AS Message_Code;
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
            ('ERROR', 'Result From : sp_SaveFile -' + 'No rows affected in UnitReference table');
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
				('ERROR', 'From : sp_SaveFile -' + @ErrorMessage);

				-- Insert into a logging table
				INSERT INTO ErrorLog
				(
					ProcedureName,
					ErrorMessage,
					LogDateTime
				)
				VALUES
				('sp_SaveFile','From : sp_SaveFile -' + @ErrorMessage, GETDATE());

				-- Return an error message
				SELECT 'ERROR' AS Message_Code,
					   @ErrorMessage AS ErrorMessage;
	   end
END
