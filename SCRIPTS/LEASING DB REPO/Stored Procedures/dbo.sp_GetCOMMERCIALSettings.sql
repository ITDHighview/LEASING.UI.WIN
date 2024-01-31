SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetCOMMERCIALSettings]
AS
BEGIN

    SET NOCOUNT ON;


    SELECT [tblRatesSettings].[ProjectType],
           ISNULL([tblRatesSettings].[GenVat], 0) AS [GenVat],
           ISNULL([tblRatesSettings].[SecurityAndMaintenance], 0) AS [SecurityAndMaintenance],
           ISNULL([tblRatesSettings].[WithHoldingTax], 0) AS [WithHoldingTax],
           ISNULL([tblRatesSettings].[PenaltyPct], 0) AS [PenaltyPct],
           [tblRatesSettings].[EncodedBy],
           [tblRatesSettings].[EncodedDate],
           [tblRatesSettings].[ComputerName]
    FROM [dbo].[tblRatesSettings]
    WHERE [tblRatesSettings].[ProjectType] = 'COMMERCIAL';

END;
GO
