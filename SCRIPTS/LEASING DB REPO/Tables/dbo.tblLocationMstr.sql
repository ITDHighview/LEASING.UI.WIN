CREATE TABLE [dbo].[tblLocationMstr]
(
[RecId] [int] NOT NULL IDENTITY(1, 1),
[Descriptions] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LocAddress] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsActive] [bit] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblLocationMstr_Descriptions] ON [dbo].[tblLocationMstr] ([Descriptions]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblLocationMstr_IsActive] ON [dbo].[tblLocationMstr] ([IsActive]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblLocationMstr_LocAddress] ON [dbo].[tblLocationMstr] ([LocAddress]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblLocationMstr_RecId] ON [dbo].[tblLocationMstr] ([RecId]) ON [PRIMARY]
GO
