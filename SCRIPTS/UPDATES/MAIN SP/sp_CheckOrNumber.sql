--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--EXEC [sp_CheckOrNumber] '234234234'
ALTER PROCEDURE [sp_CheckOrNumber] @CompanyORNo AS VARCHAR(100) = NULL
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT
            1 AS [IsExist]
        FROM
            [dbo].[tblPaymentMode]
        WHERE
            [tblPaymentMode].[CompanyORNo] = @CompanyORNo;
    END;
GO
