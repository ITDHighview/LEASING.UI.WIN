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
--EXEC [sp_GetFormListByGroupId] 2
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetFormListByGroupId] @GroupId INT = NULL
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
