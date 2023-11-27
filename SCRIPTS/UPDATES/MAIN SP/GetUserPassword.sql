ALTER PROCEDURE [sp_GetUserPassword] @UserId INT = NULL
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT
            [tblUser].[UserId],
            [tblUser].[GroupId],
            [tblUser].[UserName],
            [tblUser].[UserPassword],
            [tblUser].[UserPasswordIncrypt],
            UPPER([tblUser].[StaffName]) AS [StaffName],
            [tblUser].[Middlename],
            [tblUser].[Lastname],
            [tblUser].[EmailAddress],
            [tblUser].[Phone],
            ISNULL([tblUser].[IsDelete], 0) AS [UserStatus]
        FROM
            [dbo].[tblUser]
        WHERE
            [tblUser].[UserId] = @UserId;
    END;
GO

