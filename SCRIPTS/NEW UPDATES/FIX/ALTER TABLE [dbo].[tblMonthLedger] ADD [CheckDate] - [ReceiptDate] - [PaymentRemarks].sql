USE [LEASINGDB]
ALTER TABLE [dbo].[tblMonthLedger]
ADD
    [CheckDate] [DATETIME] NULL,
    [ReceiptDate] [DATETIME] NULL,
    [PaymentRemarks] [NVARCHAR](4000) NULL