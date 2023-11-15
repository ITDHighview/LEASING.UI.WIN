USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveFile]    Script Date: 11/9/2023 10:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_SaveFile]
    @FilePath NVARCHAR(MAX),
    @FileData VARBINARY(MAX),
	@ClientName VARCHAR(100),
	@FileNames VARCHAR(100),
	@Files VARCHAR(200),
	@Notes VARCHAR(500) = NULL
AS
BEGIN
    INSERT INTO Files (ClientName,FilePath, FileData,FileNames,Notes,Files)
    VALUES (@ClientName,@FilePath, @FileData,@FileNames,@Notes,@Files)

	--ADD Reference Id in file table for mapping
	--Update tblunitreference IsContractSigned
END
