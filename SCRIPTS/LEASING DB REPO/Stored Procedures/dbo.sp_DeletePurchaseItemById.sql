SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_DeletePurchaseItemById] @RecId INT
AS
    BEGIN

        SET NOCOUNT ON;


        DELETE FROM
        [dbo].[tblProjPurchItem]
        WHERE
            [tblProjPurchItem].[RecId] = @RecId;

        IF (@@ROWCOUNT > 0)
            BEGIN

                SELECT
                    'SUCCESS' AS [Message_Code];

            END;
    END;
GO
