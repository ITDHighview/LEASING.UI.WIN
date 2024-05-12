CREATE TABLE [dbo].[tblUnitReference]
(
[RecId] [bigint] NOT NULL IDENTITY(10000000, 1),
[RefId] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ProjectId] [int] NULL,
[InquiringClient] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ClientMobile] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UnitId] [int] NULL,
[UnitNo] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StatDate] [date] NULL,
[FinishDate] [date] NULL,
[TransactionDate] [date] NULL,
[Rental] [decimal] (18, 2) NULL,
[SecAndMaintenance] [decimal] (18, 2) NULL,
[TotalRent] [decimal] (18, 2) NULL,
[SecDeposit] [decimal] (18, 2) NULL,
[Total] [decimal] (18, 2) NULL,
[EncodedBy] [int] NULL,
[EncodedDate] [datetime] NULL,
[LastCHangedBy] [int] NULL,
[LastChangedDate] [datetime] NULL,
[IsActive] [bit] NULL,
[ComputerName] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ClientID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsPaid] [bit] NULL,
[IsDone] [bit] NULL,
[HeaderRefId] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsSignedContract] [bit] NULL,
[IsUnitMove] [bit] NULL,
[IsTerminated] [bit] NULL,
[GenVat] [decimal] (18, 2) NULL,
[WithHoldingTax] [decimal] (18, 2) NULL,
[IsUnitMoveOut] [bit] NULL,
[FirstPaymentDate] [datetime] NULL,
[ContactDoneDate] [datetime] NULL,
[SignedContractDate] [datetime] NULL,
[UnitMoveInDate] [datetime] NULL,
[UnitMoveOutDate] [datetime] NULL,
[TerminationDate] [datetime] NULL,
[AdvancePaymentAmount] [decimal] (18, 2) NULL,
[IsFullPayment] [bit] NULL,
[PenaltyPct] [decimal] (18, 2) NULL,
[IsPartialPayment] [bit] NULL,
[FirtsPaymentBalanceAmount] [decimal] (18, 2) NULL,
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
[Unit_ProjectType] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Unit_AreaTotalAmount] [decimal] (18, 2) NULL,
[Unit_AreaSqm] [decimal] (18, 2) NULL,
[Unit_AreaRateSqm] [decimal] (18, 2) NULL,
[IsRenewal] [bit] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_AdvancePaymentAmount] ON [dbo].[tblUnitReference] ([AdvancePaymentAmount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_ClientID] ON [dbo].[tblUnitReference] ([ClientID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_ClientMobile] ON [dbo].[tblUnitReference] ([ClientMobile]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_ContactDoneDate] ON [dbo].[tblUnitReference] ([ContactDoneDate]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_EncodedBy] ON [dbo].[tblUnitReference] ([EncodedBy]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_EncodedDate] ON [dbo].[tblUnitReference] ([EncodedDate]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_FinishDate] ON [dbo].[tblUnitReference] ([FinishDate]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_FirstPaymentDate] ON [dbo].[tblUnitReference] ([FirstPaymentDate]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_FirtsPaymentBalanceAmount] ON [dbo].[tblUnitReference] ([FirtsPaymentBalanceAmount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_GenVat] ON [dbo].[tblUnitReference] ([GenVat]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_HeaderRefId] ON [dbo].[tblUnitReference] ([HeaderRefId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_InquiringClient] ON [dbo].[tblUnitReference] ([InquiringClient]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_IsActive] ON [dbo].[tblUnitReference] ([IsActive]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_IsDone] ON [dbo].[tblUnitReference] ([IsDone]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_IsFullPayment] ON [dbo].[tblUnitReference] ([IsFullPayment]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_IsPaid] ON [dbo].[tblUnitReference] ([IsPaid]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_IsPartialPayment] ON [dbo].[tblUnitReference] ([IsPartialPayment]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_IsRenewal] ON [dbo].[tblUnitReference] ([IsRenewal]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_IsSignedContract] ON [dbo].[tblUnitReference] ([IsSignedContract]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_IsTerminated] ON [dbo].[tblUnitReference] ([IsTerminated]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_IsUnitMove] ON [dbo].[tblUnitReference] ([IsUnitMove]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_IsUnitMoveOut] ON [dbo].[tblUnitReference] ([IsUnitMoveOut]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_LastCHangedBy] ON [dbo].[tblUnitReference] ([LastCHangedBy]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_LastChangedDate] ON [dbo].[tblUnitReference] ([LastChangedDate]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_PenaltyPct] ON [dbo].[tblUnitReference] ([PenaltyPct]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_ProjectId] ON [dbo].[tblUnitReference] ([ProjectId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_RecId] ON [dbo].[tblUnitReference] ([RecId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_RefId] ON [dbo].[tblUnitReference] ([RefId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_Rental] ON [dbo].[tblUnitReference] ([Rental]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_SecAndMaintenance] ON [dbo].[tblUnitReference] ([SecAndMaintenance]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_SecDeposit] ON [dbo].[tblUnitReference] ([SecDeposit]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_SignedContractDate] ON [dbo].[tblUnitReference] ([SignedContractDate]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_StatDate] ON [dbo].[tblUnitReference] ([StatDate]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_TerminationDate] ON [dbo].[tblUnitReference] ([TerminationDate]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_Total] ON [dbo].[tblUnitReference] ([Total]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_TotalRent] ON [dbo].[tblUnitReference] ([TotalRent]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_TransactionDate] ON [dbo].[tblUnitReference] ([TransactionDate]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_Unit_AreaRateSqm] ON [dbo].[tblUnitReference] ([Unit_AreaRateSqm]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_Unit_AreaSqm] ON [dbo].[tblUnitReference] ([Unit_AreaSqm]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_Unit_AreaTotalAmount] ON [dbo].[tblUnitReference] ([Unit_AreaTotalAmount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_Unit_BaseRentalTax] ON [dbo].[tblUnitReference] ([Unit_BaseRentalTax]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_Unit_BaseRentalVatAmount] ON [dbo].[tblUnitReference] ([Unit_BaseRentalVatAmount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_Unit_BaseRentalWithVatAmount] ON [dbo].[tblUnitReference] ([Unit_BaseRentalWithVatAmount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_Unit_IsNonVat] ON [dbo].[tblUnitReference] ([Unit_IsNonVat]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_Unit_IsParking] ON [dbo].[tblUnitReference] ([Unit_IsParking]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_Unit_ProjectType] ON [dbo].[tblUnitReference] ([Unit_ProjectType]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_Unit_SecAndMainAmount] ON [dbo].[tblUnitReference] ([Unit_SecAndMainAmount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_Unit_SecAndMainVatAmount] ON [dbo].[tblUnitReference] ([Unit_SecAndMainVatAmount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_Unit_SecAndMainWithVatAmount] ON [dbo].[tblUnitReference] ([Unit_SecAndMainWithVatAmount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_Unit_Tax] ON [dbo].[tblUnitReference] ([Unit_Tax]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_Unit_TaxAmount] ON [dbo].[tblUnitReference] ([Unit_TaxAmount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_Unit_TotalRental] ON [dbo].[tblUnitReference] ([Unit_TotalRental]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_Unit_Vat] ON [dbo].[tblUnitReference] ([Unit_Vat]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_UnitId] ON [dbo].[tblUnitReference] ([UnitId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_UnitMoveInDate] ON [dbo].[tblUnitReference] ([UnitMoveInDate]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_UnitMoveOutDate] ON [dbo].[tblUnitReference] ([UnitMoveOutDate]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_UnitNo] ON [dbo].[tblUnitReference] ([UnitNo]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitReference_WithHoldingTax] ON [dbo].[tblUnitReference] ([WithHoldingTax]) ON [PRIMARY]
GO
