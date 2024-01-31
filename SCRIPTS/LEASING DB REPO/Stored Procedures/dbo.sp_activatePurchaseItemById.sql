SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC sp_GetPurchaseItemInfoById @RecId = 2
-- =============================================
CREATE PROCEDURE [dbo].[sp_activatePurchaseItemById] @RecId INT
AS
    BEGIN

        SET NOCOUNT ON;

        UPDATE
            [dbo].[tblProjPurchItem]
        SET
            [tblProjPurchItem].[IsActive] = 1
        WHERE
            [tblProjPurchItem].[RecId] = @RecId;


        IF (@@ROWCOUNT > 0)
            BEGIN
                SELECT
                    'SUCCESS' AS [Message_Code];
            END;


    END;

GO
