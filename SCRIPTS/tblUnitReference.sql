ALTER TABLE tblUnitReference ADD HeaderRefId varchar(50),IsSignedContract BIT,IsUnitMove BIT
ALTER TABLE tblUnitReference ADD IsTerminated BIT
ALTER TABLE tblUnitReference ADD GenVat DECIMAL(18,2),WithHoldingTax DECIMAL(18,2)
ALTER TABLE  tblUnitReference ADD IsUnitMoveOut BIT 
ALTER TABLE  tblUnitReference ADD FirstPaymentDate DATETIME,ContactDoneDate DATETIME, SignedContractDate DATETIME, UnitMoveInDate DATETIME, UnitMoveOutDate DATETIME,TerminationDate DATETIME 

