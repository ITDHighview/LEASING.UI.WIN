USE [LEASINGDB];
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateWAREHOUSESettings]    Script Date: 11/9/2023 10:06:23 PM ******/
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_UpdateWAREHOUSESettings]
    @GenVat                 DECIMAL(18, 2) = NULL,
    @SecurityAndMaintenance DECIMAL(18, 2) = NULL,
    @WithHoldingTax         DECIMAL(18, 2) = NULL
AS
    BEGIN

        SET NOCOUNT ON;


        UPDATE
            [dbo].[tblRatesSettings]
        SET
            [tblRatesSettings].[GenVat] = @GenVat,
            [tblRatesSettings].[SecurityAndMaintenance] = @SecurityAndMaintenance,
            [tblRatesSettings].[WithHoldingTax] = @WithHoldingTax
        WHERE
            [tblRatesSettings].[ProjectType] = 'WAREHOUSE';

        IF (@@ROWCOUNT > 0)
            BEGIN
                SELECT
                    'SUCCESS' AS [Message_Code];
            END;


    END;
