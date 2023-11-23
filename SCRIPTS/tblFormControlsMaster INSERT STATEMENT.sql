


SET IDENTITY_INSERT	[dbo].[tblFormControlsMaster] ON
INSERT INTO [tblFormControlsMaster] ([ControlId], [FormId], [MenuId], [ControlName], [ControlDescription], [IsBackRoundControl], [IsHeaderControl], [IsDelete])
VALUES
( 1, 1, 1, 'radPanel2', '', 0, 1, 0 ),
( 2, 1, 1, 'radMenuItemClient', '', 1, 0, 0 ),
( 3, 1, 1, 'radMenuItemAddNewClient', '', 0, 0, 0 ),
( 4, 1, 1, 'radMenuItemClientInformation', '', 0, 0, 0 ),
( 5, 1, 4, 'radPanel3', 'CONTRACT MAIN PANEL', 0, 1, 0 ),
( 6, 1, 4, 'radMenuItemContracts', 'CONTRACT HEADER MENU ITEM', 1, 0, 0 ),
( 7, 1, 4, 'radMenuItemUnitContracts', 'Unit Contracts', 0, 0, 0 ),
( 8, 1, 4, 'radMenuItemContractSignedUnit', 'Contract Signed Unit', 0, 0, 0 ),
( 9, 1, 4, 'radMenuItemTenantMoveUnit', 'Tenant Move-In Unit', 0, 0, 0 ),
( 10, 1, 4, 'radMenuItemTenantMoveOutUnit', 'For Contract Closing', 0, 0, 0 ),
( 11, 1, 4, 'radMenuItemParkingContracts', 'Parking Contracts', 0, 0, 0 ),
( 12, 1, 4, 'radMenuItemContractSignedParking', 'Contract Signed Parking', 0, 0, 0 ),
( 13, 1, 4, 'radMenuItemTenantMoveParking', 'Tenant Move-In Parking', 0, 0, 0 ),
( 14, 1, 4, 'radMenuItemTenantMoveOutParking', 'For Contract Closing Parking', 0, 0, 0 ),
( 15, 1, 4, 'radMenuItemCloseContract', 'Close Contract', 0, 0, 0 ),
( 16, 1, 7, 'radPanel4', 'REPORTS MAIN PANEL', 0, 1, 0 ),
( 17, 1, 7, 'radMenuItemReports', 'REPORTS HEADER MENU ITEM', 1, 0, 0 ),
( 18, 1, 8, 'radPanel5', 'PAYMENTS MAIN PANEL', 0, 1, 0 ),
( 19, 1, 8, 'radMenuItemPayments', 'PAYMENTS HEADER MENU ITEM', 1, 0, 0 ),
( 20, 1, 8, 'radMenuItemTransactions', 'Transaction', 0, 0, 0 ),
( 21, 1, 8, 'radMenuItemLedger', 'Ledger', 0, 0, 0 ),
( 22, 1, 8, 'radMenuItemReciept', 'Reciept', 0, 0, 0 ),
( 23, 1, 9, 'radPanel6', 'COMPUTATION MAIN PANEL', 0, 1, 0 ),
( 24, 1, 9, 'radMenuItemComputation', 'COMPUTATION HEADER MENU ITEM', 1, 0, 0 ),
( 26, 1, 9, 'radMenuUnitComputation', 'Unit Computation', 0, 0, 0 ),
( 27, 1, 9, 'radMenuParkingComputation', 'Parking Computation', 0, 0, 0 ),
( 28, 1, 9, 'radMenuGenerateComputation', 'Generate Computation', 0, 0, 0 ),
( 29, 1, 9, 'radMenuItemGenerateComputationUnit2', 'UNIT', 0, 0, 0 ),
( 30, 1, 9, 'radMenuItemGenerateComputationParking2', 'PARKING', 0, 0, 0 ),
( 31, 1, 10, 'radPanel7', 'ADMINISTRATIVE MAIN PANEL', 0, 1, 0 ),
( 32, 1, 10, 'radMenuItemAdministrative', 'ADMINISTRATIVE HEADER MENU ITEM', 1, 0, 0 ),
( 33, 1, 10, 'radMenuItemAddNewLocation', 'Location', 0, 0, 0 ),
( 34, 1, 10, 'radMenuItemAddNewProject', 'Project', 0, 0, 0 ),
( 35, 1, 10, 'radMenuItemAddNewPurhcaseItem', 'Purchase Item', 0, 0, 0 ),
( 36, 1, 10, 'radMenuItemRates2', 'Rates', 0, 0, 0 ),
( 37, 1, 10, 'radMenuItemResidentialSettings2', 'RESIDENTIAL', 0, 0, 0 ),
( 38, 1, 10, 'radMenuItemCommercialSettings2', 'COMMERCIAL', 0, 0, 0 ),
( 39, 1, 10, 'radMenuItemWareHouseSettings2', 'WAREHOUSE', 0, 0, 0 ),
( 40, 1, 10, 'radMenuItemAddNewUnit', 'Units', 0, 0, 0 ),
( 41, 1, 10, 'radMenuItemBankName', 'Bank Name', 0, 0, 0 ),
( 42, 1, 11, 'radPanel9', 'SECURITY MAIN PANEL', 0, 1, 0 ),
( 43, 1, 11, 'radMenuItemSecurity', 'SECURITY HEADER MENU ITEM', 1, 0, 0 ),
( 44, 1, 11, 'radMenuItemUser', 'User', 0, 0, 0 ),
( 45, 1, 11, 'radMenuItemGroupSecurity', 'Group Permission', 0, 0, 0 ),
( 46, 1, 11, 'radMenuItemFormControls', 'Form Controls', 0, 0, 0 ),
( 47, 1, 11, 'radMenuItemSystemMenu', 'System Menu', 0, 0, 0 )



SET IDENTITY_INSERT	[dbo].[tblFormControlsMaster] OFF

