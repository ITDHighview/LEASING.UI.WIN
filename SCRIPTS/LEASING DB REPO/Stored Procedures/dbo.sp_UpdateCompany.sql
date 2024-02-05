SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_UpdateCompany]
    @RecId INT = NULL,
    @CompanyName VARCHAR(200) = NULL,
    @CompanyAddress VARCHAR(500) = NULL,
    @CompanyTIN VARCHAR(20) = NULL,
    @CompanyOwnerName VARCHAR(100) = NULL,
    @ComputerName VARCHAR(100) = NULL,
    @EncodedBy INT = NULL
AS
BEGIN
    DECLARE @Message_Code VARCHAR(MAX) = ''

    IF EXISTS
    (
        SELECT 1
        FROM [dbo].[tblCompany]
        WHERE [tblCompany].[CompanyName] = UPPER(@CompanyName)
    )
    BEGIN

        UPDATE [dbo].[tblCompany]
        SET [tblCompany].[CompanyName] = UPPER(@CompanyName),
            [tblCompany].[CompanyAddress] = @CompanyAddress,
            [tblCompany].[CompanyTIN] = @CompanyTIN,
            [tblCompany].[CompanyOwnerName] = UPPER(@CompanyOwnerName),
            [tblCompany].[LastChangedBy] = @EncodedBy,
            [tblCompany].[LastChangedDate] = GETDATE(),
            [tblCompany].[ComputerName] = @ComputerName
        WHERE [tblCompany].[RecId] = @RecId
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
        SET @Message_Code = 'COMPANY NOT EXIST';
    END

    SELECT @Message_Code AS [Message_Code]
END
GO
