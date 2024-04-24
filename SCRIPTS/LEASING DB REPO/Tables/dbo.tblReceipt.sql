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
