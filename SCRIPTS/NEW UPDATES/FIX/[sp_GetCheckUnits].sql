USE [LEASINGDB]
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- EXEC [sp_GetUnitByProjectId] @ProjectId = 1
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_GetCheckUnits]
    @ProjectId INT          = NULL,
    @UnitType  VARCHAR(150) = NULL
AS
    BEGIN

        SET NOCOUNT ON;
        DECLARE @Flag BIT = 0;

        IF (@UnitType = 'UNIT')
            BEGIN
                SET @Flag = 0

            END
        ELSE
            BEGIN
                SET @Flag = 1
            END
        SELECT  DISTINCT
                [tblUnitMstr].[RecId],
                [tblUnitMstr].[ProjectId],
                ISNULL([tblProjectMstr].[ProjectName], '')                                       AS [ProjectName],
                IIF(ISNULL([tblUnitMstr].[IsParking], 0) = 1, 'TYPE OF PARKING', 'TYPE OF UNIT') AS [UnitDescription],
                ISNULL([tblUnitMstr].[FloorNo], 0)                                               AS [FloorNo],
                ISNULL([tblUnitMstr].[AreaSqm], 0)                                               AS [AreaSqm],
                FORMAT(ISNULL([tblUnitMstr].[AreaRateSqm], 0), 'N2')                             AS [AreaRateSqm],
                ISNULL([tblUnitMstr].[FloorType], '')                                            AS [FloorType],
                FORMAT(ISNULL([tblUnitMstr].[BaseRental], 0), 'N2')                              AS [BaseRental],
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
                END                                                                              AS [UnitStatus],
                ISNULL([tblUnitMstr].[UnitStatus], '')                                           AS [UnitStat],
                ISNULL([tblUnitMstr].[DetailsofProperty], '')                                    AS [DetailsofProperty],
                ISNULL([tblUnitMstr].[UnitNo], '')                                               AS [UnitNo],
                IIF(ISNULL([tblUnitMstr].[IsActive], 0) = 1, 'ACTIVE', 'IN-ACTIVE')              AS [IsActive]
        FROM
                [dbo].[tblUnitMstr] WITH (NOLOCK)
            INNER JOIN
                [dbo].[tblProjectMstr] WITH (NOLOCK)
                    ON [tblUnitMstr].[ProjectId] = [tblProjectMstr].[RecId]
            LEFT JOIN
                [dbo].[tblUnitReference] WITH (NOLOCK)
                    ON [tblUnitMstr].[RecId] = [tblUnitReference].[UnitId]
        WHERE
                [tblUnitMstr].[ProjectId] = @ProjectId
                AND ISNULL([tblUnitMstr].[IsParking], 0) = @Flag

    END;
GO

