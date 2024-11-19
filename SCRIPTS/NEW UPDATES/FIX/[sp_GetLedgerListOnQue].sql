USE [LEASINGDB]
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_GetLedgerListOnQue]
    --@ReferenceID BIGINT = NULL,
    --@ClientID VARCHAR(50) = NULL
    @XML XML = NULL
AS
    BEGIN

        SET NOCOUNT ON;
        DECLARE @ReferenceID BIGINT = 0

        CREATE TABLE [#tempMonthDecalrationFinal]
            (
                [Id]                           [BIGINT] IDENTITY(1, 1),
                [Recid]                        [BIGINT],
                [ReferenceID]                  [BIGINT],
                [ClientID]                     [VARCHAR](500),
                [LedgMonth]                    [DATE],
                [LedgAmount]                   [DECIMAL](18, 2),
                [IsPaid]                       [BIT],
                [EncodedBy]                    [INT],
                [EncodedDate]                  [DATETIME],
                [ComputerName]                 [VARCHAR](30),
                [TransactionID]                [VARCHAR](500),
                [IsHold]                       [BIT],
                [BalanceAmount]                [DECIMAL](18, 2),
                [PenaltyAmount]                [DECIMAL](18, 2),
                [ActualAmount]                 [DECIMAL](18, 2),
                [LedgRentalAmount]             [DECIMAL](18, 2),
                [Remarks]                      [VARCHAR](500),
                [Unit_ProjectType]             [VARCHAR](150),
                [Unit_IsNonVat]                [BIT],
                [Unit_BaseRentalVatAmount]     [DECIMAL](18, 2),
                [Unit_BaseRentalWithVatAmount] [DECIMAL](18, 2),
                [Unit_BaseRentalTax]           [DECIMAL](18, 2),
                [Unit_TotalRental]             [DECIMAL](18, 2),
                [Unit_SecAndMainAmount]        [DECIMAL](18, 2),
                [Unit_SecAndMainVatAmount]     [DECIMAL](18, 2),
                [Unit_SecAndMainWithVatAmount] [DECIMAL](18, 2),
                [Unit_Vat]                     [DECIMAL](18, 2),
                [Unit_Tax]                     [DECIMAL](18, 2),
                [Unit_TaxAmount]               [DECIMAL](18, 2),
                [Unit_IsParking]               [BIT],
                [Unit_AreaTotalAmount]         [DECIMAL](18, 2),
                [Unit_AreaSqm]                 [DECIMAL](18, 2),
                [Unit_AreaRateSqm]             [DECIMAL](18, 2),
                [IsRenewal]                    [BIT],
                [CompanyORNo]                  [VARCHAR](200),
                [REF]                          [VARCHAR](200),
                [BNK_ACCT_NAME]                [VARCHAR](200),
                [BNK_ACCT_NUMBER]              [VARCHAR](200),
                [BNK_NAME]                     [VARCHAR](200),
                [SERIAL_NO]                    [VARCHAR](200),
                [ModeType]                     [VARCHAR](20),
                [CompanyPRNo]                  [VARCHAR](50),
                [BankBranch]                   [VARCHAR](250),
                [CheckDate]                    [DATETIME],
                [ReceiptDate]                  [DATETIME],
                [PaymentRemarks]               [NVARCHAR](4000)
            )

        CREATE TABLE [#tempAdvancePayment]
            (
                [Id]                           [BIGINT] IDENTITY(1, 1),
                [Recid]                        [BIGINT],
                [ReferenceID]                  [BIGINT],
                [ClientID]                     [VARCHAR](500),
                [LedgMonth]                    [DATE],
                [LedgAmount]                   [DECIMAL](18, 2),
                [IsPaid]                       [BIT],
                [EncodedBy]                    [INT],
                [EncodedDate]                  [DATETIME],
                [ComputerName]                 [VARCHAR](30),
                [TransactionID]                [VARCHAR](500),
                [IsHold]                       [BIT],
                [BalanceAmount]                [DECIMAL](18, 2),
                [PenaltyAmount]                [DECIMAL](18, 2),
                [ActualAmount]                 [DECIMAL](18, 2),
                [LedgRentalAmount]             [DECIMAL](18, 2),
                [Remarks]                      [VARCHAR](500),
                [Unit_ProjectType]             [VARCHAR](150),
                [Unit_IsNonVat]                [BIT],
                [Unit_BaseRentalVatAmount]     [DECIMAL](18, 2),
                [Unit_BaseRentalWithVatAmount] [DECIMAL](18, 2),
                [Unit_BaseRentalTax]           [DECIMAL](18, 2),
                [Unit_TotalRental]             [DECIMAL](18, 2),
                [Unit_SecAndMainAmount]        [DECIMAL](18, 2),
                [Unit_SecAndMainVatAmount]     [DECIMAL](18, 2),
                [Unit_SecAndMainWithVatAmount] [DECIMAL](18, 2),
                [Unit_Vat]                     [DECIMAL](18, 2),
                [Unit_Tax]                     [DECIMAL](18, 2),
                [Unit_TaxAmount]               [DECIMAL](18, 2),
                [Unit_IsParking]               [BIT],
                [Unit_AreaTotalAmount]         [DECIMAL](18, 2),
                [Unit_AreaSqm]                 [DECIMAL](18, 2),
                [Unit_AreaRateSqm]             [DECIMAL](18, 2),
                [IsRenewal]                    [BIT],
                [CompanyORNo]                  [VARCHAR](200),
                [REF]                          [VARCHAR](200),
                [BNK_ACCT_NAME]                [VARCHAR](200),
                [BNK_ACCT_NUMBER]              [VARCHAR](200),
                [BNK_NAME]                     [VARCHAR](200),
                [SERIAL_NO]                    [VARCHAR](200),
                [ModeType]                     [VARCHAR](20),
                [CompanyPRNo]                  [VARCHAR](50),
                [BankBranch]                   [VARCHAR](250),
                [CheckDate]                    [DATETIME],
                [ReceiptDate]                  [DATETIME],
                [PaymentRemarks]               [NVARCHAR](4000)
            )
        CREATE TABLE [#tempMonthLedger]
            (
                [Id]                           [BIGINT] IDENTITY(1, 1),
                [Recid]                        [BIGINT],
                [ReferenceID]                  [BIGINT],
                [ClientID]                     [VARCHAR](500),
                [LedgMonth]                    [DATE],
                [LedgAmount]                   [DECIMAL](18, 2),
                [IsPaid]                       [BIT],
                [EncodedBy]                    [INT],
                [EncodedDate]                  [DATETIME],
                [ComputerName]                 [VARCHAR](30),
                [TransactionID]                [VARCHAR](500),
                [IsHold]                       [BIT],
                [BalanceAmount]                [DECIMAL](18, 2),
                [PenaltyAmount]                [DECIMAL](18, 2),
                [ActualAmount]                 [DECIMAL](18, 2),
                [LedgRentalAmount]             [DECIMAL](18, 2),
                [Remarks]                      [VARCHAR](500),
                [Unit_ProjectType]             [VARCHAR](150),
                [Unit_IsNonVat]                [BIT],
                [Unit_BaseRentalVatAmount]     [DECIMAL](18, 2),
                [Unit_BaseRentalWithVatAmount] [DECIMAL](18, 2),
                [Unit_BaseRentalTax]           [DECIMAL](18, 2),
                [Unit_TotalRental]             [DECIMAL](18, 2),
                [Unit_SecAndMainAmount]        [DECIMAL](18, 2),
                [Unit_SecAndMainVatAmount]     [DECIMAL](18, 2),
                [Unit_SecAndMainWithVatAmount] [DECIMAL](18, 2),
                [Unit_Vat]                     [DECIMAL](18, 2),
                [Unit_Tax]                     [DECIMAL](18, 2),
                [Unit_TaxAmount]               [DECIMAL](18, 2),
                [Unit_IsParking]               [BIT],
                [Unit_AreaTotalAmount]         [DECIMAL](18, 2),
                [Unit_AreaSqm]                 [DECIMAL](18, 2),
                [Unit_AreaRateSqm]             [DECIMAL](18, 2),
                [IsRenewal]                    [BIT],
                [CompanyORNo]                  [VARCHAR](200),
                [REF]                          [VARCHAR](200),
                [BNK_ACCT_NAME]                [VARCHAR](200),
                [BNK_ACCT_NUMBER]              [VARCHAR](200),
                [BNK_NAME]                     [VARCHAR](200),
                [SERIAL_NO]                    [VARCHAR](200),
                [ModeType]                     [VARCHAR](20),
                [CompanyPRNo]                  [VARCHAR](50),
                [BankBranch]                   [VARCHAR](250),
                [CheckDate]                    [DATETIME],
                [ReceiptDate]                  [DATETIME],
                [PaymentRemarks]               [NVARCHAR](4000)
            )

        CREATE TABLE [#tblBulkPostdatedMonth]
            (
                [Recid] VARCHAR(10)
            )
        IF (@XML IS NOT NULL)
            BEGIN
                INSERT INTO [#tblBulkPostdatedMonth]
                    (
                        [Recid]
                    )
                            SELECT
                                [ParaValues].[data].[value]('c1[1]', 'VARCHAR(10)')
                            FROM
                                @XML.[nodes]('/Table1') AS [ParaValues]([data])
            END


        SELECT TOP 1
               @ReferenceID = [tblMonthLedger].[ReferenceID]
        FROM
               [dbo].[tblMonthLedger]
        WHERE
               [tblMonthLedger].[Recid] =
            (
                SELECT TOP 1
                       [#tblBulkPostdatedMonth].[Recid]
                FROM
                       [#tblBulkPostdatedMonth]
            )

        CREATE TABLE #tempAdvancePaymentFiltered
            (
                id      [BIGINT] IDENTITY(1, 1),
                [Recid] [BIGINT]
            )

        INSERT INTO [#tempAdvancePaymentFiltered]
            (
                [Recid]
            )
                    SELECT
                            [tblMonthLedger].[Recid]
                    FROM
                            [dbo].[tblMonthLedger]
                        INNER JOIN
                            [dbo].[tblAdvancePayment]
                                ON [tblAdvancePayment].[RefId] = CONCAT(
                                                                           'REF',
                                                                           CAST([tblMonthLedger].[ReferenceID] AS VARCHAR(150))
                                                                       )
                                   AND [tblAdvancePayment].[Months] = [tblMonthLedger].[LedgMonth]
                    WHERE
                            [tblMonthLedger].[ReferenceID] = @ReferenceID
        INSERT INTO [#tempMonthLedger]
            (
                [Recid],
                [ReferenceID],
                [ClientID],
                [LedgMonth],
                [LedgAmount],
                [IsPaid],
                [EncodedBy],
                [EncodedDate],
                [ComputerName],
                [TransactionID],
                [IsHold],
                [BalanceAmount],
                [PenaltyAmount],
                [ActualAmount],
                [LedgRentalAmount],
                [Remarks],
                [Unit_ProjectType],
                [Unit_IsNonVat],
                [Unit_BaseRentalVatAmount],
                [Unit_BaseRentalWithVatAmount],
                [Unit_BaseRentalTax],
                [Unit_TotalRental],
                [Unit_SecAndMainAmount],
                [Unit_SecAndMainVatAmount],
                [Unit_SecAndMainWithVatAmount],
                [Unit_Vat],
                [Unit_Tax],
                [Unit_TaxAmount],
                [Unit_IsParking],
                [Unit_AreaTotalAmount],
                [Unit_AreaSqm],
                [Unit_AreaRateSqm],
                [IsRenewal],
                [CompanyORNo],
                [REF],
                [BNK_ACCT_NAME],
                [BNK_ACCT_NUMBER],
                [BNK_NAME],
                [SERIAL_NO],
                [ModeType],
                [CompanyPRNo],
                [BankBranch],
                [CheckDate],
                [ReceiptDate],
                [PaymentRemarks]
            )
                    SELECT
                        [tblMonthLedger].[Recid],
                        [tblMonthLedger].[ReferenceID],
                        [tblMonthLedger].[ClientID],
                        [tblMonthLedger].[LedgMonth],
                        [tblMonthLedger].[LedgAmount],
                        [tblMonthLedger].[IsPaid],
                        [tblMonthLedger].[EncodedBy],
                        [tblMonthLedger].[EncodedDate],
                        [tblMonthLedger].[ComputerName],
                        [tblMonthLedger].[TransactionID],
                        [tblMonthLedger].[IsHold],
                        [tblMonthLedger].[BalanceAmount],
                        [tblMonthLedger].[PenaltyAmount],
                        [tblMonthLedger].[ActualAmount],
                        [tblMonthLedger].[LedgRentalAmount],
                        [tblMonthLedger].[Remarks],
                        [tblMonthLedger].[Unit_ProjectType],
                        [tblMonthLedger].[Unit_IsNonVat],
                        [tblMonthLedger].[Unit_BaseRentalVatAmount],
                        [tblMonthLedger].[Unit_BaseRentalWithVatAmount],
                        [tblMonthLedger].[Unit_BaseRentalTax],
                        [tblMonthLedger].[Unit_TotalRental],
                        [tblMonthLedger].[Unit_SecAndMainAmount],
                        [tblMonthLedger].[Unit_SecAndMainVatAmount],
                        [tblMonthLedger].[Unit_SecAndMainWithVatAmount],
                        [tblMonthLedger].[Unit_Vat],
                        [tblMonthLedger].[Unit_Tax],
                        [tblMonthLedger].[Unit_TaxAmount],
                        [tblMonthLedger].[Unit_IsParking],
                        [tblMonthLedger].[Unit_AreaTotalAmount],
                        [tblMonthLedger].[Unit_AreaSqm],
                        [tblMonthLedger].[Unit_AreaRateSqm],
                        [tblMonthLedger].[IsRenewal],
                        [tblMonthLedger].[CompanyORNo],
                        [tblMonthLedger].[REF],
                        [tblMonthLedger].[BNK_ACCT_NAME],
                        [tblMonthLedger].[BNK_ACCT_NUMBER],
                        [tblMonthLedger].[BNK_NAME],
                        [tblMonthLedger].[SERIAL_NO],
                        [tblMonthLedger].[ModeType],
                        [tblMonthLedger].[CompanyPRNo],
                        [tblMonthLedger].[BankBranch],
                        [tblMonthLedger].[CheckDate],
                        [tblMonthLedger].[ReceiptDate],
                        [tblMonthLedger].[PaymentRemarks]
                    FROM
                        [dbo].[tblMonthLedger]
                    WHERE
                        [tblMonthLedger].[ReferenceID] = @ReferenceID

        INSERT INTO [#tempAdvancePayment]
            (
                [Recid],
                [ReferenceID],
                [ClientID],
                [LedgMonth],
                [LedgAmount],
                [IsPaid],
                [EncodedBy],
                [EncodedDate],
                [ComputerName],
                [TransactionID],
                [IsHold],
                [BalanceAmount],
                [PenaltyAmount],
                [ActualAmount],
                [LedgRentalAmount],
                [Remarks],
                [Unit_ProjectType],
                [Unit_IsNonVat],
                [Unit_BaseRentalVatAmount],
                [Unit_BaseRentalWithVatAmount],
                [Unit_BaseRentalTax],
                [Unit_TotalRental],
                [Unit_SecAndMainAmount],
                [Unit_SecAndMainVatAmount],
                [Unit_SecAndMainWithVatAmount],
                [Unit_Vat],
                [Unit_Tax],
                [Unit_TaxAmount],
                [Unit_IsParking],
                [Unit_AreaTotalAmount],
                [Unit_AreaSqm],
                [Unit_AreaRateSqm],
                [IsRenewal],
                [CompanyORNo],
                [REF],
                [BNK_ACCT_NAME],
                [BNK_ACCT_NUMBER],
                [BNK_NAME],
                [SERIAL_NO],
                [ModeType],
                [CompanyPRNo],
                [BankBranch],
                [CheckDate],
                [ReceiptDate],
                [PaymentRemarks]
            )
                    SELECT
                        [tblMonthLedger].[Recid],
                        [tblMonthLedger].[ReferenceID],
                        [tblMonthLedger].[ClientID],
                        [tblMonthLedger].[LedgMonth],
                        [tblMonthLedger].[LedgAmount],
                        [tblMonthLedger].[IsPaid],
                        [tblMonthLedger].[EncodedBy],
                        [tblMonthLedger].[EncodedDate],
                        [tblMonthLedger].[ComputerName],
                        [tblMonthLedger].[TransactionID],
                        [tblMonthLedger].[IsHold],
                        [tblMonthLedger].[BalanceAmount],
                        [tblMonthLedger].[PenaltyAmount],
                        [tblMonthLedger].[ActualAmount],
                        [tblMonthLedger].[LedgRentalAmount],
                        [tblMonthLedger].[Remarks],
                        [tblMonthLedger].[Unit_ProjectType],
                        [tblMonthLedger].[Unit_IsNonVat],
                        [tblMonthLedger].[Unit_BaseRentalVatAmount],
                        [tblMonthLedger].[Unit_BaseRentalWithVatAmount],
                        [tblMonthLedger].[Unit_BaseRentalTax],
                        [tblMonthLedger].[Unit_TotalRental],
                        [tblMonthLedger].[Unit_SecAndMainAmount],
                        [tblMonthLedger].[Unit_SecAndMainVatAmount],
                        [tblMonthLedger].[Unit_SecAndMainWithVatAmount],
                        [tblMonthLedger].[Unit_Vat],
                        [tblMonthLedger].[Unit_Tax],
                        [tblMonthLedger].[Unit_TaxAmount],
                        [tblMonthLedger].[Unit_IsParking],
                        [tblMonthLedger].[Unit_AreaTotalAmount],
                        [tblMonthLedger].[Unit_AreaSqm],
                        [tblMonthLedger].[Unit_AreaRateSqm],
                        [tblMonthLedger].[IsRenewal],
                        [tblMonthLedger].[CompanyORNo],
                        [tblMonthLedger].[REF],
                        [tblMonthLedger].[BNK_ACCT_NAME],
                        [tblMonthLedger].[BNK_ACCT_NUMBER],
                        [tblMonthLedger].[BNK_NAME],
                        [tblMonthLedger].[SERIAL_NO],
                        [tblMonthLedger].[ModeType],
                        [tblMonthLedger].[CompanyPRNo],
                        [tblMonthLedger].[BankBranch],
                        [tblMonthLedger].[CheckDate],
                        [tblMonthLedger].[ReceiptDate],
                        [tblMonthLedger].[PaymentRemarks]
                    FROM
                        [dbo].[tblMonthLedger]
                    WHERE
                        [tblMonthLedger].[ReferenceID] = @ReferenceID

        DELETE FROM
        [#tempAdvancePayment]
        WHERE
            [#tempAdvancePayment].[Recid] NOT IN
                (
                    SELECT
                        [#tempAdvancePaymentFiltered].[Recid]
                    FROM
                        #tempAdvancePaymentFiltered
                )

        INSERT INTO [#tempMonthDecalrationFinal]
            (
                [Recid],
                [ReferenceID],
                [ClientID],
                [LedgMonth],
                [LedgAmount],
                [IsPaid],
                [EncodedBy],
                [EncodedDate],
                [ComputerName],
                [TransactionID],
                [IsHold],
                [BalanceAmount],
                [PenaltyAmount],
                [ActualAmount],
                [LedgRentalAmount],
                [Remarks],
                [Unit_ProjectType],
                [Unit_IsNonVat],
                [Unit_BaseRentalVatAmount],
                [Unit_BaseRentalWithVatAmount],
                [Unit_BaseRentalTax],
                [Unit_TotalRental],
                [Unit_SecAndMainAmount],
                [Unit_SecAndMainVatAmount],
                [Unit_SecAndMainWithVatAmount],
                [Unit_Vat],
                [Unit_Tax],
                [Unit_TaxAmount],
                [Unit_IsParking],
                [Unit_AreaTotalAmount],
                [Unit_AreaSqm],
                [Unit_AreaRateSqm],
                [IsRenewal],
                [CompanyORNo],
                [REF],
                [BNK_ACCT_NAME],
                [BNK_ACCT_NUMBER],
                [BNK_NAME],
                [SERIAL_NO],
                [ModeType],
                [CompanyPRNo],
                [BankBranch],
                [CheckDate],
                [ReceiptDate],
                [PaymentRemarks]
            )
                    SELECT
                        [#tempMonthLedger].[Recid],
                        [#tempMonthLedger].[ReferenceID],
                        [#tempMonthLedger].[ClientID],
                        [#tempMonthLedger].[LedgMonth],
                        [#tempMonthLedger].[LedgAmount],
                        [#tempMonthLedger].[IsPaid],
                        [#tempMonthLedger].[EncodedBy],
                        [#tempMonthLedger].[EncodedDate],
                        [#tempMonthLedger].[ComputerName],
                        [#tempMonthLedger].[TransactionID],
                        [#tempMonthLedger].[IsHold],
                        [#tempMonthLedger].[BalanceAmount],
                        [#tempMonthLedger].[PenaltyAmount],
                        [#tempMonthLedger].[ActualAmount],
                        [#tempMonthLedger].[LedgRentalAmount],
                        [#tempMonthLedger].[Remarks],
                        [#tempMonthLedger].[Unit_ProjectType],
                        [#tempMonthLedger].[Unit_IsNonVat],
                        [#tempMonthLedger].[Unit_BaseRentalVatAmount],
                        [#tempMonthLedger].[Unit_BaseRentalWithVatAmount],
                        [#tempMonthLedger].[Unit_BaseRentalTax],
                        [#tempMonthLedger].[Unit_TotalRental],
                        [#tempMonthLedger].[Unit_SecAndMainAmount],
                        [#tempMonthLedger].[Unit_SecAndMainVatAmount],
                        [#tempMonthLedger].[Unit_SecAndMainWithVatAmount],
                        [#tempMonthLedger].[Unit_Vat],
                        [#tempMonthLedger].[Unit_Tax],
                        [#tempMonthLedger].[Unit_TaxAmount],
                        [#tempMonthLedger].[Unit_IsParking],
                        [#tempMonthLedger].[Unit_AreaTotalAmount],
                        [#tempMonthLedger].[Unit_AreaSqm],
                        [#tempMonthLedger].[Unit_AreaRateSqm],
                        [#tempMonthLedger].[IsRenewal],
                        [#tempMonthLedger].[CompanyORNo],
                        [#tempMonthLedger].[REF],
                        [#tempMonthLedger].[BNK_ACCT_NAME],
                        [#tempMonthLedger].[BNK_ACCT_NUMBER],
                        [#tempMonthLedger].[BNK_NAME],
                        [#tempMonthLedger].[SERIAL_NO],
                        [#tempMonthLedger].[ModeType],
                        [#tempMonthLedger].[CompanyPRNo],
                        [#tempMonthLedger].[BankBranch],
                        [#tempMonthLedger].[CheckDate],
                        [#tempMonthLedger].[ReceiptDate],
                        [#tempMonthLedger].[PaymentRemarks]
                    FROM
                        [#tempMonthLedger]
                    WHERE
                        [#tempMonthLedger].[Recid] IN
                            (
                                SELECT
                                    [#tblBulkPostdatedMonth].[Recid]
                                FROM
                                    [#tblBulkPostdatedMonth]
                                WHERE
                                    [#tblBulkPostdatedMonth].[Recid] NOT IN
                                        (
                                            SELECT
                                                [#tempAdvancePaymentFiltered].[Recid]
                                            FROM
                                                #tempAdvancePaymentFiltered
                                        )
                            )
                    UNION
                    SELECT
                            [#tempAdvancePayment].[Recid],
                            [#tempAdvancePayment].[ReferenceID],
                            [#tempAdvancePayment].[ClientID],
                            [#tempAdvancePayment].[LedgMonth],
                            [#tempAdvancePayment].[LedgAmount],
                            [#tempAdvancePayment].[IsPaid],
                            [#tempAdvancePayment].[EncodedBy],
                            [#tempAdvancePayment].[EncodedDate],
                            [#tempAdvancePayment].[ComputerName],
                            [#tempAdvancePayment].[TransactionID],
                            [#tempAdvancePayment].[IsHold],
                            [#tempAdvancePayment].[BalanceAmount],
                            [#tempAdvancePayment].[PenaltyAmount],
                            [#tempAdvancePayment].[ActualAmount],
                            ISNULL([tblAdvancePayment].[Amount], 0) AS [LedgRentalAmount],
                            [#tempAdvancePayment].[Remarks],
                            [#tempAdvancePayment].[Unit_ProjectType],
                            [#tempAdvancePayment].[Unit_IsNonVat],
                            [#tempAdvancePayment].[Unit_BaseRentalVatAmount],
                            [#tempAdvancePayment].[Unit_BaseRentalWithVatAmount],
                            [#tempAdvancePayment].[Unit_BaseRentalTax],
                            [#tempAdvancePayment].[Unit_TotalRental],
                            [#tempAdvancePayment].[Unit_SecAndMainAmount],
                            [#tempAdvancePayment].[Unit_SecAndMainVatAmount],
                            [#tempAdvancePayment].[Unit_SecAndMainWithVatAmount],
                            [#tempAdvancePayment].[Unit_Vat],
                            [#tempAdvancePayment].[Unit_Tax],
                            [#tempAdvancePayment].[Unit_TaxAmount],
                            [#tempAdvancePayment].[Unit_IsParking],
                            [#tempAdvancePayment].[Unit_AreaTotalAmount],
                            [#tempAdvancePayment].[Unit_AreaSqm],
                            [#tempAdvancePayment].[Unit_AreaRateSqm],
                            [#tempAdvancePayment].[IsRenewal],
                            [#tempAdvancePayment].[CompanyORNo],
                            [#tempAdvancePayment].[REF],
                            [#tempAdvancePayment].[BNK_ACCT_NAME],
                            [#tempAdvancePayment].[BNK_ACCT_NUMBER],
                            [#tempAdvancePayment].[BNK_NAME],
                            [#tempAdvancePayment].[SERIAL_NO],
                            [#tempAdvancePayment].[ModeType],
                            [#tempAdvancePayment].[CompanyPRNo],
                            [#tempAdvancePayment].[BankBranch],
                            [#tempAdvancePayment].[CheckDate],
                            [#tempAdvancePayment].[ReceiptDate],
                            [#tempAdvancePayment].[PaymentRemarks]
                    FROM
                            [#tempAdvancePayment]
                        INNER JOIN
                            [dbo].[tblAdvancePayment]
                                ON CONCAT('REF', CAST([#tempAdvancePayment].[ReferenceID] AS VARCHAR(150))) = [tblAdvancePayment].[RefId]
                                   AND [#tempAdvancePayment].[LedgMonth] = [tblAdvancePayment].[Months]
        SELECT
            ROW_NUMBER() OVER (ORDER BY
                                   [#tempMonthDecalrationFinal].[LedgMonth] ASC
                              )                                                                                [seq],
            [#tempMonthDecalrationFinal].[Recid],
            [#tempMonthDecalrationFinal].[ReferenceID],
            [#tempMonthDecalrationFinal].[ClientID],
            FORMAT(ISNULL([#tempMonthDecalrationFinal].[LedgRentalAmount], 0), 'N2')                           AS [LedgAmount],
            FORMAT(ISNULL([#tempMonthDecalrationFinal].[PenaltyAmount], 0), 'N2')                              AS [PenaltyAmount],
            ISNULL([#tempMonthDecalrationFinal].[TransactionID], '')                                           AS [TransactionID],
            CONVERT(VARCHAR(20), [#tempMonthDecalrationFinal].[LedgMonth], 107)                                AS [LedgMonth],
            ''                                                                                                 AS [Remarks],
            CASE
                WHEN ISNULL([#tempMonthDecalrationFinal].[IsPaid], 0) = 1
                     AND ISNULL([#tempMonthDecalrationFinal].[IsHold], 0) = 0
                    THEN
                    'PAID'
                WHEN ISNULL([#tempMonthDecalrationFinal].[IsPaid], 0) = 0
                     AND ISNULL([#tempMonthDecalrationFinal].[IsHold], 0) = 1
                    THEN
                    'HOLD'
                WHEN [#tempMonthDecalrationFinal].[LedgMonth] IN
                         (
                             SELECT
                                 [tblAdvancePayment].[Months]
                             FROM
                                 [dbo].[tblAdvancePayment]
                             WHERE
                                 [tblAdvancePayment].[RefId] = 'REF'
                                                               + CAST([#tempMonthDecalrationFinal].[ReferenceID] AS VARCHAR(150))
                         )
                     AND ISNULL([#tempMonthDecalrationFinal].[IsPaid], 0) = 0
                     AND ISNULL([#tempMonthDecalrationFinal].[IsHold], 0) = 0
                    THEN
                    'FOR PAYMENT'
                WHEN CONVERT(VARCHAR(20), [#tempMonthDecalrationFinal].[LedgMonth], 107) = CONVERT(
                                                                                                      VARCHAR(20),
                                                                                                      GETDATE(), 107
                                                                                                  )
                     AND ISNULL([#tempMonthDecalrationFinal].[IsPaid], 0) = 0
                     AND ISNULL([#tempMonthDecalrationFinal].[IsHold], 0) = 0
                    THEN
                    'FOR PAYMENT'
                ELSE
                    'PENDING'
            END                                                                                                AS [PaymentStatus],
            IIF(
                ISNULL([#tempMonthDecalrationFinal].[IsPaid], 0) = 1
                OR
                    (
                        ISNULL([#tempMonthDecalrationFinal].[IsHold], 0) = 1
                        AND [#tempMonthDecalrationFinal].[BalanceAmount] > 0
                    ),
                ([#tempMonthDecalrationFinal].[LedgRentalAmount]
                 - ISNULL([#tempMonthDecalrationFinal].[BalanceAmount], 0)
                ),
                0)                                                                                             AS [AmountPaid],
            FORMAT(CAST(ABS(ISNULL([#tempMonthDecalrationFinal].[BalanceAmount], 0)) AS DECIMAL(18, 2)), 'N2') AS [BalanceAmount],
            --ISNULL([tblMonthLedger].[PaymentMode], '') AS [PaymentMode],
            --ISNULL([tblMonthLedger].[RcptID], '') AS [RcptID],
            ISNULL([#tempMonthDecalrationFinal].[CompanyORNo], '')                                             AS [CompanyORNo],
            ISNULL([#tempMonthDecalrationFinal].[CompanyPRNo], '')                                             AS [CompanyPRNo],
            ISNULL([#tempMonthDecalrationFinal].[REF], '')                                                     AS [REF],
            ISNULL([#tempMonthDecalrationFinal].[BNK_ACCT_NAME], '')                                           AS [BNK_ACCT_NAME],
            ISNULL([#tempMonthDecalrationFinal].[BNK_ACCT_NUMBER], '')                                         AS [BNK_ACCT_NUMBER],
            ISNULL([#tempMonthDecalrationFinal].[BNK_NAME], '')                                                AS [BNK_NAME],
            ISNULL([#tempMonthDecalrationFinal].[SERIAL_NO], '')                                               AS [SERIAL_NO],
            ISNULL([#tempMonthDecalrationFinal].[ModeType], '')                                                AS [ModeType],
            ISNULL([#tempMonthDecalrationFinal].[BankBranch], '')                                              AS [BankBranch]
        FROM
            [dbo].[#tempMonthDecalrationFinal]
        --WHERE
        --    [tblMonthLedger].[Recid] IN
        --        (
        --            SELECT
        --                [#tblBulkPostdatedMonth].[Recid]
        --            FROM
        --                [#tblBulkPostdatedMonth]
        --        )
        ORDER BY
            [seq] ASC

        DROP TABLE IF EXISTS [#tempAdvancePaymentFiltered]
        DROP TABLE IF EXISTS [#tblBulkPostdatedMonth]
        DROP TABLE IF EXISTS [#tempMonthDecalrationFinal]
        DROP TABLE IF EXISTS [#tempAdvancePayment]
        DROP TABLE IF EXISTS [#tempMonthLedger]
    END;
GO

