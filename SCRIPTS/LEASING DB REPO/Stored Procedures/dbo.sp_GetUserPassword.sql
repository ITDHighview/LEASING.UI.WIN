SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_GetUserPassword] @UserId VARCHAR(20) = NULL
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
            [tblUser].[UserName] = @UserId;
    END;
GO
