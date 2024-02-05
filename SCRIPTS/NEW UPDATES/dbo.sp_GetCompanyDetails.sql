SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_GetCompanyDetails] @RecId AS INT = NULL
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    SELECT [tblCompany].[RecId],
           [tblCompany].[CompanyName],
           [tblCompany].[CompanyAddress],
           [tblCompany].[CompanyTIN],
           [tblCompany].[CompanyOwnerName],
           [tblCompany].[Status],
           [tblCompany].[EncodedBy],
           [tblCompany].[EncodedDate],
           [tblCompany].[LastChangedBy],
           [tblCompany].[LastChangedDate],
           [tblCompany].[ComputerName]
    FROM [dbo].[tblCompany]
    WHERE [tblCompany].[RecId] = @RecId
END
GO
