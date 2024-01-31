SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetProjectTypeById] @RecId INT = NULL
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        -- Insert statements for procedure here

        SELECT
            [tblProjectMstr].[ProjectType]
        FROM
            [dbo].[tblProjectMstr]
        WHERE
            [tblProjectMstr].[RecId] = @RecId
            AND ISNULL([tblProjectMstr].[IsActive], 0) = 1;
    END;
GO
