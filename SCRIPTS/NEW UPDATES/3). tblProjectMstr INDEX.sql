---[tblProjectMstr]---

CREATE INDEX [IdxtblProjectMstr_RecId]
    ON [dbo].[tblProjectMstr] ([RecId]);
CREATE INDEX [IdxtblProjectMstr_LocId]
    ON [dbo].[tblProjectMstr] ([LocId]);
CREATE INDEX [IdxtblProjectMstr_ProjectName]
    ON [dbo].[tblProjectMstr] ([ProjectName]);
CREATE INDEX [IdxtblProjectMstr_Descriptions]
    ON [dbo].[tblProjectMstr] ([Descriptions]);
CREATE INDEX [IdxtblProjectMstr_IsActive]
    ON [dbo].[tblProjectMstr] ([IsActive]);
CREATE INDEX [IdxtblProjectMstr_ProjectAddress]
    ON [dbo].[tblProjectMstr] ([ProjectAddress]);
CREATE INDEX [IdxtblProjectMstr_ProjectType]
    ON [dbo].[tblProjectMstr] ([ProjectType]);
CREATE INDEX [IdxtblProjectMstr_CompanyId]
    ON [dbo].[tblProjectMstr] ([CompanyId]);