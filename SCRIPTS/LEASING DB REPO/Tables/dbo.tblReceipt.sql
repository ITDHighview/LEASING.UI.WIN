CREATE TABLE [dbo].[tblReceipt]
(
[RecId] [bigint] NOT NULL IDENTITY(10000000, 1),
[RcptID] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TranId] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
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
[CompanyORNo] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BankAccountName] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BankAccountNumber] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BankName] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SerialNo] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[REF] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CompanyPRNo] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Category] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BankBranch] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RefId] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ReceiptDate] [datetime] NULL
) ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[tr_tblReceipt]
ON [dbo].[tblReceipt]
FOR INSERT
AS
BEGIN

    UPDATE [dbo].[tblReceipt]
    SET [tblReceipt].[RcptID] = 'RCPT' + CONVERT([VARCHAR](5000), [Inserted].[RecId])
    FROM [dbo].[tblReceipt]
        INNER JOIN [Inserted]
            ON [Inserted].[RecId] = [tblReceipt].[RecId]
    WHERE [Inserted].[RecId] = [tblReceipt].[RecId]

END
GO
CREATE NONCLUSTERED INDEX [IdxtblReceipt_Amount] ON [dbo].[tblReceipt] ([Amount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblReceipt_BankAccountName] ON [dbo].[tblReceipt] ([BankAccountName]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblReceipt_BankAccountNumber] ON [dbo].[tblReceipt] ([BankAccountNumber]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblReceipt_BankBranch] ON [dbo].[tblReceipt] ([BankBranch]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblReceipt_BankName] ON [dbo].[tblReceipt] ([BankName]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblReceipt_Category] ON [dbo].[tblReceipt] ([Category]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblReceipt_CompanyORNo] ON [dbo].[tblReceipt] ([CompanyORNo]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblReceipt_CompanyPRNo] ON [dbo].[tblReceipt] ([CompanyPRNo]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblReceipt_Description] ON [dbo].[tblReceipt] ([Description]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblReceipt_EncodedBy] ON [dbo].[tblReceipt] ([EncodedBy]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblReceipt_EncodedDate] ON [dbo].[tblReceipt] ([EncodedDate]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblReceipt_IsActive] ON [dbo].[tblReceipt] ([IsActive]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblReceipt_LastChangedBy] ON [dbo].[tblReceipt] ([LastChangedBy]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblReceipt_LastChangedDate] ON [dbo].[tblReceipt] ([LastChangedDate]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblReceipt_PaymentMethod] ON [dbo].[tblReceipt] ([PaymentMethod]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblReceipt_RcptID] ON [dbo].[tblReceipt] ([RcptID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblReceipt_ReceiptDate] ON [dbo].[tblReceipt] ([ReceiptDate]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblReceipt_RecId] ON [dbo].[tblReceipt] ([RecId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblReceipt_REF] ON [dbo].[tblReceipt] ([REF]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblReceipt_RefId] ON [dbo].[tblReceipt] ([RefId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblReceipt_Remarks] ON [dbo].[tblReceipt] ([Remarks]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblReceipt_SerialNo] ON [dbo].[tblReceipt] ([SerialNo]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblReceipt_TranIdD] ON [dbo].[tblReceipt] ([TranId]) ON [PRIMARY]
GO
