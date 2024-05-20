USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[pr_BlankAllTransactionRecords]    Script Date: 5/20/2024 2:42:58 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*
	EXEC [pr_BlankAllTransactionRecords]
*/
CREATE OR ALTER PROC [dbo].[pr_BlankAllTransactionRecords]
AS
    BEGIN


        DELETE FROM
        [dbo].[tblUnitReference]
        DBCC CHECKIDENT('[tblUnitReference]', RESEED, 0);

        DELETE FROM
        [dbo].[tblTransaction]
        DBCC CHECKIDENT('[tblTransaction]', RESEED, 0);

        DELETE FROM
        [dbo].[tblMonthLedger]
        DBCC CHECKIDENT('[tblMonthLedger]', RESEED, 0);

        DELETE FROM
        [dbo].[tblReceipt]
        DBCC CHECKIDENT('[tblReceipt]', RESEED, 0);

        DELETE FROM
        [dbo].[tblPayment]
        DBCC CHECKIDENT('[tblPayment]', RESEED, 0);

        DELETE FROM
        [dbo].[tblAdvancePayment]
        DBCC CHECKIDENT('[tblAdvancePayment]', RESEED, 0);

        DELETE FROM
        [dbo].[tblPaymentMode]
        DBCC CHECKIDENT('[tblPaymentMode]', RESEED, 0);

        DELETE FROM
        [dbo].[LoggingEvent]
        DBCC CHECKIDENT('[LoggingEvent]', RESEED, 0);

        DELETE FROM
        [dbo].[ErrorLog]
        DBCC CHECKIDENT('[ErrorLog]', RESEED, 0);

        UPDATE
            [dbo].[tblUnitMstr]
        SET
            [tblUnitMstr].[UnitStatus] = 'VACANT'
    END













