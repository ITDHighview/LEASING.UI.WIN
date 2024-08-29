SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE   PROCEDURE [dbo].[sp_GetClientType]
AS
    BEGIN

        SELECT
            [tblSetupClientType].[RecId],
            [tblSetupClientType].[ClientCode],
            [tblSetupClientType].[ClientType]
        FROM
            [dbo].[tblSetupClientType]

    END
GO
