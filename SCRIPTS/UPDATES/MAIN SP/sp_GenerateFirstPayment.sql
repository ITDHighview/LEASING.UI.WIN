SET QUOTED_IDENTIFIER ON;
SET ANSI_NULLS ON;
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_GenerateFirstPayment]
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
        [ChangeAmount],
        [Remarks],
        [EncodedBy],
        [EncodedDate],
        [ComputerName],
        [IsActive]
    )
    VALUES
    (@RefId, @PaidAmount, @ReceiveAmount, @ChangeAmount, IIF(@IsFullPayment = 1, 'FULL PAYMENT', 'FIRST PAYMENT'),
     @EncodedBy, GETDATE(), @ComputerName, 1);

    SET @TranRecId = @@IDENTITY;
    SELECT @TranID = [tblTransaction].[TranID]
    FROM [dbo].[tblTransaction] WITH (NOLOCK)
    WHERE [tblTransaction].[RecId] = @TranRecId;
    IF @IsFullPayment = 1
    BEGIN
        INSERT INTO [dbo].[tblPayment]
        (
            [TranId],
            [RefId],
            [Amount],
            [ForMonth],
            [Remarks],
            [EncodedBy],
            [EncodedDate],
            [ComputerName],
            [IsActive]
        )
        SELECT @TranID AS [TranId],
               @RefId AS [RefId],
               [tblMonthLedger].[LedgAmount] AS [Amount],
               [tblMonthLedger].[LedgMonth] AS [ForMonth],
               'FULL PAYMENT' AS [Remarks],
               @EncodedBy,
               GETDATE(), --Dated payed
               @ComputerName,
               1
        FROM [dbo].[tblMonthLedger] WITH (NOLOCK)
        WHERE [tblMonthLedger].[ReferenceID] =
        (
            SELECT [tblUnitReference].[RecId]
            FROM [dbo].[tblUnitReference] WITH (NOLOCK)
            WHERE [tblUnitReference].[RefId] = @RefId
        )
              AND ISNULL([tblMonthLedger].[IsPaid], 0) = 0
              AND ISNULL([tblMonthLedger].[TransactionID], '') = ''
        UNION
        SELECT @TranID AS [TranId],
               @RefId AS [RefId],
               @SecAmountADV AS [Amount],
               CONVERT(DATE, GETDATE()) AS [ForMonth],
               'SECURITY DEPOSIT' AS [Remarks],
               @EncodedBy,
               GETDATE(),
               @ComputerName,
               1
        FROM [dbo].[tblUnitReference]
        WHERE [RefId] = @RefId
              AND ISNULL([tblUnitReference].[SecDeposit], 0) > 0;

        UPDATE [dbo].[tblUnitReference]
        SET [tblUnitReference].[IsPaid] = 1
        WHERE [tblUnitReference].[RefId] = @RefId;
        UPDATE [dbo].[tblMonthLedger]
        SET [tblMonthLedger].[IsPaid] = 1,
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
            [REF]
        )
        VALUES
        (@TranID, @PaidAmount, 'FULL PAYMENT', @PaymentRemarks, @EncodedBy, GETDATE(), @ComputerName, 1, @ModeType,
         @CompanyORNo, @CompanyPRNo, @BankAccountName, @BankAccountNumber, @BankName, @SerialNo, @REF);

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
            [ModeType]
        )
        VALUES
        (@RcptID, @CompanyORNo, @CompanyPRNo, @REF, @BankAccountName, @BankAccountNumber, @BankName, @SerialNo,
         @ModeType);

    END;

    ELSE
    BEGIN
        INSERT INTO [dbo].[tblPayment]
        (
            [TranId],
            [RefId],
            [Amount],
            [ForMonth],
            [Remarks],
            [EncodedBy],
            [EncodedDate],
            [ComputerName],
            [IsActive]
        )
        SELECT @TranID AS [TranId],
               @RefId AS [RefId],
               [tblMonthLedger].[LedgAmount] AS [Amount],
               [tblMonthLedger].[LedgMonth] AS [ForMonth],
               'MONTHS ADVANCE' AS [Remarks],
               @EncodedBy,
               GETDATE(), --Dated payed
               @ComputerName,
               1
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
               @EncodedBy,
               GETDATE(),
               @ComputerName,
               1;


        UPDATE [dbo].[tblUnitReference]
        SET [tblUnitReference].[IsPaid] = 1
        WHERE [tblUnitReference].[RefId] = @RefId;
        UPDATE [dbo].[tblMonthLedger]
        SET [tblMonthLedger].[IsPaid] = 1,
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
            [REF]
        )
        VALUES
        (@TranID, @PaidAmount, 'FIRST PAYMENT', @PaymentRemarks, @EncodedBy, GETDATE(), @ComputerName, 1, @ModeType,
         @CompanyORNo, @CompanyPRNo, @BankAccountName, @BankAccountNumber, @BankName, @SerialNo, @REF);

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
            [ModeType]
        )
        VALUES
        (@RcptID, @CompanyORNo, @CompanyPRNo, @REF, @BankAccountName, @BankAccountNumber, @BankName, @SerialNo,
         @ModeType);

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

