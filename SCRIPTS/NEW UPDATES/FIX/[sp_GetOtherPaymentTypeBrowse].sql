USE [LEASINGDB]
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_GetOtherPaymentTypeBrowse]
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        -- Insert statements for procedure here
        SELECT
            [tblOtherPaymentTypes].[RecId],
            ISNULL([tblOtherPaymentTypes].[OtherPaymentTypeName], '')                    AS [OtherPaymentTypeName],
            CAST(ISNULL([tblOtherPaymentTypes].[OtherPaymentVatPCT], 0) AS VARCHAR(150)) AS [OtherPaymentVatPCT],
            CAST(ISNULL([tblOtherPaymentTypes].[OtherPaymentTaxPCT], 0) AS VARCHAR(150)) AS [OtherPaymentTaxPCT]
        FROM
            [dbo].[tblOtherPaymentTypes]
    END;
GO

