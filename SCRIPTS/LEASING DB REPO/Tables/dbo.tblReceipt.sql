CREATE TABLE [dbo].[tblReceipt]
(
[RecId] [int] NOT NULL IDENTITY(10000000, 1),
[RcptID] AS ('RCPT'+CONVERT([varchar](10),[RecId],(0))),
[TranId] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Amount] [decimal] (18, 2) NULL,
[Description] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Remarks] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EncodedBy] [int] NULL,
[EncodedDate] [datetime] NULL,
[LastChangedBy] [int] NULL,
[LastChangedDate] [datetime] NULL,
[ComputerName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsActive] [bit] NULL,
[PaymentMethod] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CompanyORNo] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BankAccountName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BankAccountNumber] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BankName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SerialNo] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[REF] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CompanyPRNo] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
