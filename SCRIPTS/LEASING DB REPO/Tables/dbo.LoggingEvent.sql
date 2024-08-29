CREATE TABLE [dbo].[LoggingEvent]
(
[LogID] [bigint] NOT NULL IDENTITY(1, 1),
[EventDateTime] [datetime] NOT NULL CONSTRAINT [DF__LoggingEv__Event__116A8EFB] DEFAULT (getdate()),
[EventType] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[EventMessage] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[UserId] [int] NULL,
[ComputerName] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LoggingEvent] ADD CONSTRAINT [PK__LoggingE__5E5499A8944D7C3A] PRIMARY KEY CLUSTERED ([LogID]) ON [PRIMARY]
GO
