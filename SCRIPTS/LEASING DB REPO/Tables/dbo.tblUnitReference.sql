CREATE TABLE [dbo].[tblUnitReference]
(
[RecId] [bigint] NOT NULL IDENTITY(10000000, 1),
[RefId] [varchar] (5000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
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
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[tr_tblUnitReference]
ON [dbo].[tblUnitReference]
FOR INSERT
AS
BEGIN

    UPDATE [dbo].[tblUnitReference]
    SET [tblUnitReference].[RefId] = 'REF' + CONVERT([VARCHAR](5000), [Inserted].[RecId])
    FROM [dbo].[tblUnitReference]
        INNER JOIN [Inserted]
            ON [Inserted].[RecId] = [tblUnitReference].[RecId]
    WHERE [Inserted].[RecId] = [tblUnitReference].[RecId]

END
GO
