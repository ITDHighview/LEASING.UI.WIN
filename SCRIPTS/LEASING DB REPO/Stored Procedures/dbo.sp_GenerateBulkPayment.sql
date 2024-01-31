SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GenerateBulkPayment]
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
    @ModeType VARCHAR(20) = NULL,
    @XML XML
AS
BEGIN TRY
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
    DECLARE @ReturnMessage VARCHAR(200)
    DECLARE @TranRecId BIGINT = 0
    DECLARE @TranID VARCHAR(50) = ''
    DECLARE @RcptRecId BIGINT = 0
    DECLARE @RcptID VARCHAR(50) = ''
    DECLARE @ApplicableMonth1 DATE = NULL
    DECLARE @ApplicableMonth2 DATE = NULL
    DECLARE @IsFullPayment BIT = 0
	DECLARE	@TotalRent DECIMAL(18, 2) = NULL
	DECLARE	@PenaltyPct DECIMAL(18, 2) = NULL
    -- Insert statements for procedure here

    CREATE TABLE [#tblBulkPostdatedMonth] ([Recid] VARCHAR(10))
    IF (@XML IS NOT NULL)
    BEGIN
        INSERT INTO [#tblBulkPostdatedMonth]
        (
            [Recid]
        )
        SELECT [ParaValues].[data].[value]('c1[1]', 'VARCHAR(10)')
        FROM @XML.[nodes]('/Table1') AS [ParaValues]([data])
    END


    SELECT @TotalRent = [tblUnitReference].[TotalRent],
           @PenaltyPct =[tblUnitReference].[PenaltyPct]
    FROM [dbo].[tblUnitReference] WITH (NOLOCK)
    WHERE [tblUnitReference].[RefId] = @RefId

    BEGIN TRANSACTION

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
    (@RefId, @PaidAmount, @ReceiveAmount, @ChangeAmount, 'FOLLOW-UP PAYMENT', @EncodedBy, GETDATE(), @ComputerName, 1);

    SET @TranRecId = @@IDENTITY
    SELECT @TranID = [tblTransaction].[TranID]
    FROM [dbo].[tblTransaction] WITH (NOLOCK)
    WHERE [tblTransaction].[RecId] = @TranRecId


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
           CASE
               WHEN DATEDIFF(DAY, [tblMonthLedger].[LedgMonth], CAST(GETDATE() AS DATE)) < 30 THEN
                   [tblMonthLedger].[LedgAmount]
               WHEN DATEDIFF(DAY, [tblMonthLedger].[LedgMonth], CAST(GETDATE() AS DATE)) = 30 THEN
                   @TotalRent
                   + ((@TotalRent * @PenaltyPct) / 100)
               WHEN DATEDIFF(DAY, [tblMonthLedger].[LedgMonth], CAST(GETDATE() AS DATE)) >= 31 THEN
                   @TotalRent
                   + (((@TotalRent * @PenaltyPct) / 100) * 2)
               ELSE
                  [tblMonthLedger].[LedgAmount]
           END AS [Amount],
                      --[tblMonthLedger].[LedgAmount] AS [Amount],
           [tblMonthLedger].[LedgMonth] AS [ForMonth],
           'FOLLOW-UP PAYMENT' AS [Remarks],
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
          AND [tblMonthLedger].[Recid] IN (
                                              SELECT [#tblBulkPostdatedMonth].[Recid]
                                              FROM [#tblBulkPostdatedMonth] WITH (NOLOCK)
                                          )
          AND ISNULL([tblMonthLedger].[IsPaid], 0) = 0
          AND ISNULL([tblMonthLedger].[TransactionID], '') = ''



    UPDATE [dbo].[tblUnitReference]
    SET [tblUnitReference].[IsPaid] = 1
    WHERE [tblUnitReference].[RefId] = @RefId;
    UPDATE [dbo].[tblMonthLedger]
    SET [tblMonthLedger].[IsPaid] = 1,
        [tblMonthLedger].[IsHold] = 0,
        [tblMonthLedger].[TransactionID] = @TranID
    WHERE [tblMonthLedger].[ReferenceID] =
    (
        SELECT [tblUnitReference].[RecId]
        FROM [dbo].[tblUnitReference] WITH (NOLOCK)
        WHERE [tblUnitReference].[RefId] = @RefId
    )
          AND [tblMonthLedger].[Recid] IN (
                                              SELECT [#tblBulkPostdatedMonth].[Recid]
                                              FROM [#tblBulkPostdatedMonth] WITH (NOLOCK)
                                          )
          AND (
                  ISNULL([IsPaid], 0) = 0
                  or ISNULL([IsHold], 0) = 1
              )
          AND ISNULL([tblMonthLedger].[TransactionID], '') = ''


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
    (@TranID,
     @ReceiveAmount,
     'FOLLOW-UP PAYMENT',
     @PaymentRemarks,
     @EncodedBy,
     GETDATE(),
     @ComputerName,
     1  ,
     @ModeType,
     @CompanyORNo,
     @CompanyPRNo,
     @BankAccountName,
     @BankAccountNumber,
     @BankName,
     @SerialNo,
     @REF
    );

    SET @RcptRecId = @@IDENTITY
    SELECT @RcptID = [tblReceipt].[RcptID]
    FROM [dbo].[tblReceipt] WITH (NOLOCK)
    WHERE [tblReceipt].[RecId] = @RcptRecId

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
    (@RcptID, @CompanyORNo, @CompanyPRNo, @REF, @BankAccountName, @BankAccountNumber, @BankName, @SerialNo, @ModeType);


    IF (@TranID <> '' AND @@ROWCOUNT > 0)
    BEGIN

        SET @ReturnMessage = 'SUCCESS';
    END
    ELSE
    BEGIN
        SET @ReturnMessage = ERROR_MESSAGE()
    END;
    SELECT @ReturnMessage AS [Message_Code],
           @TranID AS [TranID]

    COMMIT TRANSACTION
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION

    SET @ReturnMessage = ERROR_MESSAGE()
    SELECT @ReturnMessage AS [ReturnMessage]
END CATCH
DROP TABLE [#tblBulkPostdatedMonth]


GO
