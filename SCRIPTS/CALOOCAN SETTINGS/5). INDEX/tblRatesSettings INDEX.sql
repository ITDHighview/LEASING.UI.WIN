---[tblRatesSettings]---

CREATE INDEX [IdxtblRatesSettings_RecId]
    ON [dbo].[tblRatesSettings] ([RecId]);
CREATE INDEX [IdxtblRatesSettings_ProjectType]
    ON [dbo].[tblRatesSettings] ([ProjectType]);
CREATE INDEX [IdxtblRatesSettings_GenVat]
    ON [dbo].[tblRatesSettings] ([GenVat]);
CREATE INDEX [IdxtblRatesSettings_SecurityAndMaintenance]
    ON [dbo].[tblRatesSettings] ([SecurityAndMaintenance]);
CREATE INDEX [IdxtblRatesSettings_SecurityAndMaintenanceVat]
    ON [dbo].[tblRatesSettings] ([SecurityAndMaintenanceVat]);
CREATE INDEX [IdxtblRatesSettings_IsSecAndMaintVat]
    ON [dbo].[tblRatesSettings] ([IsSecAndMaintVat]);
CREATE INDEX [IdxtblRatesSettings_WithHoldingTax]
    ON [dbo].[tblRatesSettings] ([WithHoldingTax]);
CREATE INDEX [IdxtblRatesSettings_EncodedBy]
    ON [dbo].[tblRatesSettings] ([EncodedBy]);
CREATE INDEX [IdxtblRatesSettings_EncodedDate]
    ON [dbo].[tblRatesSettings] ([EncodedDate]);
CREATE INDEX [IdxtblRatesSettings_LastChangedBy]
    ON [dbo].[tblRatesSettings] ([LastChangedBy]);
CREATE INDEX [IdxtblRatesSettings_LastChangedDate]
    ON [dbo].[tblRatesSettings] ([LastChangedDate]);
CREATE INDEX [IdxtblRatesSettings_PenaltyPct]
    ON [dbo].[tblRatesSettings] ([PenaltyPct]);