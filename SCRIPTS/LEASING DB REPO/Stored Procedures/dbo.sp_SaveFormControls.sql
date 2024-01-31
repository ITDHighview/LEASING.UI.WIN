SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SaveFormControls]
    @FormId             INT         = NULL,
    @MenuId             INT         = NULL,
    @ControlName        VARCHAR(50) = NULL,
    @ControlDescription VARCHAR(50) = NULL,
    @IsBackRoundControl BIT         = 0,
    @IsHeaderControl    BIT         = 0
AS
    BEGIN

        SET NOCOUNT ON;
        DECLARE @Message_Code NVARCHAR(MAX) = N'';

        IF NOT EXISTS
            (
                SELECT
                    [tblFormControlsMaster].[ControlName]
                FROM
                    [dbo].[tblFormControlsMaster] WITH (NOLOCK)
                WHERE
                    [tblFormControlsMaster].[ControlName] = @ControlName
                    AND [tblFormControlsMaster].[FormId] = @FormId
                    AND [tblFormControlsMaster].[MenuId] = @MenuId
            )
            BEGIN
                INSERT INTO [dbo].[tblFormControlsMaster]
                    (
                        [FormId],
                        [MenuId],
                        [ControlName],
                        [ControlDescription],
                        [IsBackRoundControl],
                        [IsHeaderControl],
                        [IsDelete]
                    )
                VALUES
                    (
                        @FormId, @MenuId, @ControlName, @ControlDescription, @IsBackRoundControl, @IsHeaderControl, 0
                    );
                IF (@@ROWCOUNT > 0)
                    BEGIN
                        SET @Message_Code = N'SUCCESS';
                    END;
            END;
        ELSE
            BEGIN
                SET @Message_Code = N'CONTROL NAME ALREADY EXISTS';
            END;

        SELECT
            @Message_Code AS [Message_Code];

    END;
GO
