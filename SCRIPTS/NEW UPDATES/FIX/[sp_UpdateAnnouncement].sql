SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO



--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE OR ALTER PROCEDURE [dbo].[sp_UpdateAnnouncement] @Message AS NVARCHAR(MAX) = ''
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
    BEGIN
        IF
            (
                SELECT
                    COUNT(*)
                FROM
                    [dbo].[tblAnnouncement]
            ) = 0
            BEGIN
                INSERT INTO [dbo].[tblAnnouncement]
                    (
                        [AnnounceMessage]
                    )
                VALUES
                    (
                        @Message -- AnnounceMessage - nvarchar(max)
                    )

                IF @@ROWCOUNT > 0
                    BEGIN
                        SELECT
                            'SUCCESS' AS [Message_Code]
                    END
            END
        ELSE
            BEGIN
                UPDATE
                    [dbo].[tblAnnouncement]
                SET
                    [tblAnnouncement].[AnnounceMessage] = @Message

                IF @@ROWCOUNT > 0
                    BEGIN
                        SELECT
                            'SUCCESS' AS [Message_Code]
                    END
            END



    END
GO

