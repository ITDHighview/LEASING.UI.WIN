CREATE TABLE [dbo].[tblMenu]
(
[MenuId] [int] NOT NULL IDENTITY(1, 1),
[MenuHeaderId] [int] NULL,
[MenuName] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MenuNameDescription] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsDelete] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblMenu] ADD CONSTRAINT [PK__tblMenu__C99ED230892FDB65] PRIMARY KEY CLUSTERED ([MenuId]) ON [PRIMARY]
GO
