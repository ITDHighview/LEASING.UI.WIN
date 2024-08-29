CREATE TABLE [dbo].[ErrorLog]
(
[LogID] [bigint] NOT NULL IDENTITY(1, 1),
[ProcedureName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ErrorMessage] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[LogDateTime] [datetime] NOT NULL CONSTRAINT [DF__ErrorLog__LogDat__1446FBA6] DEFAULT (getdate()),
[frmName] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FormName] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Category] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UserId] [int] NULL,
[ComputerName] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ErrorLog] ADD CONSTRAINT [PK__ErrorLog__5E5499A81085F910] PRIMARY KEY CLUSTERED ([LogID]) ON [PRIMARY]
GO
