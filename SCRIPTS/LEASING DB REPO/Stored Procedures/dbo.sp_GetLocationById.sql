SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetLocationById] @RecId INT
AS
    BEGIN

        SET NOCOUNT ON;

        SELECT
            [tblLocationMstr].[RecId],
            [tblLocationMstr].[Descriptions],
            [tblLocationMstr].[LocAddress],
            ISNULL([tblLocationMstr].[IsActive], 0) AS [IsActive]
        FROM
            [dbo].[tblLocationMstr]
        WHERE
            [tblLocationMstr].[RecId] = @RecId
            AND ISNULL([IsActive], 0) = 1;
    END;
GO
