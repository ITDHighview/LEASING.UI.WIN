SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_SaveProject]
    @ProjectType    VARCHAR(50)  = NULL,
    @LocId          INT          = NULL,
    @ProjectName    VARCHAR(50)  = NULL,
    @Descriptions   VARCHAR(50)  = NULL,
    @ProjectAddress VARCHAR(500) = NULL,
    @CompanyId      INT          = NULL
AS
    BEGIN TRY

        SET NOCOUNT ON;
        DECLARE @Message_Code VARCHAR(MAX) = '';
        DECLARE @ErrorMessage NVARCHAR(MAX) = N'';
        BEGIN TRANSACTION

        IF NOT EXISTS
            (
                SELECT
                    [tblProjectMstr].[ProjectName]
                FROM
                    [dbo].[tblProjectMstr]
                WHERE
                    [tblProjectMstr].[ProjectName] = @ProjectName
            )
            BEGIN
                INSERT INTO [dbo].[tblProjectMstr]
                    (
                        [ProjectType],
                        [LocId],
                        [ProjectName],
                        [Descriptions],
                        [ProjectAddress],
                        [IsActive],
                        [CompanyId]
                    )
                VALUES
                    (
                        @ProjectType, @LocId, @ProjectName, @Descriptions, @ProjectAddress, 1, @CompanyId
                    );

                IF (@@ROWCOUNT > 0)
                    BEGIN
                        SET @Message_Code = 'SUCCESS'
                        SET @ErrorMessage = N''
                    END;
            END;
        ELSE
            BEGIN
                SELECT
                    'PROJECT NAME ALREADY EXISTS' AS [Message_Code];
                SET @ErrorMessage = N''
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
                'sp_SaveProject', @ErrorMessage, GETDATE()
            );

        SELECT
            @ErrorMessage AS [ErrorMessage],
            @Message_Code AS [Message_Code];
    END CATCH

GO
