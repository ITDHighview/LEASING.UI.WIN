ALTER PROCEDURE [dbo].[sp_LogError]
    @ProcedureName NVARCHAR(255) = NULL,
    @frmName       NVARCHAR(255) = NULL,
    @FormName      NVARCHAR(255) = NULL,
    @ErrorMessage  NVARCHAR(MAX) = NULL,
    @LogDateTime   DATETIME      = NULL,
    @UserId        INT           = NULL
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
                [LogDateTime]
            )
        VALUES
            (
                @ProcedureName, @frmName, @FormName, 'APP', @ErrorMessage, @UserId, @LogDateTime
            );
    END;


