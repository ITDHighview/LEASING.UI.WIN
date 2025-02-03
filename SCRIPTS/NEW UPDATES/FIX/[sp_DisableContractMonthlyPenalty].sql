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


        UPDATE
            [dbo].[tblUnitReference]
        SET
            [tblUnitReference].[IsContractApplyMonthlyPenalty] = @IsEnable
        WHERE
            [tblUnitReference].[RecId] = @ReferenceID

        IF @IsEnable = 1
            BEGIN
                EXEC [dbo].[sp_ApplyMonthLyPenalty]
                    @ReferenceID = @ReferenceID -- bigint
            END
        IF @@ROWCOUNT > 0
            BEGIN

                SELECT
                    'SUCCESS' AS [Message_Code]
            END
        ELSE
            BEGIN
                SELECT
                    'FAIL' AS [Message_Code]
            END
    END
GO

