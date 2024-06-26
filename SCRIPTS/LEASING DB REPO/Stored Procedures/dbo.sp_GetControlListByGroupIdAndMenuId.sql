SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC [sp_GetControlListByGroupIdAndMenuId] 1,2
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetControlListByGroupIdAndMenuId]
    @MenuId  INT = NULL,
    @GroupId INT = NULL
AS
    BEGIN

        SET NOCOUNT ON;

        SELECT  DISTINCT
                [tblFormControlsMaster].[ControlId],
                [tblMenu].[MenuName],
                [tblFormControlsMaster].[ControlName],
                [tblFormControlsMaster].[ControlDescription],
                IIF(ISNULL([tblGroupFormControls].[IsVisible], 0) = 1, 'YES', 'NO') AS [IsVisible]
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
GO
