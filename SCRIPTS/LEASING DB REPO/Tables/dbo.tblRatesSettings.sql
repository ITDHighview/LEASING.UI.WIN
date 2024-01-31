CREATE TABLE [dbo].[tblRatesSettings]
(
[RecId] [int] NOT NULL IDENTITY(1, 1),
[ProjectType] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[GenVat] [decimal] (18, 2) NULL,
[SecurityAndMaintenance] [decimal] (18, 2) NULL,
[SecurityAndMaintenanceVat] [int] NULL,
[IsSecAndMaintVat] [bit] NULL,
[WithHoldingTax] [decimal] (18, 2) NULL,
[EncodedBy] [int] NULL,
[EncodedDate] [datetime] NULL,
[LastChangedBy] [int] NULL,
[LastChangedDate] [datetime] NULL,
[ComputerName] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PenaltyPct] [decimal] (18, 2) NULL
) ON [PRIMARY]
GO
