USE [LEASINGDB];
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserInfo]    Script Date: 1/21/2024 7:35:33 PM ******/
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

--EXEC [sp_GetUserInfo] @UserId = 100000
ALTER PROCEDURE [dbo].[sp_GetUserInfo] @UserId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT [tblUser].[GroupId],
           [dbo].[fn_GetUserGroupName]([tblUser].[UserId]) AS [GroupName],
           [tblUser].[StaffName],
           [tblUser].[Middlename],
           [tblUser].[Lastname],
           [tblUser].[EmailAddress],
           [tblUser].[Phone],
           [tblUser].[UserPassword],
           [tblUser].[UserName],
           IIF(ISNULL([tblUser].[IsDelete], 0) = 0, 'ACTIVE', 'IN-ACTIVE') AS [UserStatus]
    FROM [dbo].[tblUser]
    WHERE [tblUser].[UserId] = @UserId;
END;
