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
CREATE NONCLUSTERED INDEX [IdxtblFormControlsMaster_ControlDescription] ON [dbo].[tblFormControlsMaster] ([ControlDescription]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblFormControlsMaster_ControlId] ON [dbo].[tblFormControlsMaster] ([ControlId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblFormControlsMaster_ControlName] ON [dbo].[tblFormControlsMaster] ([ControlName]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblFormControlsMaster_FormId] ON [dbo].[tblFormControlsMaster] ([FormId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblFormControlsMaster_IsBackRoundControl] ON [dbo].[tblFormControlsMaster] ([IsBackRoundControl]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblFormControlsMaster_IsDelete] ON [dbo].[tblFormControlsMaster] ([IsDelete]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblFormControlsMaster_IsHeaderControl] ON [dbo].[tblFormControlsMaster] ([IsHeaderControl]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblFormControlsMaster_MenuId] ON [dbo].[tblFormControlsMaster] ([MenuId]) ON [PRIMARY]
GO
