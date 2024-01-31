SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SelectLocation]
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        -- Insert statements for procedure here
        SELECT
            [tblLocationMstr].[RecId],
            [tblLocationMstr].[Descriptions]
        FROM
            [dbo].[tblLocationMstr]
        UNION
        SELECT
            -1,
            '--SELECT--';
    END;
GO
