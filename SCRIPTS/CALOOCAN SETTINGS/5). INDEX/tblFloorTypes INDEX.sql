USE [LEASINGDB]
---[tblFloorTypes]---

CREATE INDEX [IdxtblFloorTypes_RecId]
    ON [dbo].[tblFloorTypes] ([RecId]);
CREATE INDEX [IdxtblFloorTypes_IsActive]
    ON [dbo].[tblFloorTypes] ([IsActive]);