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
[BankBranch] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblPaymentMode] ADD CONSTRAINT [PK__tblPayme__360414DF7CA23D95] PRIMARY KEY CLUSTERED ([RecId]) ON [PRIMARY]
GO
