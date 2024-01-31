CREATE TABLE [dbo].[LoggingEvent]
(
[LogID] [int] NOT NULL IDENTITY(1, 1),
[EventDateTime] [datetime] NOT NULL CONSTRAINT [DF__LoggingEv__Event__47DBAE45] DEFAULT (getdate()),
[EventType] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[EventMessage] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoggingEvent] ADD CONSTRAINT [PK__LoggingE__5E5499A8631729DD] PRIMARY KEY CLUSTERED ([LogID]) ON [PRIMARY]
GO
