USE [LEASINGDB]
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_UpdateFloorType]
    @RecId    INT         = NULL,
    @TypeName VARCHAR(50) = NULL
AS
    BEGIN

        SET NOCOUNT ON;
        DECLARE @Message_Code VARCHAR(MAX) = '';
        DECLARE @ErrorMessage NVARCHAR(MAX) = N'';

  
            UPDATE
                [dbo].[tblFloorTypes]
            SET
                [tblFloorTypes].[FloorTypesDescription] = @TypeName
            WHERE
                [tblFloorTypes].[RecId] = @RecId

            IF (@@ROWCOUNT > 0)
                BEGIN
                    SET @Message_Code = 'SUCCESS'
                    SET @ErrorMessage = N''
                END
   



        SET @ErrorMessage = ERROR_MESSAGE()
        IF @ErrorMessage <> ''
            BEGIN

                INSERT INTO [dbo].[ErrorLog]
                    (
                        [ProcedureName],
                        [ErrorMessage],
                        [LogDateTime]
                    )
                VALUES
                    (
                        'sp_UpdateFloorType', @ErrorMessage, GETDATE()
                    );
            END
        SELECT
            @ErrorMessage AS [ErrorMessage],
            @Message_Code AS [Message_Code];
    END
GO

