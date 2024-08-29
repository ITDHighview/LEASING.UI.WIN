SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE   FUNCTION [dbo].[fnGetClientTypeCode]
    (
        -- Add the parameters for the function here
        @ClientType AS VARCHAR(150) = NULL
    )
RETURNS VARCHAR(50)
AS
    BEGIN
        -- Declare the return variable here
        DECLARE @ClientTypeCode VARCHAR(50)

        -- Add the T-SQL statements to compute the return value here
        SELECT
            @ClientTypeCode = [tblSetupClientType].[ClientCode]
        FROM
            [dbo].[tblSetupClientType]
        WHERE
            [dbo].[tblSetupClientType].[ClientType] = @ClientType
        -- Return the result of the function
        RETURN @ClientTypeCode
    END
GO
