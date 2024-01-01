DECLARE @startDate DATE = '2023-02-28';  -- Replace with your actual start date
DECLARE @endDate DATE = '2023-03-01';    -- Replace with your actual end date
DECLARE @thresholdDays INT = 30;          -- Replace with your desired threshold
DECLARE @initialAmount DECIMAL(10, 2) = 1000;  -- Replace with your initial amount

DECLARE @dateDifference INT = DATEDIFF(DAY, @startDate, @endDate);
DECLARE @totalMonths INT;
DECLARE @DifferenceDays INT;


SET @totalMonths = DATEDIFF(MONTH, @startDate, @endDate);
SET @DifferenceDays = @dateDifference - (@totalMonths);

SELECT @totalMonths AS totalMonths
SELECT @dateDifference AS dateDifference
SELECT @DifferenceDays AS DifferenceDays

--SET @remainingDays = @dateDifference - (@totalMonths * @thresholdDays);

