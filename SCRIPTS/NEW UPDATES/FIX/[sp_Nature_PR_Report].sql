USE [LEASINGDB]
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE OR ALTER PROCEDURE [dbo].[sp_Nature_PR_Report]
    @TranID       VARCHAR(20) = NULL,
    @Mode         VARCHAR(50) = NULL,
    @PaymentLevel VARCHAR(50) = NULL
AS
     BEGIN
        SET NOCOUNT ON;



        CREATE TABLE [#tblRecieptReport]
            (
                [client_no]          [VARCHAR](500)  NULL,
                [client_Name]        [VARCHAR](500)  NULL,
                [client_Address]     [VARCHAR](5000) NULL,
                [PR_No]              [VARCHAR](500)  NULL,
                [OR_No]              [VARCHAR](500)  NULL,
                [TIN_No]             [VARCHAR](500)  NULL,
                [TransactionDate]    [DATETIME]      NULL,
                [AmountInWords]      [VARCHAR](5000) NULL,
                [PaymentFor]         [VARCHAR](500)  NULL,
                [TotalAmountInDigit] [VARCHAR](100)  NULL,
                [RENTAL]             [VARCHAR](500)  NULL,
                [VAT]                [VARCHAR](500)  NULL,
                [VATPct]             [VARCHAR](500)  NULL,
                [TOTAL]              [VARCHAR](500)  NULL,
                [LESSWITHHOLDING]    [VARCHAR](500)  NULL,
                [TOTALAMOUNTDUE]     [VARCHAR](500)  NULL,
                [BANKNAME]           [VARCHAR](500)  NULL,
                [PDCCHECKSERIALNO]   [VARCHAR](500)  NULL,
                [USER]               [VARCHAR](500)  NULL,
                [EncodedDate]        [DATETIME]      NULL,
                [TRANID]             [VARCHAR](500)  NULL,
                [Mode]               [VARCHAR](500)  NULL,
                [PaymentLevel]       [VARCHAR](100)  NULL,
                [UnitNo]             [VARCHAR](150)  NULL,
                [ProjectName]        [VARCHAR](150)  NULL,
                [BankBranch]         [VARCHAR](150)  NULL,
                [BankAccountNumber]  [VARCHAR](150)  NULL,
                [BankAccountName]    [VARCHAR](150)  NULL,
                [RENTAL_LESS_VAT]    [VARCHAR](150)  NULL,
                [RENTAL_LESS_TAX]    [VARCHAR](150)  NULL
            )
        DECLARE @RentalSandMLabel VARCHAR(150) = ''
        DECLARE @UnitCategory VARCHAR(150) = ''
        DECLARE @combinedString VARCHAR(MAX);
        DECLARE @IsFullPayment BIT = 0;
        DECLARE @RefId VARCHAR(100) = '';
        DECLARE @WaterAndElectricityDeposit DECIMAL(18, 2) = 0
        DECLARE @SecDeposit DECIMAL(18, 2) = 0
        DECLARE @DepositState VARCHAR(500);
        --SELECT
        --    @UnitCategory = [dbo].[fnGetUnitCategoryByUnitId]([tblUnitReference].[UnitId])
        --FROM
        --    [dbo].[tblUnitReference]
        --WHERE
        --    [tblUnitReference].[RefId] =
        --    (
        --        SELECT
        --            [tblTransaction].[RefId]
        --        FROM
        --            [dbo].[tblTransaction]
        --        WHERE
        --            [tblTransaction].[TranID] = @TranID
        --    )

        BEGIN

            SELECT
                @IsFullPayment              = ISNULL([tblUnitReference].[IsFullPayment], 0),
                @RefId                      = [tblUnitReference].[RefId],
                @UnitCategory               = [dbo].[fnGetUnitCategoryByUnitId]([tblUnitReference].[UnitId]),
                @WaterAndElectricityDeposit = ISNULL([tblUnitReference].[WaterAndElectricityDeposit], 0),
                @SecDeposit                 = ISNULL([tblUnitReference].[SecDeposit], 0)
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

            IF @SecDeposit > 0
               AND @WaterAndElectricityDeposit = 0
                BEGIN
                    SET @DepositState = ' SECURITY DEPOSIT RENT '
                END
            ELSE IF @SecDeposit = 0
                    AND @WaterAndElectricityDeposit > 0
                BEGIN
                    SET @DepositState = ' SECURITY DEPOSIT WATER & ELECTRIC '
                END
            ELSE
                BEGIN
                    SET @DepositState = ' SECURITY DEPOSIT RENT, WATER & ELECTRIC '
                END
            ---------------------------------------------------------------------------------------------------------------------------------
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
                                    SET @RentalSandMLabel = 'RENTAL'
                                    SELECT
                                        @combinedString
                                        = 'RENTAL FOR '
                                          +
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
                                    SET @RentalSandMLabel = 'S&M'
                                    SELECT
                                        @combinedString
                                        = 'SECURITY & MAINTENANCE FOR'
                                          +
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
                                    SET @RentalSandMLabel = 'RENTAL'
                                    SELECT
                                        --@combinedString
                                        --= '('
                                        --  + CAST(CAST([dbo].[fnGetTotalSecDepositAmountCount](@RefId) AS INT) AS VARCHAR(50))
                                        --  + ')MONTH-SECURITY DEPOSIT'
                                        @combinedString = @DepositState

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
                                            SET @RentalSandMLabel = 'RENTAL'
                                            SELECT
                                                    @combinedString
                                                = IIF(@UnitCategory = 'PARKING', 'PS RENTAL FOR ', 'RENTAL FOR ')
                                                  --+ COALESCE(@combinedString + '-', '')
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
                                            SET @RentalSandMLabel = 'S&M'
                                            SELECT
                                                    @combinedString
                                                = 'SECURITY & MAINTENANCE FOR '
                                                  --+ COALESCE(@combinedString + '-', '')
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
                    INSERT INTO [#tblRecieptReport]
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
                            [BankAccountNumber],
                            [BankAccountName],
                            [RENTAL_LESS_VAT],
                            [RENTAL_LESS_TAX]
                        )
                                SELECT
                                    [CLIENT].[client_no]                                                                                                  AS [client_no],
                                    [CLIENT].[client_Name]                                                                                                AS [client_Name],
                                    [CLIENT].[client_Address]                                                                                             AS [client_Address],
                                    [RECEIPT].[PR_No]                                                                                                     AS [PR_No],
                                    [RECEIPT].[OR_No]                                                                                                     AS [OR_No],
                                    [CLIENT].[TIN_No]                                                                                                     AS [TIN_No],
                                    [RECEIPT].[TransactionDate]                                                                                           AS [TransactionDate],
                                    UPPER([dbo].[fnNumberToWordsWithDecimal](IIF(@IsFullPayment = 0,
                                                                                 [tblUnitReference].[AdvancePaymentAmount],
                                                                                 [tblUnitReference].[Total])
                                                                            )
                                         )                                                                                                                AS [AmountInWords],
                                    [PAYMENT].[PAYMENT_FOR]                                                                                               AS [PaymentFor],
                                    IIF(@IsFullPayment = 0,
                                        [tblUnitReference].[AdvancePaymentAmount],
                                        [tblUnitReference].[Total])                                                                                       AS [TotalAmountInDigit],
                                    IIF(@IsFullPayment = 0,
                                        [tblUnitReference].[AdvancePaymentAmount],
                                        [tblUnitReference].[Total])
                                    - (([tblUnitReference].[Unit_BaseRentalVatAmount]
                                        + [tblUnitReference].[Unit_SecAndMainVatAmount]
                                       )
                                       * CAST([dbo].[fnGetAdvanceMonthCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2))
                                      )                                                                                                                   AS [RENTAL],
                                    CAST(([tblUnitReference].[Unit_BaseRentalVatAmount]
                                          + [tblUnitReference].[Unit_SecAndMainVatAmount]
                                         )
                                         * CAST([dbo].[fnGetAdvanceMonthCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150))      AS [VAT_AMOUNT],
                                    CAST(CAST(IIF(ISNULL([tblUnitReference].[Unit_IsNonVat], 0) = 1,
                                                  0,
                                                  [tblUnitReference].[Unit_Vat]) AS INT) AS VARCHAR(10)) + '% VAT'                                        AS [VATPct],
                                    IIF(@IsFullPayment = 0,
                                        [tblUnitReference].[AdvancePaymentAmount],
                                        [tblUnitReference].[Total])                                                                                       AS [TOTAL],
                                    IIF([tblUnitReference].[Unit_TaxAmount] = 0,
                                        '',
                                        CAST([tblUnitReference].[Unit_BaseRentalTax]
                                             * CAST([dbo].[fnGetAdvanceMonthCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150))) AS [LESSWITHHOLDING],
                                    [tblUnitReference].[AdvancePaymentAmount]                                                                             AS [TOTALAMOUNTDUE],
                                    [RECEIPT].[BankName]                                                                                                  AS [BANKNAME],
                                    [RECEIPT].[PDC_CHECK_SERIAL]                                                                                          AS [PDCCHECKSERIALNO],
                                    [TRANSACTION].[USER]                                                                                                  AS [USER],
                                    GETDATE()                                                                                                             AS [EncodedDate],
                                    @TranID                                                                                                               AS [TRANID],
                                    @Mode                                                                                                                 AS [Mode],
                                    @PaymentLevel                                                                                                         AS [PaymentLevel],
                                    [tblUnitReference].[UnitNo]                                                                                           AS [UnitNo],
                                    [dbo].[fnGetProjectNameById]([tblUnitReference].[ProjectId])                                                          AS [ProjectName],
                                    [RECEIPT].[BankBranch]                                                                                                AS [BankBranch],
                                    [RECEIPT].[BankAccountNumber]                                                                                         AS [BankAccountNumber],
                                    [RECEIPT].[BankAccountName]                                                                                           AS [BankAccountName],
                                    CAST(CAST(IIF(@IsFullPayment = 0,
                                                  IIF([tblUnitReference].[Unit_TaxAmount] > 0,
                                                      ([tblUnitReference].[AdvancePaymentAmount]
                                                       + CAST([tblUnitReference].[Unit_BaseRentalTax]
                                                              * [dbo].[fnGetAdvanceMonthCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2))
                                                      ),
                                                      [tblUnitReference].[AdvancePaymentAmount]),
                                                  [tblUnitReference].[Total]) AS DECIMAL(18, 2))
                                         - CAST(([dbo].[tblUnitReference].[Unit_BaseRentalVatAmount]
                                                 + [tblUnitReference].[Unit_SecAndMainVatAmount]
                                                )
                                                * [dbo].[fnGetAdvanceMonthCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150))    AS [RENTAL_LESS_VAT],
                                    CAST(IIF(@IsFullPayment = 0,
                                             [tblUnitReference].[AdvancePaymentAmount],
                                             [tblUnitReference].[Total]) AS VARCHAR(150))                                                                 AS [RENTAL_LESS_TAX]
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
                                            [tblTransaction].[EncodedDate],
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
                                            [tblReceipt].[CompanyPRNo]       AS [PR_No],
                                            [tblReceipt].[CompanyORNo]       AS [OR_No],
                                            [tblReceipt].[Amount]            AS [TOTAL],
                                            [tblReceipt].[BankName]          AS [BankName],
                                            [tblReceipt].[BankBranch]        AS [BankBranch],
                                            [tblReceipt].[BankAccountNumber] AS [BankAccountNumber],
                                            [tblReceipt].[BankAccountName]   AS [BankAccountName],
                                            [tblReceipt].[SerialNo]          AS [PDC_CHECK_SERIAL],
                                            [tblReceipt].[TranId],
                                            [tblReceipt].[ReceiptDate]       AS [TransactionDate],
                                            [tblReceipt].[CheckDate]         AS [CheckDate],
                                            [tblReceipt].[PaymentMethod]     AS [ModeType]
                                        FROM
                                            [dbo].[tblReceipt]
                                        WHERE
                                            [TRANSACTION].[TranID] = [tblReceipt].[TranId]
                                    ) [RECEIPT]
                                    OUTER APPLY
                                    (
                                        SELECT
                                            IIF(@IsFullPayment = 1, 'FULL PAYMENT', @combinedString) AS [PAYMENT_FOR]
                                    ) [PAYMENT]
                                WHERE
                                    [TRANSACTION].[TranID] = @TranID


                END

            IF @Mode = 'SEC'
               AND @PaymentLevel = 'FIRST'
                BEGIN
                    INSERT INTO [#tblRecieptReport]
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
                            [BankAccountNumber],
                            [BankAccountName],
                            [RENTAL_LESS_VAT],
                            [RENTAL_LESS_TAX]
                        )
                                SELECT
                                    [CLIENT].[client_no]                                                                                                           AS [client_no],
                                    [CLIENT].[client_Name]                                                                                                         AS [client_Name],
                                    [CLIENT].[client_Address]                                                                                                      AS [client_Address],
                                    [RECEIPT].[PR_No]                                                                                                              AS [PR_No],
                                    [RECEIPT].[OR_No]                                                                                                              AS [OR_No],
                                    [CLIENT].[TIN_No]                                                                                                              AS [TIN_No],
                                    [RECEIPT].[TransactionDate]                                                                                                    AS [TransactionDate],
                                    UPPER([dbo].[fnNumberToWordsWithDecimal]((ISNULL([tblUnitReference].[SecDeposit], 0)
                                                                              + ISNULL(
                                                                                          [tblUnitReference].[WaterAndElectricityDeposit],
                                                                                          0
                                                                                      )
                                                                             )
                                                                            )
                                         )                                                                                                                         AS [AmountInWords],
                                    [PAYMENT].[PAYMENT_FOR]                                                                                                        AS [PaymentFor],
                                    ISNULL([tblUnitReference].[SecDeposit], 0)
                                    + ISNULL([tblUnitReference].[WaterAndElectricityDeposit], 0)                                                                   AS [TotalAmountInDigit],
                                    (ISNULL([tblUnitReference].[SecDeposit], 0)
                                     + ISNULL([tblUnitReference].[WaterAndElectricityDeposit], 0)
                                    )
                                    - CAST(([tblUnitReference].[Unit_BaseRentalVatAmount]
                                            + [tblUnitReference].[Unit_SecAndMainVatAmount]
                                           )
                                           * [dbo].[fnGetTotalSecDepositAmountCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2))                          AS [RENTAL],
                                    CAST(CAST(([tblUnitReference].[Unit_BaseRentalVatAmount]
                                               + [tblUnitReference].[Unit_SecAndMainVatAmount]
                                              )
                                              * [dbo].[fnGetTotalSecDepositAmountCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150))      AS [VAT],
                                    CAST(CAST(IIF(ISNULL([tblUnitReference].[Unit_IsNonVat], 0) = 1,
                                                  0,
                                                  [tblUnitReference].[Unit_Vat]) AS INT) AS VARCHAR(10)) + '% VAT'                                                 AS [VATPct],
                                    ISNULL([tblUnitReference].[SecDeposit], 0)
                                    + ISNULL([tblUnitReference].[WaterAndElectricityDeposit], 0)                                                                   AS [TOTAL],
                                    IIF([tblUnitReference].[Unit_TaxAmount] = 0,
                                        '',
                                        CAST(CAST([tblUnitReference].[Unit_TaxAmount]
                                                  * [dbo].[fnGetTotalSecDepositAmountCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150))) AS [LESSWITHHOLDING],
                                    ISNULL([tblUnitReference].[SecDeposit], 0)
                                    + ISNULL([tblUnitReference].[WaterAndElectricityDeposit], 0)                                                                   AS [TOTALAMOUNTDUE],
                                    [RECEIPT].[BankName]                                                                                                           AS [BANKNAME],
                                    [RECEIPT].[PDC_CHECK_SERIAL]                                                                                                   AS [PDCCHECKSERIALNO],
                                    [TRANSACTION].[USER]                                                                                                           AS [USER],
                                    GETDATE()                                                                                                                      AS [EncodedDate],
                                    @TranID                                                                                                                        AS [TRANID],
                                    @Mode                                                                                                                          AS [Mode],
                                    @PaymentLevel                                                                                                                  AS [PaymentLevel],
                                    [tblUnitReference].[UnitNo]                                                                                                    AS [UnitNo],
                                    [dbo].[fnGetProjectNameById]([tblUnitReference].[ProjectId])                                                                   AS [ProjectName],
                                    [RECEIPT].[BankBranch]                                                                                                         AS [BankBranch],
                                    [RECEIPT].[BankAccountNumber]                                                                                                  AS [BankAccountNumber],
                                    [RECEIPT].[BankAccountName]                                                                                                    AS [BankAccountName],
                                    CAST(CAST(IIF([tblUnitReference].[Unit_TaxAmount] > 0,
                                                  (ISNULL([tblUnitReference].[SecDeposit], 0)
                                                   + ISNULL([tblUnitReference].[WaterAndElectricityDeposit], 0)
                                                   + CAST([tblUnitReference].[Unit_BaseRentalTax]
                                                          * [dbo].[fnGetTotalSecDepositAmountCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2))
                                                  ),
                                                  0) AS DECIMAL(18, 2))
                                         - CAST(([tblUnitReference].[Unit_BaseRentalVatAmount]
                                                 + [tblUnitReference].[Unit_SecAndMainVatAmount]
                                                )
                                                * [dbo].[fnGetTotalSecDepositAmountCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150))    AS [RENTAL_LESS_VAT],
                                    CAST(CAST((ISNULL([tblUnitReference].[SecDeposit], 0)
                                               + ISNULL([tblUnitReference].[WaterAndElectricityDeposit], 0)
                                              ) AS DECIMAL(18, 2)) AS VARCHAR(150))                                                                                AS [RENTAL_LESS_TAX]
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
                                            [tblTransaction].[EncodedDate],
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
                                            [tblReceipt].[CompanyPRNo]       AS [PR_No],
                                            [tblReceipt].[CompanyORNo]       AS [OR_No],
                                            [tblReceipt].[Amount]            AS [TOTAL],
                                            [tblReceipt].[BankName]          AS [BankName],
                                            [tblReceipt].[BankBranch]        AS [BankBranch],
                                            [tblReceipt].[BankAccountNumber] AS [BankAccountNumber],
                                            [tblReceipt].[BankAccountName]   AS [BankAccountName],
                                            [tblReceipt].[SerialNo]          AS [PDC_CHECK_SERIAL],
                                            [tblReceipt].[TranId],
                                            [tblReceipt].[ReceiptDate]       AS [TransactionDate],
                                            [tblReceipt].[CheckDate]         AS [CheckDate],
                                            [tblReceipt].[PaymentMethod]     AS [ModeType]
                                        FROM
                                            [dbo].[tblReceipt]
                                        WHERE
                                            [TRANSACTION].[TranID] = [tblReceipt].[TranId]
                                    ) [RECEIPT]
                                    OUTER APPLY
                                    (
                                        SELECT
                                            IIF(@IsFullPayment = 1, 'FULL PAYMENT', @combinedString) AS [PAYMENT_FOR]
                                    ) [PAYMENT]
                                WHERE
                                    [TRANSACTION].[TranID] = @TranID


                END

            IF @Mode = 'REN'
               AND @PaymentLevel = 'SECOND'
                BEGIN
                    INSERT INTO [#tblRecieptReport]
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
                            [BankAccountNumber],
                            [BankAccountName],
                            [RENTAL_LESS_VAT],
                            [RENTAL_LESS_TAX]
                        )
                                SELECT
                                    [CLIENT].[client_no]                                                           AS [client_no],
                                    [CLIENT].[client_Name]                                                         AS [client_Name],
                                    [CLIENT].[client_Address]                                                      AS [client_Address],
                                    [RECEIPT].[PR_No]                                                              AS [PR_No],
                                    [RECEIPT].[OR_No]                                                              AS [OR_No],
                                    [CLIENT].[TIN_No]                                                              AS [TIN_No],
                                    [RECEIPT].[TransactionDate]                                                    AS [TransactionDate],
                                    UPPER([dbo].[fnNumberToWordsWithDecimal]([TRANSACTION].[ReceiveAmount]))       AS [AmountInWords],
                                    [PAYMENT].[PAYMENT_FOR]                                                        AS [PaymentFor],
                                    [TRANSACTION].[ReceiveAmount]                                                  AS [TotalAmountInDigit],
                                    [TRANSACTION].[ReceiveAmount]
                                    - [dbo].[fnGetBaseRentalTotalVatAmount](
                                                                               [dbo].[tblUnitReference].[RefId],
                                                                               [TRANSACTION].[AmountToPay],
                                                                               [TRANSACTION].[ReceiveAmount]
                                                                           )                                       AS [RENTAL],
                                    CAST([dbo].[fnGetBaseRentalTotalVatAmount](
                                                                                  [dbo].[tblUnitReference].[RefId],
                                                                                  [TRANSACTION].[AmountToPay],
                                                                                  [TRANSACTION].[ReceiveAmount]
                                                                              ) AS VARCHAR(150))                   AS [VAT],
                                    CAST(CAST(IIF(ISNULL([tblUnitReference].[Unit_IsNonVat], 0) = 1,
                                                  0,
                                                  [tblUnitReference].[Unit_Vat]) AS INT) AS VARCHAR(10)) + '% VAT' AS [VATPct],
                                    [TRANSACTION].[ReceiveAmount]                                                  AS [TOTAL],
                                    IIF([tblUnitReference].[Unit_TaxAmount] = 0,
                                        '',
                                        CAST([dbo].[fnGetBaseRentalTotalTaxAmount](
                                                                                      [dbo].[tblUnitReference].[RefId],
                                                                                      [TRANSACTION].[AmountToPay],
                                                                                      [TRANSACTION].[ReceiveAmount]
                                                                                  ) AS VARCHAR(150)))              AS [LESSWITHHOLDING],
                                    [TRANSACTION].[ReceiveAmount]                                                  AS [TOTALAMOUNTDUE],
                                    [RECEIPT].[BankName]                                                           AS [BANKNAME],
                                    [RECEIPT].[PDC_CHECK_SERIAL]                                                   AS [PDCCHECKSERIALNO],
                                    [TRANSACTION].[USER]                                                           AS [USER],
                                    GETDATE()                                                                      AS [EncodedDate],
                                    @TranID                                                                        AS [TRANID],
                                    @Mode                                                                          AS [Mode],
                                    @PaymentLevel                                                                  AS [PaymentLevel],
                                    [tblUnitReference].[UnitNo]                                                    AS [UnitNo],
                                    [dbo].[fnGetProjectNameById]([tblUnitReference].[ProjectId])                   AS [ProjectName],
                                    [RECEIPT].[BankBranch]                                                         AS [BankBranch],
                                    [RECEIPT].[BankAccountNumber]                                                  AS [BankAccountNumber],
                                    [RECEIPT].[BankAccountName]                                                    AS [BankAccountName],
                                    '0'                                                                            AS [RENTAL_LESS_VAT],
                                    '0'                                                                            AS [RENTAL_LESS_TAX]
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
                                                [tblTransaction].[EncodedDate],
                                                [tblTransaction].[TranID],
                                                SUM([tblMonthLedger].[LedgRentalAmount])                         AS [AmountToPay],
                                                ISNULL([dbo].[fn_GetUserName]([tblTransaction].[EncodedBy]), '') AS [USER],
                                                SUM([tblPayment].[Amount])                                       AS [ReceiveAmount]
                                        FROM
                                                [dbo].[tblTransaction]
                                            INNER JOIN
                                                [dbo].[tblPayment]
                                                    ON [tblPayment].[TranId] = [tblTransaction].[TranID]
                                            INNER JOIN
                                                [dbo].[tblMonthLedger]
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
                                            [tblReceipt].[CompanyPRNo]       AS [PR_No],
                                            [tblReceipt].[CompanyORNo]       AS [OR_No],
                                            [tblReceipt].[Amount]            AS [TOTAL],
                                            [tblReceipt].[Amount]            AS [TotalAmountInDigit],
                                            [tblReceipt].[BankName]          AS [BankName],
                                            [tblReceipt].[BankBranch]        AS [BankBranch],
                                            [tblReceipt].[BankAccountNumber] AS [BankAccountNumber],
                                            [tblReceipt].[BankAccountName]   AS [BankAccountName],
                                            [tblReceipt].[SerialNo]          AS [PDC_CHECK_SERIAL],
                                            [tblReceipt].[TranId],
                                            [tblReceipt].[ReceiptDate]       AS [TransactionDate],
                                            [tblReceipt].[CheckDate]         AS [CheckDate],
                                            [tblReceipt].[PaymentMethod]     AS [ModeType]
                                        FROM
                                            [dbo].[tblReceipt]
                                        WHERE
                                            [TRANSACTION].[TranID] = [tblReceipt].[TranId]
                                    ) [RECEIPT]
                                    OUTER APPLY
                                    (
                                        SELECT
                                            IIF(@IsFullPayment = 1, 'FULL PAYMENT', @combinedString) AS [PAYMENT_FOR]
                                    ) [PAYMENT]
                                WHERE
                                    [TRANSACTION].[TranID] = @TranID;
                END

            IF @Mode = 'MAIN'
               AND @PaymentLevel = 'SECOND'
                BEGIN
                    INSERT INTO [#tblRecieptReport]
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
                            [BankAccountNumber],
                            [BankAccountName],
                            [RENTAL_LESS_VAT],
                            [RENTAL_LESS_TAX]
                        )
                                SELECT
                                    [CLIENT].[client_no]                                                           AS [client_no],
                                    [CLIENT].[client_Name]                                                         AS [client_Name],
                                    [CLIENT].[client_Address]                                                      AS [client_Address],
                                    [RECEIPT].[PR_No]                                                              AS [PR_No],
                                    [RECEIPT].[OR_No]                                                              AS [OR_No],
                                    [CLIENT].[TIN_No]                                                              AS [TIN_No],
                                    [RECEIPT].[TransactionDate]                                                    AS [TransactionDate],
                                    UPPER([dbo].[fnNumberToWordsWithDecimal]([TRANSACTION].[ReceiveAmount]))       AS [AmountInWords],
                                    [PAYMENT].[PAYMENT_FOR]                                                        AS [PaymentFor],
                                    [TRANSACTION].[ReceiveAmount]                                                  AS [TotalAmountInDigit],
                                    [TRANSACTION].[ReceiveAmount]
                                    - CAST(((IIF(ISNULL([tblUnitReference].[Unit_IsNonVat], 0) = 1,
                                                 0,
                                                 [tblUnitReference].[Unit_Vat]) * [TRANSACTION].[ReceiveAmount]
                                            ) / 100
                                           ) AS DECIMAL(18, 2))                                                    AS [RENTAL],
                                    CAST(CAST(((IIF(ISNULL([tblUnitReference].[Unit_IsNonVat], 0) = 1,
                                                    0,
                                                    [tblUnitReference].[Unit_Vat]) * [TRANSACTION].[ReceiveAmount]
                                               )
                                               / 100
                                              ) AS DECIMAL(18, 2)) AS VARCHAR(30))                                 AS [VAT], --TAX WILL FOLLOW
                                    CAST(CAST(IIF(ISNULL([tblUnitReference].[Unit_IsNonVat], 0) = 1,
                                                  0,
                                                  [tblUnitReference].[Unit_Vat]) AS INT) AS VARCHAR(10)) + '% VAT' AS [VATPct],
                                    [TRANSACTION].[ReceiveAmount]                                                  AS [TOTAL],
                                    IIF([tblUnitReference].[Unit_TaxAmount] > 0,
                                        CAST(CAST((([tblUnitReference].[Unit_Tax] * [TRANSACTION].[ReceiveAmount])
                                                   / 100
                                                  ) AS DECIMAL(18, 2)) AS VARCHAR(30)),
                                        '')                                                                        AS [LESSWITHHOLDING],
                                    [TRANSACTION].[ReceiveAmount]                                                  AS [TOTALAMOUNTDUE],
                                    [RECEIPT].[BankName]                                                           AS [BANKNAME],
                                    [RECEIPT].[PDC_CHECK_SERIAL]                                                   AS [PDCCHECKSERIALNO],
                                    [TRANSACTION].[USER]                                                           AS [USER],
                                    GETDATE()                                                                      AS [EncodedDate],
                                    @TranID                                                                        AS [TRANID],
                                    @Mode                                                                          AS [Mode],
                                    @PaymentLevel                                                                  AS [PaymentLevel],
                                    [tblUnitReference].[UnitNo]                                                    AS [UnitNo],
                                    [dbo].[fnGetProjectNameById]([tblUnitReference].[ProjectId])                   AS [ProjectName],
                                    [RECEIPT].[BankBranch]                                                         AS [BankBranch],
                                    [RECEIPT].[BankAccountNumber]                                                  AS [BankAccountNumber],
                                    [RECEIPT].[BankAccountName]                                                    AS [BankAccountName],
                                    '0'                                                                            AS [RENTAL_LESS_VAT],
                                    '0'                                                                            AS [RENTAL_LESS_TAX]
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
                                                [tblTransaction].[EncodedDate],
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
                                            [tblReceipt].[CompanyPRNo]       AS [PR_No],
                                            [tblReceipt].[CompanyORNo]       AS [OR_No],
                                            [tblReceipt].[Amount]            AS [TOTAL],
                                            [tblReceipt].[Amount]            AS [TotalAmountInDigit],
                                            [tblReceipt].[BankName]          AS [BankName],
                                            [tblReceipt].[BankBranch]        AS [BankBranch],
                                            [tblReceipt].[BankAccountNumber] AS [BankAccountNumber],
                                            [tblReceipt].[BankAccountName]   AS [BankAccountName],
                                            [tblReceipt].[SerialNo]          AS [PDC_CHECK_SERIAL],
                                            [tblReceipt].[TranId],
                                            [tblReceipt].[ReceiptDate]       AS [TransactionDate],
                                            [tblReceipt].[CheckDate]         AS [CheckDate],
                                            [tblReceipt].[PaymentMethod]     AS [ModeType]
                                        FROM
                                            [dbo].[tblReceipt]
                                        WHERE
                                            [TRANSACTION].[TranID] = [tblReceipt].[TranId]
                                    ) [RECEIPT]
                                    OUTER APPLY
                                    (
                                        SELECT
                                            IIF(@IsFullPayment = 1, 'FULL PAYMENT', @combinedString) AS [PAYMENT_FOR]
                                    ) [PAYMENT]
                                WHERE
                                    [TRANSACTION].[TranID] = @TranID;
                END

            IF @Mode = 'RENMAIN'
               AND @PaymentLevel = 'SECOND'
                BEGIN
                    INSERT INTO [#tblRecieptReport]
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
                            [BankAccountNumber],
                            [BankAccountName],
                            [RENTAL_LESS_VAT],
                            [RENTAL_LESS_TAX]
                        )
                                SELECT
                                    [CLIENT].[client_no]                                                           AS [client_no],
                                    [CLIENT].[client_Name]                                                         AS [client_Name],
                                    [CLIENT].[client_Address]                                                      AS [client_Address],
                                    [RECEIPT].[PR_No]                                                              AS [PR_No],
                                    [RECEIPT].[OR_No]                                                              AS [OR_No],
                                    [CLIENT].[TIN_No]                                                              AS [TIN_No],
                                    [RECEIPT].[TransactionDate]                                                    AS [TransactionDate],
                                    UPPER([dbo].[fnNumberToWordsWithDecimal]([TRANSACTION].[ReceiveAmount]))       AS [AmountInWords],
                                    [PAYMENT].[PAYMENT_FOR]                                                        AS [PaymentFor],
                                    [TRANSACTION].[ReceiveAmount]                                                  AS [TotalAmountInDigit],
                                    [TRANSACTION].[ReceiveAmount]
                                    - [dbo].[fnGetBaseRentalTotalVatAmount](
                                                                               [dbo].[tblUnitReference].[RefId],
                                                                               [TRANSACTION].[AmountToPay],
                                                                               [TRANSACTION].[ReceiveAmount]
                                                                           )                                       AS [RENTAL],
                                    CAST([dbo].[fnGetBaseRentalTotalVatAmount](
                                                                                  [dbo].[tblUnitReference].[RefId],
                                                                                  [TRANSACTION].[AmountToPay],
                                                                                  [TRANSACTION].[ReceiveAmount]
                                                                              ) AS VARCHAR(150))                   AS [VAT],
                                    CAST(CAST(IIF(ISNULL([tblUnitReference].[Unit_IsNonVat], 0) = 1,
                                                  0,
                                                  [tblUnitReference].[Unit_Vat]) AS INT) AS VARCHAR(10)) + '% VAT' AS [VATPct],
                                    [TRANSACTION].[ReceiveAmount]                                                  AS [TOTAL],
                                    IIF([tblUnitReference].[Unit_TaxAmount] = 0,
                                        '',
                                        CAST([dbo].[fnGetBaseRentalTotalTaxAmount](
                                                                                      [dbo].[tblUnitReference].[RefId],
                                                                                      [TRANSACTION].[AmountToPay],
                                                                                      [TRANSACTION].[ReceiveAmount]
                                                                                  ) AS VARCHAR(150)))              AS [LESSWITHHOLDING],
                                    [TRANSACTION].[ReceiveAmount]                                                  AS [TOTALAMOUNTDUE],
                                    [RECEIPT].[BankName]                                                           AS [BANKNAME],
                                    [RECEIPT].[PDC_CHECK_SERIAL]                                                   AS [PDCCHECKSERIALNO],
                                    [TRANSACTION].[USER]                                                           AS [USER],
                                    GETDATE()                                                                      AS [EncodedDate],
                                    @TranID                                                                        AS [TRANID],
                                    @Mode                                                                          AS [Mode],
                                    @PaymentLevel                                                                  AS [PaymentLevel],
                                    [tblUnitReference].[UnitNo]                                                    AS [UnitNo],
                                    [dbo].[fnGetProjectNameById]([tblUnitReference].[ProjectId])                   AS [ProjectName],
                                    [RECEIPT].[BankBranch]                                                         AS [BankBranch],
                                    [RECEIPT].[BankAccountNumber]                                                  AS [BankAccountNumber],
                                    [RECEIPT].[BankAccountName]                                                    AS [BankAccountName],
                                    '0'                                                                            AS [RENTAL_LESS_VAT],
                                    '0'                                                                            AS [RENTAL_LESS_TAX]
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
                                                [tblTransaction].[EncodedDate],
                                                [tblTransaction].[TranID],
                                                SUM([tblMonthLedger].[LedgRentalAmount])                         AS [AmountToPay],
                                                ISNULL([dbo].[fn_GetUserName]([tblTransaction].[EncodedBy]), '') AS [USER],
                                                SUM([tblPayment].[Amount])                                       AS [ReceiveAmount]
                                        FROM
                                                [dbo].[tblTransaction]
                                            INNER JOIN
                                                [dbo].[tblPayment]
                                                    ON [tblPayment].[TranId] = [tblTransaction].[TranID]
                                            INNER JOIN
                                                [dbo].[tblMonthLedger]
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
                                            [tblReceipt].[CompanyPRNo]       AS [PR_No],
                                            [tblReceipt].[CompanyORNo]       AS [OR_No],
                                            [tblReceipt].[Amount]            AS [TOTAL],
                                            [tblReceipt].[Amount]            AS [TotalAmountInDigit],
                                            [tblReceipt].[BankName]          AS [BankName],
                                            [tblReceipt].[BankBranch]        AS [BankBranch],
                                            [tblReceipt].[BankAccountNumber] AS [BankAccountNumber],
                                            [tblReceipt].[BankAccountName]   AS [BankAccountName],
                                            [tblReceipt].[SerialNo]          AS [PDC_CHECK_SERIAL],
                                            [tblReceipt].[TranId],
                                            [tblReceipt].[ReceiptDate]       AS [TransactionDate],
                                            [tblReceipt].[CheckDate]         AS [CheckDate],
                                            [tblReceipt].[PaymentMethod]     AS [ModeType]
                                        FROM
                                            [dbo].[tblReceipt]
                                        WHERE
                                            [TRANSACTION].[TranID] = [tblReceipt].[TranId]
                                    ) [RECEIPT]
                                    OUTER APPLY
                                    (
                                        SELECT
                                            IIF(@IsFullPayment = 1, 'FULL PAYMENT', @combinedString) AS [PAYMENT_FOR]
                                    ) [PAYMENT]
                                WHERE
                                    [TRANSACTION].[TranID] = @TranID;
                END

            IF @Mode = 'PEN'
               AND @PaymentLevel = 'SECOND'
                BEGIN
                    INSERT INTO [#tblRecieptReport]
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
                            [BankAccountNumber],
                            [BankAccountName],
                            [RENTAL_LESS_VAT],
                            [RENTAL_LESS_TAX]
                        )
                                SELECT
                                    [CLIENT].[client_no]                                                           AS [client_no],
                                    [CLIENT].[client_Name]                                                         AS [client_Name],
                                    [CLIENT].[client_Address]                                                      AS [client_Address],
                                    [RECEIPT].[PR_No]                                                              AS [PR_No],
                                    [RECEIPT].[OR_No]                                                              AS [OR_No],
                                    [CLIENT].[TIN_No]                                                              AS [TIN_No],
                                    [RECEIPT].[TransactionDate]                                                    AS [TransactionDate],
                                    UPPER([dbo].[fnNumberToWordsWithDecimal]([TRANSACTION].[ReceiveAmount]))       AS [AmountInWords],
                                    [PAYMENT].[PAYMENT_FOR]                                                        AS [PaymentFor],
                                    [TRANSACTION].[ReceiveAmount]                                                  AS [TotalAmountInDigit],
                                    [TRANSACTION].[ReceiveAmount]
                                    - [dbo].[fnGetBaseRentalTotalVatAmount](
                                                                               [dbo].[tblUnitReference].[RefId],
                                                                               [TRANSACTION].[AmountToPay],
                                                                               [TRANSACTION].[ReceiveAmount]
                                                                           )                                       AS [RENTAL],
                                    CAST([dbo].[fnGetBaseRentalTotalVatAmount](
                                                                                  [dbo].[tblUnitReference].[RefId],
                                                                                  [TRANSACTION].[AmountToPay],
                                                                                  [TRANSACTION].[ReceiveAmount]
                                                                              ) AS VARCHAR(150))                   AS [VAT],
                                    CAST(CAST(IIF(ISNULL([tblUnitReference].[Unit_IsNonVat], 0) = 1,
                                                  0,
                                                  [tblUnitReference].[Unit_Vat]) AS INT) AS VARCHAR(10)) + '% VAT' AS [VATPct],
                                    [TRANSACTION].[ReceiveAmount]                                                  AS [TOTAL],
                                    IIF([tblUnitReference].[Unit_TaxAmount] = 0,
                                        '',
                                        CAST([dbo].[fnGetBaseRentalTotalTaxAmount](
                                                                                      [dbo].[tblUnitReference].[RefId],
                                                                                      [TRANSACTION].[AmountToPay],
                                                                                      [TRANSACTION].[ReceiveAmount]
                                                                                  ) AS VARCHAR(150)))              AS [LESSWITHHOLDING],
                                    [TRANSACTION].[ReceiveAmount]                                                  AS [TOTALAMOUNTDUE],
                                    [RECEIPT].[BankName]                                                           AS [BANKNAME],
                                    [RECEIPT].[PDC_CHECK_SERIAL]                                                   AS [PDCCHECKSERIALNO],
                                    [TRANSACTION].[USER]                                                           AS [USER],
                                    GETDATE()                                                                      AS [EncodedDate],
                                    @TranID                                                                        AS [TRANID],
                                    @Mode                                                                          AS [Mode],
                                    @PaymentLevel                                                                  AS [PaymentLevel],
                                    [tblUnitReference].[UnitNo]                                                    AS [UnitNo],
                                    [dbo].[fnGetProjectNameById]([tblUnitReference].[ProjectId])                   AS [ProjectName],
                                    [RECEIPT].[BankBranch]                                                         AS [BankBranch],
                                    [RECEIPT].[BankAccountNumber]                                                  AS [BankAccountNumber],
                                    [RECEIPT].[BankAccountName]                                                    AS [BankAccountName],
                                    '0'                                                                            AS [RENTAL_LESS_VAT],
                                    '0'                                                                            AS [RENTAL_LESS_TAX]
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
                                                [tblTransaction].[EncodedDate],
                                                [tblTransaction].[TranID],
                                                SUM([tblMonthLedger].[LedgRentalAmount])                         AS [AmountToPay],
                                                ISNULL([dbo].[fn_GetUserName]([tblTransaction].[EncodedBy]), '') AS [USER],
                                                SUM([tblPayment].[Amount])                                       AS [ReceiveAmount]
                                        FROM
                                                [dbo].[tblTransaction]
                                            INNER JOIN
                                                [dbo].[tblPayment]
                                                    ON [tblPayment].[TranId] = [tblTransaction].[TranID]
                                            INNER JOIN
                                                [dbo].[tblMonthLedger]
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
                                            [tblReceipt].[CompanyPRNo]       AS [PR_No],
                                            [tblReceipt].[CompanyORNo]       AS [OR_No],
                                            [tblReceipt].[Amount]            AS [TOTAL],
                                            [tblReceipt].[Amount]            AS [TotalAmountInDigit],
                                            [tblReceipt].[BankName]          AS [BankName],
                                            [tblReceipt].[BankBranch]        AS [BankBranch],
                                            [tblReceipt].[BankAccountNumber] AS [BankAccountNumber],
                                            [tblReceipt].[BankAccountName]   AS [BankAccountName],
                                            [tblReceipt].[SerialNo]          AS [PDC_CHECK_SERIAL],
                                            [tblReceipt].[TranId],
                                            [tblReceipt].[ReceiptDate]       AS [TransactionDate],
                                            [tblReceipt].[CheckDate]         AS [CheckDate],
                                            [tblReceipt].[PaymentMethod]     AS [ModeType]
                                        FROM
                                            [dbo].[tblReceipt]
                                        WHERE
                                            [TRANSACTION].[TranID] = [tblReceipt].[TranId]
                                    ) [RECEIPT]
                                    OUTER APPLY
                                    (
                                        SELECT
                                            IIF(@IsFullPayment = 1, 'FULL PAYMENT', @combinedString) AS [PAYMENT_FOR]
                                    ) [PAYMENT]
                                WHERE
                                    [TRANSACTION].[TranID] = @TranID;
                END

            IF @Mode = 'OTH'
               AND @PaymentLevel = 'OTHER'
                BEGIN
                    INSERT INTO [#tblRecieptReport]
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
                            [BankAccountNumber],
                            [BankAccountName],
                            [RENTAL_LESS_VAT],
                            [RENTAL_LESS_TAX]
                        )
                                SELECT
                                    [CLIENT].[client_no]                                                        AS [client_no],
                                    [CLIENT].[client_Name]                                                      AS [client_Name],
                                    [CLIENT].[client_Address]                                                   AS [client_Address],
                                    [RECEIPT].[PR_No]                                                           AS [PR_No],
                                    [RECEIPT].[OR_No]                                                           AS [OR_No],
                                    [CLIENT].[TIN_No]                                                           AS [TIN_No],
                                    [RECEIPT].[TransactionDate]                                                 AS [TransactionDate],
                                    UPPER([dbo].[fnNumberToWordsWithDecimal]([tblTransaction].[ReceiveAmount])) AS [AmountInWords],
                                    [PAYMENT].[PAYMENT_FOR]                                                     AS [PaymentFor],
                                    [tblTransaction].[ReceiveAmount]                                            AS [TotalAmountInDigit],
                                    [tblTransaction].[ReceiveAmount]                                            AS [RENTAL],
                                    0                                                                           AS [VAT],
                                    '% VAT'                                                                     AS [VATPct],
                                    [tblTransaction].[ReceiveAmount]                                            AS [TOTAL],
                                    0                                                                           AS [LESSWITHHOLDING],
                                    [tblTransaction].[ReceiveAmount]                                            AS [TOTALAMOUNTDUE],
                                    [RECEIPT].[BankName]                                                        AS [BANKNAME],
                                    [RECEIPT].[PDC_CHECK_SERIAL]                                                AS [PDCCHECKSERIALNO],
                                    ISNULL([dbo].[fn_GetUserName]([tblTransaction].[EncodedBy]), '')            AS [USER],
                                    GETDATE()                                                                   AS [EncodedDate],
                                    @TranID                                                                     AS [TRANID],
                                    @Mode                                                                       AS [Mode],
                                    @PaymentLevel                                                               AS [PaymentLevel],
                                    0                                                                           AS [UnitNo],
                                    [dbo].[fnGetProjectNameById](1)                                             AS [ProjectName],
                                    [RECEIPT].[BankBranch]                                                      AS [BankBranch],
                                    [RECEIPT].[BankAccountNumber]                                               AS [BankAccountNumber],
                                    [RECEIPT].[BankAccountName]                                                 AS [BankAccountName],
                                    '0'                                                                         AS [RENTAL_LESS_VAT],
                                    '0'                                                                         AS [RENTAL_LESS_TAX]
                                FROM
                                    [dbo].[tblTransaction]
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
                                            [tblClientMstr].[ClientID] = [tblTransaction].[OtherPaymentClientID]
                                    ) [CLIENT]
                                    --OUTER APPLY
                                    --(
                                    --    SELECT
                                    --            [tblTransaction].[EncodedDate],
                                    --            [tblTransaction].[TranID],
                                    --            SUM([tblMonthLedger].[LedgRentalAmount])                         AS [AmountToPay],
                                    --            ISNULL([dbo].[fn_GetUserName]([tblTransaction].[EncodedBy]), '') AS [USER],
                                    --            SUM([tblPayment].[Amount])                                       AS [ReceiveAmount]
                                    --    FROM
                                    --            [dbo].[tblTransaction]
                                    --        INNER JOIN
                                    --            [dbo].[tblPayment]
                                    --                ON [tblPayment].[TranId] = [tblTransaction].[TranID]
                                    --        INNER JOIN
                                    --            [dbo].[tblMonthLedger]
                                    --                ON [tblMonthLedger].[Recid] = [tblPayment].[LedgeRecid]
                                    --    WHERE
                                    --            [tblUnitReference].[RefId] = [tblTransaction].[RefId]
                                    --            AND [tblPayment].[Notes] = 'RENTAL NET OF VAT'
                                    --    GROUP BY
                                    --            [tblTransaction].[EncodedDate],
                                    --            [tblTransaction].[TranID],
                                    --            [tblTransaction].[EncodedBy],
                                    --            [tblPayment].[Amount],
                                    --            [tblTransaction].[PaidAmount]
                                    --) [TRANSACTION]
                                    OUTER APPLY
                                    (
                                        SELECT
                                            [tblReceipt].[CompanyPRNo]       AS [PR_No],
                                            [tblReceipt].[CompanyORNo]       AS [OR_No],
                                            [tblReceipt].[Amount]            AS [TOTAL],
                                            [tblReceipt].[Amount]            AS [TotalAmountInDigit],
                                            [tblReceipt].[BankName]          AS [BankName],
                                            [tblReceipt].[BankBranch]        AS [BankBranch],
                                            [tblReceipt].[BankAccountNumber] AS [BankAccountNumber],
                                            [tblReceipt].[BankAccountName]   AS [BankAccountName],
                                            [tblReceipt].[SerialNo]          AS [PDC_CHECK_SERIAL],
                                            [tblReceipt].[TranId],
                                            [tblReceipt].[ReceiptDate]       AS [TransactionDate],
                                            [tblReceipt].[CheckDate]         AS [CheckDate],
                                            [tblReceipt].[PaymentMethod]     AS [ModeType]
                                        FROM
                                            [dbo].[tblReceipt]
                                        WHERE
                                            [tblReceipt].[TranId] = [tblTransaction].[TranID]
                                    ) [RECEIPT]
                                    OUTER APPLY
                                    (
                                        SELECT
                                            IIF(@IsFullPayment = 1, 'FULL PAYMENT', @combinedString) AS [PAYMENT_FOR]
                                    ) [PAYMENT]
                                WHERE
                                    [tblTransaction].[TranID] = @TranID;
                END

        END


        SELECT
            @RentalSandMLabel                                                                      AS [RentalSandMLabel],
            [#tblRecieptReport].[client_no],
            [#tblRecieptReport].[client_Name],
            [#tblRecieptReport].[client_Address],
            [#tblRecieptReport].[PR_No],
            [#tblRecieptReport].[OR_No],
            [#tblRecieptReport].[TIN_No],
            CAST(CONVERT(VARCHAR(15), [#tblRecieptReport].[TransactionDate], 107) AS VARCHAR(150)) AS [TransactionDate],
            [#tblRecieptReport].[AmountInWords],
            ISNULL([#tblRecieptReport].[PaymentFor], '')                                           AS [PaymentFor],
            --FORMAT(CAST([#TMP].[TotalAmountInDigit] AS DECIMAL(18, 2)), 'C', 'en-PH') AS [TotalAmountInDigit],
            FORMAT(CAST([#tblRecieptReport].[TotalAmountInDigit] AS DECIMAL(18, 2)), 'N')          AS [TotalAmountInDigit],
            --FORMAT(CAST([#TMP].[RENTAL] AS DECIMAL(18, 2)), 'C', 'en-PH') AS [RENTAL],
            FORMAT(CAST([#tblRecieptReport].[RENTAL] AS DECIMAL(18, 2)), 'C', 'en-PH')             AS [RENTAL],
            FORMAT(CAST([#tblRecieptReport].[VAT] AS DECIMAL(18, 2)), 'C', 'en-PH')                AS [VAT],
            [#tblRecieptReport].[VATPct],
            FORMAT(CAST([#tblRecieptReport].[RENTAL] AS DECIMAL(18, 2)), 'C', 'en-PH')             AS [TOTAL],
            --FORMAT(CAST([tblRecieptReport].[LESSWITHHOLDING] AS DECIMAL(18, 2)), 'C', 'en-PH') AS [LESSWITHHOLDING],
            [#tblRecieptReport].[LESSWITHHOLDING]                                                  AS [LESSWITHHOLDING],
            IIF([#tblRecieptReport].[LESSWITHHOLDING] <> '', 'LESS WITHHOLDING', '')               AS [LESSWITHHOLDING_label],
            --[#TMP].[LESSWITHHOLDING] AS [LESSWITHHOLDING],
            FORMAT(CAST([#tblRecieptReport].[TOTALAMOUNTDUE] AS DECIMAL(18, 2)), 'C', 'en-PH')     AS [TOTALAMOUNTDUE],
            [#tblRecieptReport].[BANKNAME],
            [#tblRecieptReport].[PDCCHECKSERIALNO],
            [#tblRecieptReport].[USER],
            [#tblRecieptReport].[Mode],
            [#tblRecieptReport].[UnitNo],
            [#tblRecieptReport].[ProjectName],
            [#tblRecieptReport].[BankBranch],
            [#tblRecieptReport].[BankAccountNumber]                                                AS [BankAccountNumber],
            [#tblRecieptReport].[BankAccountName]                                                  AS [BankAccountName],
            CAST(CONVERT(VARCHAR(15), [#tblRecieptReport].[TransactionDate], 107) AS VARCHAR(150)) AS [BankCheckDate],
            FORMAT(CAST([#tblRecieptReport].[TOTALAMOUNTDUE] AS DECIMAL(18, 2)), 'C', 'en-PH')     AS [BankCheckAmount],
            [#tblRecieptReport].[RENTAL_LESS_VAT],
            [#tblRecieptReport].[RENTAL_LESS_TAX]
        FROM
            [#tblRecieptReport]
        --WHERE
        --       [tblRecieptReport].[TRANID] = @TranID
        --       AND [tblRecieptReport].[Mode] = @Mode
        --       AND [tblRecieptReport].[PaymentLevel] = @PaymentLevel
        ORDER BY
            [#tblRecieptReport].[EncodedDate]

    END;

    DROP TABLE [#tblRecieptReport]
GO

