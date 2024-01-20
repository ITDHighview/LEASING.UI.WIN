--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [sp_UpdateORNumber]
    @RcptID AS VARCHAR(20) = NULL,
    @CompanyORNo AS VARCHAR(20) = NULL,
    @EncodedBy AS INT = NULL
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    UPDATE [dbo].[tblReceipt]
    SET [tblReceipt].[CompanyORNo] = @CompanyORNo,
        [tblReceipt].[EncodedBy] = @EncodedBy,
        [tblReceipt].[EncodedDate] = GETDATE()
    WHERE [tblReceipt].[RcptID] = @RcptID;
    UPDATE [dbo].[tblPaymentMode]
    SET [tblPaymentMode].[CompanyORNo] = @CompanyORNo
    WHERE [tblPaymentMode].[RcptID] = @RcptID;

    IF @@ROWCOUNT > 0
    BEGIN
        SELECT 'SUCCESS' AS Message_Code;

    END;
END;
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO


