USE [LEASINGDB]
GO
/****** Object:  Trigger [dbo].[tr_tblReceipt]    Script Date: 3/25/2024 12:14:16 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER TRIGGER [dbo].[tr_tblReceipt]
ON [dbo].[tblReceipt]
FOR INSERT
AS
BEGIN

    UPDATE [dbo].[tblReceipt]
    SET [tblReceipt].[RcptID] = 'RCPT' + CONVERT([VARCHAR](5000), [Inserted].[RecId])
    FROM [dbo].[tblReceipt]
        INNER JOIN [Inserted]
            ON [Inserted].[RecId] = [tblReceipt].[RecId]
    WHERE [Inserted].[RecId] = [tblReceipt].[RecId]

END