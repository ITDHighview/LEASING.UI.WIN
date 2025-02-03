USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetComputationById]    Script Date: 12/2/2024 5:34:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC [sp_GetLedgerTotalPaidAmountByContractId] 10000000
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_GetLedgerTotalPaidAmountByContractId] @ContractId INT = NULL
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;


        SELECT
            FORMAT(ISNULL(SUM([tblTransaction].[ReceiveAmount]), 0), 'N2') AS [LedgerTotalPaidAmount]
        FROM
            [dbo].[tblTransaction]
        WHERE
            [tblTransaction].[RefId] = CONCAT('REF', CAST(@ContractId AS VARCHAR(150)))
        GROUP BY
            [tblTransaction].[RefId]

    END;
