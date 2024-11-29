USE [LEASINGDB]
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
GO
CREATE OR ALTER PROCEDURE [sp_IsContractApplyMonthlyPenalty] @ReferenceID AS BIGINT
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
    BEGIN
        SELECT
            ISNULL([tblUnitReference].[IsContractApplyMonthlyPenalty], 0) AS [IsContractApplyMonthlyPenalty]
        FROM
            [dbo].[tblUnitReference]
        WHERE
            [tblUnitReference].[RecId] = @ReferenceID
    END
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO