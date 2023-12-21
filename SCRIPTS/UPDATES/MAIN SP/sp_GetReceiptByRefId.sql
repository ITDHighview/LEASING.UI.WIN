--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
ALTER PROCEDURE [dbo].[sp_GetReceiptByRefId] @RefId AS VARCHAR(50) = NULL
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT
                [tblTransaction].[RefId],
                [tblTransaction].[TranID],
                [tblReceipt].[RcptID],
                --[tblPayment].[PayID],
                [PAYMENT].[Amount]                                        AS [PaidAmount],
                CONVERT(VARCHAR(10), [tblTransaction].[EncodedDate], 101) AS [PayDate],
                [tblReceipt].[CompanyORNo],
                [tblReceipt].[BankAccountName],
                [tblReceipt].[BankAccountNumber],
                [tblReceipt].[BankName],
                [tblReceipt].[SerialNo],
                [tblReceipt].[REF]
        FROM
                [dbo].[tblTransaction]
            OUTER APPLY
                (
                    SELECT
                        SUM([tblPayment].[Amount]) AS [Amount],
                        [tblPayment].[TranId],
                        [tblPayment].[EncodedDate]
                    FROM
                        [dbo].[tblPayment]
                    WHERE
                        [tblTransaction].[TranID] = [tblPayment].[TranId]
                    GROUP BY
                        [tblPayment].[TranId],
                        [tblPayment].[EncodedDate]
                ) [PAYMENT]
            INNER JOIN
                [dbo].[tblReceipt]
                    ON [PAYMENT].[TranId] = [tblReceipt].[TranId]
        WHERE
                [tblTransaction].[RefId] = @RefId
        ORDER BY
                [PAYMENT].[EncodedDate];

    END;
GO
