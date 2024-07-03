USE [LEASINGDB]
---[tblLocationMstr]---

CREATE INDEX [IdxtblLocationMstr_RecId]
    ON [dbo].[tblLocationMstr] ([RecId]);
CREATE INDEX [IdxtblLocationMstr_Descriptions]
    ON [dbo].[tblLocationMstr] ([Descriptions]);
CREATE INDEX [IdxtblLocationMstr_LocAddress]
    ON [dbo].[tblLocationMstr] ([LocAddress]);
CREATE INDEX [IdxtblLocationMstr_IsActive]
    ON [dbo].[tblLocationMstr] ([IsActive]);