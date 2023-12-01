-- ================================================
-- Template generated from Template Explorer using:
-- Create Scalar Function (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the function.
-- ================================================
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
ALTER FUNCTION [fn_GetUserGroupName]
    (
        -- Add the parameters for the function here
        @UserId INT
    )
RETURNS VARCHAR(100)
AS
    BEGIN
        -- Declare the return variable here
        DECLARE @GroupName VARCHAR(100);

        -- Add the T-SQL statements to compute the return value here
        SELECT
                @GroupName = [tblGroup].[GroupName]
        FROM
                [dbo].[tblUser] WITH (NOLOCK)
            INNER JOIN
                [dbo].[tblGroup] WITH (NOLOCK)
                    ON [tblGroup].[GroupId] = [tblUser].[GroupId]
        WHERE
                [tblUser].[UserId] = @UserId;

        -- Return the result of the function
        RETURN @GroupName;

    END;
GO

