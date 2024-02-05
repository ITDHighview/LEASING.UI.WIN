SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetCompanyList]
AS
BEGIN

    SET NOCOUNT ON;

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
           [tblCompany].[ComputerName],
           IIF(ISNULL([tblCompany].[Status], 0) = 1, 'ACTIVE', 'IN-ACTIVE') AS [Status]
    FROM [dbo].[tblCompany]
    WHERE ISNULL([tblCompany].[Status], 0) = 1;

END;
GO
