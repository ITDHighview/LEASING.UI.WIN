USE [LEASINGDB]
ALTER TABLE [dbo].[tblUnitReference]
ADD
    [IsContractApplyMonthlyPenalty] BIT
        DEFAULT 1