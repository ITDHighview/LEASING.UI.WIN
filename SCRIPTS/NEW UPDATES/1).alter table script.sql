ALTER TABLE [tblTransaction] ADD [ActualAmountPaid] [decimal] (18, 2) NULL
ALTER TABLE [tblMonthLedger] ADD [BalanceAmount] [decimal] (18, 2) NULL,
[PenaltyAmount] [decimal] (18, 2) NULL,
[ActualAmount] [decimal] (18, 2) NULL
ALTER TABLE [dbo].[tblProjectMstr] ADD CompanyId INT