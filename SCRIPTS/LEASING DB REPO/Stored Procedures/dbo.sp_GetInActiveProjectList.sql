SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetInActiveProjectList]
AS
    BEGIN

        SET NOCOUNT ON;


        SELECT
                [tblProjectMstr].[RecId],
                [tblProjectMstr].[LocId],
                [tblProjectMstr].[ProjectAddress],
                [tblLocationMstr].[Descriptions]                                       AS [LocationName],
                [tblProjectMstr].[ProjectName],
                [tblProjectMstr].[Descriptions],
                IIF(ISNULL([tblProjectMstr].[IsActive], 0) = 1, 'ACTIVE', 'IN-ACTIVE') AS [IsActive]
        FROM
                [dbo].[tblProjectMstr] WITH (NOLOCK)
            INNER JOIN
                [dbo].[tblLocationMstr] WITH (NOLOCK)
                    ON [tblLocationMstr].[RecId] = [tblProjectMstr].[LocId]
        WHERE
                ISNULL([tblProjectMstr].[IsActive], 0) = 0;

    END;
GO
