USE [LEASINGDB]

ALTER TABLE [dbo].[tblMonthLedger]
ADD
    [IsAdvanceMonth] BIT
        DEFAULT 0,
    [IsFreeMonth] BIT
        DEFAULT 0,
    AdvanceMonthAmount DECIMAL(18, 2)
        DEFAULT 0


