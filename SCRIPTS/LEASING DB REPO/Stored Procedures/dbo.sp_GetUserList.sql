SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_GetUserList]
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT
            [tblUser].[UserId],
            [tblUser].[GroupId],
            [tblUser].[UserName],
            [tblUser].[UserPassword],
            [tblUser].[UserPasswordIncrypt],
            [tblUser].[StaffName],
            [tblUser].[Middlename],
            [tblUser].[Lastname],
            [tblUser].[EmailAddress],
            [tblUser].[Phone],
            IIF(ISNULL([tblUser].[IsDelete],0)=1,'ACTIVE','IN-ACTIVE') AS UserStatus
        FROM
            [dbo].[tblUser];
    END;
GO
