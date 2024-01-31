SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_MoveInAuthorization] @RefId AS VARCHAR(50) = NULL
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    SET NOCOUNT ON;

    CREATE TABLE [#tblTemp]
    (
        [DatePrint] VARCHAR(10),
        [ProjectName] VARCHAR(100),
        [ProjectAddress] VARCHAR(1000),
        [UnitNo] VARCHAR(50),
        [TenantName] VARCHAR(50),
        [Taddress] VARCHAR(1000),
        [MoveInDate] VARCHAR(10),
        [leasingStaff] VARCHAR(50),
        [leasingManager] VARCHAR(50),
        [Remakrs] VARCHAR(500),
    );

    INSERT INTO [#tblTemp]
    (
        [DatePrint],
        [ProjectName],
        [ProjectAddress],
        [UnitNo],
        [TenantName],
        [Taddress],
        [MoveInDate],
        [leasingStaff],
        [leasingManager],
        [Remakrs]
    )
    SELECT CONVERT(VARCHAR(10), GETDATE(), 111),                                -- DatePrint - varchar(10)
           ISNULL([tblProjectMstr].[ProjectName], '') AS [ProjectName],         -- ProjectName - varchar(100)
           'occupy Unit ' + ISNULL([tblUnitMstr].[UnitNo], '') + ' located at '
           + ISNULL([tblProjectMstr].[ProjectAddress], '') AS [ProjectAddress], -- ProjectAddress - varchar(1000)
           ISNULL([tblUnitMstr].[UnitNo], '') AS [UnitNo],                      -- UnitNo - varchar(50)
           ISNULL([tblClientMstr].[ClientName], '') AS [ClientName],            -- TenantName - varchar(50)
           ISNULL([tblClientMstr].[PostalAddress], '') AS [PostalAddress],      -- Taddress - varchar(1000)
           CONVERT(VARCHAR(10), GETDATE(), 111),                                -- MoveInDate - varchar(10)
           '',                                                                  -- leasingStaff - varchar(50)
           '',                                                                  -- leasingManager - varchar(50)
           ''                                                                   -- Remakrs - varchar(500)
    FROM [dbo].[tblUnitReference]
        INNER JOIN [dbo].[tblProjectMstr]
            ON [dbo].[tblUnitReference].[ProjectId] = [dbo].[tblProjectMstr].[RecId]
        INNER JOIN [dbo].[tblUnitMstr]
            ON [dbo].[tblUnitReference].[UnitId] = [dbo].[tblUnitMstr].[RecId]
        INNER JOIN [dbo].[tblClientMstr]
            ON [tblUnitReference].[ClientID] = [tblClientMstr].[ClientID]
    WHERE [tblUnitReference].[RefId] = @RefId;

    SELECT [#tblTemp].[DatePrint],
           [#tblTemp].[ProjectName],
           [#tblTemp].[ProjectAddress],
           [#tblTemp].[UnitNo],
           [#tblTemp].[TenantName],
           [#tblTemp].[Taddress],
           [#tblTemp].[MoveInDate],
           [#tblTemp].[leasingStaff],
           [#tblTemp].[leasingManager],
           [#tblTemp].[Remakrs]
    FROM [#tblTemp];
END;

DROP TABLE IF EXISTS [#tblTemp];
GO
