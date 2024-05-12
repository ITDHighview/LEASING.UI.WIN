CREATE TABLE [dbo].[tblForm]
(
[FormId] [int] NOT NULL IDENTITY(1, 1),
[MenuId] [int] NULL,
[FormName] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FormDescription] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsDelete] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblForm] ADD CONSTRAINT [PK__tblForm__FB05B7DD3ECE83E7] PRIMARY KEY CLUSTERED ([FormId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblForm_FormDescription] ON [dbo].[tblForm] ([FormDescription]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblForm_FormId] ON [dbo].[tblForm] ([FormId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblForm_FormName] ON [dbo].[tblForm] ([FormName]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblForm_IsDelete] ON [dbo].[tblForm] ([IsDelete]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblForm_MenuId] ON [dbo].[tblForm] ([MenuId]) ON [PRIMARY]
GO
