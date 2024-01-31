SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetFormList]
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
GO
