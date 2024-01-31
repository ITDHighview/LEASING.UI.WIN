SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_GetUserGroupList]
  

AS
BEGIN
    SET NOCOUNT ON

	SELECT [tblGroup].[GroupId],
       [tblGroup].[GroupName],
       [tblGroup].[IsDelete]
FROM [dbo].[tblGroup];

END
GO
