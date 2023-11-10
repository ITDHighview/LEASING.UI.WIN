USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteFile]    Script Date: 11/9/2023 9:55:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_DeleteFile]
    @FilePath NVARCHAR(500)
AS
BEGIN
    DELETE FROM Files
    WHERE FilePath = @FilePath;
END