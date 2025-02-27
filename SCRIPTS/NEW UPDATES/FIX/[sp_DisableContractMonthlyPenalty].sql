USE [LEASINGDB]
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
--EXEC [sp_DisableContractMonthlyPenalty] 10000000
CREATE OR ALTER PROCEDURE [sp_DisableContractMonthlyPenalty]
    @ReferenceID AS BIGINT,
    @IsEnable       BIT
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
    BEGIN
        DECLARE @Message_Code VARCHAR(MAX) = '';
        DECLARE @ErrorMessage NVARCHAR(MAX) = N'';

        UPDATE
            [dbo].[tblUnitReference]
        SET
            [tblUnitReference].[IsContractApplyMonthlyPenalty] = @IsEnable
        WHERE
            [tblUnitReference].[RecId] = @ReferenceID

        --IF @IsEnable = 1
        --    BEGIN
        --        EXEC [dbo].[sp_ApplyMonthLyPenalty]
        --            @ReferenceID = @ReferenceID -- bigint
        --    END
        IF @@ROWCOUNT > 0
            BEGIN

                SET @Message_Code = 'SUCCESS'
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
                        'sp_DisableContractMonthlyPenalty', @ErrorMessage, GETDATE()
                    );


            END

        SELECT
            @ErrorMessage AS [ErrorMessage],
            @Message_Code AS [Message_Code];

    END
GO

