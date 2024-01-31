SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC [sp_GetMenuListByFormId] 1
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetMenuListByFormId] @FormId INT = NULL
AS
    BEGIN

        SET NOCOUNT ON;

        SELECT  DISTINCT
                [tblFormControlsMaster].[MenuId],
                [tblMenu].[MenuName]
        FROM
                [dbo].[tblFormControlsMaster]
            INNER JOIN
                [dbo].[tblMenu]
                    ON [tblFormControlsMaster].[MenuId] = [tblMenu].[MenuId]
        WHERE
                [tblFormControlsMaster].[FormId] = @FormId;

    END;
GO
