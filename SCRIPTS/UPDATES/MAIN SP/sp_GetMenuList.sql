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
ALTER PROCEDURE [dbo].[sp_GetMenuList]
AS
    BEGIN

        SET NOCOUNT ON;

        SELECT
            [tblMenu].[MenuId],
            [tblMenu].[MenuHeaderId],
            [tblMenu].[MenuName],
            [tblMenu].[MenuNameDescription],
            [tblMenu].[IsDelete]
        FROM
            [dbo].[tblMenu]
        WHERE
            ISNULL([tblMenu].[MenuHeaderId], 0) = 0;

    END;
