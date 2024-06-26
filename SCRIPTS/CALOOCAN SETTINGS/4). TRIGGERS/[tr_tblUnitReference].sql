USE [LEASINGDB]
GO
/****** Object:  Trigger [dbo].[tr_tblUnitReference]    Script Date: 3/25/2024 12:14:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER TRIGGER [dbo].[tr_tblUnitReference]
ON [dbo].[tblUnitReference]
FOR INSERT
AS
BEGIN

    UPDATE [dbo].[tblUnitReference]
    SET [tblUnitReference].[RefId] = 'REF' + CONVERT([VARCHAR](5000), [Inserted].[RecId])
    FROM [dbo].[tblUnitReference]
        INNER JOIN [Inserted]
            ON [Inserted].[RecId] = [tblUnitReference].[RecId]
    WHERE [Inserted].[RecId] = [tblUnitReference].[RecId]

END