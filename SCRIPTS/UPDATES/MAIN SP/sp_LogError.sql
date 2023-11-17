ALTER PROCEDURE [dbo].[sp_LogError]
    @ProcedureName NVARCHAR(255)=null,
	@frmName NVARCHAR(255)=null,
	@FormName NVARCHAR(255)=null,
    @ErrorMessage NVARCHAR(MAX)=null,
    @LogDateTime DATETIME=null,
	@UserId INT=NULL
AS
BEGIN
    INSERT INTO ErrorLog (ProcedureName,frmName,FormName,Category,ErrorMessage,UserId, LogDateTime)
    VALUES (@ProcedureName,@frmName,@FormName,'APP',@ErrorMessage,@UserId, @LogDateTime);
END;


