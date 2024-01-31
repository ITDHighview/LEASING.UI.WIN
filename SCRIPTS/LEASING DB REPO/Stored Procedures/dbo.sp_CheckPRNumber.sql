SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--EXEC [sp_CheckOrNumber] '234234234'
CREATE PROCEDURE [dbo].[sp_CheckPRNumber] @CompanyPRNo AS VARCHAR(100) = NULL
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT
            1 AS [IsExist]
        FROM
            [dbo].[tblPaymentMode]
        WHERE
            [tblPaymentMode].[CompanyPRNo] = @CompanyPRNo;
    END;
GO
