---[tblPaymentMode]---

CREATE INDEX [IdxtblPaymentMode_RecId]
    ON [dbo].[tblPaymentMode] ([RecId]);
CREATE INDEX [IdxtblPaymentMode_RcptID]
    ON [dbo].[tblPaymentMode] ([RcptID]);
CREATE INDEX [IdxtblPaymentMode_CompanyORNo]
    ON [dbo].[tblPaymentMode] ([CompanyORNo]);
CREATE INDEX [IdxtblPaymentMode_REF]
    ON [dbo].[tblPaymentMode] ([REF]);
CREATE INDEX [IdxtblPaymentMode_BNK_ACCT_NAME]
    ON [dbo].[tblPaymentMode] ([BNK_ACCT_NAME]);
CREATE INDEX [IdxtblPaymentMode_BNK_ACCT_NUMBER]
    ON [dbo].[tblPaymentMode] ([BNK_ACCT_NUMBER]);
CREATE INDEX [IdxtblPaymentMode_BNK_NAME]
    ON [dbo].[tblPaymentMode] ([BNK_NAME]);
CREATE INDEX [IdxtblPaymentMode_SERIAL_NO]
    ON [dbo].[tblPaymentMode] ([SERIAL_NO]);
CREATE INDEX [IdxtblPaymentMode_ModeType]
    ON [dbo].[tblPaymentMode] ([ModeType]);
CREATE INDEX [IdxtblPaymentMode_CompanyPRNo]
    ON [dbo].[tblPaymentMode] ([CompanyPRNo]);
CREATE INDEX [IdxtblPaymentMode_BankBranch]
    ON [dbo].[tblPaymentMode] ([BankBranch]);
CREATE INDEX [IdxtblPaymentMode_ReceiptDate]
    ON [dbo].[tblPaymentMode] ([ReceiptDate]);