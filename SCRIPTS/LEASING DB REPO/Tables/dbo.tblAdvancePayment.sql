CREATE TABLE [dbo].[tblAdvancePayment]
(
[RecId] [int] NOT NULL IDENTITY(1, 1),
[RefId] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Months] [date] NULL,
[Amount] [decimal] (18, 2) NULL
) ON [PRIMARY]
GO
