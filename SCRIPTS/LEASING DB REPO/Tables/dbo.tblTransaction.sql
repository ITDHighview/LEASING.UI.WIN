CREATE TABLE [dbo].[tblTransaction]
(
[RecId] [int] NOT NULL IDENTITY(10000000, 1),
[TranID] AS ('TRAN'+CONVERT([varchar](10),[RecId],(0))),
[RefId] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PaidAmount] [decimal] (18, 2) NULL,
[ReceiveAmount] [decimal] (18, 2) NULL,
[ChangeAmount] [decimal] (18, 2) NULL,
[Remarks] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EncodedBy] [int] NULL,
[EncodedDate] [datetime] NULL,
[LastChangedBy] [int] NULL,
[LastChangedDate] [datetime] NULL,
[ComputerName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsActive] [bit] NULL
) ON [PRIMARY]
GO
