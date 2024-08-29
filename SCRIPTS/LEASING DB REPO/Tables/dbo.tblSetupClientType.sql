CREATE TABLE [dbo].[tblSetupClientType]
(
[RecId] [int] NOT NULL IDENTITY(1, 1),
[ClientCode] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ClientType] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
