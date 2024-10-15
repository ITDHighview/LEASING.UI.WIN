USE [LEASINGDB]

CREATE TABLE [dbo].[tblOtherPaymentTypes]
    (
        [RecId]                [INT]          NOT NULL IDENTITY(1, 1),
        [OtherPaymentTypeName] [VARCHAR](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        [OtherPaymentVatPCT]   DECIMAL(18, 2),
        [OtherPaymentTaxPCT]   DECIMAL(18, 2),
        [Remarks]              [VARCHAR](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        [EncodedBy]            [INT]          NULL,
        [EncodedDate]          [DATETIME]     NULL,
        [LastChangedBy]        [INT]          NULL,
        [LastChangedDate]      [DATETIME]     NULL,
        [ComputerName]         [VARCHAR](50)  COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        [IsActive]             [BIT]          NULL,
    )
	