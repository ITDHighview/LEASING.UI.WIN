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
