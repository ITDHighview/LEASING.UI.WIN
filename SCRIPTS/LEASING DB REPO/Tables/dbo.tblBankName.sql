CREATE TABLE [dbo].[tblBankName]
(
[RecId] [int] NOT NULL IDENTITY(1, 1),
[BankName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblBankName_BankName] ON [dbo].[tblBankName] ([BankName]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblBankName_RecId] ON [dbo].[tblBankName] ([RecId]) ON [PRIMARY]
GO
