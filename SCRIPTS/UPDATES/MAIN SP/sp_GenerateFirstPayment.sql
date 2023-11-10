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
ALTER PROCEDURE [dbo].[sp_GenerateFirstPayment] 
	-- Add the parameters for the stored procedure here
	@RefId VARCHAR(50)=NULL,
	@PaidAmount DECIMAL(18,2) = NULL,
	@ReceiveAmount DECIMAL(18,2)=NULL,
	@ChangeAmount DECIMAL(18,2)=NULL,
	@SecAmountADV DECIMAL(18,2)=NULL,
	@EncodedBy INT =NULL,
	@ComputerName VARCHAR(30)=NULL,
	@PaymentMethod VARCHAR(30)=NULL,
	@CompanyORNo VARCHAR(30)=NULL,
	@BankAccountName VARCHAR(30)=NULL,
	@BankAccountNumber VARCHAR(30)=NULL,
	@BankName VARCHAR(30)=NULL,
	@SerialNo VARCHAR(30)=NULL,
	@PaymentRemarks  VARCHAR(100)=NULL
	

	
AS
BEGIN TRY 
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
SET NOCOUNT ON;


DECLARE @ReturnMessage varchar(200)   

DECLARE @TranRecId BIGINT = 0
DECLARE @TranID VARCHAR(50) = ''
DECLARE @ApplicableMonth1 DATE = NULL
DECLARE @ApplicableMonth2 DATE = NULL
-- Insert statements for procedure here

BEGIN TRANSACTION 

SELECT @ApplicableMonth1 = Applicabledate1,
       @ApplicableMonth2 = Applicabledate2
FROM tblUnitReference
WHERE RefId = @RefId

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
(@RefId, @PaidAmount, @ReceiveAmount, @ChangeAmount, 'FIRST PAYMENT', @EncodedBy, GETDATE(), @ComputerName, 1)

SET @TranRecId = @@IDENTITY
SELECT @TranID = TranID
FROM tblTransaction
WHERE RecId = @TranRecId





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
       'TWO MONTHS ADVANCE' as Remarks,
       @EncodedBy,
       GETDATE(),--Dated payed
       @ComputerName,
       1
FROM tblMonthLedger
WHERE ReferenceID =
(
    SELECT Recid FROM tblUnitReference WHERE RefId = @RefId
)
      and LedgMonth IN ( @ApplicableMonth1, @ApplicableMonth2 )
UNION
SELECT @TranID AS TranId,
       @RefId AS RefId,
       @SecAmountADV as Amount,
       CONVERT(DATE, GETDATE()) as ForMonth,
       'THREE MONTHS SECURITY DEPOSIT' as Remarks,
       @EncodedBy,
       GETDATE(),
       @ComputerName,
       1


UPDATE tblUnitReference
SET IsPaid = 1
WHERE RefId = @RefId
UPDATE tblMonthLedger
SET IsPaid = 1,
    TransactionID = @TranID
WHERE LedgMonth IN ( @ApplicableMonth1, @ApplicableMonth2 )


INSERT INTO tblReceipt (
TranId
,Amount
,[Description]
,Remarks
,EncodedBy
,EncodedDate
,ComputerName
,IsActive
,PaymentMethod
,CompanyORNo
,BankAccountName
,BankAccountNumber
,BankName
,SerialNo)
VALUES (
@TranID 
,@PaidAmount
,'FIRST PAYMENT' 
,@PaymentRemarks
,@EncodedBy
,GETDATE()
,@ComputerName
,1
,@PaymentMethod
,@CompanyORNo
,@BankAccountName
,@BankAccountNumber
,@BankName
,@SerialNo)

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
