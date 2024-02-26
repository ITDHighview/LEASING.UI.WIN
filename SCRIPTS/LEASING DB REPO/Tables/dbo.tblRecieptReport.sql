CREATE TABLE [dbo].[tblRecieptReport]
(
[client_no] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[client_Name] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[client_Address] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PR_No] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OR_No] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TIN_No] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TransactionDate] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AmountInWords] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PaymentFor] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TotalAmountInDigit] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RENTAL] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VAT] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VATPct] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TOTAL] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LESSWITHHOLDING] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TOTALAMOUNTDUE] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BANKNAME] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PDCCHECKSERIALNO] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[USER] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EncodedDate] [datetime] NULL,
[TRANID] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
