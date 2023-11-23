USE [LEASINGDB];
GO
/****** Object:  StoredProcedure [dbo].[sp_GetFilesByClient]    Script Date: 11/9/2023 9:58:18 PM ******/
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
ALTER PROCEDURE [dbo].[sp_GetFilesByClientAndReference]
    @ClientName  VARCHAR(50) = NULL,
    @ReferenceID VARCHAR(20) = NULL
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
            AND [Files].[RefId] = @ReferenceID;
    END;

