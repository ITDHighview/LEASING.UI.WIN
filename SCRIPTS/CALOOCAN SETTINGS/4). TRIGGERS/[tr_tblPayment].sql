USE [LEASINGDB]
GO
/****** Object:  Trigger [dbo].[tr_tblPayment]    Script Date: 3/25/2024 12:13:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER TRIGGER [dbo].[tr_tblPayment]
ON [dbo].[tblPayment]
FOR INSERT
AS
BEGIN

    UPDATE [dbo].[tblPayment]
    SET [tblPayment].[PayID] = 'PAY' + CONVERT([VARCHAR](5000), [Inserted].[RecId])
    FROM [dbo].[tblPayment]
        INNER JOIN [Inserted]
            ON [Inserted].[RecId] = [tblPayment].[RecId]
    WHERE [Inserted].[RecId] = [tblPayment].[RecId]

END