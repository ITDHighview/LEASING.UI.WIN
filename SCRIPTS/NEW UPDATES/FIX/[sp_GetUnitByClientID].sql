USE [LEASINGDB]
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
GO
CREATE OR ALTER PROCEDURE [sp_GetUnitByClientID] @ClientID AS VARCHAR(150) = NULL
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
    BEGIN
        SELECT
            [tblUnitReference].[UnitId] AS [ValueMember],
            [tblUnitReference].[UnitNo] AS [DisplayMember]
        FROM
            [dbo].[tblUnitReference] WITH (NOLOCK)
        WHERE
            [tblUnitReference].[ClientID] = @ClientID
    END
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO