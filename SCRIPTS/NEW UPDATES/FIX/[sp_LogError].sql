USE [LEASINGDB]
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
CREATE OR ALTER PROCEDURE [dbo].[sp_LogError]
    @ProcedureName NVARCHAR(255) = NULL,
    @frmName       NVARCHAR(255) = NULL,
    @FormName      NVARCHAR(255) = NULL,
    @ErrorMessage  NVARCHAR(MAX) = NULL,
    @LogDateTime   DATETIME      = NULL,
    @UserId        INT           = NULL,
    @ComputerName  NVARCHAR(255) = NULL
AS
    BEGIN
        INSERT INTO [dbo].[ErrorLog]
            (
                [ProcedureName],
                [frmName],
                [FormName],
                [Category],
                [ErrorMessage],
                [UserId],
                [LogDateTime],
                [ComputerName]
            )
        VALUES
            (
                @ProcedureName, @frmName, @FormName, 'APP', @ErrorMessage, @UserId, @LogDateTime, @ComputerName
            );
    END;


GO

