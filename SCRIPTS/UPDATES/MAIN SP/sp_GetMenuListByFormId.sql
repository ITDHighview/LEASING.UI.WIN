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
--EXEC [sp_GetMenuListByFormId] 1
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetMenuListByFormId] @FormId INT = NULL
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
