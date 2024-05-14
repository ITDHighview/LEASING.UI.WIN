SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MovedOut]
    -- Add the parameters for the stored procedure here
    @ReferenceID VARCHAR(20) = NULL
AS
    BEGIN TRY

        SET NOCOUNT ON;
        DECLARE @Message_Code VARCHAR(MAX) = '';
        DECLARE @ErrorMessage NVARCHAR(MAX) = N'';
        BEGIN TRANSACTION
        UPDATE
            [dbo].[tblUnitReference]
        SET
            [tblUnitReference].[IsUnitMoveOut] = 1,
            [tblUnitReference].[UnitMoveOutDate] = GETDATE()
        WHERE
            [tblUnitReference].[RefId] = @ReferenceID;
        -- Log a success event    
        IF (@@ROWCOUNT > 0)
            BEGIN


                SET @Message_Code = 'SUCCESS'
                SET @ErrorMessage = N''
            END;


        UPDATE
            [dbo].[tblUnitMstr]
        SET
            [tblUnitMstr].[UnitStatus] = 'HOLD'
        WHERE
            [RecId] =
            (
                SELECT
                    [tblUnitReference].[UnitId]
                FROM
                    [dbo].[tblUnitReference]
                WHERE
                    [tblUnitReference].[RefId] = @ReferenceID
            );
        -- Log a success event    
        IF (@@ROWCOUNT > 0)
            BEGIN

                SET @Message_Code = N'SUCCESS';
            END;
        SELECT
            @ErrorMessage AS [ErrorMessage],
            @Message_Code AS [Message_Code];


        COMMIT TRANSACTION

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION
        SET @Message_Code = 'ERROR'
        SET @ErrorMessage = ERROR_MESSAGE()

        INSERT INTO [dbo].[ErrorLog]
            (
                [ProcedureName],
                [ErrorMessage],
                [LogDateTime]
            )
        VALUES
            (
                'sp_MovedOut', @ErrorMessage, GETDATE()
            );

        SELECT
            @ErrorMessage AS [ErrorMessage],
            @Message_Code AS [Message_Code];
    END CATCH
GO
