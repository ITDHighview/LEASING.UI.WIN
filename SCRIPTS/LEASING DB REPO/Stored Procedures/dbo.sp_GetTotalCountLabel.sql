SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_GetTotalCountLabel]

-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN

    SELECT
        (
            SELECT COUNT(*)FROM [dbo].[tblLocationMstr]
       ) AS [TotalLocation],
        (
            SELECT COUNT(*)FROM [dbo].[tblProjectMstr]
        ) AS [TotalProject],
        (
            SELECT COUNT(*)FROM [dbo].[tblClientMstr]
        ) AS [TotalClient],
        (
            SELECT COUNT(*)
            FROM [dbo].[tblUnitReference]
            WHERE ISNULL([tblUnitReference].[IsDone], 0) = 0
        ) AS [TotalActiveContract];
END;
GO
