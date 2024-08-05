USE [LEASINGDB]

--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
GO
CREATE OR ALTER PROCEDURE [dbo].[sp_GetClientType]
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
