SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetClientTypeAndID] @ClientID VARCHAR(50) = NULL
AS
    BEGIN

        SET NOCOUNT ON;

        SELECT
            ISNULL([tblClientMstr].[ClientID], '')                                           AS [ClientID],
            IIF(ISNULL([tblClientMstr].[ClientType], '') = 'INV', 'INDIVIDUAL', 'CORPORATE') AS [ClientType]
        FROM
            [dbo].[tblClientMstr] WITH (NOLOCK)
        WHERE
            [ClientID] = @ClientID;

    END;
GO
