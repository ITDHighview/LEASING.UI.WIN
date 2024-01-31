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
[IsParking] [bit] NULL
) ON [PRIMARY]
GO
