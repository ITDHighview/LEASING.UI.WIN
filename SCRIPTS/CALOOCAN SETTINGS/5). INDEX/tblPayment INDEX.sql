USE [LEASINGDB]
---[tblPayment]---

CREATE INDEX [IdxtblPayment_RecId]
    ON [dbo].[tblPayment] ([RecId]);
CREATE INDEX [IdxtblPayment_PayID]
    ON [dbo].[tblPayment] ([PayID]);
CREATE INDEX [IdxtblPayment_TranId]
    ON [dbo].[tblPayment] ([TranId]);
CREATE INDEX [IdxtblPayment_Amount]
    ON [dbo].[tblPayment] ([Amount]);
CREATE INDEX [IdxtblPayment_ForMonth]
    ON [dbo].[tblPayment] ([ForMonth]);
CREATE INDEX [IdxtblPayment_Remarks]
    ON [dbo].[tblPayment] ([Remarks]);
CREATE INDEX [IdxtblPayment_EncodedBy]
    ON [dbo].[tblPayment] ([EncodedBy]);
CREATE INDEX [IdxtblPayment_EncodedDate]
    ON [dbo].[tblPayment] ([EncodedDate]);
CREATE INDEX [IdxtblPayment_LastChangedBy]
    ON [dbo].[tblPayment] ([LastChangedBy]);
CREATE INDEX [IdxtblPayment_IsActive]
    ON [dbo].[tblPayment] ([IsActive]);
CREATE INDEX [IdxtblPayment_RefId]
    ON [dbo].[tblPayment] ([RefId]);
CREATE INDEX [IdxtblPayment_Notes]
    ON [dbo].[tblPayment] ([Notes]);
CREATE INDEX [IdxtblPayment_LedgeRecid]
    ON [dbo].[tblPayment] ([LedgeRecid]);