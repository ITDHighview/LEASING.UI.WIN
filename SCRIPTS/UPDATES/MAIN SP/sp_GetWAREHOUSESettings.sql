USE [LEASINGDB];
GO
/****** Object:  StoredProcedure [dbo].[sp_GetWAREHOUSESettings]    Script Date: 11/9/2023 10:03:09 PM ******/
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetWAREHOUSESettings]
AS
    BEGIN

        SET NOCOUNT ON;


        SELECT
            [tblRatesSettings].[ProjectType],
            ISNULL([tblRatesSettings].[GenVat], 0)                 AS [GenVat],
            ISNULL([tblRatesSettings].[SecurityAndMaintenance], 0) AS [SecurityAndMaintenance],
            ISNULL([tblRatesSettings].[WithHoldingTax], 0)         AS [WithHoldingTax],
            [tblRatesSettings].[EncodedBy],
            [tblRatesSettings].[EncodedDate],
            [tblRatesSettings].[ComputerName]
        FROM
            [dbo].[tblRatesSettings]
        WHERE
            [tblRatesSettings].[ProjectType] = 'WAREHOUSE';

    END;
