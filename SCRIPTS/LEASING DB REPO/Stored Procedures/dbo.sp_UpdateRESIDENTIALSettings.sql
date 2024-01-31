SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UpdateRESIDENTIALSettings]
    @GenVat DECIMAL(18, 2) = NULL,
    @SecurityAndMaintenance DECIMAL(18, 2) = NULL,
    @PenaltyPct DECIMAL(18, 2) = NULL,
    @LastChangedBy INT = NULL
AS
BEGIN

    SET NOCOUNT ON;


    UPDATE [dbo].[tblRatesSettings]
    SET [tblRatesSettings].[GenVat] = @GenVat,
        [tblRatesSettings].[SecurityAndMaintenance] = @SecurityAndMaintenance,
        [tblRatesSettings].[PenaltyPct] = @PenaltyPct,
        [tblRatesSettings].[LastChangedBy] = @LastChangedBy,
        [tblRatesSettings].[LastChangedDate] = GETDATE()
    WHERE [tblRatesSettings].[ProjectType] = 'RESIDENTIAL';

    IF (@@ROWCOUNT > 0)
    BEGIN
        SELECT 'SUCCESS' AS [Message_Code];
    END;
    ELSE
    BEGIN
        SELECT ERROR_MESSAGE() AS [Message_Code];
    END;

END;
GO
