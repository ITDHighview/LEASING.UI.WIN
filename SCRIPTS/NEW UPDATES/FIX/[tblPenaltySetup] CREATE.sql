USE [LEASINGDB]
GO

/****** Object:  Table [dbo].[tblPenaltySetup]    Script Date: 12/16/2024 10:43:22 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tblPenaltySetup](
	[Recid] [INT] IDENTITY(1,1) NOT NULL,
	[DayCount] [INT] NULL,
	[MultiplyBy] [DECIMAL](18, 2) NULL,
	[IsForPenalty] [BIT] NULL
) ON [PRIMARY]
GO


