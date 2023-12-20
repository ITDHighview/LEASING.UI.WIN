--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
ALTER PROCEDURE [dbo].[sp_Nature_OR_Report]
AS
    BEGIN
        SET NOCOUNT ON;


        CREATE TABLE [#TMP]
            (
                [client_no]          VARCHAR(50),
                [client_Name]        VARCHAR(50),
                [client_Address]     VARCHAR(MAX),
                [PR_No]              VARCHAR(50),
                [TIN_No]             VARCHAR(50),
                [TransactionDate]    VARCHAR(50),
                [AmountInWords]      VARCHAR(MAX),
                [PaymentFor]         VARCHAR(100),
                [TotalAmountInDigit] VARCHAR(100),
                [RENTAL]             VARCHAR(50),
                [VAT]                VARCHAR(50),
                [TOTAL]              VARCHAR(50),
                [LESSWITHHOLDING]    VARCHAR(50),
                [TOTALAMOUNTDUE]     VARCHAR(50),
                [BANKNAME]           VARCHAR(100),
                [PDCCHECKSERIALNO]   VARCHAR(100),
                [USER]               VARCHAR(50),
            );


        INSERT INTO [#TMP]
            (
                [client_no],
                [client_Name],
                [client_Address],
                [PR_No],
                [TIN_No],
                [TransactionDate],
                [AmountInWords],
                [PaymentFor],
                [TotalAmountInDigit],
                [RENTAL],
                [VAT],
                [TOTAL],
                [LESSWITHHOLDING],
                [TOTALAMOUNTDUE],
                [BANKNAME],
                [PDCCHECKSERIALNO],
                [USER]
            )
        VALUES
            (
                'INV10000010', 'MARK JASON GELISANGA',
                'Cecilia Chapman 711-2880 Nulla St. Mankato Mississippi 96522 (257) 563-7401', 'PR-12345689',
                '1231-121-2154', '12/20/2023', UPPER([dbo].[fnNumberToWordsWithDecimal](16658.3)),
                'RENTAL FOR JULY-AGUST 2023', '12535.32', '00.0', '00.0', '00.0', '00.0', '00.0', 'BDO',
                '1231-1321-123-6', 'MARK JASON'
            );

        SELECT
            [#TMP].[client_no],
            [#TMP].[client_Name],
            [#TMP].[client_Address],
            [#TMP].[PR_No],
            [#TMP].[TIN_No],
            [#TMP].[TransactionDate],
            [#TMP].[AmountInWords],
            [#TMP].[PaymentFor],
            FORMAT(CAST([#TMP].[TotalAmountInDigit] AS DECIMAL), 'C', 'en-PH') AS [TotalAmountInDigit],
            FORMAT(CAST([#TMP].[RENTAL] AS DECIMAL), 'C', 'en-PH')             AS [RENTAL],
            [#TMP].[VAT],
            FORMAT(CAST([#TMP].[TOTAL] AS DECIMAL), 'C', 'en-PH')              AS [TOTAL],
            FORMAT(CAST([#TMP].[LESSWITHHOLDING] AS DECIMAL), 'C', 'en-PH')    AS [LESSWITHHOLDING],
            FORMAT(CAST([#TMP].[TOTALAMOUNTDUE] AS DECIMAL), 'C', 'en-PH')     AS [TOTALAMOUNTDUE],
            [#TMP].[BANKNAME],
            [#TMP].[PDCCHECKSERIALNO],
            [#TMP].[USER]
        FROM
            [#TMP];


        DROP TABLE [#TMP];
    END;
GO
