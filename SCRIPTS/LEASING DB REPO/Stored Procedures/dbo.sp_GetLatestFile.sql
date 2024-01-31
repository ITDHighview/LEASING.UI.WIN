SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_GetLatestFile]
AS
    BEGIN
        SELECT TOP 1
               [Files].[FilePath],
               [Files].[FileData]
        FROM
               [dbo].[Files]
        ORDER BY
               [Files].[Id] DESC;
    END;
GO
