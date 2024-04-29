SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
	EXEC [pr_BlankAllTransactionRecords]
*/
CREATE   PROC [dbo].[pr_BlankAllTransactionRecords]
AS
    BEGIN

        DELETE FROM
        [dbo].[tblRecieptReport]
        DBCC CHECKIDENT('[tblRecieptReport]', RESEED, 0);

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













GO
