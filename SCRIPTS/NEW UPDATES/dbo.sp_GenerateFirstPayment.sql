SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [dbo].[sp_GenerateFirstPayment]
    -- Add the parameters for the stored procedure here
    @RefId VARCHAR(50) = NULL,
    @PaidAmount DECIMAL(18, 2) = NULL,
    @ReceiveAmount DECIMAL(18, 2) = NULL,
    @ChangeAmount DECIMAL(18, 2) = NULL,
    @SecAmountADV DECIMAL(18, 2) = NULL,
    @EncodedBy INT = NULL,
    @ComputerName VARCHAR(30) = NULL,
    @CompanyORNo VARCHAR(30) = NULL,
    @CompanyPRNo VARCHAR(30) = NULL,
    @BankAccountName VARCHAR(30) = NULL,
    @BankAccountNumber VARCHAR(30) = NULL,
    @BankName VARCHAR(30) = NULL,
    @SerialNo VARCHAR(30) = NULL,
    @PaymentRemarks VARCHAR(100) = NULL,
    @REF VARCHAR(100) = NULL,
	@ReceiptDate DATETIME = NULL,
    @BankBranch VARCHAR(100) = NULL,
    @ModeType VARCHAR(20) = NULL
AS
BEGIN TRY
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
    DECLARE @ReturnMessage VARCHAR(200);
    DECLARE @TranRecId BIGINT = 0;
    DECLARE @TranID VARCHAR(50) = '';
    DECLARE @RcptRecId BIGINT = 0;
    DECLARE @RcptID VARCHAR(50) = '';
    DECLARE @ApplicableMonth1 DATE = NULL;
    DECLARE @ApplicableMonth2 DATE = NULL;
    DECLARE @IsFullPayment BIT = 0;
    DECLARE @ActualAmount DECIMAL(18, 2) = NULL
    -- Insert statements for procedure here

    SELECT @IsFullPayment = ISNULL([tblUnitReference].[IsFullPayment], 0)
    FROM [dbo].[tblUnitReference]
    WHERE [tblUnitReference].[RefId] = @RefId;

    BEGIN TRANSACTION;

    INSERT INTO [dbo].[tblTransaction]
    (
        [RefId],
        [PaidAmount],
        [ReceiveAmount],
        [ActualAmountPaid],
        [ChangeAmount], ---Not Assigned
        [Remarks],
        [EncodedBy],
        [EncodedDate],
        [ComputerName],
        [IsActive]
    )
    VALUES
    (@RefId, @PaidAmount, @ReceiveAmount, @ReceiveAmount, @ChangeAmount,
     IIF(@IsFullPayment = 1,
         'FULL PAYMENT',
         IIF(@PaidAmount > @ReceiveAmount, 'PARTIAL - FIRST PAYMENT', 'FIRST PAYMENT')), @EncodedBy, GETDATE(),
     @ComputerName, 1);

    SET @TranRecId = @@IDENTITY;
    SELECT @TranID = [tblTransaction].[TranID]
    FROM [dbo].[tblTransaction]
    WHERE [tblTransaction].[RecId] = @TranRecId;

    SELECT @ActualAmount = [tblTransaction].[ActualAmountPaid]
    FROM [dbo].[tblTransaction]
    WHERE [tblTransaction].[RecId] = @TranRecId

    --1). IF Paid Amount > Actual amount ---IS Partial Payment-
    --2). Create A flag in UnitReference As Partial Payment--- Only for First Payment
    --3). Save The Balance Amount-IN UnitReference FirtsPaymentBalanceAmount
    --4). if parial payment dont insert in payment the security and maintenance only after will payall and datepay will be the final date last pay

    --IN PAYMENT HISTORy TO GET THE TRANSACTION FOR FIRST PARTIAL PAYMENT SUM THE AMOUNT OF [Remarks]= 'PARTIAL - FIRST PAYMENT' 
    --then MAP the MAX transactionid to tblpayment then display the payment history

    IF @IsFullPayment = 0
    BEGIN
        IF @PaidAmount > @ActualAmount
        BEGIN

            --PARTIAL PAYMENT

            UPDATE [dbo].[tblUnitReference]
            SET [tblUnitReference].[IsPartialPayment] = 1,
                [tblUnitReference].[FirtsPaymentBalanceAmount] = ABS(@PaidAmount - @ActualAmount)
            WHERE [tblUnitReference].[RefId] = @RefId

            INSERT INTO [dbo].[tblReceipt]
            (
                [TranId],
                [Amount],
                [Description],
                [Remarks],
                [EncodedBy],
                [EncodedDate],
                [ComputerName],
                [IsActive],
                [PaymentMethod],
                [CompanyORNo],
                [CompanyPRNo],
                [BankAccountName],
                [BankAccountNumber],
                [BankName],
                [SerialNo],
                [REF],
                [BankBranch],
                [RefId],
				[ReceiptDate]
            )
            VALUES
            (@TranID, @ReceiveAmount, 'PARTIAL - FIRST PAYMENT', @PaymentRemarks, @EncodedBy, GETDATE(), @ComputerName,
             1  , @ModeType, @CompanyORNo, @CompanyPRNo, @BankAccountName, @BankAccountNumber, @BankName, @SerialNo,
             @REF, @BankBranch, @RefId,@ReceiptDate);

            SET @RcptRecId = @@IDENTITY;
            SELECT @RcptID = [tblReceipt].[RcptID]
            FROM [dbo].[tblReceipt] WITH (NOLOCK)
            WHERE [tblReceipt].[RecId] = @RcptRecId;

            INSERT INTO [dbo].[tblPaymentMode]
            (
                [RcptID],
                [CompanyORNo],
                [CompanyPRNo],
                [REF],
                [BNK_ACCT_NAME],
                [BNK_ACCT_NUMBER],
                [BNK_NAME],
                [SERIAL_NO],
                [ModeType],
                [BankBranch],
				[ReceiptDate]
            )
            VALUES
            (@RcptID, @CompanyORNo, @CompanyPRNo, @REF, @BankAccountName, @BankAccountNumber, @BankName, @SerialNo,
             @ModeType, @BankBranch,@ReceiptDate);

        END
        ELSE
        BEGIN
            UPDATE [dbo].[tblUnitReference]
            SET [tblUnitReference].[FirtsPaymentBalanceAmount] = 0
            WHERE [tblUnitReference].[RefId] = @RefId
            INSERT INTO [dbo].[tblPayment]
            (
                [TranId],
                [RefId],
                [Amount],
                [ForMonth],
                [Remarks],
                [Notes],
                [EncodedBy],
                [EncodedDate],
                [ComputerName],
                [IsActive],
                [LedgeRecid]
            )
            SELECT @TranID AS [TranId],
                   @RefId AS [RefId],
                   [tblMonthLedger].[LedgRentalAmount] AS [Amount],
                   [tblMonthLedger].[LedgMonth] AS [ForMonth],
                   'MONTHS ADVANCE' AS [Remarks],
                   [tblMonthLedger].[Remarks] AS [Notes],
                   @EncodedBy,
                   GETDATE(), --Dated payed
                   @ComputerName,
                   1,
                   [tblMonthLedger].[Recid]
            FROM [dbo].[tblMonthLedger] WITH (NOLOCK)
            WHERE [tblMonthLedger].[ReferenceID] =
            (
                SELECT [tblUnitReference].[RecId]
                FROM [dbo].[tblUnitReference] WITH (NOLOCK)
                WHERE [tblUnitReference].[RefId] = @RefId
            )
                  AND [tblMonthLedger].[LedgMonth] IN
                      (
                          SELECT [tblAdvancePayment].[Months]
                          FROM [dbo].[tblAdvancePayment] WITH (NOLOCK)
                          WHERE [tblAdvancePayment].[RefId] = @RefId
                      )
                  AND ISNULL([tblMonthLedger].[IsPaid], 0) = 0
                  AND ISNULL([tblMonthLedger].[TransactionID], '') = ''
            UNION
            SELECT @TranID AS [TranId],
                   @RefId AS [RefId],
                   @SecAmountADV AS [Amount],
                   CONVERT(DATE, GETDATE()) AS [ForMonth],
                   'SECURITY DEPOSIT' AS [Remarks],
                   NULL,
                   @EncodedBy,
                   GETDATE(),
                   @ComputerName,
                   1,
                   0

            UPDATE [dbo].[tblUnitReference]
            SET [tblUnitReference].[IsPaid] = 1
            WHERE [tblUnitReference].[RefId] = @RefId;

            UPDATE [dbo].[tblMonthLedger]
            SET [tblMonthLedger].[IsPaid] = 1,
                [tblMonthLedger].[CompanyORNo] = @CompanyORNo,
                [tblMonthLedger].[CompanyPRNo] = @CompanyPRNo,
                [tblMonthLedger].[REF] = @REF,
                [tblMonthLedger].[BNK_ACCT_NAME] = @BankAccountName,
                [tblMonthLedger].[BNK_ACCT_NUMBER] = @BankAccountNumber,
                [tblMonthLedger].[BNK_NAME] = @BankName,
                [tblMonthLedger].[SERIAL_NO] = @SerialNo,
                [tblMonthLedger].[ModeType] = @ModeType,
                [tblMonthLedger].[BankBranch] = @BankBranch,
                [tblMonthLedger].[TransactionID] = @TranID
            WHERE [tblMonthLedger].[ReferenceID] =
            (
                SELECT [tblUnitReference].[RecId]
                FROM [dbo].[tblUnitReference] WITH (NOLOCK)
                WHERE [tblUnitReference].[RefId] = @RefId
            )
                  AND [tblMonthLedger].[LedgMonth] IN
                      (
                          SELECT [tblAdvancePayment].[Months]
                          FROM [dbo].[tblAdvancePayment] WITH (NOLOCK)
                          WHERE [tblAdvancePayment].[RefId] = @RefId
                      )
                  AND ISNULL([tblMonthLedger].[IsPaid], 0) = 0
                  AND ISNULL([tblMonthLedger].[TransactionID], '') = '';

            INSERT INTO [dbo].[tblReceipt]
            (
                [TranId],
                [Amount],
                [Description],
                [Remarks],
                [EncodedBy],
                [EncodedDate],
                [ComputerName],
                [IsActive],
                [PaymentMethod],
                [CompanyORNo],
                [CompanyPRNo],
                [BankAccountName],
                [BankAccountNumber],
                [BankName],
                [SerialNo],
                [REF],
                [BankBranch],
                [RefId],
				[ReceiptDate]
            )
            VALUES
            (@TranID, @PaidAmount, 'FIRST PAYMENT', @PaymentRemarks, @EncodedBy, GETDATE(), @ComputerName, 1,
             @ModeType, @CompanyORNo, @CompanyPRNo, @BankAccountName, @BankAccountNumber, @BankName, @SerialNo, @REF,
             @BankBranch, @RefId,@ReceiptDate);

            SET @RcptRecId = @@IDENTITY;
            SELECT @RcptID = [tblReceipt].[RcptID]
            FROM [dbo].[tblReceipt] WITH (NOLOCK)
            WHERE [tblReceipt].[RecId] = @RcptRecId;

            INSERT INTO [dbo].[tblPaymentMode]
            (
                [RcptID],
                [CompanyORNo],
                [CompanyPRNo],
                [REF],
                [BNK_ACCT_NAME],
                [BNK_ACCT_NUMBER],
                [BNK_NAME],
                [SERIAL_NO],
                [ModeType],
                [BankBranch],
				[ReceiptDate]
            )
            VALUES
            (@RcptID, @CompanyORNo, @CompanyPRNo, @REF, @BankAccountName, @BankAccountNumber, @BankName, @SerialNo,
             @ModeType, @BankBranch,@ReceiptDate);
        END
    END
    ELSE IF @IsFullPayment = 1
    BEGIN


        BEGIN
            UPDATE [dbo].[tblUnitReference]
            SET [tblUnitReference].[FirtsPaymentBalanceAmount] = 0
            WHERE [tblUnitReference].[RefId] = @RefId


            UPDATE [dbo].[tblUnitReference]
            SET [tblUnitReference].[IsPaid] = 1
            WHERE [tblUnitReference].[RefId] = @RefId;


            UPDATE [dbo].[tblMonthLedger]
            SET [tblMonthLedger].[IsPaid] = 1,
                [tblMonthLedger].[CompanyORNo] = @CompanyORNo,
                [tblMonthLedger].[CompanyPRNo] = @CompanyPRNo,
                [tblMonthLedger].[REF] = @REF,
                [tblMonthLedger].[BNK_ACCT_NAME] = @BankAccountName,
                [tblMonthLedger].[BNK_ACCT_NUMBER] = @BankAccountNumber,
                [tblMonthLedger].[BNK_NAME] = @BankName,
                [tblMonthLedger].[SERIAL_NO] = @SerialNo,
                [tblMonthLedger].[ModeType] = @ModeType,
                [tblMonthLedger].[BankBranch] = @BankBranch,
                [tblMonthLedger].[TransactionID] = @TranID
            WHERE [tblMonthLedger].[ReferenceID] =
            (
                SELECT [tblUnitReference].[RecId]
                FROM [dbo].[tblUnitReference] WITH (NOLOCK)
                WHERE [tblUnitReference].[RefId] = @RefId
            )
                  AND ISNULL([IsPaid], 0) = 0
                  AND ISNULL([tblMonthLedger].[TransactionID], '') = '';

            INSERT INTO [dbo].[tblReceipt]
            (
                [TranId],
                [Amount],
                [Description],
                [Remarks],
                [EncodedBy],
                [EncodedDate],
                [ComputerName],
                [IsActive],
                [PaymentMethod],
                [CompanyORNo],
                [CompanyPRNo],
                [BankAccountName],
                [BankAccountNumber],
                [BankName],
                [SerialNo],
                [REF],
                [BankBranch],
                [RefId],
				[ReceiptDate]
            )
            VALUES
            (@TranID, @PaidAmount, 'FULL PAYMENT', @PaymentRemarks, @EncodedBy, GETDATE(), @ComputerName, 1, @ModeType,
             @CompanyORNo, @CompanyPRNo, @BankAccountName, @BankAccountNumber, @BankName, @SerialNo, @REF, @BankBranch,
             @RefId,@ReceiptDate);

            SET @RcptRecId = @@IDENTITY;
            SELECT @RcptID = [tblReceipt].[RcptID]
            FROM [dbo].[tblReceipt] WITH (NOLOCK)
            WHERE [tblReceipt].[RecId] = @RcptRecId;

            INSERT INTO [dbo].[tblPaymentMode]
            (
                [RcptID],
                [CompanyORNo],
                [CompanyPRNo],
                [REF],
                [BNK_ACCT_NAME],
                [BNK_ACCT_NUMBER],
                [BNK_NAME],
                [SERIAL_NO],
                [ModeType],
                [BankBranch],
				[ReceiptDate]
            )
            VALUES
            (@RcptID, @CompanyORNo, @CompanyPRNo, @REF, @BankAccountName, @BankAccountNumber, @BankName, @SerialNo,
             @ModeType, @BankBranch,@ReceiptDate);
        END

    END;

    IF (@TranID <> '' AND @@ROWCOUNT > 0)
    BEGIN

        SET @ReturnMessage = 'SUCCESS';
    END;
    ELSE
    BEGIN
        SET @ReturnMessage = ERROR_MESSAGE();
    END;
    SELECT @ReturnMessage AS [Message_Code],
           @TranID AS [TranID];

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    SET @ReturnMessage = ERROR_MESSAGE();
    SELECT @ReturnMessage AS [ReturnMessage];
END CATCH;
GO
