SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_DeActivatePojectById] @RecId INT
AS
    BEGIN

        SET NOCOUNT ON;

        UPDATE
            [dbo].[tblProjectMstr]
        SET
            [tblProjectMstr].[IsActive] = 0
        WHERE
            [tblProjectMstr].[RecId] = @RecId;

        IF (@@ROWCOUNT > 0)
            BEGIN

                SELECT
                    'SUCCESS' AS [Message_Code];

            END;
    END;
GO
