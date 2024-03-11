-----------LOCATION MASTER--------------------------------------
CREATE INDEX [IX_tblLocationMstr_RecId]
ON [dbo].[tblLocationMstr] ([RecId]);
CREATE INDEX [IX_tblLocationMstr_Descriptions]
ON [dbo].[tblLocationMstr] ([Descriptions]);
CREATE INDEX [IX_tblLocationMstr_LocAddress]
ON [dbo].[tblLocationMstr] ([LocAddress]);
CREATE INDEX [IX_tblLocationMstr_IsActive]
ON [dbo].[tblLocationMstr] ([IsActive]);
-----------PROJECT MASTER--------------------------------------
CREATE INDEX [IX_tblProjectMstr_RecId]
ON [dbo].[tblProjectMstr] ([RecId]);
CREATE INDEX [IX_tblProjectMstr_LocId]
ON [dbo].[tblProjectMstr] ([LocId]);
CREATE INDEX [IX_tblProjectMstr_ProjectName]
ON [dbo].[tblProjectMstr] ([ProjectName]);
CREATE INDEX [IX_tblProjectMstr_Descriptions]
ON [dbo].[tblProjectMstr] ([Descriptions]);
CREATE INDEX [IX_tblProjectMstr_IsActive]
ON [dbo].[tblProjectMstr] ([IsActive]);
CREATE INDEX [IX_tblProjectMstr_ProjectAddress]
ON [dbo].[tblProjectMstr] ([ProjectAddress]);
CREATE INDEX [IX_tblProjectMstr_ProjectType]
ON [dbo].[tblProjectMstr] ([ProjectType]);
CREATE INDEX [IX_tblProjectMstr_CompanyId]
ON [dbo].[tblProjectMstr] ([CompanyId]);
-----------COMPANY MASTER--------------------------------------
CREATE INDEX [IX_tblCompany_RecId]
ON [dbo].[tblCompany] ([RecId]);
CREATE INDEX [IX_tblCompany_CompanyName]
ON [dbo].[tblCompany] ([CompanyName]);
CREATE INDEX [IX_tblCompany_CompanyAddress]
ON [dbo].[tblCompany] ([CompanyAddress]);
CREATE INDEX [IX_tblCompany_CompanyTIN]
ON [dbo].[tblCompany] ([CompanyTIN]);
CREATE INDEX [IX_tblCompany_CompanyOwnerName]
ON [dbo].[tblCompany] ([CompanyOwnerName]);
CREATE INDEX [IX_tblCompany_Status]
ON [dbo].[tblCompany] ([Status]);
CREATE INDEX [IX_tblCompany_EncodedBy]
ON [dbo].[tblCompany] ([EncodedBy]);
CREATE INDEX [IX_tblCompany_EncodedDate]
ON [dbo].[tblCompany] ([EncodedDate]);
CREATE INDEX [IX_tblCompany_LastChangedBy]
ON [dbo].[tblCompany] ([LastChangedBy]);
CREATE INDEX [IX_tblCompany_LastChangedDate]
ON [dbo].[tblCompany] ([LastChangedDate]);