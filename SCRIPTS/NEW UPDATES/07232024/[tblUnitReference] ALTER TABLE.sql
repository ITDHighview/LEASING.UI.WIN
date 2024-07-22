USE [LEASINGDB]

ALTER TABLE [dbo].[tblUnitReference]
ADD
    [DiscountAmount] DECIMAL(18, 2),
    [IsDiscounted] BIT