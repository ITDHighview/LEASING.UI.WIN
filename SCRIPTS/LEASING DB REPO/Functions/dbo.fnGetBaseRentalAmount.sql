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
CREATE FUNCTION [dbo].[fnGetBaseRentalAmount]
(
    -- Add the parameters for the function here
    @UnitId AS INT
)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    -- Declare the return variable here
    DECLARE @BaseRentalAmount DECIMAL(18, 2)




    SELECT @BaseRentalAmount = [tblUnitMstr].[BaseRental]
    FROM [dbo].[tblUnitMstr]
    WHERE [tblUnitMstr].[RecId] = @UnitId



    RETURN @BaseRentalAmount


END
GO
