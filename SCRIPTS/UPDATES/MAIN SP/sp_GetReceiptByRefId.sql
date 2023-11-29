--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
ALTER PROCEDURE [sp_GetReceiptByRefId] @RefId AS VARCHAR(50) = NULL
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT
                [tblTransaction].[RefId],
                [tblTransaction].[TranID],
                [tblReceipt].[RcptID],
                [tblPayment].[PayID],
                [tblTransaction].[PaidAmount],
                CONVERT(VARCHAR(10), [tblPayment].[ForMonth], 101)    AS [ForMonth],
                CONVERT(VARCHAR(10), [tblPayment].[EncodedDate], 101) AS [PayDate],
                [tblReceipt].[CompanyORNo],
                [tblReceipt].[BankAccountName],
                [tblReceipt].[BankAccountNumber],
                [tblReceipt].[BankName],
                [tblReceipt].[SerialNo],
                [tblReceipt].[REF]
        FROM
                [dbo].[tblTransaction]
            INNER JOIN
                [dbo].[tblPayment]
                    ON [tblPayment].[RefId] = [tblTransaction].[RefId]
                       AND [tblTransaction].[TranID] = [tblPayment].[TranId]
            INNER JOIN
                [dbo].[tblReceipt]
                    ON [tblPayment].[TranId] = [tblReceipt].[TranId]
        WHERE
                [tblTransaction].[RefId] = @RefId
        ORDER BY
                [tblPayment].[EncodedDate],
                [tblPayment].[ForMonth];
    END;
GO
