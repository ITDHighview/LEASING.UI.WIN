---[tblMenu]---

CREATE INDEX [IdxtblMenu_MenuId]
    ON [dbo].[tblMenu] ([MenuId]);
CREATE INDEX [IdxtblMenu_MenuHeaderId]
    ON [dbo].[tblMenu] ([MenuHeaderId]);
CREATE INDEX [IdxtblMenu_MenuName]
    ON [dbo].[tblMenu] ([MenuName]);
CREATE INDEX [IdxtblMenu_MenuNameDescription]
    ON [dbo].[tblMenu] ([MenuNameDescription]);
CREATE INDEX [IdxtblMenu_IsDelete]
    ON [dbo].[tblMenu] ([IsDelete]);