USE [LEASINGDB]
ALTER TABLE [dbo].[tblUnitMstr]
ADD
    [IsNotRoundOff] BIT
UPDATE
    [dbo].[tblUnitMstr]
SET
    [tblUnitMstr].[IsNotRoundOff] = 1