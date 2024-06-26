USE [LEASINGDB]
GO
/****** Object:  Trigger [dbo].[tr_tblPayment]    Script Date: 5/13/2024 5:27:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER TRIGGER [dbo].[tr_tblProjPurchItem]
ON [dbo].[tblProjPurchItem]
FOR INSERT
AS
BEGIN

    UPDATE [dbo].[tblProjPurchItem]
    SET [tblProjPurchItem].[PurchItemID] = 'PURCH' + CONVERT([VARCHAR](5000), [Inserted].[RecId])
    FROM [dbo].[tblProjPurchItem]
        INNER JOIN [Inserted]
            ON [Inserted].[RecId] = [tblProjPurchItem].[RecId]
    WHERE [Inserted].[RecId] = [tblProjPurchItem].[RecId]

END