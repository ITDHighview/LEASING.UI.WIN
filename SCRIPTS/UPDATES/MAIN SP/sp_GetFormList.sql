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
ALTER PROCEDURE [dbo].[sp_GetFormList]
AS
    BEGIN

        SET NOCOUNT ON;

        SELECT
            [tblForm].[FormId],
            [tblForm].[MenuId],
            [tblForm].[FormName],
            [tblForm].[FormDescription],
            [tblForm].[IsDelete]
        FROM
            [dbo].[tblForm];
    END;
