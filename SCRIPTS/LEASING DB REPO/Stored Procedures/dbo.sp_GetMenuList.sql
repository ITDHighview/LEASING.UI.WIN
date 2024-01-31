SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetMenuList]
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
GO
