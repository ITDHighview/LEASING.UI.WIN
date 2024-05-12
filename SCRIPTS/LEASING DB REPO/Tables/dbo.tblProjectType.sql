CREATE TABLE [dbo].[tblProjectType]
(
[Recid] [int] NOT NULL IDENTITY(1, 1),
[ProjectTypeName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblProjectType_ProjectTypeName] ON [dbo].[tblProjectType] ([ProjectTypeName]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblProjectType_RecId] ON [dbo].[tblProjectType] ([Recid]) ON [PRIMARY]
GO
