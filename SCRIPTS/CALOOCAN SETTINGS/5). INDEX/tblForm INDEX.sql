USE [LEASINGDB]
---[tblForm]---

CREATE INDEX [IdxtblForm_FormId]
    ON [dbo].[tblForm] ([FormId]);
CREATE INDEX [IdxtblForm_MenuId]
    ON [dbo].[tblForm] ([MenuId]);
CREATE INDEX [IdxtblForm_FormName]
    ON [dbo].[tblForm] ([FormName]);
CREATE INDEX [IdxtblForm_FormDescription]
    ON [dbo].[tblForm] ([FormDescription]);
CREATE INDEX [IdxtblForm_IsDelete]
    ON [dbo].[tblForm] ([IsDelete]);