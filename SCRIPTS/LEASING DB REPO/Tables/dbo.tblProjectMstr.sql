CREATE TABLE [dbo].[tblProjectMstr]
(
[RecId] [int] NOT NULL IDENTITY(1, 1),
[LocId] [int] NULL,
[ProjectName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Descriptions] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsActive] [bit] NULL,
[ProjectAddress] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ProjectType] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CompanyId] [int] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblProjectMstr_CompanyId] ON [dbo].[tblProjectMstr] ([CompanyId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblProjectMstr_Descriptions] ON [dbo].[tblProjectMstr] ([Descriptions]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblProjectMstr_IsActive] ON [dbo].[tblProjectMstr] ([IsActive]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblProjectMstr_LocId] ON [dbo].[tblProjectMstr] ([LocId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblProjectMstr_ProjectAddress] ON [dbo].[tblProjectMstr] ([ProjectAddress]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblProjectMstr_ProjectName] ON [dbo].[tblProjectMstr] ([ProjectName]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblProjectMstr_ProjectType] ON [dbo].[tblProjectMstr] ([ProjectType]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblProjectMstr_RecId] ON [dbo].[tblProjectMstr] ([RecId]) ON [PRIMARY]
GO
