SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[fnGetUnitCategoryByUnitId]
(
    -- Add the parameters for the function here
    @UnitId AS INT
)
RETURNS VARCHAR(50)
AS
BEGIN
    -- Declare the return variable here
    DECLARE @CategoryName VARCHAR(50)

    -- Add the T-SQL statements to compute the return value here
    SELECT @CategoryName = IIF(ISNULL([tblUnitMstr].[IsParking], 0) = 1, 'PARKING', 'UNIT')
    FROM [dbo].[tblUnitMstr]
    WHERE [dbo].[tblUnitMstr].[RecId] = @UnitId
    -- Return the result of the function
    RETURN @CategoryName

END
GO
