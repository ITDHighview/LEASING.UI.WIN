USE [LEASINGDB]
GO
/****** Object:  UserDefinedFunction [dbo].[fn_GetUserName]    Script Date: 5/20/2024 1:26:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE OR ALTER FUNCTION [dbo].[fn_GetDateFullName]
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
