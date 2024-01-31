SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SelectProject]
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        -- Insert statements for procedure here

        SELECT
            -1           AS [RecId],
            '--SELECT--' AS [ProjectName]
        UNION
        SELECT
            [tblProjectMstr].[RecId],
            [tblProjectMstr].[ProjectName]
        FROM
            [dbo].[tblProjectMstr]
        WHERE
            ISNULL([tblProjectMstr].[IsActive], 0) = 1;
    END;
GO
