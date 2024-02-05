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
