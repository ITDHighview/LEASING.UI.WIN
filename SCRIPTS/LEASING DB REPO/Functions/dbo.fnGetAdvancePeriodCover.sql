SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
--SELECT [dbo].[fnGetAdvancePeriodCover]('REF10000000')
-- =============================================
CREATE FUNCTION [dbo].[fnGetAdvancePeriodCover]
(
    -- Add the parameters for the function here
    @RefId AS VARCHAR(50)
)
RETURNS VARCHAR(500)
AS
BEGIN
    -- Declare the return variable here
    DECLARE @dates VARCHAR(500)


    -- Add the T-SQL statements to compute the return value here
    SELECT @dates
        = MIN(CONVERT(VARCHAR(20), [tblAdvancePayment].[Months], 107))
          +' - '+ MAX(CONVERT(VARCHAR(20), [tblAdvancePayment].[Months], 107))
    FROM [dbo].[tblAdvancePayment]
    WHERE [dbo].[tblAdvancePayment].[RefId] = @RefId


    RETURN @dates

END
GO
