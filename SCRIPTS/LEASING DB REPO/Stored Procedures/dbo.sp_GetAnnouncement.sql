SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_GetAnnouncement]
AS
BEGIN
    SELECT ISNULL([tblAnnouncement].[AnnounceMessage], '') AS [AnnounceMessage]
    FROM [dbo].[tblAnnouncement]

END
GO
