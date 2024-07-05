SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_DeleteFloorType] @FloorTypeDescription VARCHAR(150) = 0
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        DECLARE @Message_Code VARCHAR(MAX) = '';
        -- Insert statements for procedure here
        IF EXISTS
            (
                SELECT
                    [tblFloorTypes].[FloorTypesDescription]
                FROM
                    [dbo].[tblFloorTypes]
                WHERE
                    [tblFloorTypes].[FloorTypesDescription] = @FloorTypeDescription
            )
            BEGIN

                DELETE FROM
                [dbo].[tblFloorTypes]
                WHERE
                    [tblFloorTypes].[FloorTypesDescription] = @FloorTypeDescription;
                IF (@@ROWCOUNT > 0)
                    BEGIN
                        SET @Message_Code = 'SUCCESS';
                    END;
            END;

        SELECT
            @Message_Code AS [Message_Code];
    END;

GO

