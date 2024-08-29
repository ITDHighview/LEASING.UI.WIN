CREATE TABLE [dbo].[tblUnitMstr]
(
[RecId] [int] NOT NULL IDENTITY(1, 1),
[ProjectId] [int] NULL,
[UnitDescription] [varchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FloorNo] [int] NULL,
[AreaSqm] [decimal] (18, 2) NULL,
[AreaRateSqm] [decimal] (18, 2) NULL,
[FloorType] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BaseRental] [decimal] (18, 2) NULL,
[GenVat] [int] NULL,
[SecurityAndMaintenance] [decimal] (18, 2) NULL,
[SecurityAndMaintenanceVat] [int] NULL,
[UnitStatus] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DetailsofProperty] [varchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UnitNo] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UnitSequence] [int] NULL,
[EndodedBy] [int] NULL,
[EndodedDate] [datetime] NULL,
[LastChangedBy] [int] NULL,
[LastChangedDate] [datetime] NULL,
[IsActive] [bit] NULL,
[ComputerName] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[clientID] [int] NULL,
[Tennant] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsParking] [bit] NULL,
[IsNonVat] [bit] NULL,
[BaseRentalVatAmount] [decimal] (18, 2) NULL,
[BaseRentalWithVatAmount] [decimal] (18, 2) NULL,
[BaseRentalTax] [decimal] (18, 2) NULL,
[TotalRental] [decimal] (18, 2) NULL,
[SecAndMainAmount] [decimal] (18, 2) NULL,
[SecAndMainVatAmount] [decimal] (18, 2) NULL,
[SecAndMainWithVatAmount] [decimal] (18, 2) NULL,
[Vat] [decimal] (18, 2) NULL,
[Tax] [decimal] (18, 2) NULL,
[TaxAmount] [decimal] (18, 2) NULL,
[AreaTotalAmount] [decimal] (18, 2) NULL,
[IsNotRoundOff] [bit] NULL,
[IsNonTax] [bit] NULL,
[IsNonCusa] [bit] NULL,
[IsOverrideSecAndMain] [bit] NULL
) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitMstr_AreaRateSqm] ON [dbo].[tblUnitMstr] ([AreaRateSqm]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitMstr_AreaSqm] ON [dbo].[tblUnitMstr] ([AreaSqm]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitMstr_AreaTotalAmount] ON [dbo].[tblUnitMstr] ([AreaTotalAmount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitMstr_BaseRental] ON [dbo].[tblUnitMstr] ([BaseRental]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitMstr_BaseRentalTax] ON [dbo].[tblUnitMstr] ([BaseRentalTax]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitMstr_BaseRentalVatAmount] ON [dbo].[tblUnitMstr] ([BaseRentalVatAmount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitMstr_BaseRentalWithVatAmount] ON [dbo].[tblUnitMstr] ([BaseRentalWithVatAmount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitMstr_clientID] ON [dbo].[tblUnitMstr] ([clientID]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitMstr_DetailsofProperty] ON [dbo].[tblUnitMstr] ([DetailsofProperty]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitMstr_EndodedBy] ON [dbo].[tblUnitMstr] ([EndodedBy]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitMstr_EndodedDate] ON [dbo].[tblUnitMstr] ([EndodedDate]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitMstr_FloorNo] ON [dbo].[tblUnitMstr] ([FloorNo]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitMstr_FloorType] ON [dbo].[tblUnitMstr] ([FloorType]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitMstr_GenVat] ON [dbo].[tblUnitMstr] ([GenVat]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitMstr_IsActive] ON [dbo].[tblUnitMstr] ([IsActive]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitMstr_IsNonVat] ON [dbo].[tblUnitMstr] ([IsNonVat]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitMstr_IsParking] ON [dbo].[tblUnitMstr] ([IsParking]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitMstr_LastChangedBy] ON [dbo].[tblUnitMstr] ([LastChangedBy]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitMstr_LastChangedDate] ON [dbo].[tblUnitMstr] ([LastChangedDate]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitMstr_ProjectId] ON [dbo].[tblUnitMstr] ([ProjectId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitMstr_RecId] ON [dbo].[tblUnitMstr] ([RecId]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitMstr_SecAndMainAmount] ON [dbo].[tblUnitMstr] ([SecAndMainAmount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitMstr_SecAndMainVatAmount] ON [dbo].[tblUnitMstr] ([SecAndMainVatAmount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitMstr_SecAndMainWithVatAmount] ON [dbo].[tblUnitMstr] ([SecAndMainWithVatAmount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitMstr_SecurityAndMaintenance] ON [dbo].[tblUnitMstr] ([SecurityAndMaintenance]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitMstr_SecurityAndMaintenanceVat] ON [dbo].[tblUnitMstr] ([SecurityAndMaintenanceVat]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitMstr_Tax] ON [dbo].[tblUnitMstr] ([Tax]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitMstr_TaxAmount] ON [dbo].[tblUnitMstr] ([TaxAmount]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitMstr_Tennant] ON [dbo].[tblUnitMstr] ([Tennant]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitMstr_TotalRental] ON [dbo].[tblUnitMstr] ([TotalRental]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitMstr_UnitNo] ON [dbo].[tblUnitMstr] ([UnitNo]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitMstr_UnitSequence] ON [dbo].[tblUnitMstr] ([UnitSequence]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitMstr_UnitStatus] ON [dbo].[tblUnitMstr] ([UnitStatus]) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX [IdxtblUnitMstr_Vat] ON [dbo].[tblUnitMstr] ([Vat]) ON [PRIMARY]
GO
