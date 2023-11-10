USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetClientFileByFileId]    Script Date: 11/9/2023 9:56:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_GetClientFileByFileId]
    @ClientName VARCHAR(50),
	@Id INT
AS
BEGIN
    SELECT Id,FilePath, FileData,FileNames,Notes,Files
    FROM Files
    WHERE ClientName = @ClientName and Id = @Id
END



--TRUNCATE TABLE Files
SELECT * FROM Files

