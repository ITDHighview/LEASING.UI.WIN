CREATE TABLE [dbo].[tblProjPurchItem]
(
[RecId] [int] NOT NULL IDENTITY(10000000, 1),
[PurchItemID] AS ('PURCH'+CONVERT([varchar](10),[RecId],(0))),
[ProjectId] [int] NULL,
[Descriptions] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DatePurchase] [datetime] NULL,
[UnitAmount] [int] NULL,
[Amount] [money] NULL,
[Remarks] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EncodedBy] [int] NULL,
[EncodedDate] [datetime] NULL,
[LastChangedBy] [int] NULL,
[LastChangedDate] [datetime] NULL,
[ComputerName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsActive] [bit] NULL,
[TotalAmount] [decimal] (18, 2) NULL,
[UnitNumber] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UnitID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
