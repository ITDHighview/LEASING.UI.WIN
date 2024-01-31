CREATE TABLE [dbo].[tblGroup]
(
[GroupId] [int] NOT NULL IDENTITY(1, 1),
[GroupName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsDelete] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblGroup] ADD CONSTRAINT [PK__tblGroup__149AF36A052EFE6E] PRIMARY KEY CLUSTERED ([GroupId]) ON [PRIMARY]
GO
