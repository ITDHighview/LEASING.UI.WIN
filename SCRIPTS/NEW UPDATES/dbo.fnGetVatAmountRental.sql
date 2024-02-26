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
CREATE FUNCTION [dbo].[fnGetVatAmountRental]
(
    -- Add the parameters for the function here
    @UnitId AS INT
)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    -- Declare the return variable here
    DECLARE @VatAmount DECIMAL(18, 2)
    DECLARE @Vat DECIMAL(18, 2)

    -- Add the T-SQL statements to compute the return value here
    SELECT @Vat = [tblRatesSettings].[GenVat]
    FROM [dbo].[tblRatesSettings]
    WHERE [tblRatesSettings].[ProjectType] = [dbo].[fnGetProjectTypeByUnitId](@UnitId)
    -- Return the result of the function


    SELECT @VatAmount = CAST(([tblUnitMstr].[BaseRental] * @Vat) / 100 AS DECIMAL(18,2))
    FROM [dbo].[tblUnitMstr]
    WHERE [tblUnitMstr].[RecId] = @UnitId
    RETURN @VatAmount

END
GO
