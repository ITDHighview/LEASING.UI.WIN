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
[Remarks] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
