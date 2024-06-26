USE [LEASINGDB]
GO
/****** Object:  Table [dbo].[tblMonthLedger]    Script Date: 4/11/2024 9:08:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
DROP TABLE	[tblMonthLedger]
CREATE TABLE [dbo].[tblMonthLedger](
	[Recid] [bigint] IDENTITY(1,1) NOT NULL,
	[ReferenceID] [bigint] NULL,
	[ClientID] [varchar](500) NULL,
	[LedgMonth] [date] NULL,
	[LedgAmount] [decimal](18, 2) NULL,
	[IsPaid] [bit] NULL,
	[EncodedBy] [int] NULL,
	[EncodedDate] [datetime] NULL,
	[ComputerName] [varchar](30) NULL,
	[TransactionID] [varchar](500) NULL,
	[IsHold] [bit] NULL,
	[BalanceAmount] [decimal](18, 2) NULL,
	[PenaltyAmount] [decimal](18, 2) NULL,
	[ActualAmount] [decimal](18, 2) NULL,
	[LedgRentalAmount] [decimal](18, 2) NULL,
	[Remarks] [varchar](500) NULL,
	[Unit_ProjectType] [varchar](150) NULL,
	[Unit_IsNonVat] [bit] NULL,
	[Unit_BaseRentalVatAmount] [decimal](18, 2) NULL,
	[Unit_BaseRentalWithVatAmount] [decimal](18, 2) NULL,
	[Unit_BaseRentalTax] [decimal](18, 2) NULL,
	[Unit_TotalRental] [decimal](18, 2) NULL,
	[Unit_SecAndMainAmount] [decimal](18, 2) NULL,
	[Unit_SecAndMainVatAmount] [decimal](18, 2) NULL,
	[Unit_SecAndMainWithVatAmount] [decimal](18, 2) NULL,
	[Unit_Vat] [decimal](18, 2) NULL,
	[Unit_Tax] [decimal](18, 2) NULL,
	[Unit_TaxAmount] [decimal](18, 2) NULL,
	[Unit_IsParking] [bit] NULL,
	[Unit_AreaTotalAmount] [decimal](18, 2) NULL,
	[Unit_AreaSqm] [decimal](18, 2) NULL,
	[Unit_AreaRateSqm] [decimal](18, 2) NULL,
	[IsRenewal] [bit] NULL,
	[CompanyORNo] [varchar](200) NULL,
	[REF] [varchar](200) NULL,
	[BNK_ACCT_NAME] [varchar](200) NULL,
	[BNK_ACCT_NUMBER] [varchar](200) NULL,
	[BNK_NAME] [varchar](200) NULL,
	[SERIAL_NO] [varchar](200) NULL,
	[ModeType] [varchar](20) NULL,
	[CompanyPRNo] [varchar](50) NULL,
	[BankBranch] [varchar](250) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblPayment]    Script Date: 4/11/2024 9:08:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
DROP TABLE [tblPayment]
CREATE TABLE [dbo].[tblPayment](
	[RecId] [bigint] IDENTITY(10000000,1) NOT NULL,
	[PayID] [varchar](500) NULL,
	[TranId] [varchar](500) NULL,
	[Amount] [decimal](18, 2) NULL,
	[ForMonth] [date] NULL,
	[Remarks] [varchar](500) NULL,
	[EncodedBy] [int] NULL,
	[EncodedDate] [datetime] NULL,
	[LastChangedBy] [int] NULL,
	[LastChangedDate] [datetime] NULL,
	[ComputerName] [varchar](50) NULL,
	[IsActive] [bit] NULL,
	[RefId] [varchar](500) NULL,
	[Notes] [varchar](200) NULL,
	[LedgeRecid] [bigint] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblReceipt]    Script Date: 4/11/2024 9:08:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
DROP TABLE [tblReceipt]
CREATE TABLE [dbo].[tblReceipt](
	[RecId] [bigint] IDENTITY(10000000,1) NOT NULL,
	[RcptID] [varchar](500) NULL,
	[TranId] [varchar](500) NULL,
	[Amount] [decimal](18, 2) NULL,
	[Description] [varchar](500) NULL,
	[Remarks] [varchar](500) NULL,
	[EncodedBy] [int] NULL,
	[EncodedDate] [datetime] NULL,
	[LastChangedBy] [int] NULL,
	[LastChangedDate] [datetime] NULL,
	[ComputerName] [varchar](50) NULL,
	[IsActive] [bit] NULL,
	[PaymentMethod] [varchar](20) NULL,
	[CompanyORNo] [varchar](150) NULL,
	[BankAccountName] [varchar](150) NULL,
	[BankAccountNumber] [varchar](150) NULL,
	[BankName] [varchar](150) NULL,
	[SerialNo] [varchar](150) NULL,
	[REF] [varchar](150) NULL,
	[CompanyPRNo] [varchar](150) NULL,
	[Category] [varchar](20) NULL,
	[BankBranch] [varchar](250) NULL,
	[RefId] [varchar](150) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblRecieptReport]    Script Date: 4/11/2024 9:08:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
DROP TABLE [tblRecieptReport]
CREATE TABLE [dbo].[tblRecieptReport](
	[client_no] [varchar](500) NULL,
	[client_Name] [varchar](500) NULL,
	[client_Address] [varchar](5000) NULL,
	[PR_No] [varchar](500) NULL,
	[OR_No] [varchar](500) NULL,
	[TIN_No] [varchar](500) NULL,
	[TransactionDate] [varchar](500) NULL,
	[AmountInWords] [varchar](5000) NULL,
	[PaymentFor] [varchar](500) NULL,
	[TotalAmountInDigit] [varchar](100) NULL,
	[RENTAL] [varchar](500) NULL,
	[VAT] [varchar](500) NULL,
	[VATPct] [varchar](500) NULL,
	[TOTAL] [varchar](500) NULL,
	[LESSWITHHOLDING] [varchar](500) NULL,
	[TOTALAMOUNTDUE] [varchar](500) NULL,
	[BANKNAME] [varchar](500) NULL,
	[PDCCHECKSERIALNO] [varchar](500) NULL,
	[USER] [varchar](500) NULL,
	[EncodedDate] [datetime] NULL,
	[TRANID] [varchar](500) NULL,
	[Mode] [varchar](500) NULL,
	[PaymentLevel] [varchar](100) NULL,
	[UnitNo] [varchar](150) NULL,
	[ProjectName] [varchar](150) NULL,
	[BankBranch] [varchar](150) NULL,
	[RENTAL_LESS_VAT] [varchar](150) NULL,
	[RENTAL_LESS_TAX] [varchar](150) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUnitMstr]    Script Date: 4/11/2024 9:08:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
DROP TABLE [tblUnitMstr]
CREATE TABLE [dbo].[tblUnitMstr](
	[RecId] [int] IDENTITY(1,1) NOT NULL,
	[ProjectId] [int] NULL,
	[UnitDescription] [varchar](300) NULL,
	[FloorNo] [int] NULL,
	[AreaSqm] [decimal](18, 2) NULL,
	[AreaRateSqm] [decimal](18, 2) NULL,
	[FloorType] [varchar](50) NULL,
	[BaseRental] [decimal](18, 2) NULL,
	[GenVat] [int] NULL,
	[SecurityAndMaintenance] [decimal](18, 2) NULL,
	[SecurityAndMaintenanceVat] [int] NULL,
	[UnitStatus] [varchar](50) NULL,
	[DetailsofProperty] [varchar](300) NULL,
	[UnitNo] [varchar](20) NULL,
	[UnitSequence] [int] NULL,
	[EndodedBy] [int] NULL,
	[EndodedDate] [datetime] NULL,
	[LastChangedBy] [int] NULL,
	[LastChangedDate] [datetime] NULL,
	[IsActive] [bit] NULL,
	[ComputerName] [varchar](20) NULL,
	[clientID] [int] NULL,
	[Tennant] [varchar](200) NULL,
	[IsParking] [bit] NULL,
	[IsNonVat] [bit] NULL,
	[BaseRentalVatAmount] [decimal](18, 2) NULL,
	[BaseRentalWithVatAmount] [decimal](18, 2) NULL,
	[BaseRentalTax] [decimal](18, 2) NULL,
	[TotalRental] [decimal](18, 2) NULL,
	[SecAndMainAmount] [decimal](18, 2) NULL,
	[SecAndMainVatAmount] [decimal](18, 2) NULL,
	[SecAndMainWithVatAmount] [decimal](18, 2) NULL,
	[Vat] [decimal](18, 2) NULL,
	[Tax] [decimal](18, 2) NULL,
	[TaxAmount] [decimal](18, 2) NULL,
	[AreaTotalAmount] [decimal](18, 2) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUnitReference]    Script Date: 4/11/2024 9:08:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
DROP TABLE [tblUnitReference]
CREATE TABLE [dbo].[tblUnitReference](
	[RecId] [bigint] IDENTITY(10000000,1) NOT NULL,
	[RefId] [varchar](5000) NULL,
	[ProjectId] [int] NULL,
	[InquiringClient] [varchar](500) NULL,
	[ClientMobile] [varchar](50) NULL,
	[UnitId] [int] NULL,
	[UnitNo] [varchar](50) NULL,
	[StatDate] [date] NULL,
	[FinishDate] [date] NULL,
	[TransactionDate] [date] NULL,
	[Rental] [decimal](18, 2) NULL,
	[SecAndMaintenance] [decimal](18, 2) NULL,
	[TotalRent] [decimal](18, 2) NULL,
	[SecDeposit] [decimal](18, 2) NULL,
	[Total] [decimal](18, 2) NULL,
	[EncodedBy] [int] NULL,
	[EncodedDate] [datetime] NULL,
	[LastCHangedBy] [int] NULL,
	[LastChangedDate] [datetime] NULL,
	[IsActive] [bit] NULL,
	[ComputerName] [varchar](30) NULL,
	[ClientID] [varchar](50) NULL,
	[IsPaid] [bit] NULL,
	[IsDone] [bit] NULL,
	[HeaderRefId] [varchar](50) NULL,
	[IsSignedContract] [bit] NULL,
	[IsUnitMove] [bit] NULL,
	[IsTerminated] [bit] NULL,
	[GenVat] [decimal](18, 2) NULL,
	[WithHoldingTax] [decimal](18, 2) NULL,
	[IsUnitMoveOut] [bit] NULL,
	[FirstPaymentDate] [datetime] NULL,
	[ContactDoneDate] [datetime] NULL,
	[SignedContractDate] [datetime] NULL,
	[UnitMoveInDate] [datetime] NULL,
	[UnitMoveOutDate] [datetime] NULL,
	[TerminationDate] [datetime] NULL,
	[AdvancePaymentAmount] [decimal](18, 2) NULL,
	[IsFullPayment] [bit] NULL,
	[PenaltyPct] [decimal](18, 2) NULL,
	[IsPartialPayment] [bit] NULL,
	[FirtsPaymentBalanceAmount] [decimal](18, 2) NULL,
	[Unit_IsNonVat] [bit] NULL,
	[Unit_BaseRentalVatAmount] [decimal](18, 2) NULL,
	[Unit_BaseRentalWithVatAmount] [decimal](18, 2) NULL,
	[Unit_BaseRentalTax] [decimal](18, 2) NULL,
	[Unit_TotalRental] [decimal](18, 2) NULL,
	[Unit_SecAndMainAmount] [decimal](18, 2) NULL,
	[Unit_SecAndMainVatAmount] [decimal](18, 2) NULL,
	[Unit_SecAndMainWithVatAmount] [decimal](18, 2) NULL,
	[Unit_Vat] [decimal](18, 2) NULL,
	[Unit_Tax] [decimal](18, 2) NULL,
	[Unit_TaxAmount] [decimal](18, 2) NULL,
	[Unit_IsParking] [bit] NULL,
	[Unit_ProjectType] [varchar](150) NULL,
	[Unit_AreaTotalAmount] [decimal](18, 2) NULL,
	[Unit_AreaSqm] [decimal](18, 2) NULL,
	[Unit_AreaRateSqm] [decimal](18, 2) NULL,
	[IsRenewal] [bit] NULL
) ON [PRIMARY]
GO
