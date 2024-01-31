SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetControlList]
AS
    BEGIN

        SET NOCOUNT ON;

        SELECT
                [tblFormControlsMaster].[ControlId],
                [tblFormControlsMaster].[FormId],
                [tblForm].[FormDescription],
                [tblFormControlsMaster].[MenuId],
                [tblMenu].[MenuName],
                [tblFormControlsMaster].[ControlName],
                [tblFormControlsMaster].[ControlDescription],
                IIF(ISNULL([tblFormControlsMaster].[IsBackRoundControl], 0) = 1, 'YES', 'NO') AS [IsBackRoundControl],
                IIF(ISNULL([tblFormControlsMaster].[IsHeaderControl], 0) = 1, 'YES', 'NO')    AS [IsHeaderControl],
                IIF(ISNULL([tblFormControlsMaster].[IsDelete], 0) = 0, 'ACTIVE', 'IN-ACTIVE') AS [Status]
        FROM
                [dbo].[tblFormControlsMaster]
            INNER JOIN
                [dbo].[tblForm]
                    ON [tblFormControlsMaster].[FormId] = [tblForm].[FormId]
            INNER JOIN
                [dbo].[tblMenu]
                    ON [tblFormControlsMaster].[MenuId] = [tblMenu].[MenuId];

    END;
GO
