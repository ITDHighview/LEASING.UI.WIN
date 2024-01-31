SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetSelecClient]
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;
        SELECT
            -1           AS [RecId],
            '--SELECT--' AS [ClientName]
        UNION
        SELECT
            [tblClientMstr].[RecId],
            ISNULL([tblClientMstr].[ClientName], '') AS [ClientName]
        FROM
            [dbo].[tblClientMstr] WITH (NOLOCK)
        WHERE
            ISNULL([tblClientMstr].[IsMap], 0) = 0;
    END;
GO
