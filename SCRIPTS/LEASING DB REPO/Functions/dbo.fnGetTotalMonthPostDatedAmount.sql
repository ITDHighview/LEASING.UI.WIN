SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
--SELECT [dbo].[fnGetTotalMonthAdvanceAmount]('REF10000000')
-- =============================================
CREATE FUNCTION [dbo].[fnGetTotalMonthPostDatedAmount]
(
    -- Add the parameters for the function here
    @RefId AS BIGINT
)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    -- Declare the return variable here
    DECLARE @Amount DECIMAL(18, 2)


    -- Add the T-SQL statements to compute the return value here
    SELECT @Amount = SUM([dbo].[tblMonthLedger].[LedgAmount])
    FROM [dbo].[tblMonthLedger]
    WHERE [tblMonthLedger].[ReferenceID] = @RefId


    RETURN @Amount

END
GO
