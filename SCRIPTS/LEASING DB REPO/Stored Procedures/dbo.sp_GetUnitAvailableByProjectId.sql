SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC [sp_GetUnitAvailableByProjectId] @ProjectId = 1
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetUnitAvailableByProjectId] @ProjectId INT
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        SELECT
            [tblUnitMstr].[RecId],
            ISNULL([tblUnitMstr].[UnitNo], '') AS [UnitNo]
        FROM
            [dbo].[tblUnitMstr]
        WHERE
            [tblUnitMstr].[ProjectId] = @ProjectId
            AND ISNULL([tblUnitMstr].[IsActive], 0) = 1
            AND [tblUnitMstr].[UnitStatus] = 'VACANT'
            AND ISNULL([tblUnitMstr].[IsParking], 0) = 0
        ORDER BY
            [tblUnitMstr].[UnitSequence] DESC;
    END;
GO
