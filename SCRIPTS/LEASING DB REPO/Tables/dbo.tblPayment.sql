CREATE TABLE [dbo].[tblPayment]
(
[RecId] [bigint] NOT NULL IDENTITY(10000000, 1),
[PayID] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TranId] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Amount] [decimal] (18, 2) NULL,
[ForMonth] [date] NULL,
[Remarks] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EncodedBy] [int] NULL,
[EncodedDate] [datetime] NULL,
[LastChangedBy] [int] NULL,
[LastChangedDate] [datetime] NULL,
[ComputerName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsActive] [bit] NULL,
[RefId] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Notes] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LedgeRecid] [bigint] NULL
) ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[tr_tblPayment]
ON [dbo].[tblPayment]
FOR INSERT
AS
BEGIN

    UPDATE [dbo].[tblPayment]
    SET [tblPayment].[PayID] = 'PAY' + CONVERT([VARCHAR](5000), [Inserted].[RecId])
    FROM [dbo].[tblPayment]
        INNER JOIN [Inserted]
            ON [Inserted].[RecId] = [tblPayment].[RecId]
    WHERE [Inserted].[RecId] = [tblPayment].[RecId]

END
GO
