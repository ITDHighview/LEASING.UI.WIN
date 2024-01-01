--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
ALTER PROCEDURE [sp_CheckHoldPenalty]
--@parameter_name AS INT
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN

    DECLARE @startDate DATE = '2023-01-01'; -- Replace with your actual start date
    DECLARE @endDate DATE = '2023-01-30'; -- Replace with your actual end date
    DECLARE @thresholdDays INT = 30; -- Replace with your desired threshold
    DECLARE @initialAmount DECIMAL(10, 2) = 1000; -- Replace with your initial amount

    DECLARE @dateDifference INT = DATEDIFF(DAY, @startDate, @endDate);
    DECLARE @totalMonths INT;
    DECLARE @remainingDays INT;
    DECLARE @penaltyPercentage DECIMAL(5, 2);
    DECLARE @penaltyAmount DECIMAL(10, 2);
    DECLARE @message NVARCHAR(100);

    SET @totalMonths = DATEDIFF(MONTH, @startDate, @endDate);
    SET @remainingDays = @dateDifference - (@totalMonths * @thresholdDays);

    -- Calculate penalty based on the conditions
    IF @dateDifference > @thresholdDays
    BEGIN
        -- Calculate penalty percentage based on the number of months
        SET @penaltyPercentage = @totalMonths * 3.00; -- 3% penalty per month

        -- Calculate penalty amount
        SET @penaltyAmount = (@penaltyPercentage / 100) * @initialAmount;

        SET @message = N'Penalty: ' + CAST(@penaltyAmount AS NVARCHAR(20));
    END;
    ELSE
    BEGIN
        SET @message = N'No Penalty';
    END;

    PRINT 'Total Months: ' + CAST(@totalMonths AS NVARCHAR(10)) + ', Remaining Days: '
          + CAST(@remainingDays AS NVARCHAR(10));
    PRINT 'Message: ' + @message;
END;
GO
