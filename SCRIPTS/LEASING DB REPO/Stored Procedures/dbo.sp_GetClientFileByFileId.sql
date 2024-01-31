SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_GetClientFileByFileId]
    @ClientName VARCHAR(50),
    @Id         INT
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
            [Files].[ClientName] = @ClientName
            AND [Files].[Id] = @Id;
    END;


GO
