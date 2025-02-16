USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetClientUnitList]    Script Date: 12/2/2024 5:31:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC [sp_GetClientUnitList] 'CORP10000001'
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_GetClientUnitList] @ClientID VARCHAR(50) = NULL
AS
    BEGIN

        SET NOCOUNT ON;


        SELECT
                [tblUnitReference].[RecId],
                [tblUnitReference].[UnitNo],
                ISNULL([tblProjectMstr].[ProjectName], '') + '-' + ISNULL([tblProjectMstr].[ProjectType], '') AS [ProjectName],
                ISNULL([tblUnitMstr].[DetailsofProperty], 'N/A') + ' - Type (' + ISNULL([tblUnitMstr].[FloorType], 'N/A')
                + ')'                                                                                         AS [DetailsofProperty],
                IIF(ISNULL([tblUnitMstr].[IsParking], 0) = 1, 'TYPE OF PARKING', 'TYPE OF UNIT')              AS [TypeOf],
                CASE
                    WHEN ISNULL([tblUnitReference].[IsUnitMove], 0) = 0
                         AND ISNULL([tblUnitReference].[IsUnitMoveOut], 0) = 0
                         AND ISNULL([tblUnitReference].[IsSignedContract], 0) = 1
                        THEN
                        'RESERVED'
                    WHEN ISNULL([tblUnitReference].[IsSignedContract], 0) = 1
                         AND ISNULL([tblUnitReference].[IsUnitMove], 0) = 1
                         AND ISNULL([tblUnitReference].[IsUnitMoveOut], 0) = 0
                        THEN
                        'OCCUPIED'
                    WHEN ISNULL([tblUnitReference].[IsSignedContract], 0) = 1
                         AND ISNULL([tblUnitReference].[IsUnitMove], 0) = 1
                         AND ISNULL([tblUnitReference].[IsUnitMoveOut], 0) = 1
                         AND ISNULL([tblUnitReference].[IsUnitMoveOut], 0) = 0
                         AND ISNULL([tblUnitReference].IsDone, 0) = 0
                        THEN
                        'MOVE-OUT'
                    WHEN (
                             ISNULL([tblUnitReference].[IsSignedContract], 0) = 1
                             AND ISNULL([tblUnitReference].[IsUnitMove], 0) = 1
                             AND ISNULL([tblUnitReference].[IsUnitMoveOut], 0) = 1
                             AND ISNULL([tblUnitReference].IsTerminated, 0) = 0
                             AND ISNULL([tblUnitReference].IsDone, 0) = 1
                         )
                         OR
                             (
                                 ISNULL([tblUnitReference].[IsSignedContract], 0) = 1
                                 AND ISNULL([tblUnitReference].[IsUnitMove], 0) = 1
                                 AND ISNULL([tblUnitReference].[IsUnitMoveOut], 0) = 1
                                 AND ISNULL([tblUnitReference].IsTerminated, 0) = 1
                                 AND ISNULL([tblUnitReference].IsDone, 0) = 1
                             )
                        THEN
                        'CLOSE CONTRACT'
                    WHEN ISNULL([tblUnitReference].[IsSignedContract], 0) = 1
                         AND ISNULL([tblUnitReference].[IsUnitMove], 0) = 1
                         AND ISNULL([tblUnitReference].[IsUnitMoveOut], 0) = 1
                         AND ISNULL([tblUnitReference].IsDone, 0) = 0
                         AND ISNULL([tblUnitReference].IsTerminated, 0) = 1
                        THEN
                        'EARLY TERMINATION'
                    WHEN ISNULL([tblUnitReference].[IsSignedContract], 0) = 0
                         AND ISNULL([tblUnitReference].[IsUnitMove], 0) = 0
                         AND ISNULL([tblUnitReference].[IsUnitMoveOut], 0) = 0
                         AND ISNULL([tblUnitReference].IsDone, 0) = 0
                         AND ISNULL([tblUnitReference].IsTerminated, 0) = 0
                         AND ISNULL([tblUnitReference].[IsDeclineUnit], 0) = 1
                        THEN
                        'DECLINED CONTRACT'
                    ELSE
                        ''
                END                                                                                           AS [UnitStatus]
        FROM
                [dbo].[tblUnitReference] WITH (NOLOCK)
            LEFT JOIN
                [dbo].[tblUnitMstr] WITH (NOLOCK)
                    ON [tblUnitReference].[UnitId] = [tblUnitMstr].[RecId]
            INNER JOIN
                [dbo].[tblProjectMstr]
                    ON [tblUnitReference].[ProjectId] = [tblProjectMstr].[RecId]
        WHERE
                [tblUnitReference].[ClientID] = @ClientID;
    END;
