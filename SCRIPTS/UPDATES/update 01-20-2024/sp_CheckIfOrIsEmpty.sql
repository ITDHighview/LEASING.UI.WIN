--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [sp_CheckIfOrIsEmpty] @TranId AS VARCHAR(30) = NULL
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    SELECT [tblReceipt].[RecId],
           [tblReceipt].[RcptID],
           [tblReceipt].[TranId],
           --[tblReceipt].[Amount],
           --[tblReceipt].[Description],
           --[tblReceipt].[Remarks],
           --[tblReceipt].[EncodedBy],
           --[tblReceipt].[EncodedDate],
           --[tblReceipt].[LastChangedBy],
           --[tblReceipt].[LastChangedDate],
           --[tblReceipt].[ComputerName],
           --[tblReceipt].[IsActive],
           --[tblReceipt].[PaymentMethod],
           ISNULL([tblReceipt].[CompanyORNo], '') AS [CompanyORNo],
           --[tblReceipt].[BankAccountName],
           --[tblReceipt].[BankAccountNumber],
           --[tblReceipt].[BankName],
           --[tblReceipt].[SerialNo],
           --[tblReceipt].[REF],
           ISNULL([tblReceipt].[CompanyPRNo], '') AS [CompanyPRNo]
    FROM [dbo].[tblReceipt]
    WHERE [tblReceipt].[TranId] = @TranId;


END;
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO