SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_HoldPDCPayment]
    @CompanyORNo VARCHAR(30) = NULL,
    @CompanyPRNo VARCHAR(30) = NULL,
    @BankAccountName VARCHAR(30) = NULL,
    @BankAccountNumber VARCHAR(30) = NULL,
    @BankName VARCHAR(30) = NULL,
    @SerialNo VARCHAR(30) = NULL,
    @PaymentRemarks VARCHAR(100) = NULL,
    @REF VARCHAR(100) = NULL,
    @BankBranch VARCHAR(100) = NULL,
    @ModeType VARCHAR(20) = NULL,
    @XML XML

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

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
        SELECT [ParaValues].[data].[value]('c1[1]', 'VARCHAR(10)')
        FROM @XML.[nodes]('/Table1') AS [ParaValues]([data])
    END

    -- Insert statements for procedure here
    UPDATE [dbo].[tblMonthLedger]
    SET [tblMonthLedger].[IsHold] = 1,
        [tblMonthLedger].[CompanyORNo] = @CompanyORNo,
        [tblMonthLedger].[CompanyPRNo] = @CompanyPRNo,
        [tblMonthLedger].[REF] = @REF,
        [tblMonthLedger].[BNK_ACCT_NAME] = @BankAccountName,
        [tblMonthLedger].[BNK_ACCT_NUMBER] = @BankAccountNumber,
        [tblMonthLedger].[BNK_NAME] = @BankName,
        [tblMonthLedger].[SERIAL_NO] = @SerialNo,
        [tblMonthLedger].[ModeType] = @ModeType,
        [tblMonthLedger].[BankBranch] = @BankBranch
	
    WHERE [tblMonthLedger].[Recid] IN
          (
              SELECT [#tblBulkPostdatedMonth].[Recid]
              FROM [#tblBulkPostdatedMonth] WITH (NOLOCK)
          )


    IF (@@ROWCOUNT > 0)
    BEGIN
        SELECT 'SUCCESS' AS [Message_Code];
    END;

--select IIF(COUNT(*)>0,'IN-PROGRESS','PAYMENT DONE') AS PAYMENT_STATUS from tblMonthLedger where ReferenceID = substring(@ReferenceID,4,11) and ISNULL(IsPaid,0)=0
END;
GO
