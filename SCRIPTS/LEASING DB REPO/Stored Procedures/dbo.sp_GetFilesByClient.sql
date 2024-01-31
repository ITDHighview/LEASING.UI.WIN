SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_GetFilesByClient] @ClientName VARCHAR(50)
AS
    BEGIN
        SELECT
            [Files].[Id],
            [Files].[FilePath],
            [Files].[FileData],
            [Files].[FileNames],
            [Files].[Notes],
            [Files].[Files]
        FROM
            [dbo].[Files]
        WHERE
            [Files].[ClientName] = @ClientName;
    END;

GO
