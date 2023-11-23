--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
ALTER PROCEDURE [sp_UpdateGroupFormControls]
    @FormId AS    INT = NULL,
    @ControlId AS INT = NULL,
    @GroupId AS   INT = NULL,
    @IsVisible AS BIT = NULL
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @Message_Code AS NVARCHAR(MAX) = N'';
        UPDATE
            [dbo].[tblGroupFormControls]
        SET
            [tblGroupFormControls].[IsVisible] = @IsVisible
        WHERE
            [tblGroupFormControls].[FormId] = @FormId
            AND [tblGroupFormControls].[ControlId] = @ControlId
            AND [tblGroupFormControls].[GroupId] = @GroupId;


        IF (@@ROWCOUNT > 0)
            BEGIN
                SET @Message_Code = N'SUCCESS';
            END;
        ELSE
            BEGIN
                SET @Message_Code = ERROR_MESSAGE();
            END;
        SELECT
            @Message_Code AS [Message_Code];
    END;
GO
