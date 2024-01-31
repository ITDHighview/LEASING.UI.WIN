CREATE TABLE [dbo].[demoTable]
(
[ID] [int] NOT NULL IDENTITY(1000, 1),
[GeneratedString] AS (('CORP'+CONVERT([varchar](10),[ID],(0)))+right('0000'+CONVERT([varchar](10),abs(checksum(newid()))%(10000),(0)),(4))),
[names] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[demoTable] ADD CONSTRAINT [PK__demoTabl__3214EC2787224D03] PRIMARY KEY CLUSTERED ([ID]) ON [PRIMARY]
GO
