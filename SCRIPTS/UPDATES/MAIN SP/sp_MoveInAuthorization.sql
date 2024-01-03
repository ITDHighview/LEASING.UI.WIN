--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
ALTER PROCEDURE [sp_MoveInAuthorization] @RefId AS VARCHAR(50) = NULL
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    SET NOCOUNT ON;

    CREATE TABLE [#tblTemp]
    (
        [DatePrint] VARCHAR(10),
        [ProjectName] VARCHAR(100),
        [UnitNo] VARCHAR(50),
        [TenantName] VARCHAR(50),
        [Taddress] VARCHAR(500),
        [MoveInDate] VARCHAR(10),
        [leasingStaff] VARCHAR(50),
        [leasingManager] VARCHAR(50),
        [Remakrs] VARCHAR(500),
    );


    INSERT INTO [#tblTemp]
    (
        [DatePrint],
        [ProjectName],
        [UnitNo],
        [TenantName],
        [Taddress],
        [MoveInDate],
        [leasingStaff],
        [leasingManager],
        [Remakrs]
    )
    VALUES
    (   CONVERT(VARCHAR(10), GETDATE(), 111), -- DatePrint - date
        'OHAYO MANSION',                      -- ProjectName - varchar(100)
        'UNIT No.1',                          -- UnitNo - varchar(50)
        'MARK JASON GELISANGA',               -- TenantName - varchar(50)
        'DEMO ADDRESS',                       -- Taddress - varchar(500)
        CONVERT(VARCHAR(10), GETDATE(), 111), -- MoveInDate - date
        'LEASING STAFF',                      -- leasingStaff - varchar(50)
        'LEASING MANAGER',                    -- leasingManager - varchar(50)
        'TEST ONLY'                           -- Remakrs - varchar(500)
        );

    SELECT [#tblTemp].[DatePrint],
           [#tblTemp].[ProjectName],
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
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO