SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_SaveUserGroup] @GroupName AS VARCHAR(50) = NULL
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
    BEGIN TRY

        SET NOCOUNT ON;
        DECLARE @Message_Code VARCHAR(MAX) = '';
        DECLARE @ErrorMessage NVARCHAR(MAX) = N'';
        BEGIN TRANSACTION
        IF NOT EXISTS
            (
                SELECT
                    [tblGroup].[GroupName]
                FROM
                    [dbo].[tblGroup]
                WHERE
                    [tblGroup].[GroupName] = @GroupName
            )
            BEGIN


                INSERT INTO [dbo].[tblGroup]
                    (
                        [GroupName],
                        [IsDelete]
                    )
                VALUES
                    (
                        UPPER(@GroupName), -- GroupName - varchar(50)
                        0                  -- IsDelete - bit
                    );
                IF (@@ROWCOUNT > 0)
                    BEGIN
                        MERGE INTO [dbo].[tblGroupFormControls] AS [target]
                        USING
                            (
                                SELECT
                                               [tblFormControlsMaster].[FormId],
                                               [tblFormControlsMaster].[ControlId],
                                               [tblGroup].[GroupId],
                                               1 AS [IsVisible],
                                               0 AS [IsDelete]
                                FROM
                                               [dbo].[tblFormControlsMaster]
                                    CROSS JOIN [dbo].[tblGroup]
                            ) AS [source]
                        ON [target].[FormId] = [source].[FormId]
                           AND [target].[ControlId] = [source].[ControlId]
                           AND [target].[GroupId] = [source].[GroupId]
                        WHEN NOT MATCHED
                            THEN INSERT
                                     (
                                         [FormId],
                                         [ControlId],
                                         [GroupId],
                                         [IsVisible],
                                         [IsDelete]
                                     )
                                 VALUES
                                     (
                                         [source].[FormId], [source].[ControlId], [source].[GroupId],
                                         [source].[IsVisible], [source].[IsDelete]
                                     );
                        SET @Message_Code = 'SUCCESS'
                        SET @ErrorMessage = N''
                    END;
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
                'sp_SaveUserGroup', @ErrorMessage, GETDATE()
            );

        SELECT
            @ErrorMessage AS [ErrorMessage],
            @Message_Code AS [Message_Code];
    END CATCH

GO
