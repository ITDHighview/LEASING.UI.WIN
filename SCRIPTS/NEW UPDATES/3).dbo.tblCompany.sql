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
