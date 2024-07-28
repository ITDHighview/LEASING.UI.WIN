USE [LEASINGDB]
CREATE TABLE [dbo].[tblPrevLogUnitMstr]
    (
        [LogId]                     [INT]            NOT NULL IDENTITY(1, 1),
        [RecId]                     [INT]            NULL,
        [ProjectId]                 [INT]            NULL,
        [UnitDescription]           [VARCHAR](300)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        [FloorNo]                   [INT]            NULL,
        [AreaSqm]                   [DECIMAL](18, 2) NULL,
        [AreaRateSqm]               [DECIMAL](18, 2) NULL,
        [FloorType]                 [VARCHAR](50)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        [BaseRental]                [DECIMAL](18, 2) NULL,
        [GenVat]                    [INT]            NULL,
        [SecurityAndMaintenance]    [DECIMAL](18, 2) NULL,
        [SecurityAndMaintenanceVat] [INT]            NULL,
        [UnitStatus]                [VARCHAR](50)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        [DetailsofProperty]         [VARCHAR](300)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        [UnitNo]                    [VARCHAR](20)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        [UnitSequence]              [INT]            NULL,
        [LogBy]                     [INT]            NULL,
        [LogDate]                   [DATETIME]       NULL,
        [ComputerName]              [VARCHAR](20)    COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        [clientID]                  [INT]            NULL,
        [Tennant]                   [VARCHAR](200)   COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        [IsParking]                 [BIT]            NULL,
        [IsNonVat]                  [BIT]            NULL,
        [BaseRentalVatAmount]       [DECIMAL](18, 2) NULL,
        [BaseRentalWithVatAmount]   [DECIMAL](18, 2) NULL,
        [BaseRentalTax]             [DECIMAL](18, 2) NULL,
        [TotalRental]               [DECIMAL](18, 2) NULL,
        [SecAndMainAmount]          [DECIMAL](18, 2) NULL,
        [SecAndMainVatAmount]       [DECIMAL](18, 2) NULL,
        [SecAndMainWithVatAmount]   [DECIMAL](18, 2) NULL,
        [Vat]                       [DECIMAL](18, 2) NULL,
        [Tax]                       [DECIMAL](18, 2) NULL,
        [TaxAmount]                 [DECIMAL](18, 2) NULL,
        [AreaTotalAmount]           [DECIMAL](18, 2) NULL,
        [IsNotRoundOff]             [BIT]            NULL,
        [IsNonTax]                  [BIT]            NULL,
        [IsNonCusa]                 [BIT]            NULL,
        [IsOverrideSecAndMain]      [BIT]            NULL
    )