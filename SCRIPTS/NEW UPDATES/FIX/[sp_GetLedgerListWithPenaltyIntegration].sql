USE [LEASINGDB]
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC [sp_GetLedgerListWithPenaltyIntegration] @ReferenceID =10000000, @ClientID='INDV10000000'
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_GetLedgerListWithPenaltyIntegration]
    @ReferenceID    BIGINT       = NULL,
    @ClientID       VARCHAR(150) = NULL,
    @IsApplyPenalty BIT          = NULL
AS
    BEGIN
        SET NOCOUNT ON;
        DECLARE @TotalRent DECIMAL(18, 2) = NULL
        DECLARE @PenaltyPct DECIMAL(18, 2) = NULL
        DECLARE @RefId VARCHAR(150) = ''


        CREATE TABLE [#tempAdvancePaymentFiltered]
            (
                [id]    [BIGINT] IDENTITY(1, 1),
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
        CREATE TABLE [#tempAdvancePaymentZeroAmount]
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
        CREATE TABLE [#tempAdvancePaymentExactAmount]
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


        SELECT
            @RefId =
            (
                SELECT
                    [tblUnitReference].[RefId]
                FROM
                    [dbo].[tblUnitReference]
                WHERE
                    [tblUnitReference].[RecId] = @ReferenceID
            )
        SELECT
            @TotalRent  = [tblUnitReference].[TotalRent],
            @PenaltyPct = [tblUnitReference].[PenaltyPct]
        FROM
            [dbo].[tblUnitReference] WITH (NOLOCK)
        WHERE
            [tblUnitReference].[RecId] = @ReferenceID

        --IF
        --    (
        --        SELECT
        --            ISNULL([tblUnitReference].[IsContractApplyMonthlyPenalty], 0)
        --        FROM
        --            [dbo].[tblUnitReference]
        --        WHERE
        --            [tblUnitReference].[RecId] = @ReferenceID
        --    ) = 1
        --    BEGIN
        --        --IF ISNULL(@IsApplyPenalty, 0) = 1
        --        --    BEGIN
        --                --/*Check if the penalty stop when it reach the specific date to penalty*/
        --                EXEC [dbo].[sp_ApplyMonthLyPenalty]
        --                    @ReferenceID = @ReferenceID -- bigint
        --            --END
        --    END




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
                        AND [tblMonthLedger].[ClientID] = @ClientID
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
                        AND [tblMonthLedger].[ClientID] = @ClientID
        DELETE FROM
        [#tempAdvancePayment]
        WHERE
            [#tempAdvancePayment].[Recid] NOT IN
                (
                    SELECT
                        [#tempAdvancePaymentFiltered].[Recid]
                    FROM
                        [#tempAdvancePaymentFiltered]
                )



        INSERT INTO [#tempAdvancePaymentZeroAmount]
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
                    SELECT  DISTINCT
                            0,               --[#tempAdvancePayment].[Recid],
                            [#tempAdvancePayment].[ReferenceID],
                            [#tempAdvancePayment].[ClientID],
                            [#tempAdvancePayment].[LedgMonth],
                            [#tempAdvancePayment].[LedgAmount],
                            0,               --[#tempAdvancePayment].[IsPaid],
                            1,               --[#tempAdvancePayment].[EncodedBy],
                            NULL,
                            NULL,            --[#tempAdvancePayment].[ComputerName],
                            NULL,            --[#tempAdvancePayment].[TransactionID],
                            NULL,            --[#tempAdvancePayment].[IsHold],
                            NULL,            --[#tempAdvancePayment].[BalanceAmount],
                            NULL,            --[#tempAdvancePayment].[PenaltyAmount],
                            NULL,            --[#tempAdvancePayment].[ActualAmount],
                            [tblAdvancePayment].[Amount] AS [LedgRentalAmount],
                            'MONTH ADVANCE', --'RENTAL WITH SECURITY AND MAINTENANCE NET OF VAT' AS [Remarks],
                            NULL,            --[#tempAdvancePayment].[Unit_ProjectType],
                            NULL,            --[#tempAdvancePayment].[Unit_IsNonVat],
                            NULL,            --[#tempAdvancePayment].[Unit_BaseRentalVatAmount],
                            NULL,            --[#tempAdvancePayment].[Unit_BaseRentalWithVatAmount],
                            NULL,            --[#tempAdvancePayment].[Unit_BaseRentalTax],
                            NULL,            --[#tempAdvancePayment].[Unit_TotalRental],
                            NULL,            --[#tempAdvancePayment].[Unit_SecAndMainAmount],
                            NULL,            --[#tempAdvancePayment].[Unit_SecAndMainVatAmount],
                            NULL,            --[#tempAdvancePayment].[Unit_SecAndMainWithVatAmount],
                            NULL,            --[#tempAdvancePayment].[Unit_Vat],
                            NULL,            --[#tempAdvancePayment].[Unit_Tax],
                            NULL,            --[#tempAdvancePayment].[Unit_TaxAmount],
                            NULL,            --[#tempAdvancePayment].[Unit_IsParking],
                            NULL,            --[#tempAdvancePayment].[Unit_AreaTotalAmount],
                            NULL,            --[#tempAdvancePayment].[Unit_AreaSqm],
                            NULL,            --[#tempAdvancePayment].[Unit_AreaRateSqm],
                            NULL,            --[#tempAdvancePayment].[IsRenewal],
                            NULL,            --[#tempAdvancePayment].[CompanyORNo],
                            NULL,            --[#tempAdvancePayment].[REF],
                            NULL,            --[#tempAdvancePayment].[BNK_ACCT_NAME],
                            NULL,            --[#tempAdvancePayment].[BNK_ACCT_NUMBER],
                            NULL,            --[#tempAdvancePayment].[BNK_NAME],
                            NULL,            --[#tempAdvancePayment].[SERIAL_NO],
                            NULL,            --[#tempAdvancePayment].[ModeType],
                            NULL,            --[#tempAdvancePayment].[CompanyPRNo],
                            NULL,            --[#tempAdvancePayment].[BankBranch],
                            NULL,            --[#tempAdvancePayment].[CheckDate],
                            NULL,            --[#tempAdvancePayment].[ReceiptDate],
                            NULL             --[#tempAdvancePayment].[PaymentRemarks]
                    FROM
                            [#tempAdvancePayment]
                        INNER JOIN
                            [dbo].[tblAdvancePayment]
                                ON CONCAT('REF', CAST([#tempAdvancePayment].[ReferenceID] AS VARCHAR(150))) = [tblAdvancePayment].[RefId]
                                   AND [#tempAdvancePayment].[LedgMonth] = [tblAdvancePayment].[Months]
                    WHERE
                            ISNULL([tblAdvancePayment].[Amount], 0) = 0

        INSERT INTO [#tempAdvancePaymentExactAmount]
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
                            [#tempAdvancePayment].[LedgRentalAmount],
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
                    WHERE
                            ISNULL([tblAdvancePayment].[Amount], 0) > 0

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
                        [#tempMonthLedger].[Recid] NOT IN
                            (
                                SELECT
                                    [#tempAdvancePaymentFiltered].[Recid]
                                FROM
                                    [#tempAdvancePaymentFiltered]
                            )
                    UNION
                    SELECT
                        [#tempAdvancePaymentExactAmount].[Recid],
                        [#tempAdvancePaymentExactAmount].[ReferenceID],
                        [#tempAdvancePaymentExactAmount].[ClientID],
                        [#tempAdvancePaymentExactAmount].[LedgMonth],
                        [#tempAdvancePaymentExactAmount].[LedgAmount],
                        [#tempAdvancePaymentExactAmount].[IsPaid],
                        [#tempAdvancePaymentExactAmount].[EncodedBy],
                        [#tempAdvancePaymentExactAmount].[EncodedDate],
                        [#tempAdvancePaymentExactAmount].[ComputerName],
                        [#tempAdvancePaymentExactAmount].[TransactionID],
                        [#tempAdvancePaymentExactAmount].[IsHold],
                        [#tempAdvancePaymentExactAmount].[BalanceAmount],
                        [#tempAdvancePaymentExactAmount].[PenaltyAmount],
                        [#tempAdvancePaymentExactAmount].[ActualAmount],
                        [#tempAdvancePaymentExactAmount].[LedgRentalAmount],
                        [#tempAdvancePaymentExactAmount].[Remarks],
                        [#tempAdvancePaymentExactAmount].[Unit_ProjectType],
                        [#tempAdvancePaymentExactAmount].[Unit_IsNonVat],
                        [#tempAdvancePaymentExactAmount].[Unit_BaseRentalVatAmount],
                        [#tempAdvancePaymentExactAmount].[Unit_BaseRentalWithVatAmount],
                        [#tempAdvancePaymentExactAmount].[Unit_BaseRentalTax],
                        [#tempAdvancePaymentExactAmount].[Unit_TotalRental],
                        [#tempAdvancePaymentExactAmount].[Unit_SecAndMainAmount],
                        [#tempAdvancePaymentExactAmount].[Unit_SecAndMainVatAmount],
                        [#tempAdvancePaymentExactAmount].[Unit_SecAndMainWithVatAmount],
                        [#tempAdvancePaymentExactAmount].[Unit_Vat],
                        [#tempAdvancePaymentExactAmount].[Unit_Tax],
                        [#tempAdvancePaymentExactAmount].[Unit_TaxAmount],
                        [#tempAdvancePaymentExactAmount].[Unit_IsParking],
                        [#tempAdvancePaymentExactAmount].[Unit_AreaTotalAmount],
                        [#tempAdvancePaymentExactAmount].[Unit_AreaSqm],
                        [#tempAdvancePaymentExactAmount].[Unit_AreaRateSqm],
                        [#tempAdvancePaymentExactAmount].[IsRenewal],
                        [#tempAdvancePaymentExactAmount].[CompanyORNo],
                        [#tempAdvancePaymentExactAmount].[REF],
                        [#tempAdvancePaymentExactAmount].[BNK_ACCT_NAME],
                        [#tempAdvancePaymentExactAmount].[BNK_ACCT_NUMBER],
                        [#tempAdvancePaymentExactAmount].[BNK_NAME],
                        [#tempAdvancePaymentExactAmount].[SERIAL_NO],
                        [#tempAdvancePaymentExactAmount].[ModeType],
                        [#tempAdvancePaymentExactAmount].[CompanyPRNo],
                        [#tempAdvancePaymentExactAmount].[BankBranch],
                        [#tempAdvancePaymentExactAmount].[CheckDate],
                        [#tempAdvancePaymentExactAmount].[ReceiptDate],
                        [#tempAdvancePaymentExactAmount].[PaymentRemarks]
                    FROM
                        [#tempAdvancePaymentExactAmount]
                    --INNER JOIN
                    --    [dbo].[tblMonthLedger]
                    --        ON [#tempAdvancePaymentExactAmount].[ReferenceID] = [tblMonthLedger].[ReferenceID]
                    --           AND [#tempAdvancePaymentExactAmount].[LedgMonth] = [tblMonthLedger].[LedgMonth]

                    UNION
                    SELECT
                        [#tempAdvancePaymentZeroAmount].[Recid],
                        [#tempAdvancePaymentZeroAmount].[ReferenceID],
                        [#tempAdvancePaymentZeroAmount].[ClientID],
                        [#tempAdvancePaymentZeroAmount].[LedgMonth],
                        [#tempAdvancePaymentZeroAmount].[LedgAmount],
                        [#tempAdvancePaymentZeroAmount].[IsPaid],
                        [#tempAdvancePaymentZeroAmount].[EncodedBy],
                        [#tempAdvancePaymentZeroAmount].[EncodedDate],
                        [#tempAdvancePaymentZeroAmount].[ComputerName],
                        [#tempAdvancePaymentZeroAmount].[TransactionID],
                        [#tempAdvancePaymentZeroAmount].[IsHold],
                        [#tempAdvancePaymentZeroAmount].[BalanceAmount],
                        [#tempAdvancePaymentZeroAmount].[PenaltyAmount],
                        [#tempAdvancePaymentZeroAmount].[ActualAmount],
                        [#tempAdvancePaymentZeroAmount].[LedgRentalAmount],
                        [#tempAdvancePaymentZeroAmount].[Remarks],
                        [#tempAdvancePaymentZeroAmount].[Unit_ProjectType],
                        [#tempAdvancePaymentZeroAmount].[Unit_IsNonVat],
                        [#tempAdvancePaymentZeroAmount].[Unit_BaseRentalVatAmount],
                        [#tempAdvancePaymentZeroAmount].[Unit_BaseRentalWithVatAmount],
                        [#tempAdvancePaymentZeroAmount].[Unit_BaseRentalTax],
                        [#tempAdvancePaymentZeroAmount].[Unit_TotalRental],
                        [#tempAdvancePaymentZeroAmount].[Unit_SecAndMainAmount],
                        [#tempAdvancePaymentZeroAmount].[Unit_SecAndMainVatAmount],
                        [#tempAdvancePaymentZeroAmount].[Unit_SecAndMainWithVatAmount],
                        [#tempAdvancePaymentZeroAmount].[Unit_Vat],
                        [#tempAdvancePaymentZeroAmount].[Unit_Tax],
                        [#tempAdvancePaymentZeroAmount].[Unit_TaxAmount],
                        [#tempAdvancePaymentZeroAmount].[Unit_IsParking],
                        [#tempAdvancePaymentZeroAmount].[Unit_AreaTotalAmount],
                        [#tempAdvancePaymentZeroAmount].[Unit_AreaSqm],
                        [#tempAdvancePaymentZeroAmount].[Unit_AreaRateSqm],
                        [#tempAdvancePaymentZeroAmount].[IsRenewal],
                        [#tempAdvancePaymentZeroAmount].[CompanyORNo],
                        [#tempAdvancePaymentZeroAmount].[REF],
                        [#tempAdvancePaymentZeroAmount].[BNK_ACCT_NAME],
                        [#tempAdvancePaymentZeroAmount].[BNK_ACCT_NUMBER],
                        [#tempAdvancePaymentZeroAmount].[BNK_NAME],
                        [#tempAdvancePaymentZeroAmount].[SERIAL_NO],
                        [#tempAdvancePaymentZeroAmount].[ModeType],
                        [#tempAdvancePaymentZeroAmount].[CompanyPRNo],
                        [#tempAdvancePaymentZeroAmount].[BankBranch],
                        [#tempAdvancePaymentZeroAmount].[CheckDate],
                        [#tempAdvancePaymentZeroAmount].[ReceiptDate],
                        [#tempAdvancePaymentZeroAmount].[PaymentRemarks]
                    FROM
                        [#tempAdvancePaymentZeroAmount]


        SELECT
            ROW_NUMBER() OVER (ORDER BY
                                   [#tempMonthDecalrationFinal].[LedgMonth] ASC
                              )                                                                                [seq],
            [#tempMonthDecalrationFinal].[Recid],
            [#tempMonthDecalrationFinal].[ReferenceID],
            [#tempMonthDecalrationFinal].[ClientID],
            --[tblMonthLedger].[LedgAmount]  + ISNULL([tblMonthLedger].[PenaltyAmount], 0) AS [LedgAmount],
            FORMAT(ISNULL([#tempMonthDecalrationFinal].[LedgRentalAmount], 0), 'N2')                           AS [LedgAmount],
            FORMAT(ISNULL([#tempMonthDecalrationFinal].[PenaltyAmount], 0), 'N2')                              AS [PenaltyAmount],
            ISNULL([#tempMonthDecalrationFinal].[TransactionID], '')                                           AS [TransactionID],
            CONVERT(VARCHAR(20), [#tempMonthDecalrationFinal].[LedgMonth], 107)                                AS [LedgMonth],
            [#tempMonthDecalrationFinal].[Remarks]                                                             AS [Remarks],
            --IIF(ISNULL(IsPaid, 0) = 1,
            --    'PAID',
            --    IIF(CONVERT(VARCHAR(20), LedgMonth, 107) = CONVERT(VARCHAR(20), GETDATE(), 107), 'FOR PAYMENT', 'PENDING')) As PaymentStatus,
            CASE
                WHEN ISNULL([#tempMonthDecalrationFinal].[IsPaid], 0) = 1
                     AND ISNULL([#tempMonthDecalrationFinal].[IsHold], 0) = 0
                    THEN
                    IIF(ISNULL([#tempMonthDecalrationFinal].[LedgRentalAmount], 0) = 0,
                        IIF([#tempMonthDecalrationFinal].[Unit_SecAndMainAmount] = 0, 'N/A', 'FREE'),
                        'PAID')
                WHEN ISNULL([#tempMonthDecalrationFinal].[IsPaid], 0) = 0
                     AND ISNULL([#tempMonthDecalrationFinal].[IsHold], 0) = 1
                    THEN
                    IIF(ISNULL([#tempMonthDecalrationFinal].[LedgRentalAmount], 0) = 0,
                        IIF([#tempMonthDecalrationFinal].[Unit_SecAndMainAmount] = 0, 'N/A', 'FREE'),
                        'HOLD')
                WHEN [#tempMonthDecalrationFinal].[LedgMonth] IN
                         (
                             SELECT
                                 [tblAdvancePayment].[Months]
                             FROM
                                 [dbo].[tblAdvancePayment]
                             WHERE
                                 [tblAdvancePayment].[RefId] = @RefId
                         )
                     AND ISNULL([#tempMonthDecalrationFinal].[IsPaid], 0) = 0
                     AND ISNULL([#tempMonthDecalrationFinal].[IsHold], 0) = 0
                    THEN
                    IIF(ISNULL([#tempMonthDecalrationFinal].[LedgRentalAmount], 0) = 0,
                        IIF([#tempMonthDecalrationFinal].[Unit_SecAndMainAmount] = 0, 'N/A', 'FREE'),
                        'DUE')
                WHEN CONVERT(VARCHAR(20), [#tempMonthDecalrationFinal].[LedgMonth], 107) = CONVERT(
                                                                                                      VARCHAR(20),
                                                                                                      GETDATE(), 107
                                                                                                  )
                     AND ISNULL([#tempMonthDecalrationFinal].[IsPaid], 0) = 0
                     AND ISNULL([#tempMonthDecalrationFinal].[IsHold], 0) = 0
                    THEN
                    IIF(ISNULL([#tempMonthDecalrationFinal].[LedgRentalAmount], 0) = 0,
                        IIF([#tempMonthDecalrationFinal].[Unit_SecAndMainAmount] = 0, 'N/A', 'FREE'),
                        'DUE')
                ELSE
                    IIF(ISNULL([#tempMonthDecalrationFinal].[LedgRentalAmount], 0) = 0,
                        IIF([#tempMonthDecalrationFinal].[Unit_SecAndMainAmount] = 0, 'N/A', 'FREE'),
                        'PENDING')
            END                                                                                                AS [PaymentStatus],
            --IIF(
            --    [tblMonthLedger].[BalanceAmount] <= 0
            --    AND [tblMonthLedger].[IsPaid] = 0,
            --    0,
            --    [tblMonthLedger].[LedgAmount] - [tblMonthLedger].[BalanceAmount]) AS [AmountPaid],
            IIF(
                ISNULL([#tempMonthDecalrationFinal].[IsPaid], 0) = 1
                OR
                    (
                        ISNULL([#tempMonthDecalrationFinal].[IsHold], 0) = 1
                        AND [#tempMonthDecalrationFinal].[BalanceAmount] > 0
                    ),
                ([#tempMonthDecalrationFinal].[ActualAmount]
                 - (ISNULL([#tempMonthDecalrationFinal].[BalanceAmount], 0)
                    + ISNULL([#tempMonthDecalrationFinal].[PenaltyAmount], 0)
                   )
                ),
                0)                                                                                             AS [AmountPaid],
            FORMAT(CAST(ABS(ISNULL([#tempMonthDecalrationFinal].[BalanceAmount], 0)) AS DECIMAL(18, 2)), 'N2') AS [BalanceAmount]

        --'0.00' [PenaltyAmount]
        FROM
            [dbo].[#tempMonthDecalrationFinal]
        --WHERE
        --    [tblMonthLedger].[ReferenceID] = @ReferenceID
        --    AND [tblMonthLedger].[ClientID] = @ClientID
        ORDER BY
            [seq] ASC;



    --SELECT
    --    *
    --FROM
    --    [#tempAdvancePayment]
    --SELECT
    --    *
    --FROM
    --    [#tempAdvancePaymentZeroAmount]
    --SELECT
    --    *
    --FROM
    --    [#tempAdvancePaymentExactAmount]
    END;
    DROP TABLE IF EXISTS [#tempAdvancePaymentFiltered]
    DROP TABLE IF EXISTS [#tempMonthDecalrationFinal]
    DROP TABLE IF EXISTS [#tempAdvancePayment]
    DROP TABLE IF EXISTS [#tempMonthLedger]
    DROP TABLE IF EXISTS [#tempAdvancePaymentZeroAmount]
    DROP TABLE IF EXISTS [#tempAdvancePaymentExactAmount]
GO

