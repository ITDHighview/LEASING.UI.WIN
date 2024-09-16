USE [LEASINGDB]
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_GetLedgerListOnQueTotalAMount] @XML XML = NULL
AS
    BEGIN

        SET NOCOUNT ON;
        CREATE TABLE [#tblBulkAmount]
            (
                [LedgAmount] DECIMAL(18, 2)
            )
        CREATE TABLE [#tblBulkPostdatedMonth]
            (
                [Recid] VARCHAR(10)
            )
        IF (@XML IS NOT NULL)
            BEGIN
                INSERT INTO [#tblBulkPostdatedMonth]
                    (
                        [Recid]
                    )
                            SELECT
                                [ParaValues].[data].[value]('c1[1]', 'VARCHAR(10)')
                            FROM
                                @XML.[nodes]('/Table1') AS [ParaValues]([data])
            END

        INSERT INTO [#tblBulkAmount]
            (
                [LedgAmount]
            )
                    SELECT
                        CASE
                            WHEN ISNULL([tblMonthLedger].[BalanceAmount], 0) > 0
                                THEN
                                ISNULL([tblMonthLedger].[BalanceAmount], 0)
                            ELSE
                        (ISNULL([tblMonthLedger].[LedgRentalAmount], 0) + ISNULL([tblMonthLedger].[PenaltyAmount], 0))
                        END AS [LedgAmount]
                    FROM
                        [dbo].[tblMonthLedger]
                    WHERE
                        [tblMonthLedger].[Recid] IN
                            (
                                SELECT
                                    [#tblBulkPostdatedMonth].[Recid]
                                FROM
                                    [#tblBulkPostdatedMonth]
                            )


        SELECT
            FORMAT(SUM([#tblBulkAmount].[LedgAmount]), 'N2') AS [TOTAL_AMOUNT]
        FROM
            [#tblBulkAmount]

        DROP TABLE [#tblBulkPostdatedMonth]
        DROP TABLE [#tblBulkAmount]
    END;
GO

