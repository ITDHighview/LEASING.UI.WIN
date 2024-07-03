USE [LEASINGDB]
---[tblPermission]---

CREATE INDEX [IdxtblPermission_PermissionId]
    ON [dbo].[tblPermission] ([PermissionId]);
CREATE INDEX [IdxtblPermission_GroupId]
    ON [dbo].[tblPermission] ([GroupId]);
CREATE INDEX [IdxtblPermission_IsCLIENT]
    ON [dbo].[tblPermission] ([IsCLIENT]);
CREATE INDEX [IdxtblPermission_IsAdd_New_CLient]
    ON [dbo].[tblPermission] ([IsAdd_New_CLient]);
CREATE INDEX [IdxtblPermission_IsClient_Information]
    ON [dbo].[tblPermission] ([IsClient_Information]);
CREATE INDEX [IdxtblPermission_IsCONTRACTS]
    ON [dbo].[tblPermission] ([IsCONTRACTS]);
CREATE INDEX [IdxtblPermission_IsUnit_Contracts]
    ON [dbo].[tblPermission] ([IsUnit_Contracts]);
CREATE INDEX [IdxtblPermission_IsParking_Contracts]
    ON [dbo].[tblPermission] ([IsParking_Contracts]);
CREATE INDEX [IdxtblPermission_IsDelete]
    ON [dbo].[tblPermission] ([IsDelete]);