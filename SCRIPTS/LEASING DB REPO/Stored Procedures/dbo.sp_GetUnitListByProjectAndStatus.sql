SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [dbo].[sp_GetUnitListByProjectAndStatus]
    @ProjectId  INT         = NULL,
    @UnitStatus VARCHAR(15) = NULL,
    @ProjStatus VARCHAR(15) = NULL
AS
    BEGIN

        SET NOCOUNT ON;


        IF @ProjectId = 0
           AND @ProjStatus <> '--ALL--'
           AND
               (
                   @UnitStatus = ''
                   OR @UnitStatus = '--ALL--'
               )
            BEGIN
                SELECT  DISTINCT
                        [tblUnitMstr].[RecId],
                        [tblUnitMstr].[ProjectId],
                        ISNULL([tblProjectMstr].[ProjectName], '')                                               AS [ProjectName],
                        FORMAT(ISNULL([tblUnitMstr].[TotalRental], 0), 'N2')                                     AS [TotalMonthlyRental],
                        ISNULL([tblUnitMstr].[FloorNo], 0)                                                       AS [FloorNo],
                        ISNULL([tblUnitMstr].[AreaSqm], 0)                                                       AS [AreaSqm],
                        ISNULL([tblUnitMstr].[AreaRateSqm], 0)                                                   AS [AreaRateSqm],
                        IIF([tblUnitMstr].[FloorType] = '--SELECT--', '', ISNULL([tblUnitMstr].[FloorType], '')) AS [FloorType],
                        ISNULL([tblUnitMstr].[BaseRental], 0)                                                    AS [BaseRental],
                        CASE
                            WHEN ISNULL([tblUnitMstr].[UnitStatus], '') = 'RESERVED'
                                THEN
                                ISNULL([tblUnitMstr].[UnitStatus], '') + ' TO : '
                                + ISNULL(CAST([tblUnitReference].[ClientID] AS VARCHAR(20)), '') + ' - '
                                + [tblUnitReference].[InquiringClient]
                            WHEN ISNULL([tblUnitMstr].[UnitStatus], '') = 'MOVE-IN'
                                THEN
                                ISNULL([tblUnitMstr].[UnitStatus], '') + '  : '
                                + ISNULL(CAST([tblUnitReference].[ClientID] AS VARCHAR(20)), '') + ' - '
                                + [tblUnitReference].[InquiringClient]
                            ELSE
                                ISNULL([tblUnitMstr].[UnitStatus], '')
                        END                                                                                      AS [UnitStatus],
                        ISNULL([tblUnitMstr].[UnitStatus], '')                                                   AS [UnitStat],
                        ISNULL([tblUnitMstr].[DetailsofProperty], '')                                            AS [DetailsofProperty],
                        ISNULL([tblUnitMstr].[UnitNo], '')                                                       AS [UnitNo],
                        IIF(ISNULL([tblUnitMstr].[IsActive], 0) = 1, 'ACTIVE', 'IN-ACTIVE')                      AS [IsActive],
                        [tblUnitReference].[ClientID]
                FROM
                        [dbo].[tblUnitMstr] WITH (NOLOCK)
                    INNER JOIN
                        [dbo].[tblProjectMstr] WITH (NOLOCK)
                            ON [tblUnitMstr].[ProjectId] = [tblProjectMstr].[RecId]
                    LEFT JOIN
                        [dbo].[tblUnitReference] WITH (NOLOCK)
                            ON [tblUnitMstr].[RecId] = [tblUnitReference].[UnitId]
                WHERE
                        [tblProjectMstr].[RecId] = @ProjectId
                        AND [tblUnitMstr].[UnitStatus] <> 'DISABLED'

            END
        ELSE IF @ProjectId = 0
                AND @ProjStatus = '--ALL--'
                AND
                    (
                        @UnitStatus = ''
                        OR @UnitStatus = '--ALL--'
                    )
            BEGIN
                SELECT  DISTINCT
                        [tblUnitMstr].[RecId],
                        [tblUnitMstr].[ProjectId],
                        ISNULL([tblProjectMstr].[ProjectName], '')                                               AS [ProjectName],
                        FORMAT(ISNULL([tblUnitMstr].[TotalRental], 0), 'N2')                                     AS [TotalMonthlyRental],
                        ISNULL([tblUnitMstr].[FloorNo], 0)                                                       AS [FloorNo],
                        ISNULL([tblUnitMstr].[AreaSqm], 0)                                                       AS [AreaSqm],
                        ISNULL([tblUnitMstr].[AreaRateSqm], 0)                                                   AS [AreaRateSqm],
                        IIF([tblUnitMstr].[FloorType] = '--SELECT--', '', ISNULL([tblUnitMstr].[FloorType], '')) AS [FloorType],
                        ISNULL([tblUnitMstr].[BaseRental], 0)                                                    AS [BaseRental],
                        CASE
                            WHEN ISNULL([tblUnitMstr].[UnitStatus], '') = 'RESERVED'
                                THEN
                                ISNULL([tblUnitMstr].[UnitStatus], '') + ' TO : '
                                + ISNULL(CAST([tblUnitReference].[ClientID] AS VARCHAR(20)), '') + ' - '
                                + [tblUnitReference].[InquiringClient]
                            WHEN ISNULL([tblUnitMstr].[UnitStatus], '') = 'MOVE-IN'
                                THEN
                                ISNULL([tblUnitMstr].[UnitStatus], '') + '  : '
                                + ISNULL(CAST([tblUnitReference].[ClientID] AS VARCHAR(20)), '') + ' - '
                                + [tblUnitReference].[InquiringClient]
                            ELSE
                                ISNULL([tblUnitMstr].[UnitStatus], '')
                        END                                                                                      AS [UnitStatus],
                        ISNULL([tblUnitMstr].[UnitStatus], '')                                                   AS [UnitStat],
                        ISNULL([tblUnitMstr].[DetailsofProperty], '')                                            AS [DetailsofProperty],
                        ISNULL([tblUnitMstr].[UnitNo], '')                                                       AS [UnitNo],
                        IIF(ISNULL([tblUnitMstr].[IsActive], 0) = 1, 'ACTIVE', 'IN-ACTIVE')                      AS [IsActive],
                        [tblUnitReference].[ClientID]
                FROM
                        [dbo].[tblUnitMstr] WITH (NOLOCK)
                    INNER JOIN
                        [dbo].[tblProjectMstr] WITH (NOLOCK)
                            ON [tblUnitMstr].[ProjectId] = [tblProjectMstr].[RecId]
                    LEFT JOIN
                        [dbo].[tblUnitReference] WITH (NOLOCK)
                            ON [tblUnitReference].[UnitId] = [tblUnitMstr].[RecId]
                --WHERE
                --        [tblProjectMstr].[RecId] = @ProjectId
                --        AND [tblUnitMstr].[UnitStatus] = @UnitStatus
                ORDER BY
                        [tblUnitMstr].[ProjectId]
            END
        ELSE IF @ProjectId = 0
                AND @ProjStatus = '--ALL--'
                AND @UnitStatus <> '--ALL--'
            BEGIN
                SELECT  DISTINCT
                        [tblUnitMstr].[RecId],
                        [tblUnitMstr].[ProjectId],
                        ISNULL([tblProjectMstr].[ProjectName], '')                                               AS [ProjectName],
                        FORMAT(ISNULL([tblUnitMstr].[TotalRental], 0), 'N2')                                     AS [TotalMonthlyRental],
                        ISNULL([tblUnitMstr].[FloorNo], 0)                                                       AS [FloorNo],
                        ISNULL([tblUnitMstr].[AreaSqm], 0)                                                       AS [AreaSqm],
                        ISNULL([tblUnitMstr].[AreaRateSqm], 0)                                                   AS [AreaRateSqm],
                        IIF([tblUnitMstr].[FloorType] = '--SELECT--', '', ISNULL([tblUnitMstr].[FloorType], '')) AS [FloorType],
                        ISNULL([tblUnitMstr].[BaseRental], 0)                                                    AS [BaseRental],
                        CASE
                            WHEN ISNULL([tblUnitMstr].[UnitStatus], '') = 'RESERVED'
                                THEN
                                ISNULL([tblUnitMstr].[UnitStatus], '') + ' TO : '
                                + ISNULL(CAST([tblUnitReference].[ClientID] AS VARCHAR(20)), '') + ' - '
                                + [tblUnitReference].[InquiringClient]
                            WHEN ISNULL([tblUnitMstr].[UnitStatus], '') = 'MOVE-IN'
                                THEN
                                ISNULL([tblUnitMstr].[UnitStatus], '') + '  : '
                                + ISNULL(CAST([tblUnitReference].[ClientID] AS VARCHAR(20)), '') + ' - '
                                + [tblUnitReference].[InquiringClient]
                            ELSE
                                ISNULL([tblUnitMstr].[UnitStatus], '')
                        END                                                                                      AS [UnitStatus],
                        ISNULL([tblUnitMstr].[UnitStatus], '')                                                   AS [UnitStat],
                        ISNULL([tblUnitMstr].[DetailsofProperty], '')                                            AS [DetailsofProperty],
                        ISNULL([tblUnitMstr].[UnitNo], '')                                                       AS [UnitNo],
                        IIF(ISNULL([tblUnitMstr].[IsActive], 0) = 1, 'ACTIVE', 'IN-ACTIVE')                      AS [IsActive],
                        [tblUnitReference].[ClientID]
                FROM
                        [dbo].[tblUnitMstr] WITH (NOLOCK)
                    INNER JOIN
                        [dbo].[tblProjectMstr] WITH (NOLOCK)
                            ON [tblUnitMstr].[ProjectId] = [tblProjectMstr].[RecId]
                    LEFT JOIN
                        [dbo].[tblUnitReference] WITH (NOLOCK)
                            ON [tblUnitReference].[UnitId] = [tblUnitMstr].[RecId]
                WHERE
                        [tblUnitMstr].[UnitStatus] = @UnitStatus
            END
        ELSE IF @ProjectId > 0
                AND @ProjStatus <> '--ALL--'
                AND
                    (
                        @UnitStatus = ''
                        OR @UnitStatus = '--ALL--'
                    )
            BEGIN
                SELECT  DISTINCT
                        [tblUnitMstr].[RecId],
                        [tblUnitMstr].[ProjectId],
                        ISNULL([tblProjectMstr].[ProjectName], '')                                               AS [ProjectName],
                        FORMAT(ISNULL([tblUnitMstr].[TotalRental], 0), 'N2')                                     AS [TotalMonthlyRental],
                        ISNULL([tblUnitMstr].[FloorNo], 0)                                                       AS [FloorNo],
                        ISNULL([tblUnitMstr].[AreaSqm], 0)                                                       AS [AreaSqm],
                        ISNULL([tblUnitMstr].[AreaRateSqm], 0)                                                   AS [AreaRateSqm],
                        IIF([tblUnitMstr].[FloorType] = '--SELECT--', '', ISNULL([tblUnitMstr].[FloorType], '')) AS [FloorType],
                        ISNULL([tblUnitMstr].[BaseRental], 0)                                                    AS [BaseRental],
                        CASE
                            WHEN ISNULL([tblUnitMstr].[UnitStatus], '') = 'RESERVED'
                                THEN
                                ISNULL([tblUnitMstr].[UnitStatus], '') + ' TO : '
                                + ISNULL(CAST([tblUnitReference].[ClientID] AS VARCHAR(20)), '') + ' - '
                                + [tblUnitReference].[InquiringClient]
                            WHEN ISNULL([tblUnitMstr].[UnitStatus], '') = 'MOVE-IN'
                                THEN
                                ISNULL([tblUnitMstr].[UnitStatus], '') + '  : '
                                + ISNULL(CAST([tblUnitReference].[ClientID] AS VARCHAR(20)), '') + ' - '
                                + [tblUnitReference].[InquiringClient]
                            ELSE
                                ISNULL([tblUnitMstr].[UnitStatus], '')
                        END                                                                                      AS [UnitStatus],
                        ISNULL([tblUnitMstr].[UnitStatus], '')                                                   AS [UnitStat],
                        ISNULL([tblUnitMstr].[DetailsofProperty], '')                                            AS [DetailsofProperty],
                        ISNULL([tblUnitMstr].[UnitNo], '')                                                       AS [UnitNo],
                        IIF(ISNULL([tblUnitMstr].[IsActive], 0) = 1, 'ACTIVE', 'IN-ACTIVE')                      AS [IsActive],
                        [tblUnitReference].[ClientID]
                FROM
                        [dbo].[tblUnitMstr] WITH (NOLOCK)
                    INNER JOIN
                        [dbo].[tblProjectMstr] WITH (NOLOCK)
                            ON [tblUnitMstr].[ProjectId] = [tblProjectMstr].[RecId]
                    LEFT JOIN
                        [dbo].[tblUnitReference] WITH (NOLOCK)
                            ON [tblUnitReference].[UnitId] = [tblUnitMstr].[RecId]
                WHERE
                        [tblProjectMstr].[RecId] = @ProjectId

            END
        ELSE
            BEGIN
                SELECT  DISTINCT
                        [tblUnitMstr].[RecId],
                        [tblUnitMstr].[ProjectId],
                        ISNULL([tblProjectMstr].[ProjectName], '')                                               AS [ProjectName],
                        FORMAT(ISNULL([tblUnitMstr].[TotalRental], 0), 'N2')                                     AS [TotalMonthlyRental],
                        ISNULL([tblUnitMstr].[FloorNo], 0)                                                       AS [FloorNo],
                        ISNULL([tblUnitMstr].[AreaSqm], 0)                                                       AS [AreaSqm],
                        ISNULL([tblUnitMstr].[AreaRateSqm], 0)                                                   AS [AreaRateSqm],
                        IIF([tblUnitMstr].[FloorType] = '--SELECT--', '', ISNULL([tblUnitMstr].[FloorType], '')) AS [FloorType],
                        ISNULL([tblUnitMstr].[BaseRental], 0)                                                    AS [BaseRental],
                        CASE
                            WHEN ISNULL([tblUnitMstr].[UnitStatus], '') = 'RESERVED'
                                THEN
                                ISNULL([tblUnitMstr].[UnitStatus], '') + ' TO : '
                                + ISNULL(CAST([tblUnitReference].[ClientID] AS VARCHAR(20)), '') + ' - '
                                + [tblUnitReference].[InquiringClient]
                            WHEN ISNULL([tblUnitMstr].[UnitStatus], '') = 'MOVE-IN'
                                THEN
                                ISNULL([tblUnitMstr].[UnitStatus], '') + '  : '
                                + ISNULL(CAST([tblUnitReference].[ClientID] AS VARCHAR(20)), '') + ' - '
                                + [tblUnitReference].[InquiringClient]
                            ELSE
                                ISNULL([tblUnitMstr].[UnitStatus], '')
                        END                                                                                      AS [UnitStatus],
                        ISNULL([tblUnitMstr].[UnitStatus], '')                                                   AS [UnitStat],
                        ISNULL([tblUnitMstr].[DetailsofProperty], '')                                            AS [DetailsofProperty],
                        ISNULL([tblUnitMstr].[UnitNo], '')                                                       AS [UnitNo],
                        IIF(ISNULL([tblUnitMstr].[IsActive], 0) = 1, 'ACTIVE', 'IN-ACTIVE')                      AS [IsActive],
                        [tblUnitReference].[ClientID]
                FROM
                        [dbo].[tblUnitMstr] WITH (NOLOCK)
                    INNER JOIN
                        [dbo].[tblProjectMstr] WITH (NOLOCK)
                            ON [tblUnitMstr].[ProjectId] = [tblProjectMstr].[RecId]
                    LEFT JOIN
                        [dbo].[tblUnitReference] WITH (NOLOCK)
                            ON [tblUnitReference].[UnitId] = [tblUnitMstr].[RecId]
                WHERE
                        [tblProjectMstr].[RecId] = @ProjectId
                        AND [tblUnitMstr].[UnitStatus] = @UnitStatus
            END
    END;
GO
