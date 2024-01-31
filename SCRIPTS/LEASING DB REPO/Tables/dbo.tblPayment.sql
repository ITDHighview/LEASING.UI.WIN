CREATE TABLE [dbo].[tblPayment]
(
[RecId] [int] NOT NULL IDENTITY(10000000, 1),
[PayID] AS ('PAY'+CONVERT([varchar](10),[RecId],(0))),
[TranId] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Amount] [decimal] (18, 2) NULL,
[ForMonth] [date] NULL,
[Remarks] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EncodedBy] [int] NULL,
[EncodedDate] [datetime] NULL,
[LastChangedBy] [int] NULL,
[LastChangedDate] [datetime] NULL,
[ComputerName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsActive] [bit] NULL,
[RefId] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
