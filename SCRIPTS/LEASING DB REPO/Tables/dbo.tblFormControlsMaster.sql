CREATE TABLE [dbo].[tblFormControlsMaster]
(
[ControlId] [int] NOT NULL IDENTITY(1, 1),
[FormId] [int] NULL,
[MenuId] [int] NULL,
[ControlName] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ControlDescription] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsBackRoundControl] [bit] NULL,
[IsHeaderControl] [bit] NULL,
[IsDelete] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblFormControlsMaster] ADD CONSTRAINT [PK__tblFormC__091D9B357E13469A] PRIMARY KEY CLUSTERED ([ControlId]) ON [PRIMARY]
GO
