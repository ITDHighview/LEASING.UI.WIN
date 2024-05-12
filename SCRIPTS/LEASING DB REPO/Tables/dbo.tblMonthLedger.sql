CREATE TABLE [dbo].[tblMonthLedger]
(
[Recid] [bigint] NOT NULL IDENTITY(1, 1),
[ReferenceID] [bigint] NULL,
[ClientID] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LedgMonth] [date] NULL,
[LedgAmount] [decimal] (18, 2) NULL,
[IsPaid] [bit] NULL,
[EncodedBy] [int] NULL,
[EncodedDate] [datetime] NULL,
[ComputerName] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TransactionID] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsHold] [bit] NULL,
[BalanceAmount] [decimal] (18, 2) NULL,
[PenaltyAmount] [decimal] (18, 2) NULL,
[ActualAmount] [decimal] (18, 2) NULL,
[LedgRentalAmount] [decimal] (18, 2) NULL,
[Remarks] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Unit_ProjectType] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Unit_IsNonVat] [bit] NULL,
[Unit_BaseRentalVatAmount] [decimal] (18, 2) NULL,
[Unit_BaseRentalWithVatAmount] [decimal] (18, 2) NULL,
[Unit_BaseRentalTax] [decimal] (18, 2) NULL,
[Unit_TotalRental] [decimal] (18, 2) NULL,
[Unit_SecAndMainAmount] [decimal] (18, 2) NULL,
[Unit_SecAndMainVatAmount] [decimal] (18, 2) NULL,
[Unit_SecAndMainWithVatAmount] [decimal] (18, 2) NULL,
[Unit_Vat] [decimal] (18, 2) NULL,
[Unit_Tax] [decimal] (18, 2) NULL,
[Unit_TaxAmount] [decimal] (18, 2) NULL,
[Unit_IsParking] [bit] NULL,
[Unit_AreaTotalAmount] [decimal] (18, 2) NULL,
[Unit_AreaSqm] [decimal] (18, 2) NULL,
[Unit_AreaRateSqm] [decimal] (18, 2) NULL,
[IsRenewal] [bit] NULL,
[CompanyORNo] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[REF] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BNK_ACCT_NAME] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BNK_ACCT_NUMBER] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BNK_NAME] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SERIAL_NO] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ModeType] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CompanyPRNo] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BankBranch] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_ActualAmount] ON [dbo].[tblMonthLedger] ([ActualAmount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_BalanceAmount] ON [dbo].[tblMonthLedger] ([BalanceAmount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_BankBranch] ON [dbo].[tblMonthLedger] ([BankBranch]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_BNK_ACCT_NAME] ON [dbo].[tblMonthLedger] ([BNK_ACCT_NAME]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_BNK_ACCT_NUMBER] ON [dbo].[tblMonthLedger] ([BNK_ACCT_NUMBER]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_BNK_NAME] ON [dbo].[tblMonthLedger] ([BNK_NAME]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_ClientID] ON [dbo].[tblMonthLedger] ([ClientID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_CompanyORNo] ON [dbo].[tblMonthLedger] ([CompanyORNo]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_CompanyPRNo] ON [dbo].[tblMonthLedger] ([CompanyPRNo]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_EncodedBy] ON [dbo].[tblMonthLedger] ([EncodedBy]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_EncodedDate] ON [dbo].[tblMonthLedger] ([EncodedDate]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_IsHold] ON [dbo].[tblMonthLedger] ([IsHold]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_IsPaid] ON [dbo].[tblMonthLedger] ([IsPaid]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_IsRenewal] ON [dbo].[tblMonthLedger] ([IsRenewal]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_LedgAmount] ON [dbo].[tblMonthLedger] ([LedgAmount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_LedgMonth] ON [dbo].[tblMonthLedger] ([LedgMonth]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_LedgRentalAmount] ON [dbo].[tblMonthLedger] ([LedgRentalAmount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_ModeType] ON [dbo].[tblMonthLedger] ([ModeType]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_PenaltyAmount] ON [dbo].[tblMonthLedger] ([PenaltyAmount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_RecId] ON [dbo].[tblMonthLedger] ([Recid]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_REF] ON [dbo].[tblMonthLedger] ([REF]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_ReferenceID] ON [dbo].[tblMonthLedger] ([ReferenceID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_SERIAL_NO] ON [dbo].[tblMonthLedger] ([SERIAL_NO]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_TransactionID] ON [dbo].[tblMonthLedger] ([TransactionID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_Unit_AreaRateSqm] ON [dbo].[tblMonthLedger] ([Unit_AreaRateSqm]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_Unit_AreaSqm] ON [dbo].[tblMonthLedger] ([Unit_AreaSqm]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_Unit_AreaTotalAmount] ON [dbo].[tblMonthLedger] ([Unit_AreaTotalAmount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_Unit_BaseRentalTax] ON [dbo].[tblMonthLedger] ([Unit_BaseRentalTax]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_Unit_BaseRentalVatAmount] ON [dbo].[tblMonthLedger] ([Unit_BaseRentalVatAmount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_Unit_BaseRentalWithVatAmount] ON [dbo].[tblMonthLedger] ([Unit_BaseRentalWithVatAmount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_Unit_IsNonVat] ON [dbo].[tblMonthLedger] ([Unit_IsNonVat]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_Unit_IsParking] ON [dbo].[tblMonthLedger] ([Unit_IsParking]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_Unit_ProjectType] ON [dbo].[tblMonthLedger] ([Unit_ProjectType]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_Unit_SecAndMainAmount] ON [dbo].[tblMonthLedger] ([Unit_SecAndMainAmount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_Unit_SecAndMainVatAmount] ON [dbo].[tblMonthLedger] ([Unit_SecAndMainVatAmount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_Unit_SecAndMainWithVatAmount] ON [dbo].[tblMonthLedger] ([Unit_SecAndMainWithVatAmount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_Unit_Tax] ON [dbo].[tblMonthLedger] ([Unit_Tax]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_Unit_TaxAmount] ON [dbo].[tblMonthLedger] ([Unit_TaxAmount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_Unit_TotalRental] ON [dbo].[tblMonthLedger] ([Unit_TotalRental]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblMonthLedger_Unit_Vat] ON [dbo].[tblMonthLedger] ([Unit_Vat]) ON [PRIMARY]
GO
