USE [LEASINGDB]
GO
CREATE OR ALTER PROCEDURE [spTran_AllContractResetNoLapsePenalty]
AS
    BEGIN
        UPDATE
            [dbo].[tblMonthLedger]
        SET
            [tblMonthLedger].[ActualAmount] = [tblMonthLedger].[LedgRentalAmount],
            [tblMonthLedger].[PenaltyAmount] = 0,
            [tblMonthLedger].[BalanceAmount] = 0
        WHERE
            (
                ISNULL([tblMonthLedger].[IsPaid], 0) = 0
                OR ISNULL([tblMonthLedger].[IsHold], 0) = 1
            )
    END

