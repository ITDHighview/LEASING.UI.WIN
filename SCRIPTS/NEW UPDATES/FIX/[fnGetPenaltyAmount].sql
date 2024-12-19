USE [LEASINGDB]
GO
/****** Object:  UserDefinedFunction [dbo].[fnGetVatAmountRental]    Script Date: 12/16/2024 6:56:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
--SELECT [dbo].[fnGetVatAmountRental](1004)
-- =============================================
CREATE OR ALTER FUNCTION [dbo].[fnGetPenaltyAmount]
    (
        -- Add the parameters for the function here

        @LedgRentalAmount AS DECIMAL(18, 2),
        @PenaltyPct AS       DECIMAL(18, 2),
        @MultiplyBy AS       DECIMAL(18, 2),
        @IsForPenalty AS     BIT
    )
RETURNS DECIMAL(18, 2)
AS
    BEGIN
        -- Declare the return variable here
        DECLARE @Amount DECIMAL(18, 2)



        -- Return the result of the function


        SELECT
            @Amount
            = (IIF(@IsForPenalty = 0,
                   0,
                   CAST((((@LedgRentalAmount * @PenaltyPct) / 100) * @MultiplyBy) AS DECIMAL(18, 2)))
              )

        RETURN @Amount

    END
