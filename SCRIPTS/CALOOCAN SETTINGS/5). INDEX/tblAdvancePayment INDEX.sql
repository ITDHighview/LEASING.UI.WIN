USE [LEASINGDB]
---[tblAdvancePayment]---

CREATE INDEX [IdxtblAdvancePayment_RecId]
    ON [dbo].[tblAdvancePayment] ([RecId]);
CREATE INDEX [IdxtblAdvancePayment_RefId]
    ON [dbo].[tblAdvancePayment] ([RefId]);
CREATE INDEX [IdxtblAdvancePayment_Months]
    ON [dbo].[tblAdvancePayment] ([Months]);
CREATE INDEX [IdxtblAdvancePayment_Amount]
    ON [dbo].[tblAdvancePayment] ([Amount]);