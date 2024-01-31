SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SelectFloorTypes]
-- Add the parameters for the stored procedure here

AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        -- Insert statements for procedure here
        SELECT
            -1           AS [RecId],
            '--SELECT--' AS [FloorTypesDescription]
        UNION
        SELECT
            [tblFloorTypes].[RecId],
            [tblFloorTypes].[FloorTypesDescription]
        FROM
            [dbo].[tblFloorTypes];
    END;
GO
