SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_Ongching_OR_Report]
    @TranID       VARCHAR(20) = NULL,
    @Mode         VARCHAR(50) = NULL,
    @PaymentLevel VARCHAR(50) = NULL
AS
    BEGIN
        SET NOCOUNT ON;


        DECLARE @combinedString VARCHAR(MAX);
        DECLARE @IsFullPayment BIT = 0;
        DECLARE @RefId VARCHAR(100) = '';


        IF NOT EXISTS
            (
                SELECT
                    1
                FROM
                    [dbo].[tblRecieptReport]
                WHERE
                    [tblRecieptReport].[TRANID] = @TranID
                    AND [tblRecieptReport].[Mode] = @Mode
                    AND [tblRecieptReport].[PaymentLevel] = @PaymentLevel
            )
            BEGIN
                SELECT
                    @IsFullPayment = ISNULL([tblUnitReference].[IsFullPayment], 0),
                    @RefId         = [tblUnitReference].[RefId]
                FROM
                    [dbo].[tblUnitReference]
                WHERE
                    [tblUnitReference].[RefId] =
                    (
                        SELECT TOP 1
                               [tblTransaction].[RefId]
                        FROM
                               [dbo].[tblTransaction]
                        WHERE
                               [tblTransaction].[TranID] = @TranID
                    );

                IF @IsFullPayment = 0
                    BEGIN
                        IF
                            (
                                SELECT
                                    COUNT(*)
                                FROM
                                    [dbo].[tblPayment]
                                WHERE
                                    [tblPayment].[TranId] = @TranID
                                    AND [tblPayment].[Remarks] NOT IN (
                                                                          'SECURITY DEPOSIT'
                                                                      )
                            ) > 5
                            BEGIN
                                IF @Mode = 'REN'
                                   AND @PaymentLevel = 'SECOND'
                                    BEGIN
                                        SELECT
                                            @combinedString
                                            =
                                            (
                                                SELECT  TOP 1
                                                        UPPER(DATENAME(MONTH, MIN([tblPayment].[ForMonth]))) + ' '
                                                        + CAST(YEAR(MIN([tblPayment].[ForMonth])) AS VARCHAR(4))
                                                FROM
                                                        [dbo].[tblPayment]
                                                    INNER JOIN
                                                        [dbo].[tblMonthLedger]
                                                            ON [tblMonthLedger].[LedgMonth] = [tblPayment].[ForMonth]
                                                               AND [tblMonthLedger].[Remarks] = [tblPayment].[Notes]
                                                               AND [tblMonthLedger].[TransactionID] = [tblPayment].[TranId]
                                                WHERE
                                                        [tblPayment].[TranId] = @TranID
                                                        AND [tblPayment].[Remarks] NOT IN (
                                                                                              'SECURITY DEPOSIT'
                                                                                          )
                                                        AND [tblPayment].[Notes] = 'RENTAL NET OF VAT'
                                                        AND ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                                            ) + ' TO '
                                            +
                                            (
                                                SELECT  TOP 1
                                                        UPPER(DATENAME(MONTH, MAX([tblPayment].[ForMonth]))) + ' '
                                                        + CAST(YEAR(MAX([tblPayment].[ForMonth])) AS VARCHAR(4))
                                                FROM
                                                        [dbo].[tblPayment]
                                                    INNER JOIN
                                                        [dbo].[tblMonthLedger]
                                                            ON [tblMonthLedger].[LedgMonth] = [tblPayment].[ForMonth]
                                                               AND [tblMonthLedger].[Remarks] = [tblPayment].[Notes]
                                                               AND [tblMonthLedger].[TransactionID] = [tblPayment].[TranId]
                                                WHERE
                                                        [tblPayment].[TranId] = @TranID
                                                        AND [tblPayment].[Remarks] NOT IN (
                                                                                              'SECURITY DEPOSIT'
                                                                                          )
                                                        AND [tblPayment].[Notes] = 'RENTAL NET OF VAT'
                                                        AND ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                                            )
                                    END

                                IF @Mode = 'MAIN'
                                   AND @PaymentLevel = 'SECOND'
                                    BEGIN

                                        SELECT
                                            @combinedString
                                            =
                                            (
                                                SELECT  TOP 1
                                                        UPPER(DATENAME(MONTH, MIN([tblPayment].[ForMonth]))) + ' '
                                                        + CAST(YEAR(MIN([tblPayment].[ForMonth])) AS VARCHAR(4))
                                                FROM
                                                        [dbo].[tblPayment]
                                                    INNER JOIN
                                                        [dbo].[tblMonthLedger]
                                                            ON [tblMonthLedger].[LedgMonth] = [tblPayment].[ForMonth]
                                                               AND [tblMonthLedger].[Remarks] = [tblPayment].[Notes]
                                                               AND [tblMonthLedger].[TransactionID] = [tblPayment].[TranId]
                                                WHERE
                                                        [tblPayment].[TranId] = @TranID
                                                        AND [tblPayment].[Remarks] NOT IN (
                                                                                              'SECURITY DEPOSIT'
                                                                                          )
                                                        AND [tblPayment].[Notes] = 'SECURITY AND MAINTENANCE NET OF VAT'
                                                        AND ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                                            ) + ' TO '
                                            +
                                            (
                                                SELECT  TOP 1
                                                        UPPER(DATENAME(MONTH, MAX([tblPayment].[ForMonth]))) + ' '
                                                        + CAST(YEAR(MAX([tblPayment].[ForMonth])) AS VARCHAR(4))
                                                FROM
                                                        [dbo].[tblPayment]
                                                    INNER JOIN
                                                        [dbo].[tblMonthLedger]
                                                            ON [tblMonthLedger].[LedgMonth] = [tblPayment].[ForMonth]
                                                               AND [tblMonthLedger].[Remarks] = [tblPayment].[Notes]
                                                               AND [tblMonthLedger].[TransactionID] = [tblPayment].[TranId]
                                                WHERE
                                                        [tblPayment].[TranId] = @TranID
                                                        AND [tblPayment].[Remarks] NOT IN (
                                                                                              'SECURITY DEPOSIT'
                                                                                          )
                                                        AND [tblPayment].[Notes] = 'SECURITY AND MAINTENANCE NET OF VAT'
                                                        AND ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                                            )
                                    END

                            END
                        ELSE
                            BEGIN
                                IF @Mode = 'SEC'
                                   AND @PaymentLevel = 'FIRST'
                                    BEGIN
                                        SELECT
                                            @combinedString
                                            = '('
                                              + CAST(CAST([dbo].[fnGetTotalSecDepositAmountCount](@RefId) AS INT) AS VARCHAR(50))
                                              + ')MONTH-SECURITY DEPOSIT'

                                    END
                                ELSE IF @Mode = 'ADV'
                                        AND @PaymentLevel = 'FIRST'
                                    BEGIN
                                        --SELECT @combinedString = 'ADVANCE PAYMENT'
                                        BEGIN
                                            SELECT
                                                @combinedString
                                                = COALESCE(@combinedString + '-', '')
                                                  + UPPER(DATENAME(MONTH, [tblPayment].[ForMonth])) + ' '
                                                  + CAST(YEAR([tblPayment].[ForMonth]) AS VARCHAR(4))
                                            FROM
                                                [dbo].[tblPayment]
                                            WHERE
                                                [tblPayment].[TranId] = @TranID
                                                AND [tblPayment].[Remarks] = 'MONTHS ADVANCE'
                                                AND ISNULL([tblPayment].[Notes], '') = ''


                                        END
                                    END
                                ELSE
                                    BEGIN

                                        IF @Mode = 'REN'
                                           AND @PaymentLevel = 'SECOND'
                                            BEGIN
                                                SELECT
                                                        @combinedString
                                                    = COALESCE(@combinedString + '-', '')
                                                      + UPPER(DATENAME(MONTH, [tblPayment].[ForMonth])) + ' '
                                                      + CAST(YEAR([tblPayment].[ForMonth]) AS VARCHAR(4))
                                                      + IIF(ISNULL([tblMonthLedger].[IsHold], 0) = 1, '(PARTIAL)', '')
                                                FROM
                                                        [dbo].[tblPayment]
                                                    INNER JOIN
                                                        [dbo].[tblMonthLedger]
                                                            ON [tblMonthLedger].[LedgMonth] = [tblPayment].[ForMonth]
                                                               AND [tblMonthLedger].[Remarks] = [tblPayment].[Notes]
                                                               AND [tblMonthLedger].[TransactionID] = [tblPayment].[TranId]
                                                WHERE
                                                        [tblPayment].[TranId] = @TranID
                                                        AND [tblPayment].[Remarks] NOT IN (
                                                                                              'SECURITY DEPOSIT'
                                                                                          )
                                                        AND [tblPayment].[Notes] = 'RENTAL NET OF VAT'
                                                        AND ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                                            END
                                        IF @Mode = 'MAIN'
                                           AND @PaymentLevel = 'SECOND'
                                            BEGIN
                                                SELECT
                                                        @combinedString
                                                    = COALESCE(@combinedString + '-', '')
                                                      + UPPER(DATENAME(MONTH, [tblPayment].[ForMonth])) + ' '
                                                      + CAST(YEAR([tblPayment].[ForMonth]) AS VARCHAR(4))
                                                      + IIF(ISNULL([tblMonthLedger].[IsHold], 0) = 1, '(PARTIAL)', '')
                                                FROM
                                                        [dbo].[tblPayment]
                                                    INNER JOIN
                                                        [dbo].[tblMonthLedger]
                                                            ON [tblMonthLedger].[LedgMonth] = [tblPayment].[ForMonth]
                                                               AND [tblMonthLedger].[Remarks] = [tblPayment].[Notes]
                                                               AND [tblMonthLedger].[TransactionID] = [tblPayment].[TranId]
                                                WHERE
                                                        [tblPayment].[TranId] = @TranID
                                                        AND [tblPayment].[Remarks] NOT IN (
                                                                                              'SECURITY DEPOSIT'
                                                                                          )
                                                        AND [tblPayment].[Notes] = 'SECURITY AND MAINTENANCE NET OF VAT'
                                                        AND ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                                            END


                                    END
                            END
                    END;


                IF @Mode = 'ADV'
                   AND @PaymentLevel = 'FIRST'
                    BEGIN
                        INSERT INTO [dbo].[tblRecieptReport]
                            (
                                [client_no],
                                [client_Name],
                                [client_Address],
                                [PR_No],
                                [OR_No],
                                [TIN_No],
                                [TransactionDate],
                                [AmountInWords],
                                [PaymentFor],      --PAYMENT DESCRIPTION
                                [TotalAmountInDigit],
                                [RENTAL],
                                [VAT],             --VAT AMOUNT
                                [VATPct],
                                [TOTAL],
                                [LESSWITHHOLDING], --TAX AMOUNT
                                [TOTALAMOUNTDUE],
                                [BANKNAME],
                                [PDCCHECKSERIALNO],
                                [USER],
                                [EncodedDate],
                                [TRANID],
                                [Mode],
                                [PaymentLevel],
                                [UnitNo],
                                [ProjectName],
                                [BankBranch],
                                [RENTAL_LESS_VAT],
                                [RENTAL_LESS_TAX]
                            )
                                    SELECT
                                        [CLIENT].[client_no]                                                                                               AS [client_no],
                                        [CLIENT].[client_Name]                                                                                             AS [client_Name],
                                        [CLIENT].[client_Address]                                                                                          AS [client_Address],
                                        [RECEIPT].[PR_No]                                                                                                  AS [PR_No],
                                        [RECEIPT].[OR_No]                                                                                                  AS [OR_No],
                                        [CLIENT].[TIN_No]                                                                                                  AS [TIN_No],
                                        [TRANSACTION].[TransactionDate]                                                                                    AS [TransactionDate],
                                        UPPER([dbo].[fnNumberToWordsWithDecimal](IIF(@IsFullPayment = 0,
                                                                                     [tblUnitReference].[AdvancePaymentAmount],
                                                                                     [tblUnitReference].[Total])
                                                                                )
                                             )                                                                                                             AS [AmountInWords],
                                        [PAYMENT].[PAYMENT_FOR]                                                                                            AS [PaymentFor],
                                        IIF(@IsFullPayment = 0,
                                            [tblUnitReference].[AdvancePaymentAmount],
                                            [tblUnitReference].[Total])                                                                                    AS [TotalAmountInDigit],
                                        IIF(@IsFullPayment = 0,
                                            [tblUnitReference].[AdvancePaymentAmount],
                                            [tblUnitReference].[Total])                                                                                    AS [RENTAL],
                                        CAST(([tblUnitReference].[Unit_BaseRentalVatAmount]
                                              + [tblUnitReference].[Unit_SecAndMainVatAmount]
                                             )
                                             * CAST([dbo].[fnGetAdvanceMonthCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150))   AS [VAT_AMOUNT],
                                        CAST([tblUnitReference].[Unit_Vat] AS VARCHAR(10)) + '% VAT'                                                       AS [VATPct],
                                        IIF(@IsFullPayment = 0,
                                            [tblUnitReference].[AdvancePaymentAmount],
                                            [tblUnitReference].[Total])                                                                                    AS [TOTAL],
                                        CAST([tblUnitReference].[Unit_BaseRentalTax]
                                             * CAST([dbo].[fnGetAdvanceMonthCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150))   AS [LESSWITHHOLDING],
                                        [tblUnitReference].[AdvancePaymentAmount]                                                                          AS [TOTALAMOUNTDUE],
                                        [RECEIPT].[BankName]                                                                                               AS [BANKNAME],
                                        [RECEIPT].[PDC_CHECK_SERIAL]                                                                                       AS [PDCCHECKSERIALNO],
                                        [TRANSACTION].[USER]                                                                                               AS [USER],
                                        GETDATE()                                                                                                          AS [EncodedDate],
                                        @TranID                                                                                                            AS [TRANID],
                                        @Mode                                                                                                              AS [Mode],
                                        @PaymentLevel                                                                                                      AS [PaymentLevel],
                                        [tblUnitReference].[UnitNo]                                                                                        AS [UnitNo],
                                        [dbo].[fnGetProjectNameById]([tblUnitReference].[ProjectId])                                                       AS [ProjectName],
                                        [RECEIPT].[BankBranch]                                                                                             AS [BankBranch],
                                        CAST(CAST(IIF(@IsFullPayment = 0,
                                                      IIF([tblUnitReference].[Unit_Tax] > 0,
                                                          ([tblUnitReference].[AdvancePaymentAmount]
                                                           + CAST([tblUnitReference].[Unit_BaseRentalTax]
                                                                  * [dbo].[fnGetAdvanceMonthCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2))
                                                          ),
                                                          [tblUnitReference].[AdvancePaymentAmount]),
                                                      [tblUnitReference].[Total]) AS DECIMAL(18, 2))
                                             - CAST(([dbo].[tblUnitReference].[Unit_BaseRentalVatAmount]
                                                     + [tblUnitReference].[Unit_SecAndMainVatAmount]
                                                    )
                                                    * [dbo].[fnGetAdvanceMonthCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150)) AS [RENTAL_LESS_VAT],
                                        CAST(IIF(@IsFullPayment = 0,
                                                 [tblUnitReference].[AdvancePaymentAmount],
                                                 [tblUnitReference].[Total]) AS VARCHAR(150))                                                              AS [RENTAL_LESS_TAX]
                                    FROM
                                        [dbo].[tblUnitReference]
                                        CROSS APPLY
                                        (
                                            SELECT
                                                [tblClientMstr].[ClientID]      AS [client_no],
                                                [tblClientMstr].[ClientName]    AS [client_Name],
                                                [tblClientMstr].[PostalAddress] AS [client_Address],
                                                [tblClientMstr].[TIN_No]        AS [TIN_No]
                                            FROM
                                                [dbo].[tblClientMstr]
                                            WHERE
                                                [tblClientMstr].[ClientID] = [tblUnitReference].[ClientID]
                                        ) [CLIENT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                [tblTransaction].[EncodedDate]                                   AS [TransactionDate],
                                                [tblTransaction].[TranID],
                                                ISNULL([dbo].[fn_GetUserName]([tblTransaction].[EncodedBy]), '') AS [USER],
                                                [tblTransaction].[ReceiveAmount]
                                            FROM
                                                [dbo].[tblTransaction]
                                            WHERE
                                                [tblUnitReference].[RefId] = [tblTransaction].[RefId]
                                        ) [TRANSACTION]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                [tblReceipt].[CompanyPRNo] AS [PR_No],
                                                [tblReceipt].[CompanyORNo] AS [OR_No],
                                                [tblReceipt].[Amount]      AS [TOTAL],
                                                [tblReceipt].[BankName]    AS [BankName],
                                                [tblReceipt].[BankBranch]  AS [BankBranch],
                                                [tblReceipt].[REF]         AS [PDC_CHECK_SERIAL],
                                                [tblReceipt].[TranId]
                                            FROM
                                                [dbo].[tblReceipt]
                                            WHERE
                                                [TRANSACTION].[TranID] = [tblReceipt].[TranId]
                                        ) [RECEIPT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                IIF(@IsFullPayment = 1, 'FULL PAYMENT', 'RENTAL FOR ' + @combinedString) AS [PAYMENT_FOR]
                                        ) [PAYMENT]
                                    WHERE
                                        [TRANSACTION].[TranID] = @TranID


                    END
                IF @Mode = 'SEC'
                   AND @PaymentLevel = 'FIRST'
                    BEGIN
                        INSERT INTO [dbo].[tblRecieptReport]
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
                                [USER],
                                [EncodedDate],
                                [TRANID],
                                [Mode],
                                [PaymentLevel],
                                [UnitNo],
                                [ProjectName],
                                [BankBranch],
                                [RENTAL_LESS_VAT],
                                [RENTAL_LESS_TAX]
                            )
                                    SELECT
                                        [CLIENT].[client_no]                                                                                                        AS [client_no],
                                        [CLIENT].[client_Name]                                                                                                      AS [client_Name],
                                        [CLIENT].[client_Address]                                                                                                   AS [client_Address],
                                        [RECEIPT].[PR_No]                                                                                                           AS [PR_No],
                                        [RECEIPT].[OR_No]                                                                                                           AS [OR_No],
                                        [CLIENT].[TIN_No]                                                                                                           AS [TIN_No],
                                        [TRANSACTION].[TransactionDate]                                                                                             AS [TransactionDate],
                                        UPPER([dbo].[fnNumberToWordsWithDecimal]([tblUnitReference].[SecDeposit]))                                                  AS [AmountInWords],
                                        [PAYMENT].[PAYMENT_FOR]                                                                                                     AS [PaymentFor],
                                        [tblUnitReference].[SecDeposit]                                                                                             AS [TotalAmountInDigit],
                                        [tblUnitReference].[SecDeposit]                                                                                             AS [RENTAL],
                                        CAST(CAST(([tblUnitReference].[Unit_BaseRentalVatAmount]
                                                   + [tblUnitReference].[Unit_SecAndMainVatAmount]
                                                  )
                                                  * [dbo].[fnGetTotalSecDepositAmountCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150))   AS [VAT],
                                        CAST([tblUnitReference].[Unit_Vat] AS VARCHAR(10)) + '% VAT'                                                                AS [VATPct],
                                        [tblUnitReference].[SecDeposit]                                                                                             AS [TOTAL],
                                        CAST(CAST([tblUnitReference].[Unit_TaxAmount]
                                                  * [dbo].[fnGetTotalSecDepositAmountCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150))   AS [LESSWITHHOLDING],
                                        [tblUnitReference].[SecDeposit]                                                                                             AS [TOTALAMOUNTDUE],
                                        [RECEIPT].[BankName]                                                                                                        AS [BANKNAME],
                                        [RECEIPT].[PDC_CHECK_SERIAL]                                                                                                AS [PDCCHECKSERIALNO],
                                        [TRANSACTION].[USER]                                                                                                        AS [USER],
                                        GETDATE()                                                                                                                   AS [EncodedDate],
                                        @TranID                                                                                                                     AS [TRANID],
                                        @Mode                                                                                                                       AS [Mode],
                                        @PaymentLevel                                                                                                               AS [PaymentLevel],
                                        [tblUnitReference].[UnitNo]                                                                                                 AS [UnitNo],
                                        [dbo].[fnGetProjectNameById]([tblUnitReference].[ProjectId])                                                                AS [ProjectName],
                                        [RECEIPT].[BankBranch]                                                                                                      AS [BankBranch],
                                        CAST(CAST(IIF([tblUnitReference].[Unit_Tax] > 0,
                                                      ([tblUnitReference].[SecDeposit]
                                                       + CAST([tblUnitReference].[Unit_BaseRentalTax]
                                                              * [dbo].[fnGetTotalSecDepositAmountCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2))
                                                      ),
                                                      0) AS DECIMAL(18, 2))
                                             - CAST(([tblUnitReference].[Unit_BaseRentalVatAmount]
                                                     + [tblUnitReference].[Unit_SecAndMainVatAmount]
                                                    )
                                                    * [dbo].[fnGetTotalSecDepositAmountCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150)) AS [RENTAL_LESS_VAT],
                                        CAST(CAST([tblUnitReference].[SecDeposit] AS DECIMAL(18, 2)) AS VARCHAR(150))                                               AS [RENTAL_LESS_TAX]
                                    FROM
                                        [dbo].[tblUnitReference]
                                        CROSS APPLY
                                        (
                                            SELECT
                                                [tblClientMstr].[ClientID]      AS [client_no],
                                                [tblClientMstr].[ClientName]    AS [client_Name],
                                                [tblClientMstr].[PostalAddress] AS [client_Address],
                                                [tblClientMstr].[TIN_No]        AS [TIN_No]
                                            FROM
                                                [dbo].[tblClientMstr]
                                            WHERE
                                                [tblClientMstr].[ClientID] = [tblUnitReference].[ClientID]
                                        ) [CLIENT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                [tblTransaction].[EncodedDate]                                   AS [TransactionDate],
                                                [tblTransaction].[TranID],
                                                ISNULL([dbo].[fn_GetUserName]([tblTransaction].[EncodedBy]), '') AS [USER],
                                                [tblTransaction].[ReceiveAmount]
                                            FROM
                                                [dbo].[tblTransaction]
                                            WHERE
                                                [tblUnitReference].[RefId] = [tblTransaction].[RefId]
                                        ) [TRANSACTION]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                [tblReceipt].[CompanyPRNo] AS [PR_No],
                                                [tblReceipt].[CompanyORNo] AS [OR_No],
                                                [tblReceipt].[Amount]      AS [TOTAL],
                                                [tblReceipt].[BankName]    AS [BankName],
                                                [tblReceipt].[BankBranch]  AS [BankBranch],
                                                [tblReceipt].[REF]         AS [PDC_CHECK_SERIAL],
                                                [tblReceipt].[TranId]
                                            FROM
                                                [dbo].[tblReceipt]
                                            WHERE
                                                [TRANSACTION].[TranID] = [tblReceipt].[TranId]
                                        ) [RECEIPT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                IIF(@IsFullPayment = 1, 'FULL PAYMENT', 'RENTAL FOR ' + @combinedString) AS [PAYMENT_FOR]
                                        ) [PAYMENT]
                                    WHERE
                                        [TRANSACTION].[TranID] = @TranID


                    END



                IF @Mode = 'REN'
                   AND @PaymentLevel = 'SECOND'
                    BEGIN
                        INSERT INTO [dbo].[tblRecieptReport]
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
                                [USER],
                                [EncodedDate],
                                [TRANID],
                                [Mode],
                                [PaymentLevel],
                                [UnitNo],
                                [ProjectName],
                                [BankBranch],
                                [RENTAL_LESS_VAT],
                                [RENTAL_LESS_TAX]
                            )
                                    SELECT
                                        [CLIENT].[client_no]                                                     AS [client_no],
                                        [CLIENT].[client_Name]                                                   AS [client_Name],
                                        [CLIENT].[client_Address]                                                AS [client_Address],
                                        [RECEIPT].[PR_No]                                                        AS [PR_No],
                                        [RECEIPT].[OR_No]                                                        AS [OR_No],
                                        [CLIENT].[TIN_No]                                                        AS [TIN_No],
                                        [TRANSACTION].[TransactionDate]                                          AS [TransactionDate],
                                        UPPER([dbo].[fnNumberToWordsWithDecimal]([TRANSACTION].[ReceiveAmount])) AS [AmountInWords],
                                        [PAYMENT].[PAYMENT_FOR]                                                  AS [PaymentFor],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [TotalAmountInDigit],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [RENTAL],
                                        --CAST(CAST((([tblUnitReference].[Unit_Vat] * [TRANSACTION].[ReceiveAmount])
                                        --           / 100
                                        --          ) AS DECIMAL(18, 2)) AS VARCHAR(30))                           AS [VAT],
                                        CAST([dbo].[fnGetBaseRentalTotalVatAmount](
                                                                                      [dbo].[tblUnitReference].[RefId],
                                                                                      [TRANSACTION].[AmountToPay],
                                                                                      [TRANSACTION].[ReceiveAmount]
                                                                                  ) AS VARCHAR(150))             AS [VAT],
								
                                        CAST([tblUnitReference].[Unit_Vat] AS VARCHAR(10)) + '% VAT'             AS [VATPct],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [TOTAL],
                                        --IIF([tblUnitReference].[Unit_Tax] > 0,
                                        --    CAST(CAST((([tblUnitReference].[Unit_Tax] * [TRANSACTION].[ReceiveAmount])
                                        --               / 100
                                        --              ) AS DECIMAL(18, 2)) AS VARCHAR(30)),
                                        --    '0.00')                                                              AS [LESSWITHHOLDING],
                                        CAST([dbo].[fnGetBaseRentalTotalTaxAmount](
                                                                                      [dbo].[tblUnitReference].[RefId],
                                                                                      [TRANSACTION].[AmountToPay],
                                                                                      [TRANSACTION].[ReceiveAmount]
                                                                                  ) AS VARCHAR(150))             AS [LESSWITHHOLDING],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [TOTALAMOUNTDUE],
                                        [RECEIPT].[BankName]                                                     AS [BANKNAME],
                                        [RECEIPT].[PDC_CHECK_SERIAL]                                             AS [PDCCHECKSERIALNO],
                                        [TRANSACTION].[USER]                                                     AS [USER],
                                        GETDATE()                                                                AS [EncodedDate],
                                        @TranID                                                                  AS [TRANID],
                                        @Mode                                                                    AS [Mode],
                                        @PaymentLevel                                                            AS [PaymentLevel],
                                        [tblUnitReference].[UnitNo]                                              AS [UnitNo],
                                        [dbo].[fnGetProjectNameById]([tblUnitReference].[ProjectId])             AS [ProjectName],
                                        [RECEIPT].[BankBranch]                                                   AS [BankBranch],
                                        '0'                                                                      AS [RENTAL_LESS_VAT],
                                        '0'                                                                      AS [RENTAL_LESS_TAX]
                                    FROM
                                        [dbo].[tblUnitReference]
                                        CROSS APPLY
                                        (
                                            SELECT
                                                [tblClientMstr].[ClientID]      AS [client_no],
                                                [tblClientMstr].[ClientName]    AS [client_Name],
                                                [tblClientMstr].[PostalAddress] AS [client_Address],
                                                [tblClientMstr].[TIN_No]        AS [TIN_No]
                                            FROM
                                                [dbo].[tblClientMstr]
                                            WHERE
                                                [tblClientMstr].[ClientID] = [tblUnitReference].[ClientID]
                                        ) [CLIENT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                    [tblTransaction].[EncodedDate]                                   AS [TransactionDate],
                                                    [tblTransaction].[TranID],
                                                
                                                            SUM([tblMonthLedger].[LedgRentalAmount]) 
                                                                                                           AS [AmountToPay],
                                                    ISNULL([dbo].[fn_GetUserName]([tblTransaction].[EncodedBy]), '') AS [USER],
                                                    SUM([tblPayment].[Amount])                                       AS [ReceiveAmount]
                                            FROM
                                                    [dbo].[tblTransaction]
                                                INNER JOIN
                                                    [dbo].[tblPayment]
                                                        ON [tblPayment].[TranId] = [tblTransaction].[TranID]
														INNER JOIN [dbo].[tblMonthLedger]
														ON [tblMonthLedger].[Recid] = [tblPayment].[LedgeRecid]
                                            WHERE
                                                    [tblUnitReference].[RefId] = [tblTransaction].[RefId]
                                                    AND [tblPayment].[Notes] = 'RENTAL NET OF VAT'
                                            GROUP BY
                                                    [tblTransaction].[EncodedDate],
                                                    [tblTransaction].[TranID],
                                                    [tblTransaction].[EncodedBy],
                                                    [tblPayment].[Amount],
                                                    [tblTransaction].[PaidAmount]
                                        ) [TRANSACTION]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                [tblReceipt].[CompanyPRNo] AS [PR_No],
                                                [tblReceipt].[CompanyORNo] AS [OR_No],
                                                [tblReceipt].[Amount]      AS [TOTAL],
                                                [tblReceipt].[Amount]      AS [TotalAmountInDigit],
                                                [tblReceipt].[BankName]    AS [BankName],
                                                [tblReceipt].[BankBranch]  AS [BankBranch],
                                                [tblReceipt].[REF]         AS [PDC_CHECK_SERIAL],
                                                [tblReceipt].[TranId]
                                            FROM
                                                [dbo].[tblReceipt]
                                            WHERE
                                                [TRANSACTION].[TranID] = [tblReceipt].[TranId]
                                        ) [RECEIPT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                IIF(@IsFullPayment = 1, 'FULL PAYMENT', 'RENTAL FOR ' + @combinedString) AS [PAYMENT_FOR]
                                        ) [PAYMENT]
                                    WHERE
                                        [TRANSACTION].[TranID] = @TranID;
                    END
                IF @Mode = 'MAIN'
                   AND @PaymentLevel = 'SECOND'
                    BEGIN
                        INSERT INTO [dbo].[tblRecieptReport]
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
                                [USER],
                                [EncodedDate],
                                [TRANID],
                                [Mode],
                                [PaymentLevel],
                                [UnitNo],
                                [ProjectName],
                                [BankBranch],
                                [RENTAL_LESS_VAT],
                                [RENTAL_LESS_TAX]
                            )
                                    SELECT
                                        [CLIENT].[client_no]                                                     AS [client_no],
                                        [CLIENT].[client_Name]                                                   AS [client_Name],
                                        [CLIENT].[client_Address]                                                AS [client_Address],
                                        [RECEIPT].[PR_No]                                                        AS [PR_No],
                                        [RECEIPT].[OR_No]                                                        AS [OR_No],
                                        [CLIENT].[TIN_No]                                                        AS [TIN_No],
                                        [TRANSACTION].[TransactionDate]                                          AS [TransactionDate],
                                        UPPER([dbo].[fnNumberToWordsWithDecimal]([TRANSACTION].[ReceiveAmount])) AS [AmountInWords],
                                        [PAYMENT].[PAYMENT_FOR]                                                  AS [PaymentFor],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [TotalAmountInDigit],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [RENTAL],
                                        CAST(CAST((([tblUnitReference].[Unit_Vat] * [TRANSACTION].[ReceiveAmount])
                                                   / 100
                                                  ) AS DECIMAL(18, 2)) AS VARCHAR(30))                           AS [VAT], --TAX WILL FOLLOW
                                        CAST([tblUnitReference].[GenVat] AS VARCHAR(10)) + '% VAT'               AS [VATPct],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [TOTAL],
                                        IIF([tblUnitReference].[Unit_Tax] > 0,
                                            CAST(CAST((([tblUnitReference].[Unit_Tax] * [TRANSACTION].[ReceiveAmount])
                                                       / 100
                                                      ) AS DECIMAL(18, 2)) AS VARCHAR(30)),
                                            '0.00')                                                              AS [LESSWITHHOLDING],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [TOTALAMOUNTDUE],
                                        [RECEIPT].[BankName]                                                     AS [BANKNAME],
                                        [RECEIPT].[PDC_CHECK_SERIAL]                                             AS [PDCCHECKSERIALNO],
                                        [TRANSACTION].[USER]                                                     AS [USER],
                                        GETDATE()                                                                AS [EncodedDate],
                                        @TranID                                                                  AS [TRANID],
                                        @Mode                                                                    AS [Mode],
                                        @PaymentLevel                                                            AS [PaymentLevel],
                                        [tblUnitReference].[UnitNo]                                              AS [UnitNo],
                                        [dbo].[fnGetProjectNameById]([tblUnitReference].[ProjectId])             AS [ProjectName],
                                        [RECEIPT].[BankBranch]                                                   AS [BankBranch],
                                        '0'                                                                      AS [RENTAL_LESS_VAT],
                                        '0'                                                                      AS [RENTAL_LESS_TAX]
                                    FROM
                                        [dbo].[tblUnitReference]
                                        CROSS APPLY
                                        (
                                            SELECT
                                                [tblClientMstr].[ClientID]      AS [client_no],
                                                [tblClientMstr].[ClientName]    AS [client_Name],
                                                [tblClientMstr].[PostalAddress] AS [client_Address],
                                                [tblClientMstr].[TIN_No]        AS [TIN_No]
                                            FROM
                                                [dbo].[tblClientMstr]
                                            WHERE
                                                [tblClientMstr].[ClientID] = [tblUnitReference].[ClientID]
                                        ) [CLIENT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                    [tblTransaction].[EncodedDate]                                   AS [TransactionDate],
                                                    [tblTransaction].[TranID],
                                                    ISNULL([dbo].[fn_GetUserName]([tblTransaction].[EncodedBy]), '') AS [USER],
                                                    SUM([tblPayment].[Amount])                                       AS [ReceiveAmount]
                                            FROM
                                                    [dbo].[tblTransaction]
                                                INNER JOIN
                                                    [dbo].[tblPayment]
                                                        ON [tblPayment].[TranId] = [tblTransaction].[TranID]
                                            WHERE
                                                    [tblUnitReference].[RefId] = [tblTransaction].[RefId]
                                                    AND [tblPayment].[Notes] = 'SECURITY AND MAINTENANCE NET OF VAT'
                                            GROUP BY
                                                    [tblTransaction].[EncodedDate],
                                                    [tblTransaction].[TranID],
                                                    [tblTransaction].[EncodedBy],
                                                    [tblPayment].[Amount]
                                        ) [TRANSACTION]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                [tblReceipt].[CompanyPRNo] AS [PR_No],
                                                [tblReceipt].[CompanyORNo] AS [OR_No],
                                                [tblReceipt].[Amount]      AS [TOTAL],
                                                [tblReceipt].[Amount]      AS [TotalAmountInDigit],
                                                [tblReceipt].[BankName]    AS [BankName],
                                                [tblReceipt].[BankBranch]  AS [BankBranch],
                                                [tblReceipt].[REF]         AS [PDC_CHECK_SERIAL],
                                                [tblReceipt].[TranId]
                                            FROM
                                                [dbo].[tblReceipt]
                                            WHERE
                                                [TRANSACTION].[TranID] = [tblReceipt].[TranId]
                                        ) [RECEIPT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                IIF(@IsFullPayment = 1, 'FULL PAYMENT', 'RENTAL FOR ' + @combinedString) AS [PAYMENT_FOR]
                                        ) [PAYMENT]
                                    WHERE
                                        [TRANSACTION].[TranID] = @TranID;
                    END





            END


        SELECT TOP 1
               [tblRecieptReport].[client_no],
               [tblRecieptReport].[client_Name],
               [tblRecieptReport].[client_Address],
               [tblRecieptReport].[PR_No],
               [tblRecieptReport].[OR_No],
               [tblRecieptReport].[TIN_No],
               [tblRecieptReport].[TransactionDate],
               [tblRecieptReport].[AmountInWords],
               [tblRecieptReport].[PaymentFor],
               --FORMAT(CAST([#TMP].[TotalAmountInDigit] AS DECIMAL(18, 2)), 'C', 'en-PH') AS [TotalAmountInDigit],
               FORMAT(CAST([tblRecieptReport].[TotalAmountInDigit] AS DECIMAL(18, 2)), 'N')      AS [TotalAmountInDigit],
               --FORMAT(CAST([#TMP].[RENTAL] AS DECIMAL(18, 2)), 'C', 'en-PH') AS [RENTAL],
               FORMAT(CAST([tblRecieptReport].[RENTAL] AS DECIMAL(18, 2)), 'C', 'en-PH')         AS [RENTAL],
               FORMAT(CAST([tblRecieptReport].[VAT] AS DECIMAL(18, 2)), 'C', 'en-PH')            AS [VAT],
               [tblRecieptReport].[VATPct],
               FORMAT(CAST([tblRecieptReport].[RENTAL] AS DECIMAL(18, 2)), 'C', 'en-PH')         AS [TOTAL],
               --FORMAT(CAST([tblRecieptReport].[LESSWITHHOLDING] AS DECIMAL(18, 2)), 'C', 'en-PH') AS [LESSWITHHOLDING],
               CAST(CAST('0.00' AS DECIMAL(18, 2)) AS VARCHAR(50)) + ' %'                        AS [LESSWITHHOLDING],
               --[#TMP].[LESSWITHHOLDING] AS [LESSWITHHOLDING],
               FORMAT(CAST([tblRecieptReport].[TOTALAMOUNTDUE] AS DECIMAL(18, 2)), 'C', 'en-PH') AS [TOTALAMOUNTDUE],
               [tblRecieptReport].[BANKNAME],
               [tblRecieptReport].[PDCCHECKSERIALNO],
               [tblRecieptReport].[USER],
               [tblRecieptReport].[Mode],
               [tblRecieptReport].[UnitNo],
               [tblRecieptReport].[ProjectName],
               [tblRecieptReport].[BankBranch],
               ''                                                                                AS [BankCheckDate],
               ''                                                                                AS [BankCheckAmount],
               [tblRecieptReport].[RENTAL_LESS_VAT],
               [tblRecieptReport].[RENTAL_LESS_TAX]
        FROM
               [dbo].[tblRecieptReport]
        WHERE
               [tblRecieptReport].[TRANID] = @TranID
               AND [tblRecieptReport].[Mode] = @Mode
               AND [tblRecieptReport].[PaymentLevel] = @PaymentLevel
        ORDER BY
               [tblRecieptReport].[EncodedDate]

    END;
GO
