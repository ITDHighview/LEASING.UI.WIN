CREATE TABLE [dbo].[tblUser]
(
[UserId] [int] NOT NULL IDENTITY(100000, 1),
[GroupId] [int] NULL,
[UserName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserPassword] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserPasswordIncrypt] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StaffName] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Middlename] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Lastname] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EmailAddress] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Phone] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsDelete] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tblUser] ADD CONSTRAINT [PK__tblUser__1788CC4C9F46DB89] PRIMARY KEY CLUSTERED ([UserId]) ON [PRIMARY]
GO
