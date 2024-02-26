SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
--SELECT [dbo].[fnGetClientIsRenewal]('INDV10000000',3)
-- =============================================
CREATE FUNCTION [dbo].[fnGetClientIsRenewal]
(
    -- Add the parameters for the function here
    @ClientID AS VARCHAR(100),
    @ProjectID AS INT
)
RETURNS VARCHAR(100)
AS
BEGIN
    -- Declare the return variable here
    DECLARE @Message VARCHAR(100);

    -- Add the T-SQL statements to compute the return value here
    IF 
    (
        SELECT COUNT(*)
        FROM [dbo].[tblUnitReference]
        WHERE [tblUnitReference].[ClientID] = @ClientID
              AND [tblUnitReference].[ProjectId] = @ProjectID
    )>1
    BEGIN
        SET @Message = 'RENEWAL'
    END
    ELSE
    BEGIN
        SET @Message = ''
    END

    -- Return the result of the function
    RETURN @Message;

END;
GO
