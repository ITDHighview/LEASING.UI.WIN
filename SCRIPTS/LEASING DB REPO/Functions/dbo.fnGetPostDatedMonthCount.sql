SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
--SELECT [dbo].[fnGetPostDatedMonthCount](10000000)
-- =============================================
CREATE FUNCTION [dbo].[fnGetPostDatedMonthCount]
(
    -- Add the parameters for the function here
    @RefId AS BIGINT
)
RETURNS INT
AS
BEGIN
    -- Declare the return variable here
    DECLARE @counts INT


    -- Add the T-SQL statements to compute the return value here
    SELECT @counts = COUNT(*)
    FROM [dbo].[tblMonthLedger]
    WHERE [dbo].[tblMonthLedger].[ReferenceID] = @RefId
          AND [tblMonthLedger].[LedgMonth] NOT IN
              (
                  SELECT [tblAdvancePayment].[Months]
                  FROM [dbo].[tblAdvancePayment]
                  WHERE [tblAdvancePayment].[RefId] = 'REF' + CAST(@RefId AS VARCHAR(50))
              )


    RETURN @counts

END
GO
