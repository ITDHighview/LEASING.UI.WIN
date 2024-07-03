USE [LEASINGDB]
---[tblCompany]---

CREATE INDEX [IdxtblCompany_RecId]
    ON [dbo].[tblCompany] ([RecId]);
CREATE INDEX [IdxtblCompany_Status]
    ON [dbo].[tblCompany] ([Status]);
CREATE INDEX [IdxtblCompany_EncodedBy]
    ON [dbo].[tblCompany] ([EncodedBy]);
CREATE INDEX [IdxtblCompany_EncodedDate]
    ON [dbo].[tblCompany] ([EncodedDate]);
CREATE INDEX [IdxtblCompany_LastChangedBy]
    ON [dbo].[tblCompany] ([LastChangedBy]);
CREATE INDEX [IdxtblCompany_LastChangedDate]
    ON [dbo].[tblCompany] ([LastChangedDate]);