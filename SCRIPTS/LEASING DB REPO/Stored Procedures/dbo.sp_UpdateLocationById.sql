SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UpdateLocationById]
    @RecId        INT,
    @Descriptions VARCHAR(50)  = NULL,
    @LocAddress   VARCHAR(500) = NULL
--@IsActive bit = NULL

AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;


        UPDATE
            [dbo].[tblLocationMstr]
        SET
            [tblLocationMstr].[Descriptions] = @Descriptions,
            [tblLocationMstr].[LocAddress] = @LocAddress
        WHERE
            [tblLocationMstr].[RecId] = @RecId;

        IF (@@ROWCOUNT > 0)
            BEGIN

                SELECT
                    'SUCCESS' AS [Message_Code];

            END;
    END;
GO
