SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
--SELECT [dbo].[fnGetAdvanceMonthCount]('REF10000000')
-- =============================================
CREATE FUNCTION [dbo].[fnGetAdvanceMonthCount]
(
    -- Add the parameters for the function here
    @RefId AS VARCHAR(50)
)
RETURNS int
AS
BEGIN
    -- Declare the return variable here
    DECLARE @counts int


    -- Add the T-SQL statements to compute the return value here
    SELECT @counts = count(*)       
    FROM [dbo].[tblAdvancePayment]
    WHERE [dbo].[tblAdvancePayment].[RefId] = @RefId


    RETURN @counts

END
GO
