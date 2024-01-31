SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_DeleteUnitReferenceById]
    @RecId  INT,
    @UnitId INT
AS
    BEGIN

        SET NOCOUNT ON;

        UPDATE
            [dbo].[tblUnitMstr]
        SET
            [tblUnitMstr].[UnitStatus] = 'VACANT'
        WHERE
            [tblUnitMstr].[RecId] = @UnitId;
        DELETE FROM
        [dbo].[tblUnitReference]
        WHERE
            [tblUnitReference].[RecId] = @RecId;

        IF (@@ROWCOUNT > 0)
            BEGIN

                SELECT
                    'SUCCESS' AS [Message_Code];

            END;
    END;
GO
