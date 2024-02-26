SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnGetProjectTypeByUnitId]
(
    -- Add the parameters for the function here
    @UnitId AS INT
)
RETURNS VARCHAR(50)
AS
BEGIN
    -- Declare the return variable here
    DECLARE @ProjectType VARCHAR(50)

    -- Add the T-SQL statements to compute the return value here
    SELECT @ProjectType = [tblProjectType].[ProjectTypeName]
    FROM [dbo].[tblUnitMstr]
        INNER JOIN [dbo].[tblProjectMstr]
            ON [tblUnitMstr].[ProjectId] = [tblProjectMstr].[RecId]
        INNER JOIN [dbo].[tblProjectType]
            ON [tblProjectMstr].[ProjectType] = [tblProjectType].[ProjectTypeName]
    WHERE [dbo].[tblUnitMstr].[RecId] = @UnitId
    -- Return the result of the function
    RETURN @ProjectType

END
GO
