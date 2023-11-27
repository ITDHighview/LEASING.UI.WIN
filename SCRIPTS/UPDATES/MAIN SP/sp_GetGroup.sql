ALTER PROCEDURE [sp_GetGroup] @UserId INT = NULL
AS
    BEGIN

        SELECT
                [tblUser].[UserId],
                [tblUser].[GroupId]    AS [Group_Code],
                [tblGroup].[GroupName] AS [Group_Name]
        FROM
                [dbo].[tblUser]
            INNER JOIN
                [dbo].[tblGroup]
                    ON [tblGroup].[GroupId] = [tblUser].[GroupId]
        WHERE
                [tblUser].[UserId] = @UserId;
    END;
GO



