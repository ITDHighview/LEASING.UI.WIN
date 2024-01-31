SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UpdateProjectById]
    @RecId          INT,
    @ProjectType    VARCHAR(50)  = NULL,
    @LocId          INT,
    @ProjectName    VARCHAR(50)  = NULL,
    @Descriptions   VARCHAR(500) = NULL,
    @ProjectAddress VARCHAR(500) = NULL
AS
    BEGIN

        SET NOCOUNT ON;


        UPDATE
            [dbo].[tblProjectMstr]
        SET
            [tblProjectMstr].[LocId] = @LocId,
            [tblProjectMstr].[Descriptions] = @Descriptions,
            [tblProjectMstr].[ProjectName] = @ProjectName,
            [tblProjectMstr].[ProjectType] = @ProjectType,
            [tblProjectMstr].[ProjectAddress] = @ProjectAddress
        WHERE
            [tblProjectMstr].[RecId] = @RecId;

        IF (@@ROWCOUNT > 0)
            BEGIN

                SELECT
                    'SUCCESS' AS [Message_Code];

            END;
    END;

GO
