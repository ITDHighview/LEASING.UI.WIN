USE [LEASINGDB]
---[tblTransaction]---

CREATE INDEX [IdxtblTransaction_RecId]
    ON [dbo].[tblTransaction] ([RecId]);
CREATE INDEX [IdxtblTransaction_TranID]
    ON [dbo].[tblTransaction] ([TranID]);
CREATE INDEX [IdxtblTransaction_RefId]
    ON [dbo].[tblTransaction] ([RefId]);
CREATE INDEX [IdxtblTransaction_PaidAmount]
    ON [dbo].[tblTransaction] ([PaidAmount]);
CREATE INDEX [IdxtblTransaction_ReceiveAmount]
    ON [dbo].[tblTransaction] ([ReceiveAmount]);
CREATE INDEX [IdxtblTransaction_ChangeAmount]
    ON [dbo].[tblTransaction] ([ChangeAmount]);
CREATE INDEX [IdxtblTransaction_Remarks]
    ON [dbo].[tblTransaction] ([Remarks]);
CREATE INDEX [IdxtblTransaction_EncodedBy]
    ON [dbo].[tblTransaction] ([EncodedBy]);
CREATE INDEX [IdxtblTransaction_EncodedDate]
    ON [dbo].[tblTransaction] ([EncodedDate]);
CREATE INDEX [IdxtblTransaction_LastChangedBy]
    ON [dbo].[tblTransaction] ([LastChangedBy]);
CREATE INDEX [IdxtblTransaction_LastChangedDate]
    ON [dbo].[tblTransaction] ([LastChangedDate]);
CREATE INDEX [IdxtblTransaction_IsActive]
    ON [dbo].[tblTransaction] ([IsActive]);
CREATE INDEX [IdxtblTransaction_ActualAmountPaid]
    ON [dbo].[tblTransaction] ([ActualAmountPaid]);