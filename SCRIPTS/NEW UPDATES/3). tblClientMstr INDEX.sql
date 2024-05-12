---[tblClientMstr]---

CREATE INDEX [IdxtblClientMstr_RecId]
    ON [dbo].[tblClientMstr] ([RecId]);
CREATE INDEX [IdxtblClientMstr_ClientID]
    ON [dbo].[tblClientMstr] ([ClientID]);
CREATE INDEX [IdxtblClientMstr_EncodedBy]
    ON [dbo].[tblClientMstr] ([EncodedBy]);
CREATE INDEX [IdxtblClientMstr_EncodedDate]
    ON [dbo].[tblClientMstr] ([EncodedDate]);
CREATE INDEX [IdxtblClientMstr_LastChangedBy]
    ON [dbo].[tblClientMstr] ([LastChangedBy]);
CREATE INDEX [IdxtblClientMstr_LastChangedDate]
    ON [dbo].[tblClientMstr] ([LastChangedDate]);
CREATE INDEX [IdxtblClientMstr_IsActive]
    ON [dbo].[tblClientMstr] ([IsActive]);