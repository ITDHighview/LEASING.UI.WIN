USE [LEASINGDB]
GO
CREATE OR ALTER PROCEDURE [spTran_AllContractResetNoLapsePenaltyByContractID] @ReferenceID VARCHAR(150) = NULL
AS
    BEGIN
        UPDATE
            [dbo].[tblMonthLedger]
        SET
            [tblMonthLedger].[ActualAmount] = [tblMonthLedger].[LedgRentalAmount],
            [tblMonthLedger].[PenaltyAmount] = 0,
            [tblMonthLedger].[BalanceAmount] = 0
        WHERE
            [tblMonthLedger].[ReferenceID] = @ReferenceID
            AND
                (
                    ISNULL([tblMonthLedger].[IsPaid], 0) = 0
                    OR ISNULL([tblMonthLedger].[IsHold], 0) = 1
                )
    END

