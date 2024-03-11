CREATE TABLE [dbo].[tblAdvancePayment]
(
[RecId] [bigint] NOT NULL IDENTITY(1, 1),
[RefId] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Months] [date] NULL,
[Amount] [decimal] (18, 2) NULL
) ON [PRIMARY]
GO
