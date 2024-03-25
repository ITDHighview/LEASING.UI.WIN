SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnGetProjectNameById]
(
    -- Add the parameters for the function here
    @ProjectId AS INT
)
RETURNS VARCHAR(50)
AS
BEGIN
    -- Declare the return variable here
    DECLARE @ProjectName VARCHAR(150)

    -- Add the T-SQL statements to compute the return value here
    SELECT @ProjectName = [tblProjectMstr].[ProjectName]
    FROM [dbo].[tblProjectMstr]
    WHERE [dbo].[tblProjectMstr].[RecId] = @ProjectId
    -- Return the result of the function
    RETURN @ProjectName

END
GO
