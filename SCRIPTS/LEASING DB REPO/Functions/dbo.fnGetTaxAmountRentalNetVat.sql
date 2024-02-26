SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
--SELECT [dbo].[fnGetVatAmountRental](1004)
-- =============================================
CREATE FUNCTION [dbo].[fnGetTaxAmountRentalNetVat]
(
    -- Add the parameters for the function here
    @UnitId AS INT
)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    -- Declare the return variable here
    DECLARE @AmountWithVat DECIMAL(18, 2)
    DECLARE @TaxAmount DECIMAL(18, 2)
    DECLARE @Vat DECIMAL(18, 2)
    DECLARE @Tax DECIMAL(18, 2)

    -- Add the T-SQL statements to compute the return value here
    SELECT @Tax = ISNULL([tblRatesSettings].[WithHoldingTax], 0),
           @Vat = ISNULL([tblRatesSettings].[GenVat], 0)
    FROM [dbo].[tblRatesSettings]
    WHERE [tblRatesSettings].[ProjectType] = [dbo].[fnGetProjectTypeByUnitId](@UnitId)
    -- Return the result of the function


    SELECT @AmountWithVat = (([tblUnitMstr].[BaseRental] * @Vat) / 100) + [tblUnitMstr].[BaseRental]
    FROM [dbo].[tblUnitMstr]
    WHERE [tblUnitMstr].[RecId] = @UnitId

    SET @TaxAmount = ((@AmountWithVat * @Tax) / 100)

    RETURN @TaxAmount

END
GO
