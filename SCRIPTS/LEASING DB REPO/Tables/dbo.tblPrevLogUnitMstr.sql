CREATE TABLE [dbo].[tblPrevLogUnitMstr]
(
[LogId] [int] NOT NULL IDENTITY(1, 1),
[RecId] [int] NULL,
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
[LogBy] [int] NULL,
[LogDate] [datetime] NULL,
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