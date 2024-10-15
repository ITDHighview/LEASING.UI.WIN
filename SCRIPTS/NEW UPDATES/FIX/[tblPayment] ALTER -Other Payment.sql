USE [LEASINGDB]

ALTER TABLE [dbo].[tblPayment]
ADD
    [ClientID] VARCHAR(500),
    [OtherPaymentTypeName] VARCHAR(150),
    [OtherPaymentAmount] DECIMAL(18, 2),
    [OtherPaymentVatPCT] DECIMAL(18, 2),
    [OtherPaymentVatAmount] DECIMAL(18, 2),
    [OtherPaymentIsVatApplied] BIT,
    [OtherPaymentTaxPCT] DECIMAL(18, 2),
    [OtherPaymentTaxAmount] DECIMAL(18, 2),
    [OtherPaymentTaxIsApplied] BIT