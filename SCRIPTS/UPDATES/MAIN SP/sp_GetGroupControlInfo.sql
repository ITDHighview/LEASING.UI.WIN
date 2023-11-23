--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
ALTER PROCEDURE [sp_GetGroupControlInfo]
    @ControlId AS INT = NULL,
    @GroupId AS INT = NULL,
    @FormId AS INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT [tblGroupFormControls].[GroupControlId],
           [tblGroupFormControls].[FormId],
           [tblGroupFormControls].[ControlId],
           [tblGroupFormControls].[GroupId],
           [tblGroupFormControls].[IsVisible],
           [tblGroupFormControls].[IsDelete]
    FROM [dbo].[tblGroupFormControls]
    WHERE [tblGroupFormControls].[ControlId] = @ControlId
          AND [tblGroupFormControls].[GroupId] = @GroupId
          AND [tblGroupFormControls].[FormId] = @FormId;

END;
GO
