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
(49, 1, 12, 'radPanel10', 'PURCHASE ITEM MAIN PANEL', 0, 1, 0),
(50, 1, 12, 'radMenuItemPurchaseItem', 'PURCHASE ITEM HEADER MENU ITEM', 1, 0, 0),
(51, 1, 12, 'radMenuItemInformation', 'Item Information', 0, 0, 0);


SET IDENTITY_INSERT [dbo].[tblFormControlsMaster] OFF;

