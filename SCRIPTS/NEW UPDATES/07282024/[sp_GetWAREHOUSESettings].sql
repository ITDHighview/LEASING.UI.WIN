USE [LEASINGDB]
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_GetWAREHOUSESettings]
AS
    BEGIN

        SET NOCOUNT ON;


        SELECT
            [tblRatesSettings].[ProjectType],
            ISNULL([tblRatesSettings].[GenVat], 0)                               AS [GenVat],
            FORMAT(ISNULL([tblRatesSettings].[SecurityAndMaintenance], 0), 'N2') AS [SecurityAndMaintenance],
            ISNULL([tblRatesSettings].[WithHoldingTax], 0)                       AS [WithHoldingTax],
            ISNULL([tblRatesSettings].[PenaltyPct], 0)                           AS [PenaltyPct],
            [tblRatesSettings].[EncodedBy],
            [tblRatesSettings].[EncodedDate],
            [tblRatesSettings].[ComputerName]
        FROM
            [dbo].[tblRatesSettings]
        WHERE
            [tblRatesSettings].[ProjectType] = 'WAREHOUSE';

    END;
GO

