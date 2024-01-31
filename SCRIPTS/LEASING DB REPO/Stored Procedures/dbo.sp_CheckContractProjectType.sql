SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_CheckContractProjectType] @RefId AS VARCHAR(20) = NULL
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    SET NOCOUNT ON;

    SELECT [tblUnitReference].[RefId],
           [tblUnitReference].[UnitId],
           [tblUnitMstr].[UnitNo],
           [tblUnitMstr].[FloorType],
           [tblProjectMstr].[ProjectType]
    FROM [dbo].[tblUnitReference]
        INNER JOIN [dbo].[tblUnitMstr]
            ON [tblUnitMstr].[RecId] = [tblUnitReference].[UnitId]
        INNER JOIN [dbo].[tblProjectMstr]
            ON [tblUnitMstr].[ProjectId] = [tblProjectMstr].[RecId]
    WHERE [tblUnitReference].[RefId] = @RefId;
END;
GO
