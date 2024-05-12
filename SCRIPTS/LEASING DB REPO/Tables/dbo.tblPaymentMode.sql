CREATE TABLE [dbo].[tblPaymentMode]
(
[RecId] [int] NOT NULL IDENTITY(1, 1),
[RcptID] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CompanyORNo] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[REF] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BNK_ACCT_NAME] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BNK_ACCT_NUMBER] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BNK_NAME] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SERIAL_NO] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ModeType] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CompanyPRNo] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BankBranch] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ReceiptDate] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblPaymentMode] ADD CONSTRAINT [PK__tblPayme__360414DF7CA23D95] PRIMARY KEY CLUSTERED ([RecId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblPaymentMode_BankBranch] ON [dbo].[tblPaymentMode] ([BankBranch]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblPaymentMode_BNK_ACCT_NAME] ON [dbo].[tblPaymentMode] ([BNK_ACCT_NAME]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblPaymentMode_BNK_ACCT_NUMBER] ON [dbo].[tblPaymentMode] ([BNK_ACCT_NUMBER]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblPaymentMode_BNK_NAME] ON [dbo].[tblPaymentMode] ([BNK_NAME]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblPaymentMode_CompanyORNo] ON [dbo].[tblPaymentMode] ([CompanyORNo]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblPaymentMode_CompanyPRNo] ON [dbo].[tblPaymentMode] ([CompanyPRNo]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblPaymentMode_ModeType] ON [dbo].[tblPaymentMode] ([ModeType]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblPaymentMode_RcptID] ON [dbo].[tblPaymentMode] ([RcptID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblPaymentMode_ReceiptDate] ON [dbo].[tblPaymentMode] ([ReceiptDate]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblPaymentMode_RecId] ON [dbo].[tblPaymentMode] ([RecId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblPaymentMode_REF] ON [dbo].[tblPaymentMode] ([REF]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblPaymentMode_SERIAL_NO] ON [dbo].[tblPaymentMode] ([SERIAL_NO]) ON [PRIMARY]
GO
