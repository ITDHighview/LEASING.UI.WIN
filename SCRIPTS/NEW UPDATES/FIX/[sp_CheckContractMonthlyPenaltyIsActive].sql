USE [LEASINGDB]
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
--EXEC [sp_CheckContractMonthlyPenaltyIsActive] 10000000
CREATE OR ALTER PROCEDURE [sp_CheckContractMonthlyPenaltyIsActive] @ReferenceID AS BIGINT
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
    BEGIN


        SELECT
            ISNULL([tblUnitReference].[IsContractApplyMonthlyPenalty], 0) AS [IsContractPenaltyIsActive]
        FROM
            [dbo].[tblUnitReference]
        WHERE
            [tblUnitReference].[RecId] = @ReferenceID


    END
GO

