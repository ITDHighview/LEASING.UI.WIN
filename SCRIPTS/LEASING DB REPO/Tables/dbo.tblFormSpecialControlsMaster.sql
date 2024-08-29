CREATE TABLE [dbo].[tblFormSpecialControlsMaster]
(
[ControlId] [int] NOT NULL IDENTITY(1, 1),
[FormId] [int] NULL,
[ControlName] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ControlDescription] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsBackRoundControl] [bit] NULL,
[IsHeaderControl] [bit] NULL,
[IsDelete] [bit] NULL
) ON [PRIMARY]
GO
