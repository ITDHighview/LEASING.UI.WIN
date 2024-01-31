SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetRateSettingsByType] @ProjectType VARCHAR(20) = NULL
AS
BEGIN

    SET NOCOUNT ON;
    DECLARE @BaseWithVatAmount DECIMAL(18, 2) = 0;


    SELECT @BaseWithVatAmount
        = CAST(ISNULL([tblRatesSettings].[SecurityAndMaintenance], 0)
               + (((ISNULL([tblRatesSettings].[SecurityAndMaintenance], 0) * ISNULL([tblRatesSettings].[GenVat], 0))
                   / 100
                  )
                 ) AS DECIMAL(18, 2))
    FROM [dbo].[tblRatesSettings] WITH (NOLOCK)
    WHERE [tblRatesSettings].[ProjectType] = @ProjectType;


    SELECT [tblRatesSettings].[ProjectType],
           ISNULL([tblRatesSettings].[GenVat], 0) AS [GenVat],
           CAST(ISNULL([tblRatesSettings].[SecurityAndMaintenance], 0)
                + (((ISNULL([tblRatesSettings].[SecurityAndMaintenance], 0) * ISNULL([tblRatesSettings].[GenVat], 0))
                    / 100
                   ) - ((@BaseWithVatAmount * ISNULL([tblRatesSettings].[WithHoldingTax], 0)) / 100)
                  ) AS DECIMAL(18, 2)) AS [SecurityAndMaintenance],
           ISNULL([tblRatesSettings].[SecurityAndMaintenanceVat], 0) AS [SecurityAndMaintenanceVat],
           ISNULL([tblRatesSettings].[IsSecAndMaintVat], 0) AS [IsSecAndMaintVat],
           ISNULL([tblRatesSettings].[WithHoldingTax], 0) AS [WithHoldingTax],
           ISNULL([tblRatesSettings].[PenaltyPct], 0) AS [PenaltyPct],
           ISNULL([tblRatesSettings].[EncodedBy], 0) AS [EncodedBy],
           ISNULL([tblRatesSettings].[EncodedDate], '1900-01-01') AS [EncodedDate],
           ISNULL([tblRatesSettings].[ComputerName], '') AS [ComputerName],
           IIF(ISNULL([tblRatesSettings].[GenVat], 0) > 0, 'INCLUSIVE OF VAT', 'EXCLUSIVE OF VAT') AS [labelVat]
    FROM [dbo].[tblRatesSettings] WITH (NOLOCK)
    WHERE [tblRatesSettings].[ProjectType] = @ProjectType;

END;
GO
