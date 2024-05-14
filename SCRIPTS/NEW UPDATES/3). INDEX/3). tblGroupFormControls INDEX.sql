---[tblGroupFormControls]---

CREATE INDEX [IdxtblGroupFormControls_GroupControlId]
    ON [dbo].[tblGroupFormControls] ([GroupControlId]);
CREATE INDEX [IdxtblGroupFormControls_FormId]
    ON [dbo].[tblGroupFormControls] ([FormId]);
CREATE INDEX [IdxtblGroupFormControls_ControlId]
    ON [dbo].[tblGroupFormControls] ([ControlId]);
CREATE INDEX [IdxtblGroupFormControls_GroupId]
    ON [dbo].[tblGroupFormControls] ([GroupId]);
CREATE INDEX [IdxtblGroupFormControls_IsVisible]
    ON [dbo].[tblGroupFormControls] ([IsVisible]);
CREATE INDEX [IdxtblGroupFormControls_IsDelete]
    ON [dbo].[tblGroupFormControls] ([IsDelete]);