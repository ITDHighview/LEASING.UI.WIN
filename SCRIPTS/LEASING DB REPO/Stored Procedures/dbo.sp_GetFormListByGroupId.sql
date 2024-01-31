SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC [sp_GetFormListByGroupId] 2
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetFormListByGroupId] @GroupId INT = NULL
AS
    BEGIN

        SET NOCOUNT ON;

        SELECT  DISTINCT
                [tblGroupFormControls].[FormId],
                [tblForm].[FormDescription]
        FROM
                [dbo].[tblGroupFormControls]
            INNER JOIN
                [dbo].[tblForm]
                    ON [tblGroupFormControls].[FormId] = [tblForm].[FormId]
        WHERE
                [tblGroupFormControls].[GroupId] = @GroupId;

    END;
GO
