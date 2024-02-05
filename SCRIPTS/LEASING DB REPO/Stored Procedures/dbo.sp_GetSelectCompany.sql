SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_GetSelectCompany]
AS
BEGIN

    SELECT -1 AS [RecId],
           '--SELECT--' AS [CompanyName]
    UNION
    SELECT [tblCompany].[RecId],
           [tblCompany].[CompanyName]
    FROM [dbo].[tblCompany]
END
GO
