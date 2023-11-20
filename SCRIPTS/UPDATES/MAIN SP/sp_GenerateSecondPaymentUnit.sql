USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_GenerateFirstPayment]    Script Date: 11/9/2023 9:56:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_GenerateSecondPaymentUnit]
    -- Add the parameters for the stored procedure here
    @RefId VARCHAR(50) = NULL,
    @PaidAmount DECIMAL(18, 2) = NULL,
    @ReceiveAmount DECIMAL(18, 2) = NULL,
    @ChangeAmount DECIMAL(18, 2) = NULL,
    @EncodedBy INT = NULL,
    @ComputerName VARCHAR(30) = NULL,
    @CompanyORNo VARCHAR(30) = NULL,
    @BankAccountName VARCHAR(30) = NULL,
    @BankAccountNumber VARCHAR(30) = NULL,
    @BankName VARCHAR(30) = NULL,
    @SerialNo VARCHAR(30) = NULL,
    @PaymentRemarks VARCHAR(100) = NULL,
    @REF VARCHAR(100) = NULL,
    @ModeType INT = 0,
    @ledgerRecId INT = null
AS
BEGIN TRY
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
    DECLARE @ReturnMessage varchar(200)
    DECLARE @TranRecId BIGINT = 0
    DECLARE @TranID VARCHAR(50) = ''
    DECLARE @RcptRecId BIGINT = 0
    DECLARE @RcptID VARCHAR(50) = ''
    DECLARE @LedgeMonth DATE = NULL

    BEGIN TRANSACTION
    INSERT INTO tblTransaction
    (
        RefId,
        PaidAmount,
        ReceiveAmount,
        ChangeAmount,
        Remarks,
        EncodedBy,
        EncodedDate,
        ComputerName,
        IsActive
    )
    VALUES
    (@RefId, @PaidAmount, @ReceiveAmount, @ChangeAmount, 'FOLLOW-UP PAYMENT', @EncodedBy, GETDATE(), @ComputerName, 1)

    SET @TranRecId = @@IDENTITY
    SELECT @TranID = TranID
    FROM tblTransaction WITH(NOLOCK)
    WHERE RecId = @TranRecId

    SELECT @LedgeMonth = LedgMonth
    FROM tblMonthLedger WITH(NOLOCK)
    WHERE ISNULL(IsPaid, 0) = 0
          and ISNULL(TransactionID, '') = ''
          and ReferenceID =
          (
              SELECT Recid FROM tblUnitReference WITH(NOLOCK)  WHERE RefId = @RefId
          )
          and Recid = @ledgerRecId
    INSERT INTO tblPayment
    (
        TranId,
        RefId,
        Amount,
        ForMonth,
        Remarks,
        EncodedBy,
        EncodedDate,
        ComputerName,
        IsActive
    )
    SELECT @TranID AS TranId,
           @RefId AS RefId,
           LedgAmount as Amount,
           LedgMonth as ForMonth,
           'FOLLOW-UP PAYMENT' as Remarks,
           @EncodedBy,
           GETDATE(), --Dated payed
           @ComputerName,
           1
    FROM tblMonthLedger WITH(NOLOCK)
    WHERE LedgMonth = @LedgeMonth
          and ISNULL(IsPaid, 0) = 0
          and ISNULL(TransactionID, '') = ''
          and ReferenceID =
          (
              SELECT Recid FROM tblUnitReference WITH(NOLOCK) WHERE RefId = @RefId
          )
          and Recid = @ledgerRecId


    UPDATE tblMonthLedger
    SET IsPaid = 1,
        IsHold = 0,
        TransactionID = @TranID
    WHERE LedgMonth = @LedgeMonth
          and ISNULL(IsPaid, 0) = 0
          and ISNULL(TransactionID, '') = ''
          and ReferenceID =
          (
              SELECT Recid FROM tblUnitReference WITH(NOLOCK) WHERE RefId = @RefId
          )
          and Recid = @ledgerRecId


    INSERT INTO tblReceipt
    (
        TranId,
        Amount,
        [Description],
        Remarks,
        EncodedBy,
        EncodedDate,
        ComputerName,
        IsActive,
        PaymentMethod,
        CompanyORNo,
        BankAccountName,
        BankAccountNumber,
        BankName,
        SerialNo,
        REF
    )
    VALUES
    (@TranID,
     @PaidAmount,
     'FOLLOW-UP PAYMENT',
     @PaymentRemarks,
     @EncodedBy,
     GETDATE(),
     @ComputerName,
     1  ,
     @ModeType,
     @CompanyORNo,
     @BankAccountName,
     @BankAccountNumber,
     @BankName,
     @SerialNo,
     @REF
    )

    SET @RcptRecId = @@IDENTITY
    SELECT @RcptID = RcptID
    FROM tblReceipt WITH(NOLOCK)
    WHERE RecId = @RcptRecId

    INSERT INTO tblPaymentMode
    (
        RcptID,
        CompanyORNo,
        REF,
        BNK_ACCT_NAME,
        BNK_ACCT_NUMBER,
        BNK_NAME,
        SERIAL_NO,
        ModeType
    )
    VALUES
    (@RcptID, @CompanyORNo, @REF, @BankAccountName, @BankAccountNumber, @BankName, @SerialNo, @ModeType)


    if (@TranID <> '' AND @@ROWCOUNT > 0)
    BEGIN
        SET @ReturnMessage = 'SUCCESS'
    END
    ELSE
    BEGIN
        SET @ReturnMessage = ERROR_MESSAGE()
    END
    SELECT @ReturnMessage AS Message_Code

    COMMIT TRANSACTION
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION

    SET @ReturnMessage = Error_message()
    SELECT @ReturnMessage AS ReturnMessage
END CATCH
