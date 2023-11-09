INSERT INTO tblRatesSettings
(
    ProjectType,
    GenVat,
    SecurityAndMaintenance,
    SecurityAndMaintenanceVat,
    IsSecAndMaintVat,
    WithHoldingTax,
    EncodedBy,
    EncodedDate,
    ComputerName
)
VALUES
('RESIDENTIAL', 0, 0, 0, 0, 0, 1, GETDATE(), HOST_NAME())
INSERT INTO tblRatesSettings
(
    ProjectType,
    GenVat,
    SecurityAndMaintenance,
    SecurityAndMaintenanceVat,
    IsSecAndMaintVat,
    WithHoldingTax,
    EncodedBy,
    EncodedDate,
    ComputerName
)
VALUES
('COMMERCIAL', 0, 0, 0, 0, 0, 1, GETDATE(), HOST_NAME())
INSERT INTO tblRatesSettings
(
    ProjectType,
    GenVat,
    SecurityAndMaintenance,
    SecurityAndMaintenanceVat,
    IsSecAndMaintVat,
    WithHoldingTax,
    EncodedBy,
    EncodedDate,
    ComputerName
)
VALUES
('WAREHOUSE', 0, 0, 0, 0, 0, 1, GETDATE(), HOST_NAME())