SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
--SELECT [dbo].[fnGetSecVatAmount](1004)
-- =============================================
CREATE FUNCTION [dbo].[fnGetSecVatAmount]
(
    -- Add the parameters for the function here
    @UnitId AS INT
)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    -- Declare the return variable here
    DECLARE @SecVatAmount DECIMAL(18, 2)
	DECLARE @SecBaseAmount DECIMAL(18, 2)
    DECLARE @Vat DECIMAL(18, 2)

    -- Add the T-SQL statements to compute the return value here
    SELECT @Vat = [tblRatesSettings].[GenVat],
	@SecBaseAmount = [tblRatesSettings].[SecurityAndMaintenance]
    FROM [dbo].[tblRatesSettings]
    WHERE [tblRatesSettings].[ProjectType] = [dbo].[fnGetProjectTypeByUnitId](@UnitId)
    -- Return the result of the function


    SELECT @SecVatAmount = CAST((@SecBaseAmount * @Vat) / 100 AS DECIMAL(18, 2))
    FROM [dbo].[tblUnitMstr]
    WHERE [tblUnitMstr].[RecId] = @UnitId
    RETURN @SecVatAmount

END
GO
