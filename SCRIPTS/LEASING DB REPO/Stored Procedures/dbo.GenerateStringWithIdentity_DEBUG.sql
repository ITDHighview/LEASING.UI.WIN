SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[GenerateStringWithIdentity_DEBUG]
AS
BEGIN
    DECLARE @IdentityNumber INT
    DECLARE @GeneratedString VARCHAR(50)

    -- Get the latest identity value
    SELECT @IdentityNumber = IDENT_CURRENT('demoTable')+1

    -- Increment the identity value if it is less than 100
    IF @IdentityNumber < 1000
        SET @IdentityNumber = 1000

    -- Generate the string
    SET @GeneratedString = 'CORP-' + RIGHT('00' + CAST(@IdentityNumber + 1 AS VARCHAR(10)), 3)

    -- Output the generated string
    SELECT @GeneratedString AS GeneratedString
END
GO
