	SELECT * FROM [dbo].[tblClientMstr]

	SELECT 
		[tblClientMstr].[ClientID]		AS [client_no],
		[tblClientMstr].[ClientName]	AS [client_Name],
		[tblClientMstr].[PostalAddress] AS [client_Address],
		[tblClientMstr].[TIN_No]		AS [TIN_No]
	FROM [dbo].[tblClientMstr]

	SELECT * FROM [dbo].[tblReceipt]

	SELECT 
		[tblReceipt].[CompanyPRNo]	AS [PR_No],
		[tblReceipt].[CompanyORNo]	AS [OR_No],
		[tblReceipt].[Amount]		AS [TOTAL],
		 ''							AS [AmountInWords],
		 [tblReceipt].[Amount]		AS [TotalAmountInDigit],
		 [tblReceipt].[BankName]	AS [BankName],
		 [tblReceipt].[REF]			AS [PDC_CHECK_SERIAL]
		 
	FROM [dbo].[tblReceipt]


	SELECT * FROM [dbo].[tblTransaction]

	SELECT 
	[tblTransaction].[EncodedDate] AS [TransactionDate]
	FROM [dbo].[tblTransaction]


	SELECT * FROM [dbo].[tblUnitReference]

	--SELECT 
	--[tblUnitReference].[TotalRent] AS [RENTAL_SECMAIN],
	--	[tblUnitReference].[GenVat] AS [LBL_VAT],
	--	[tblUnitReference].[GenVat] AS [VAT_AMOUNT],
	--	[tblUnitReference].[WithHoldingTax] AS [WithHoldingTax],
	--	[tblUnitReference].[WithHoldingTax] AS [WithHoldingTax_AMOUNT],
	--	[tblUnitReference].[Total] AS [TOTAL_AMOUNT_DUE]
		
	--FROM [dbo].[tblUnitReference]

	SELECT * FROM [dbo].[tblMonthLedger]
	SELECT * FROM [dbo].[tblPayment]

DECLARE @combinedString VARCHAR(MAX);
SELECT
    @combinedString
    = COALESCE(@combinedString + '- ', '') + UPPER(DATENAME(MONTH, [tblPayment].[ForMonth])) + ' '
      + CAST(YEAR(GETDATE()) AS VARCHAR(4))
FROM
    [dbo].[tblPayment]
WHERE
    [tblPayment].[TranId] = 'TRAN10000000'
    AND [tblPayment].[Remarks] NOT IN (
                                          'SECURITY DEPOSIT'
                                      );

SELECT
    'RENTAL FOR ' + +@combinedString AS PAYMENT_FOR;

	SELECT * FROM [dbo].[tblUser]

	SELECT 
		[tblUser].[StaffName] AS [CURRENT_USER] 
	FROM [dbo].[tblUser]

--			  [client_no],
--            [client_Name],
--            [client_Address],
--            [PR_No],
--            [TIN_No],
--            [TransactionDate],
--            [AmountInWords],
--            [PaymentFor],
--            [TotalAmountInDigit],
--            [RENTAL],
--            [VAT],
--            [TOTAL],
--            [LESSWITHHOLDING],
--            [TOTALAMOUNTDUE],
--            [BANKNAME],
--            [PDCCHECKSERIALNO],
--            [USER]

SELECT DATENAME(MONTH, GETDATE()) + RIGHT(CONVERT(VARCHAR(12), GETDATE(), 107), 9) AS [Month DD, YYYY]

SELECT DATENAME(MONTH, GETDATE()) + ' ' + CAST(DAY(GETDATE()) AS VARCHAR(2))
           + ' ' + CAST(YEAR(GETDATE()) AS VARCHAR(4)) AS [Month DD YYYY]