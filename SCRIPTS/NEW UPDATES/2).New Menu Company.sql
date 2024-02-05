SET IDENTITY_INSERT [dbo].[tblFormControlsMaster] ON;
INSERT INTO [dbo].[tblFormControlsMaster]
(
    [ControlId],
    [FormId],
    [MenuId],
    [ControlName],
    [ControlDescription],
    [IsBackRoundControl],
    [IsHeaderControl],
    [IsDelete]
)
VALUES
(52, 1, 10, 'radMenuItemAddCompany', 'Company', 0, 0, 0);

SET IDENTITY_INSERT [dbo].[tblFormControlsMaster] OFF;

