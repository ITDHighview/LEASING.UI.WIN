SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC [sp_GetClientUnitList] 'CORP10000001'
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetClientUnitList] @ClientID VARCHAR(50) = NULL
AS
BEGIN

    SET NOCOUNT ON;


    SELECT [tblUnitReference].[RecId],
           [tblUnitReference].[UnitNo],
           ISNULL([tblProjectMstr].[ProjectName], '') + '-' + ISNULL([tblProjectMstr].[ProjectType], '') AS [ProjectName],
           ISNULL([tblUnitMstr].[DetailsofProperty], 'N/A') + ' - Type (' + ISNULL([tblUnitMstr].[FloorType], 'N/A')
           + ')' AS [DetailsofProperty],
           IIF(ISNULL([tblUnitMstr].[IsParking], 0) = 1, 'TYPE OF PARKING', 'TYPE OF UNIT') AS [TypeOf],
           case
               when isnull([tblUnitReference].[IsUnitMove], 0) = 0
                    and isnull([tblUnitReference].[IsUnitMoveOut], 0) = 0
                    and isnull([tblUnitReference].[IsSignedContract], 0) = 1 then
                   'RESERVED'
               when isnull([tblUnitReference].[IsSignedContract], 0) = 1
                    and isnull([tblUnitReference].[IsUnitMove], 0) = 1
                    and isnull([tblUnitReference].[IsUnitMoveOut], 0) = 0 then
                   'OCCUPIED'
               when isnull([tblUnitReference].[IsSignedContract], 0) = 1
                    and isnull([tblUnitReference].[IsUnitMove], 0) = 1
                    and isnull([tblUnitReference].[IsUnitMoveOut], 0) = 1
                    and isnull([tblUnitReference].[IsUnitMoveOut], 0) = 0
                    and isnull([tblUnitReference].IsDone, 0) = 0 then
                   'MOVE-OUT'
               when (
                        isnull([tblUnitReference].[IsSignedContract], 0) = 1
                        and isnull([tblUnitReference].[IsUnitMove], 0) = 1
                        and isnull([tblUnitReference].[IsUnitMoveOut], 0) = 1
                        and isnull([tblUnitReference].IsTerminated, 0) = 0
                        and isnull([tblUnitReference].IsDone, 0) = 1
                    )
                    or (
                           isnull([tblUnitReference].[IsSignedContract], 0) = 1
                           and isnull([tblUnitReference].[IsUnitMove], 0) = 1
                           and isnull([tblUnitReference].[IsUnitMoveOut], 0) = 1
                           and isnull([tblUnitReference].IsTerminated, 0) = 1
                           and isnull([tblUnitReference].IsDone, 0) = 1
                       ) then
                   'CLOSE CONTRACT'
               when isnull([tblUnitReference].[IsSignedContract], 0) = 1
                    and isnull([tblUnitReference].[IsUnitMove], 0) = 1
                    and isnull([tblUnitReference].[IsUnitMoveOut], 0) = 1
                    and isnull([tblUnitReference].IsDone, 0) = 0
                    and isnull([tblUnitReference].IsTerminated, 0) = 1 then
                   'EARLY TERMINATION'
               else
                   ''
           end as [UnitStatus]
    FROM [dbo].[tblUnitReference] WITH (NOLOCK)
        LEFT JOIN [dbo].[tblUnitMstr] WITH (NOLOCK)
            ON [tblUnitReference].[UnitId] = [tblUnitMstr].[RecId]
        INNER JOIN [dbo].[tblProjectMstr]
            ON [tblUnitReference].[ProjectId] = [tblProjectMstr].[RecId]
    WHERE [tblUnitReference].[ClientID] = @ClientID;
END;
GO
