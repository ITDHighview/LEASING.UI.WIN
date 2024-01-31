CREATE TABLE [dbo].[ErrorLog]
(
[LogID] [int] NOT NULL IDENTITY(1, 1),
[ProcedureName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ErrorMessage] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LogDateTime] [datetime] NOT NULL CONSTRAINT [DF__ErrorLog__LogDat__46E78A0C] DEFAULT (getdate()),
[frmName] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FormName] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Category] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserId] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ErrorLog] ADD CONSTRAINT [PK__ErrorLog__5E5499A86254B27B] PRIMARY KEY CLUSTERED ([LogID]) ON [PRIMARY]
GO
