SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_UpdateUserInfo]
    @UserId AS INT,
    @UserName VARCHAR(50),
    @UserPassword NVARCHAR(50),
    @StaffName VARCHAR(100),
    @Middlename VARCHAR(50),
    @Lastname VARCHAR(50),
    @EmailAddress VARCHAR(50),
    @Phone VARCHAR(20)
AS
BEGIN
    DECLARE @Message_Code VARCHAR(100) = '';
    IF EXISTS
    (
        SELECT 1
        FROM [dbo].[tblUser]
        WHERE [tblUser].[UserId] = @UserId
    )
    BEGIN
        UPDATE [dbo].[tblUser]
        SET [tblUser].[UserName] = @UserName,
            [tblUser].[UserPassword] = @UserPassword,
            [tblUser].[StaffName] = @StaffName,
            [tblUser].[Middlename] = @Middlename,
            [tblUser].[Lastname] = @Lastname,
            [tblUser].[EmailAddress] = @EmailAddress,
            [tblUser].[Phone] = @Phone;

        IF @@ROWCOUNT > 0
        BEGIN
            SET @Message_Code = 'SUCCESS';
        END;
    END;
    ELSE
    BEGIN
        SET @Message_Code = 'User not exixt';
    END;

    SELECT @Message_Code AS [Message_Code];
END;
GO
