USE [LEASINGDB]
GO

/****** Object:  Table [dbo].[tblProjPurchItem]    Script Date: 5/13/2024 5:25:52 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
DROP TABLE [dbo].[tblProjPurchItem]
CREATE TABLE [dbo].[tblProjPurchItem](
	[RecId] BIGINT IDENTITY(10000000,1) NOT NULL,
	[PurchItemID]  VARCHAR(150) NULL,
	[ProjectId] [INT] NULL,
	[Descriptions] [VARCHAR](200) NULL,
	[DatePurchase] [DATETIME] NULL,
	[UnitAmount] [INT] NULL,
	[Amount] [MONEY] NULL,
	[Remarks] [VARCHAR](200) NULL,
	[EncodedBy] [INT] NULL,
	[EncodedDate] [DATETIME] NULL,
	[LastChangedBy] [INT] NULL,
	[LastChangedDate] [DATETIME] NULL,
	[ComputerName] [VARCHAR](50) NULL,
	[IsActive] [BIT] NULL,
	[TotalAmount] [DECIMAL](18, 2) NULL,
	[UnitNumber] [VARCHAR](50) NULL,
	[UnitID] [VARCHAR](50) NULL
) ON [PRIMARY]
GO


