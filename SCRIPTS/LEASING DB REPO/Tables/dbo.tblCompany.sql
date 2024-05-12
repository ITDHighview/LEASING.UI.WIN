CREATE TABLE [dbo].[tblCompany]
(
[RecId] [int] NOT NULL IDENTITY(1, 1),
[CompanyName] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CompanyAddress] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CompanyTIN] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CompanyOwnerName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Status] [bit] NULL,
[EncodedBy] [int] NULL,
[EncodedDate] [datetime] NULL,
[LastChangedBy] [int] NULL,
[LastChangedDate] [datetime] NULL,
[ComputerName] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblCompany_EncodedBy] ON [dbo].[tblCompany] ([EncodedBy]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblCompany_EncodedDate] ON [dbo].[tblCompany] ([EncodedDate]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblCompany_LastChangedBy] ON [dbo].[tblCompany] ([LastChangedBy]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblCompany_LastChangedDate] ON [dbo].[tblCompany] ([LastChangedDate]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblCompany_RecId] ON [dbo].[tblCompany] ([RecId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblCompany_Status] ON [dbo].[tblCompany] ([Status]) ON [PRIMARY]
GO
