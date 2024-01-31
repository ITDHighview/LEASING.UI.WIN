SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_Nature_PR_Report] @TranID VARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @combinedString VARCHAR(MAX);
    DECLARE @IsFullPayment BIT = 0;
    SELECT @IsFullPayment = ISNULL([tblUnitReference].[IsFullPayment], 0)
    FROM [dbo].[tblUnitReference]
    WHERE [tblUnitReference].[RefId] =
    (
        SELECT TOP 1
               [tblTransaction].[RefId]
        FROM [dbo].[tblTransaction]
        WHERE [tblTransaction].[TranID] = @TranID
    );
    IF @IsFullPayment = 0
    BEGIN
        SELECT @combinedString
            = COALESCE(@combinedString + '-', '') + UPPER(DATENAME(MONTH, [tblPayment].[ForMonth])) + ' '
              + CAST(YEAR([tblPayment].[ForMonth]) AS VARCHAR(4))
        FROM [dbo].[tblPayment]
        WHERE [tblPayment].[TranId] = @TranID
              AND [tblPayment].[Remarks] NOT IN ( 'SECURITY DEPOSIT' );
    END;




    CREATE TABLE [#TMP]
    (
        [client_no] VARCHAR(50),
        [client_Name] VARCHAR(200),
        [client_Address] VARCHAR(MAX),
        [PR_No] VARCHAR(50),
        [OR_No] VARCHAR(50),
        [TIN_No] VARCHAR(50),
        [TransactionDate] VARCHAR(50),
        [AmountInWords] VARCHAR(MAX),
        [PaymentFor] VARCHAR(100),
        [TotalAmountInDigit] VARCHAR(100),
        [RENTAL] VARCHAR(50),
        [VAT] VARCHAR(50),
        [VATPct] VARCHAR(50),
        [TOTAL] VARCHAR(50),
        [LESSWITHHOLDING] VARCHAR(50),
        [TOTALAMOUNTDUE] VARCHAR(50),
        [BANKNAME] VARCHAR(100),
        [PDCCHECKSERIALNO] VARCHAR(100),
        [USER] VARCHAR(50),
    );


    INSERT INTO [#TMP]
    (
        [client_no],
        [client_Name],
        [client_Address],
        [PR_No],
        [OR_No],
        [TIN_No],
        [TransactionDate],
        [AmountInWords],
        [PaymentFor],
        [TotalAmountInDigit],
        [RENTAL],
        [VAT],
        [VATPct],
        [TOTAL],
        [LESSWITHHOLDING],
        [TOTALAMOUNTDUE],
        [BANKNAME],
        [PDCCHECKSERIALNO],
        [USER]
    )
    SELECT [CLIENT].[client_no],
           [CLIENT].[client_Name],
           [CLIENT].[client_Address],
           [RECEIPT].[PR_No],
           [RECEIPT].[OR_No],
           [CLIENT].[TIN_No],
           [TRANSACTION].[TransactionDate],
           UPPER([dbo].[fnNumberToWordsWithDecimal]([TRANSACTION].[PaidAmount])) AS [AmountInWords],
           [PAYMENT].[PAYMENT_FOR],
           [RECEIPT].[TotalAmountInDigit],
           [tblUnitReference].[TotalRent] AS [RENTAL_SECMAIN],
           CAST(CAST((([tblUnitReference].[GenVat] * [TRANSACTION].[PaidAmount]) / 100) AS DECIMAL(18, 2)) AS VARCHAR(30)) AS [VAT_AMOUNT],
           CAST([tblUnitReference].[GenVat] AS VARCHAR(10)) + '% VAT' AS [VATPct],
           [RECEIPT].[TOTAL],
           IIF([tblUnitReference].[WithHoldingTax] > 0,
               CAST(CAST((([tblUnitReference].[WithHoldingTax] * [TRANSACTION].[PaidAmount]) / 100) AS DECIMAL(18, 2)) AS VARCHAR(30)),
               '0.00') AS [WithHoldingTax_AMOUNT],
           [TRANSACTION].[PaidAmount] AS [TOTAL_AMOUNT_DUE],
           [RECEIPT].[BankName],
           [RECEIPT].[PDC_CHECK_SERIAL],
           [TRANSACTION].[USER]

    --[tblUnitReference].[GenVat]         AS [LBL_VAT],                   
    --[tblUnitReference].[WithHoldingTax] AS [WithHoldingTax],   
    --[TRANSACTION].[TranID]

    FROM [dbo].[tblUnitReference]
        CROSS APPLY
    (
        SELECT [tblClientMstr].[ClientID] AS [client_no],
               [tblClientMstr].[ClientName] AS [client_Name],
               [tblClientMstr].[PostalAddress] AS [client_Address],
               [tblClientMstr].[TIN_No] AS [TIN_No]
        FROM [dbo].[tblClientMstr]
        WHERE [tblClientMstr].[ClientID] = [tblUnitReference].[ClientID]
    ) [CLIENT]
        OUTER APPLY
    (
        SELECT [tblTransaction].[EncodedDate] AS [TransactionDate],
               [tblTransaction].[TranID],
               ISNULL([dbo].[fn_GetUserName]([tblTransaction].[EncodedBy]), '') AS [USER],
               [tblTransaction].[PaidAmount]
        FROM [dbo].[tblTransaction]
        WHERE [tblUnitReference].[RefId] = [tblTransaction].[RefId]
    ) [TRANSACTION]
        OUTER APPLY
    (
        SELECT [tblReceipt].[CompanyPRNo] AS [PR_No],
               [tblReceipt].[CompanyORNo] AS [OR_No],
               [tblReceipt].[Amount] AS [TOTAL],
               --[dbo].[fnNumberToWordsWithDecimal]([tblReceipt].[Amount]) AS [AmountInWords],
               [tblReceipt].[Amount] AS [TotalAmountInDigit],
               [tblReceipt].[BankName] AS [BankName],
               [tblReceipt].[REF] AS [PDC_CHECK_SERIAL],
               [tblReceipt].[TranId]
        FROM [dbo].[tblReceipt]
        WHERE [TRANSACTION].[TranID] = [tblReceipt].[TranId]
    ) [RECEIPT]
        OUTER APPLY
    (
        SELECT IIF(@IsFullPayment = 1, 'FULL PAYMENT', 'RENTAL FOR ' + @combinedString) AS [PAYMENT_FOR]
    ) [PAYMENT]
    WHERE [TRANSACTION].[TranID] = @TranID;


    SELECT [#TMP].[client_no],
           [#TMP].[client_Name],
           [#TMP].[client_Address],
           [#TMP].[PR_No],
           [#TMP].[OR_No],
           [#TMP].[TIN_No],
           [#TMP].[TransactionDate],
           [#TMP].[AmountInWords],
           [#TMP].[PaymentFor],
           --FORMAT(CAST([#TMP].[TotalAmountInDigit] AS DECIMAL(18, 2)), 'C', 'en-PH') AS [TotalAmountInDigit],
           FORMAT(CAST([#TMP].[TotalAmountInDigit] AS DECIMAL(18, 2)), 'N') AS [TotalAmountInDigit],
           --FORMAT(CAST([#TMP].[RENTAL] AS DECIMAL(18, 2)), 'C', 'en-PH') AS [RENTAL],
           FORMAT(CAST([#TMP].[TOTAL] AS DECIMAL(18, 2)), 'C', 'en-PH') AS [RENTAL],
           FORMAT(CAST([#TMP].[VAT] AS DECIMAL(18, 2)), 'C', 'en-PH') AS [VAT],
           [#TMP].[VATPct],
           FORMAT(CAST([#TMP].[TOTAL] AS DECIMAL(18, 2)), 'C', 'en-PH') AS [TOTAL],
           FORMAT(CAST([#TMP].[LESSWITHHOLDING] AS DECIMAL(18, 2)), 'C', 'en-PH') AS [LESSWITHHOLDING],
           --[#TMP].[LESSWITHHOLDING] AS [LESSWITHHOLDING],
           FORMAT(CAST([#TMP].[TOTALAMOUNTDUE] AS DECIMAL(18, 2)), 'C', 'en-PH') AS [TOTALAMOUNTDUE],
           [#TMP].[BANKNAME],
           [#TMP].[PDCCHECKSERIALNO],
           [#TMP].[USER]
    FROM [#TMP];


    DROP TABLE [#TMP];
END;
GO
