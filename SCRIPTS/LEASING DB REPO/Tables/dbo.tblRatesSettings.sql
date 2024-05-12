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
CREATE NONCLUSTERED INDEX [IdxtblRatesSettings_EncodedBy] ON [dbo].[tblRatesSettings] ([EncodedBy]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblRatesSettings_EncodedDate] ON [dbo].[tblRatesSettings] ([EncodedDate]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblRatesSettings_GenVat] ON [dbo].[tblRatesSettings] ([GenVat]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblRatesSettings_IsSecAndMaintVat] ON [dbo].[tblRatesSettings] ([IsSecAndMaintVat]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblRatesSettings_LastChangedBy] ON [dbo].[tblRatesSettings] ([LastChangedBy]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblRatesSettings_LastChangedDate] ON [dbo].[tblRatesSettings] ([LastChangedDate]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblRatesSettings_PenaltyPct] ON [dbo].[tblRatesSettings] ([PenaltyPct]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblRatesSettings_ProjectType] ON [dbo].[tblRatesSettings] ([ProjectType]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblRatesSettings_RecId] ON [dbo].[tblRatesSettings] ([RecId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblRatesSettings_SecurityAndMaintenance] ON [dbo].[tblRatesSettings] ([SecurityAndMaintenance]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblRatesSettings_SecurityAndMaintenanceVat] ON [dbo].[tblRatesSettings] ([SecurityAndMaintenanceVat]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblRatesSettings_WithHoldingTax] ON [dbo].[tblRatesSettings] ([WithHoldingTax]) ON [PRIMARY]
GO
