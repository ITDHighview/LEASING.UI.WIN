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
