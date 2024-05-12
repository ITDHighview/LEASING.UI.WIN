CREATE TABLE [dbo].[tblPermission]
(
[PermissionId] [int] NOT NULL IDENTITY(1, 1),
[GroupId] [int] NULL,
[IsCLIENT] [bit] NULL,
[IsAdd_New_CLient] [bit] NULL,
[IsClient_Information] [bit] NULL,
[IsCONTRACTS] [bit] NULL,
[IsUnit_Contracts] [bit] NULL,
[IsParking_Contracts] [bit] NULL,
[IsDelete] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblPermission] ADD CONSTRAINT [PK__tblPermi__EFA6FB2FBEF51A88] PRIMARY KEY CLUSTERED ([PermissionId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblPermission_GroupId] ON [dbo].[tblPermission] ([GroupId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblPermission_IsAdd_New_CLient] ON [dbo].[tblPermission] ([IsAdd_New_CLient]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblPermission_IsCLIENT] ON [dbo].[tblPermission] ([IsCLIENT]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblPermission_IsClient_Information] ON [dbo].[tblPermission] ([IsClient_Information]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblPermission_IsCONTRACTS] ON [dbo].[tblPermission] ([IsCONTRACTS]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblPermission_IsDelete] ON [dbo].[tblPermission] ([IsDelete]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblPermission_IsParking_Contracts] ON [dbo].[tblPermission] ([IsParking_Contracts]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblPermission_IsUnit_Contracts] ON [dbo].[tblPermission] ([IsUnit_Contracts]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblPermission_PermissionId] ON [dbo].[tblPermission] ([PermissionId]) ON [PRIMARY]
GO
