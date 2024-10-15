USE [LEASINGDB]
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_GetOtherPaymentTypeList]
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        -- Insert statements for procedure here
        SELECT
            -0           AS [RecId],
            '--SELECT--' AS [OtherPaymentTypeName]
        UNION
        SELECT
            [tblOtherPaymentTypes].[RecId]                            AS [RecId],
            ISNULL([tblOtherPaymentTypes].[OtherPaymentTypeName], '') AS [OtherPaymentTypeName]
        FROM
            [dbo].[tblOtherPaymentTypes]
    END;
GO

