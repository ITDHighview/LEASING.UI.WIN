SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetUnitList]
AS
BEGIN

    SET NOCOUNT ON;

    SELECT DISTINCT
           [tblUnitMstr].[RecId],
           [tblUnitMstr].[ProjectId],
           ISNULL([tblProjectMstr].[ProjectName], '') AS [ProjectName],
           IIF(ISNULL([tblUnitMstr].[IsParking], 0) = 1, 'TYPE OF PARKING', 'TYPE OF UNIT') AS [UnitDescription],
           ISNULL([tblUnitMstr].[FloorNo], 0) AS [FloorNo],
           ISNULL([tblUnitMstr].[AreaSqm], 0) AS [AreaSqm],
           ISNULL([tblUnitMstr].[AreaRateSqm], 0) AS [AreaRateSqm],
           ISNULL([tblUnitMstr].[FloorType], '') AS [FloorType],
           ISNULL([tblUnitMstr].[TotalRental], 0) AS [TotalMonthlyRental],
           CASE
               WHEN ISNULL([tblUnitMstr].[UnitStatus], '') = 'RESERVED' THEN
                   ISNULL([tblUnitMstr].[UnitStatus], '') + ' TO : '
                   + ISNULL(CAST([tblUnitReference].[ClientID] AS VARCHAR(20)), '') + ' - '
                   + [tblUnitReference].[InquiringClient]
               WHEN ISNULL([tblUnitMstr].[UnitStatus], '') = 'MOVE-IN' THEN
                   ISNULL([tblUnitMstr].[UnitStatus], '') + '  : '
                   + ISNULL(CAST([tblUnitReference].[ClientID] AS VARCHAR(20)), '') + ' - '
                   + [tblUnitReference].[InquiringClient]
               ELSE
                   ISNULL([tblUnitMstr].[UnitStatus], '')
           END AS [UnitStatus],
           ISNULL([tblUnitMstr].[UnitStatus], '') AS [UnitStat],
           ISNULL([tblUnitMstr].[DetailsofProperty], '') AS [DetailsofProperty],
           ISNULL([tblUnitMstr].[UnitNo], '') AS [UnitNo],
           IIF(ISNULL([tblUnitMstr].[IsActive], 0) = 1, 'ACTIVE', 'IN-ACTIVE') AS [IsActive],
           [tblUnitReference].[ClientID]
    FROM [dbo].[tblUnitMstr]
        INNER JOIN [dbo].[tblProjectMstr]
            ON [tblUnitMstr].[ProjectId] = [tblProjectMstr].[RecId]
        LEFT JOIN [dbo].[tblUnitReference]
            ON [tblUnitMstr].[RecId] = [tblUnitReference].[UnitId];

END;
GO
