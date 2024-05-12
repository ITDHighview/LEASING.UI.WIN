CREATE TABLE [dbo].[tblProjPurchItem]
(
[RecId] [bigint] NOT NULL IDENTITY(10000000, 1),
[PurchItemID] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
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
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE   TRIGGER [dbo].[tr_tblProjPurchItem]
ON [dbo].[tblProjPurchItem]
FOR INSERT
AS
BEGIN

    UPDATE [dbo].[tblProjPurchItem]
    SET [tblProjPurchItem].[PurchItemID] = 'PURCH' + CONVERT([VARCHAR](5000), [Inserted].[RecId])
    FROM [dbo].[tblProjPurchItem]
        INNER JOIN [Inserted]
            ON [Inserted].[RecId] = [tblProjPurchItem].[RecId]
    WHERE [Inserted].[RecId] = [tblProjPurchItem].[RecId]

END
GO
CREATE NONCLUSTERED INDEX [IdxtblProjPurchItem_Amount] ON [dbo].[tblProjPurchItem] ([Amount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblProjPurchItem_DatePurchase] ON [dbo].[tblProjPurchItem] ([DatePurchase]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblProjPurchItem_Descriptions] ON [dbo].[tblProjPurchItem] ([Descriptions]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblProjPurchItem_EncodedBy] ON [dbo].[tblProjPurchItem] ([EncodedBy]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblProjPurchItem_EncodedDate] ON [dbo].[tblProjPurchItem] ([EncodedDate]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblProjPurchItem_IsActive] ON [dbo].[tblProjPurchItem] ([IsActive]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblProjPurchItem_LastChangedBy] ON [dbo].[tblProjPurchItem] ([LastChangedBy]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblProjPurchItem_LastChangedDate] ON [dbo].[tblProjPurchItem] ([LastChangedDate]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblProjPurchItem_ProjectId] ON [dbo].[tblProjPurchItem] ([ProjectId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblProjPurchItem_PurchItemID] ON [dbo].[tblProjPurchItem] ([PurchItemID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblProjPurchItem_RecId] ON [dbo].[tblProjPurchItem] ([RecId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblProjPurchItem_TotalAmount] ON [dbo].[tblProjPurchItem] ([TotalAmount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblProjPurchItem_UnitAmount] ON [dbo].[tblProjPurchItem] ([UnitAmount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblProjPurchItem_UnitID] ON [dbo].[tblProjPurchItem] ([UnitID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblProjPurchItem_UnitNumber] ON [dbo].[tblProjPurchItem] ([UnitNumber]) ON [PRIMARY]
GO
