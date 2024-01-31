SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetProjectList]
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        -- Insert statements for procedure here
        SELECT
                [tblProjectMstr].[RecId],
                [tblProjectMstr].[LocId],
                [tblProjectMstr].[ProjectAddress],
                [tblLocationMstr].[Descriptions]                                       AS [LocationName],
                [tblProjectMstr].[ProjectName],
                [tblProjectMstr].[Descriptions],
                IIF(ISNULL([tblProjectMstr].[IsActive], 0) = 1, 'ACTIVE', 'IN-ACTIVE') AS [IsActive]
        FROM
                [dbo].[tblProjectMstr]
            INNER JOIN
                [dbo].[tblLocationMstr]
                    ON [tblLocationMstr].[RecId] = [tblProjectMstr].[LocId]
        WHERE
                ISNULL([tblProjectMstr].[IsActive], 0) = 1;

    END;
GO
