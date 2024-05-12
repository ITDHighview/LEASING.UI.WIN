CREATE TABLE [dbo].[tblAdvancePayment]
(
[RecId] [bigint] NOT NULL IDENTITY(1, 1),
[RefId] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Months] [date] NULL,
[Amount] [decimal] (18, 2) NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblAdvancePayment_Amount] ON [dbo].[tblAdvancePayment] ([Amount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblAdvancePayment_Months] ON [dbo].[tblAdvancePayment] ([Months]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblAdvancePayment_RecId] ON [dbo].[tblAdvancePayment] ([RecId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblAdvancePayment_RefId] ON [dbo].[tblAdvancePayment] ([RefId]) ON [PRIMARY]
GO
