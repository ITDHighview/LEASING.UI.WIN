SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SaveProject]
    @ProjectType VARCHAR(50) = NULL,
    @LocId INT = NULL,
    @ProjectName VARCHAR(50) = NULL,
    @Descriptions VARCHAR(50) = NULL,
    @ProjectAddress VARCHAR(500) = NULL,
    @CompanyId INT = NULL
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here

    IF NOT EXISTS
    (
        SELECT [tblProjectMstr].[ProjectName]
        FROM [dbo].[tblProjectMstr]
        WHERE [tblProjectMstr].[ProjectName] = @ProjectName
    )
    BEGIN
        INSERT INTO [dbo].[tblProjectMstr]
        (
            [ProjectType],
            [LocId],
            [ProjectName],
            [Descriptions],
            [ProjectAddress],
            [IsActive],
            [CompanyId]
        )
        VALUES
        (@ProjectType, @LocId, @ProjectName, @Descriptions, @ProjectAddress, 1, @CompanyId);

        IF (@@ROWCOUNT > 0)
        BEGIN
            SELECT 'SUCCESS' AS [Message_Code];
        END;
    END;
    ELSE
    BEGIN
        SELECT 'PROJECT NAME ALREADY EXISTS' AS [Message_Code];
    END;
END;


GO
