---[tblFormControlsMaster]---

CREATE INDEX [IdxtblFormControlsMaster_ControlId]
    ON [dbo].[tblFormControlsMaster] ([ControlId]);
CREATE INDEX [IdxtblFormControlsMaster_FormId]
    ON [dbo].[tblFormControlsMaster] ([FormId]);
CREATE INDEX [IdxtblFormControlsMaster_MenuId]
    ON [dbo].[tblFormControlsMaster] ([MenuId]);
CREATE INDEX [IdxtblFormControlsMaster_ControlName]
    ON [dbo].[tblFormControlsMaster] ([ControlName]);
CREATE INDEX [IdxtblFormControlsMaster_ControlDescription]
    ON [dbo].[tblFormControlsMaster] ([ControlDescription]);
CREATE INDEX [IdxtblFormControlsMaster_IsBackRoundControl]
    ON [dbo].[tblFormControlsMaster] ([IsBackRoundControl]);
CREATE INDEX [IdxtblFormControlsMaster_IsHeaderControl]
    ON [dbo].[tblFormControlsMaster] ([IsHeaderControl]);
CREATE INDEX [IdxtblFormControlsMaster_IsDelete]
    ON [dbo].[tblFormControlsMaster] ([IsDelete]);