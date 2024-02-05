SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_SaveCompany]
    @CompanyName VARCHAR(200) = NULL,
    @CompanyAddress VARCHAR(500) = NULL,
    @CompanyTIN VARCHAR(20) = NULL,
    @CompanyOwnerName VARCHAR(100) = NULL,
    @ComputerName VARCHAR(100) = NULL,
    @EncodedBy INT = NULL
AS
BEGIN
    DECLARE @Message_Code VARCHAR(MAX) = ''

    IF NOT EXISTS
    (
        SELECT 1
        FROM [dbo].[tblCompany]
        WHERE [tblCompany].[CompanyName] = UPPER(@CompanyName)
    )
    BEGIN

        INSERT INTO [dbo].[tblCompany]
        (
            [CompanyName],
            [CompanyAddress],
            [CompanyTIN],
            [CompanyOwnerName],
            [EncodedBy],
            [EncodedDate],
            [ComputerName],
            [Status]
        )
        VALUES
        (   UPPER(@CompanyName),      -- CompanyName - varchar(200)
            @CompanyAddress,          -- CompanyAddress - varchar(500)
            @CompanyTIN,              -- CompanyTIN - varchar(20)
            UPPER(@CompanyOwnerName), -- CompanyOwnerName - varchar(100)
            @EncodedBy,               -- EncodedBy - int
            GETDATE(),                -- EncodedDate - datetime      
            @ComputerName,            -- ComputerName - varchar(20),
            1)

        IF @@ROWCOUNT > 0
        BEGIN
            SET @Message_Code = 'SUCCESS'
        END
        ELSE
        BEGIN
            SET @Message_Code = ERROR_MESSAGE();
        END
    END
    ELSE
    BEGIN
        SET @Message_Code = 'COMPANY ALREADY EXIST';
    END

    SELECT @Message_Code AS [Message_Code]
END
GO
