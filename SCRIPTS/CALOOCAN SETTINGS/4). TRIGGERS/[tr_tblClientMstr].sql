USE [LEASINGDB]
GO
/****** Object:  Trigger [dbo].[tr_tblClientMstr]    Script Date: 3/25/2024 12:13:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER TRIGGER [dbo].[tr_tblClientMstr]
ON [dbo].[tblClientMstr]
FOR INSERT
AS
BEGIN

    UPDATE [dbo].[tblClientMstr]
    SET [tblClientMstr].[ClientID] = [tblClientMstr].[ClientType] + CONVERT([VARCHAR](5000), [Inserted].[RecId])
    FROM [dbo].[tblClientMstr]
        INNER JOIN [Inserted]
            ON [Inserted].[RecId] = [tblClientMstr].[RecId]
    WHERE [Inserted].[RecId] = [tblClientMstr].[RecId]

END