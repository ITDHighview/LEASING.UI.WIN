SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[sp_GetProjectStatusCount] @ProjectId AS INT = NULL

AS
BEGIN
    SELECT
        (
            SELECT COUNT(*)
            FROM [dbo].[tblUnitMstr]
            WHERE [tblUnitMstr].[ProjectId] = 1
                  AND ISNULL([tblUnitMstr].[UnitStatus], '') = 'VACANT'
        ) AS [VACANT_COUNT],
        (
            SELECT COUNT(*)
            FROM [dbo].[tblUnitMstr]
            WHERE [tblUnitMstr].[ProjectId] = 1
                  AND ISNULL([tblUnitMstr].[UnitStatus], '') = 'MOVE-IN'
        ) AS [OCCUPIED_COUNT],
        (
            SELECT COUNT(*)
            FROM [dbo].[tblUnitMstr]
            WHERE [tblUnitMstr].[ProjectId] = 1
                  AND ISNULL([tblUnitMstr].[UnitStatus], '') = 'RESERVED'
        ) AS [RESERVED_COUNT],
        (
            SELECT COUNT(*)
            FROM [dbo].[tblUnitMstr]
            WHERE [tblUnitMstr].[ProjectId] = 1
                  AND ISNULL([tblUnitMstr].[UnitStatus], '') = 'NOT AVAILABLE'
        ) AS [NOT_AVAILABLE_COUNT],
        (
            SELECT COUNT(*)
            FROM [dbo].[tblUnitMstr]
            WHERE [tblUnitMstr].[ProjectId] = 1
                  AND ISNULL([tblUnitMstr].[UnitStatus], '') = 'HOLD'
        ) AS [HOLD_COUNT]

END
GO
