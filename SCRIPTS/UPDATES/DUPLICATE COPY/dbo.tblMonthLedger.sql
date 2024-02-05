CREATE TABLE [dbo].[tblMonthLedger]
(
[Recid] [int] NOT NULL IDENTITY(1, 1),
[ReferenceID] [int] NULL,
[ClientID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LedgMonth] [date] NULL,
[LedgAmount] [decimal] (18, 2) NULL,
[IsPaid] [bit] NULL,
[EncodedBy] [int] NULL,
[EncodedDate] [datetime] NULL,
[ComputerName] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TransactionID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsHold] [bit] NULL,
[BalanceAmount] [decimal] (18, 2) NULL,
[PenaltyAmount] [decimal] (18, 2) NULL,
[ActualAmount] [decimal] (18, 2) NULL
) ON [PRIMARY]
GO
