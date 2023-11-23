USE [LEASINGDB];
GO
/****** Object:  StoredProcedure [dbo].[sp_getControlPermission_Debug]    Script Date: 11/21/2023 3:32:32 AM ******/
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetGroupList]
AS
    BEGIN

        SET NOCOUNT ON;

        SELECT
            [tblGroup].[GroupId],
            [tblGroup].[GroupName],
            [tblGroup].[IsDelete]
        FROM
            [dbo].[tblGroup];

    END;
