SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetProjectById] @RecId INT
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        SELECT
                [tblProjectMstr].[RecId],
                [tblProjectMstr].[ProjectType],
                [tblProjectMstr].[ProjectName],
                [tblProjectMstr].[Descriptions],
                [tblProjectMstr].[ProjectAddress],
                ISNULL([tblProjectMstr].[IsActive], 0) AS [IsActive],
                [tblLocationMstr].[Descriptions]       AS [LocationName],
                [tblLocationMstr].[RecId]              AS [LocationId]
        FROM
                [dbo].[tblProjectMstr]
            INNER JOIN
                [dbo].[tblLocationMstr]
                    ON [tblLocationMstr].[RecId] = [tblProjectMstr].[LocId]
        WHERE
                [tblProjectMstr].[RecId] = @RecId;
    END;

    --SELECT
    --    [tblProjectMstr].[RecId],
    --    [tblProjectMstr].[LocId],
    --    [tblProjectMstr].[ProjectName],
    --    [tblProjectMstr].[Descriptions],
    --    [tblProjectMstr].[IsActive],
    --    [tblProjectMstr].[ProjectAddress],
    --    [tblProjectMstr].[ProjectType]
    --FROM
    --    [dbo].[tblProjectMstr];
GO
