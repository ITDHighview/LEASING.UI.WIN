USE [LEASINGDB]
---[tblProjectType]---

CREATE INDEX [IdxtblProjectType_RecId]
    ON [dbo].[tblProjectType] ([Recid]);
CREATE INDEX [IdxtblProjectType_ProjectTypeName]
    ON [dbo].[tblProjectType] ([ProjectTypeName]);