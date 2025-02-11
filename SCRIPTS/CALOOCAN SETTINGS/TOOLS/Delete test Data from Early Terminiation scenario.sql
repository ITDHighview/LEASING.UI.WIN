USE [LEASINGDB]

-------/*Declare your Contract Number*/----------
DECLARE @ContractID VARCHAR(1000)= 'REF10000000'

--------------------------------------------/*For DATA Review*/-------------------------------------------

---------------------------------------------/*Contract*/--------------------------------------------------
--SELECT * FROM [dbo].[tblUnitReference] WHERE [tblUnitReference].[RefId] = @ContractID

---------------------------------------------/*Ledger*/----------------------------------------------------
--SELECT * FROM [dbo].[tblMonthLedger] WHERE [tblMonthLedger].[ReferenceID] = SUBSTRING(@ContractID,4,8)

---------------------------------------------/*Advance Month*/---------------------------------------------
--SELECT * FROM [dbo].[tblAdvancePayment] WHERE [tblAdvancePayment].[RefId] = @ContractID

---------------------------------------------/*Payment - Transaction*/-------------------------------------
--SELECT * FROM [dbo].[tblTransaction] WHERE [tblTransaction].[RefId] = @ContractID
--SELECT * FROM [dbo].[tblPayment] WHERE [tblPayment].[TranId] = (SELECT [tblTransaction].[TranID] FROM [dbo].[tblTransaction] WHERE [tblTransaction].[RefId] = @ContractID)
--SELECT * FROM [dbo].[tblReceipt] WHERE [tblReceipt].[TranId] =  (SELECT [tblTransaction].[TranID] FROM [dbo].[tblTransaction] WHERE [tblTransaction].[RefId] = @ContractID)
--SELECT
--    *
--FROM
--    [dbo].[tblPaymentMode]
--WHERE
--    [tblPaymentMode].[RcptID] =
--    (
--        SELECT
--            [tblReceipt].[RcptID]
--        FROM
--            [dbo].[tblReceipt]
--        WHERE
--            [tblReceipt].[TranId] =
--            (
--                SELECT
--                    [tblTransaction].[TranID]
--                FROM
--                    [dbo].[tblTransaction]
--                WHERE
--                    [tblTransaction].[RefId] = @ContractID
--            )
--    )


-------/*Declare your Contract Number*/----------
DECLARE @DeleteContractID VARCHAR(1000)= 'REF10000000'
--------------------------------------------/*Delete All test Data*/--------------------------------------------

---------------------------------------------/*Contract*/--------------------------------------------------
--DELETE FROM [dbo].[tblUnitReference] WHERE [tblUnitReference].[RefId] = @DeleteContractID

---------------------------------------------/*Ledger*/----------------------------------------------------
--DELETE FROM [dbo].[tblMonthLedger] WHERE [tblMonthLedger].[ReferenceID] = SUBSTRING(@DeleteContractID,4,8)

---------------------------------------------/*Advance Month*/---------------------------------------------
--DELETE FROM  [dbo].[tblAdvancePayment] WHERE [tblAdvancePayment].[RefId] = @DeleteContractID

---------------------------------------------/*Payment - Transaction*/-------------------------------------
--DELETE FROM  [dbo].[tblTransaction] WHERE [tblTransaction].[RefId] = @DeleteContractID
--DELETE FROM [dbo].[tblPayment] WHERE [tblPayment].[TranId] = (SELECT [tblTransaction].[TranID] FROM [dbo].[tblTransaction] WHERE [tblTransaction].[RefId] = @DeleteContractID)
--DELETE FROM  [dbo].[tblReceipt] WHERE [tblReceipt].[TranId] =  (SELECT [tblTransaction].[TranID] FROM [dbo].[tblTransaction] WHERE [tblTransaction].[RefId] = @DeleteContractID)

--DELETE FROM
--    [dbo].[tblPaymentMode]
--WHERE
--    [tblPaymentMode].[RcptID] =
--    (
--        SELECT
--            [tblReceipt].[RcptID]
--        FROM
--            [dbo].[tblReceipt]
--        WHERE
--            [tblReceipt].[TranId] =
--            (
--                SELECT
--                    [tblTransaction].[TranID]
--                FROM
--                    [dbo].[tblTransaction]
--                WHERE
--                    [tblTransaction].[RefId] = @DeleteContractID
--            )
--    )