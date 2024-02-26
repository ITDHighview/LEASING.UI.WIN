SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
--SELECT [dbo].[fnGetPostDatedPeriodCover](10000000)
-- =============================================
CREATE FUNCTION [dbo].[fnGetPostDatedPeriodCover]
(
    -- Add the parameters for the function here
    @RefId AS BIGINT
)
RETURNS VARCHAR(500)
AS
BEGIN
    -- Declare the return variable here
    DECLARE @dates VARCHAR(500)
    --DATEADD(day, 1, '2017/08/25')

    -- Add the T-SQL statements to compute the return value here
    SELECT @dates
        = MIN(CONVERT(VARCHAR(20), DATEADD(DAY, 1, [tblMonthLedger].[LedgMonth]), 107)) + ' - '
          + MAX(CONVERT(VARCHAR(20), [tblMonthLedger].[LedgMonth], 107))
    FROM [dbo].[tblMonthLedger]
    WHERE [dbo].[tblMonthLedger].[ReferenceID] = @RefId
          AND [tblMonthLedger].[LedgMonth] NOT IN
              (
                  SELECT [tblAdvancePayment].[Months]
                  FROM [dbo].[tblAdvancePayment]
                  WHERE [tblAdvancePayment].[RefId] = 'REF' + CAST(@RefId AS VARCHAR(50))
              )


    RETURN @dates

END
GO
