SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE OR ALTER PROCEDURE [dbo].[sp_SaveUser]
    @GroupId AS      INT           = NULL,
    @UserId AS       INT           = NULL,
    @UserPassword AS NVARCHAR(MAX) = NULL,
    @UserName AS     VARCHAR(200)  = NULL,
    @StaffName AS    VARCHAR(200)  = NULL,
    @Middlename AS   VARCHAR(50)   = NULL,
    @Lastname AS     VARCHAR(50)   = NULL,
    @EmailAddress AS VARCHAR(100)  = NULL,
    @Phone AS        VARCHAR(20)   = NULL,
    @Mode AS         VARCHAR(20)   = NULL
AS
    BEGIN TRY

        SET NOCOUNT ON;
        DECLARE @Message_Code VARCHAR(MAX) = '';
        DECLARE @ErrorMessage NVARCHAR(MAX) = N'';
        BEGIN TRANSACTION

        IF @Mode = 'NEW'
            BEGIN

                IF NOT EXISTS
                    (
                        SELECT
                            [tblUser].[UserName]
                        FROM
                            [dbo].[tblUser]
                        WHERE
                            [tblUser].[UserName] = @UserName
                            AND [tblUser].[GroupId] = @GroupId
                    )
                    BEGIN
                        INSERT INTO [dbo].[tblUser]
                            (
                                [GroupId],
                                [UserName],
                                [UserPassword],
                                [UserPasswordIncrypt],
                                [StaffName],
                                [Middlename],
                                [Lastname],
                                [EmailAddress],
                                [Phone],
                                [IsDelete]
                            )
                        VALUES
                            (
                                @GroupId,      -- GroupId - int
                                @UserName,     -- UserName - varchar(100)
                                @UserPassword, -- UserPassword - nvarchar(max)
                                NULL,          -- UserPasswordIncrypt - varchar(200)
                                @StaffName,    -- StaffName - varchar(200)
                                @Middlename,   -- Middlename - varchar(50)
                                @Lastname,     -- Lastname - varchar(50)
                                @EmailAddress, -- EmailAddress - varchar(100)
                                @Phone,        -- Phone - varchar(20)
                                0              -- IsDelete - bit
                            );


                        IF (@@ROWCOUNT > 0)
                            BEGIN

                                SET @Message_Code = 'SUCCESS'
                                SET @ErrorMessage = N''
                            END;
                    END;
                ELSE
                    BEGIN
                        SET @Message_Code = N'User Name is already associate to other Group';
                        SET @ErrorMessage = N''
                    END;

            END;
        ELSE IF @Mode = 'EDIT'
            BEGIN
                UPDATE
                    [dbo].[tblUser]
                SET
                    [tblUser].[GroupId] = @GroupId,
                    [tblUser].[UserPassword] = @UserPassword,
                    [tblUser].[UserName] = @UserName,
                    [tblUser].[StaffName] = @StaffName,
                    [tblUser].[Lastname] = @Lastname,
                    [tblUser].[Middlename] = @Middlename,
                    [tblUser].[EmailAddress] = @EmailAddress,
                    [tblUser].[Phone] = @Phone
                WHERE
                    [tblUser].[UserId] = @UserId;

                IF (@@ROWCOUNT > 0)
                    BEGIN

                        SET @Message_Code = 'SUCCESS'
                        SET @ErrorMessage = N''
                    END;



            END;

        SELECT
            @ErrorMessage AS [ErrorMessage],
            @Message_Code AS [Message_Code];


        COMMIT TRANSACTION

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        SET @Message_Code = 'ERROR'
        SET @ErrorMessage = ERROR_MESSAGE()

        INSERT INTO [dbo].[ErrorLog]
            (
                [ProcedureName],
                [ErrorMessage],
                [LogDateTime]
            )
        VALUES
            (
                'sp_SaveUser', @ErrorMessage, GETDATE()
            );

        SELECT
            @ErrorMessage AS [ErrorMessage],
            @Message_Code AS [Message_Code];
    END CATCH
GO
