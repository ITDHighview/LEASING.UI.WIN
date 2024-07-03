USE [LEASINGDB]
---[tblGroup]---

CREATE INDEX [IdxtblGroup_GroupId]
    ON [dbo].[tblGroup] ([GroupId]);

CREATE INDEX [IdxtblGroup_GroupName]
    ON [dbo].[tblGroup] ([GroupName]);
CREATE INDEX [IdxtblGroup_IsDelete]
    ON [dbo].[tblGroup] ([IsDelete]);