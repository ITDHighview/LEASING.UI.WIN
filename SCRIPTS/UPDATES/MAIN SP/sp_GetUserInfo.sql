
--EXEC [sp_GetUserInfo] @UserId = 100000
ALTER PROCEDURE [sp_GetUserInfo] @UserId INT = NULL
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT
            [tblUser].[GroupId],
            [dbo].[fn_GetUserGroupName]([tblUser].[UserId])                AS [GroupName],
            [tblUser].[StaffName],
            [tblUser].[Middlename],
            [tblUser].[Lastname],
            [tblUser].[EmailAddress],
            [tblUser].[Phone],
			[tblUser].[UserPassword],
            IIF(ISNULL([tblUser].[IsDelete], 0) = 0, 'ACTIVE', 'IN-ACTIVE') AS [UserStatus]
        FROM
            [dbo].[tblUser]
        WHERE
            [tblUser].[UserId] = @UserId;
    END;
GO

