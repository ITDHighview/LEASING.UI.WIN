USE [LEASINGDB]
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_DeclineUnitReferenceById]
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

