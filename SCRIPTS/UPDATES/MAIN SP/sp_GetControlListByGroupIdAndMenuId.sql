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
--EXEC [sp_GetControlListByGroupIdAndMenuId] 1,2
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetControlListByGroupIdAndMenuId]
    @MenuId  INT = NULL,
    @GroupId INT = NULL
AS
    BEGIN

        SET NOCOUNT ON;

        SELECT  DISTINCT
                [tblFormControlsMaster].[ControlId],
                [tblMenu].[MenuName],
                [tblFormControlsMaster].[ControlName],
                [tblFormControlsMaster].[ControlDescription]
        FROM
                [dbo].[tblGroupFormControls]
            INNER JOIN
                [dbo].[tblFormControlsMaster]
                    ON [tblGroupFormControls].[FormId] = [tblFormControlsMaster].[FormId]
                       AND [tblGroupFormControls].[ControlId] = [tblFormControlsMaster].[ControlId]
            INNER JOIN
                [dbo].[tblMenu]
                    ON [tblFormControlsMaster].[MenuId] = [tblMenu].[MenuId]
        WHERE
                [tblGroupFormControls].[GroupId] = @GroupId
                AND [tblFormControlsMaster].[MenuId] = @MenuId
                AND ISNULL([tblFormControlsMaster].[IsBackRoundControl], 0) = 0;
    END;
