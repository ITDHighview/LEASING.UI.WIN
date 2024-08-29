SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC [sp_getControlPermission] 1
-- =============================================
CREATE   PROCEDURE [dbo].[sp_getSpecialControlPermission] @UserId INT = NULL
-- Add the parameters for the stored procedure here

AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        -- Insert statements for procedure here
        SELECT
                [tblForm].[FormName],
                [tblFormSpecialControlsMaster].[ControlName]          AS [ControlName],
                ISNULL([tblUserFormControls].[IsVisible], 0) AS [Permission]
        FROM
                [dbo].[tblUserFormControls]
            INNER JOIN
                [dbo].[tblFormSpecialControlsMaster]
                    ON [tblUserFormControls].[ControlId] = [tblFormSpecialControlsMaster].[ControlId]
            INNER JOIN
                [dbo].[tblForm]
                    ON [tblFormSpecialControlsMaster].[FormId] = [tblForm].[FormId]
        WHERE
                ISNULL([tblFormSpecialControlsMaster].[IsBackRoundControl], 0) = 0
                AND [tblUserFormControls].[UserId] = @UserId;
    END;
GO
