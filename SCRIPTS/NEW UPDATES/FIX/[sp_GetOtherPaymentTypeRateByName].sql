USE [LEASINGDB]
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_GetOtherPaymentTypeRateByName] @OtherPaymentTypeName VARCHAR(150) = NULL
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        -- Insert statements for procedure here

        SELECT
            ISNULL([tblOtherPaymentTypes].[OtherPaymentVatPCT], 0) AS [OtherPaymentVatPCT],
            ISNULL([tblOtherPaymentTypes].[OtherPaymentTaxPCT], 0) AS [OtherPaymentTaxPCT]
        FROM
            [dbo].[tblOtherPaymentTypes]
        WHERE
            [tblOtherPaymentTypes].[OtherPaymentTypeName] = @OtherPaymentTypeName
    END;
GO

