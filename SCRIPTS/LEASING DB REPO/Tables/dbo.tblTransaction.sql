CREATE TABLE [dbo].[tblTransaction]
(
[RecId] [bigint] NOT NULL IDENTITY(10000000, 1),
[TranID] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RefId] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PaidAmount] [decimal] (18, 2) NULL,
[ReceiveAmount] [decimal] (18, 2) NULL,
[ChangeAmount] [decimal] (18, 2) NULL,
[Remarks] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EncodedBy] [int] NULL,
[EncodedDate] [datetime] NULL,
[LastChangedBy] [int] NULL,
[LastChangedDate] [datetime] NULL,
[ComputerName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsActive] [bit] NULL,
[ActualAmountPaid] [decimal] (18, 2) NULL
) ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[tr_tblTransaction_TranID]
ON [dbo].[tblTransaction]
FOR INSERT
AS
BEGIN

    UPDATE [dbo].[tblTransaction]
    SET [tblTransaction].[TranID] = 'TRN' + CONVERT([VARCHAR](5000), [Inserted].[RecId])
    FROM [dbo].[tblTransaction]
        INNER JOIN [Inserted]
            ON [Inserted].[RecId] = [tblTransaction].[RecId]
    WHERE [Inserted].[RecId] = [tblTransaction].[RecId]

END
GO
CREATE NONCLUSTERED INDEX [IdxtblTransaction_ActualAmountPaid] ON [dbo].[tblTransaction] ([ActualAmountPaid]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblTransaction_ChangeAmount] ON [dbo].[tblTransaction] ([ChangeAmount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblTransaction_EncodedBy] ON [dbo].[tblTransaction] ([EncodedBy]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblTransaction_EncodedDate] ON [dbo].[tblTransaction] ([EncodedDate]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblTransaction_IsActive] ON [dbo].[tblTransaction] ([IsActive]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblTransaction_LastChangedBy] ON [dbo].[tblTransaction] ([LastChangedBy]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblTransaction_LastChangedDate] ON [dbo].[tblTransaction] ([LastChangedDate]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblTransaction_PaidAmount] ON [dbo].[tblTransaction] ([PaidAmount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblTransaction_ReceiveAmount] ON [dbo].[tblTransaction] ([ReceiveAmount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblTransaction_RecId] ON [dbo].[tblTransaction] ([RecId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblTransaction_RefId] ON [dbo].[tblTransaction] ([RefId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblTransaction_Remarks] ON [dbo].[tblTransaction] ([Remarks]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblTransaction_TranID] ON [dbo].[tblTransaction] ([TranID]) ON [PRIMARY]
GO
