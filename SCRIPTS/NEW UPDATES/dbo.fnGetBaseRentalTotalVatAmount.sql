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
CREATE FUNCTION [dbo].[fnGetBaseRentalTotalVatAmount]
    (
        -- Add the parameters for the function here
        @RefId AS       VARCHAR(150),
        @AmountToPay    DECIMAL(18, 2),
        @PaymentReceive DECIMAL(18, 2)
    )
RETURNS DECIMAL(18, 2)
AS
    BEGIN
        -- Declare the return variable here
        DECLARE @TotalOfVatAmount DECIMAL(18, 2)


        DECLARE @AmountToPayDevidedOfBase INT = 0
        DECLARE @AmountToPayDevidedOfBaseASDecimal DECIMAL(18, 2) = 0

        DECLARE @Vat DECIMAL(18, 2) = 0
        DECLARE @Tax DECIMAL(18, 2) = 0

        DECLARE @Base DECIMAL(18, 2) = 0

        DECLARE @BaseVatAmount DECIMAL(18, 2) = 0
        DECLARE @BaseWithVatAmount DECIMAL(18, 2) = 0

        DECLARE @BaseTaxAmount DECIMAL(18, 2) = 0
        DECLARE @BaseLessTaxAmount DECIMAL(18, 2) = 0
        DECLARE @TotalCountOfTaxAmount DECIMAL(18, 2) = 0
        DECLARE @TaxOfDifferentAmount DECIMAL(18, 2) = 0

        DECLARE @PaymentDifferenceOutOfCalculatedBase DECIMAL(18, 2) = 0
        DECLARE @VatOfDifferentAmount DECIMAL(18, 2) = 0


        DECLARE @TotalCountOfVatAmount DECIMAL(18, 2) = 0
        DECLARE @TotalOfTaxAmount DECIMAL(18, 2) = 0



        SELECT
            @Vat               = [tblUnitReference].[Unit_Vat],
            @Tax               = [tblUnitReference].[Unit_Tax],
            @BaseVatAmount     = [tblUnitReference].[Unit_BaseRentalVatAmount],
            @BaseTaxAmount     = [tblUnitReference].[Unit_TaxAmount],
            @BaseWithVatAmount = [tblUnitReference].[Unit_BaseRentalWithVatAmount]
        FROM
            [dbo].[tblUnitReference]
        WHERE
            [tblUnitReference].[RefId] = @RefId

        SELECT
            @BaseLessTaxAmount = (@BaseWithVatAmount - @BaseTaxAmount)

        IF @AmountToPay > @PaymentReceive
            BEGIN
                SELECT
                    @AmountToPayDevidedOfBase = (@PaymentReceive / @BaseLessTaxAmount)
                SELECT
                    @AmountToPayDevidedOfBaseASDecimal = CAST(@PaymentReceive / @BaseLessTaxAmount AS DECIMAL(18, 2))
                SELECT
                    @TotalCountOfVatAmount = (@AmountToPayDevidedOfBase * @BaseVatAmount)
                SELECT
                    @TotalCountOfTaxAmount = (@AmountToPayDevidedOfBase * @BaseTaxAmount)
                ------------------FOR THE REST OF NOT COMPLETE BASE AMOUNT---------------------------------

                SELECT
                    @PaymentDifferenceOutOfCalculatedBase
                    = (@PaymentReceive - CAST(@AmountToPayDevidedOfBase * @BaseLessTaxAmount AS DECIMAL(18, 2)))
                SELECT
                    @TaxOfDifferentAmount = ((@PaymentDifferenceOutOfCalculatedBase * @Tax) / 100)
                SELECT
                    @VatOfDifferentAmount
                    = (((@TaxOfDifferentAmount + @PaymentDifferenceOutOfCalculatedBase) * @Vat) / 100)

                SELECT
                    @TotalOfVatAmount = @TotalCountOfVatAmount + @VatOfDifferentAmount
                SELECT
                    @TotalOfTaxAmount = @TotalCountOfTaxAmount + @TaxOfDifferentAmount
            END
        ELSE IF @AmountToPay = @PaymentReceive
            BEGIN
                SELECT
                    @AmountToPayDevidedOfBase = (@PaymentReceive / @BaseLessTaxAmount)
                SELECT
                    @AmountToPayDevidedOfBaseASDecimal = CAST(@PaymentReceive / @BaseLessTaxAmount AS DECIMAL(18, 2))
                SELECT
                    @TotalCountOfVatAmount = (@AmountToPayDevidedOfBase * @BaseVatAmount)
                SELECT
                    @TotalCountOfTaxAmount = (@AmountToPayDevidedOfBase * @BaseTaxAmount)

                SELECT
                    @TotalOfVatAmount = @TotalCountOfVatAmount + @VatOfDifferentAmount
                SELECT
                    @TotalOfTaxAmount = @TotalCountOfTaxAmount + @TaxOfDifferentAmount
            END

        RETURN @TotalOfVatAmount


    END
GO
