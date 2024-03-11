SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
--SELECT [dbo].[fnGetTotalSecDepositAmountCount]('REF10000000')
-- =============================================
CREATE FUNCTION [dbo].[fnGetTotalSecDepositAmountCount]
(
    -- Add the parameters for the function here
    @RefId AS VARCHAR(50)
)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    -- Declare the return variable here
    DECLARE @Amount DECIMAL(18, 2)


    -- Add the T-SQL statements to compute the return value here
    SELECT @Amount = ([tblUnitReference].[SecDeposit] / [tblUnitReference].[TotalRent])
    FROM [dbo].[tblUnitReference]
    WHERE [tblUnitReference].[RefId] = @RefId



    RETURN @Amount

END
GO
