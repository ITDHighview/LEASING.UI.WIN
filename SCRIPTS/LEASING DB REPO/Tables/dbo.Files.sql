CREATE TABLE [dbo].[Files]
(
[Id] [int] NOT NULL IDENTITY(1, 1),
[FilePath] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FileData] [varbinary] (max) NULL,
[ClientName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FileNames] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Notes] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Files] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RefId] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
