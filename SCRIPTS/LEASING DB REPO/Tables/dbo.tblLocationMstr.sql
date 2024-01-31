CREATE TABLE [dbo].[tblLocationMstr]
(
[RecId] [int] NOT NULL IDENTITY(1, 1),
[Descriptions] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LocAddress] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsActive] [bit] NULL
) ON [PRIMARY]
GO
