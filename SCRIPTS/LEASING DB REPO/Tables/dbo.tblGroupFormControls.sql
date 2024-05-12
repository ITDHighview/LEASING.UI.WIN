CREATE TABLE [dbo].[tblGroupFormControls]
(
[GroupControlId] [int] NOT NULL IDENTITY(1, 1),
[FormId] [int] NULL,
[ControlId] [int] NULL,
[GroupId] [int] NULL,
[IsVisible] [bit] NULL,
[IsDelete] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblGroupFormControls] ADD CONSTRAINT [PK__tblGroup__64264A78E2746EBB] PRIMARY KEY CLUSTERED ([GroupControlId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblGroupFormControls_ControlId] ON [dbo].[tblGroupFormControls] ([ControlId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblGroupFormControls_FormId] ON [dbo].[tblGroupFormControls] ([FormId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblGroupFormControls_GroupControlId] ON [dbo].[tblGroupFormControls] ([GroupControlId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblGroupFormControls_GroupId] ON [dbo].[tblGroupFormControls] ([GroupId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblGroupFormControls_IsDelete] ON [dbo].[tblGroupFormControls] ([IsDelete]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblGroupFormControls_IsVisible] ON [dbo].[tblGroupFormControls] ([IsVisible]) ON [PRIMARY]
GO
