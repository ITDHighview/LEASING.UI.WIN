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
CREATE OR ALTER FUNCTION [dbo].[fnGetPenaltyResultAmount]
    (
        -- Add the parameters for the function here
        @LedgeMonth AS       DATE,
        @ReferenceID AS      BIGINT,
        @LedgRentalAmount AS DECIMAL(18, 2)
    )
RETURNS DECIMAL(18, 2)
AS
    BEGIN
        -- Declare the return variable here
        DECLARE @PenaltyAmount DECIMAL(18, 2)

        DECLARE @TotalRent DECIMAL(18, 2) = NULL
        DECLARE @PenaltyPct DECIMAL(18, 2) = NULL

        -- Return the result of the function
        SELECT
            @TotalRent  = [tblUnitReference].[TotalRent],
            @PenaltyPct = [tblUnitReference].[PenaltyPct]
        FROM
            [dbo].[tblUnitReference] WITH (NOLOCK)
        WHERE
            [tblUnitReference].[RecId] = @ReferenceID

        SELECT
            @PenaltyAmount
            =
            (
                SELECT
                    [dbo].[fnGetPenaltyAmount](
                                                  @LedgRentalAmount, @PenaltyPct, [tblPenaltySetup].[MultiplyBy],
                                                  [tblPenaltySetup].[IsForPenalty]
                                              )
                FROM
                    [dbo].[tblPenaltySetup]
                WHERE
                    [tblPenaltySetup].[DayCount] = DATEDIFF(DAY, @LedgeMonth, CAST(GETDATE() AS DATE))
            )

        RETURN @PenaltyAmount

    END
