SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE   FUNCTION [dbo].[fn_GetDateFullName]
    (
        -- Add the parameters for the function here
        @dates DATETIME
    )
RETURNS VARCHAR(100)
AS
    BEGIN
        -- Declare the return variable here
        DECLARE @DateFullName VARCHAR(100);

        -- Add the T-SQL statements to compute the return value here
        SELECT
            @DateFullName
            = CAST(DATENAME(MONTH, @dates) AS VARCHAR(150)) + ' ' + CAST(DATENAME(DAY, @dates) AS VARCHAR(150)) + ', '
              + CAST(DATENAME(YEAR, @dates) AS VARCHAR(150))

        -- Return the result of the function
        RETURN @DateFullName;

    END;
GO
