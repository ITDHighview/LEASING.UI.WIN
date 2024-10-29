USE [LEASINGDB]
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_GetOtherPaymentBrowse]
AS
    BEGIN

        SET NOCOUNT ON;

        SELECT
                [tblPayment].[RecId],
                [tblPayment].[PayID]                                       AS [PaymentID],
                [tblPayment].[TranId],
                --[tblPayment].[Amount],
                [tblPayment].[ForMonth],
                [tblPayment].[Remarks],
                [tblPayment].[EncodedBy],
                [tblPayment].[EncodedDate]                                 AS [PaymentDate],
                [tblPayment].[LastChangedBy],
                [tblPayment].[LastChangedDate],
                [tblPayment].[ComputerName],
                [tblPayment].[IsActive],
                [tblPayment].[RefId],
                [tblPayment].[Notes],
                [tblPayment].[LedgeRecid],
                [tblPayment].[ClientID]                                    AS [Client],
                [tblPayment].[OtherPaymentTypeName]                        AS [PaymentType],
                FORMAT(ISNULL([tblPayment].[OtherPaymentAmount], 0), 'N2') AS [Amount],
                [tblPayment].[OtherPaymentVatPCT],
                [tblPayment].[OtherPaymentVatAmount],
                [tblPayment].[OtherPaymentIsVatApplied],
                [tblPayment].[OtherPaymentTaxPCT],
                [tblPayment].[OtherPaymentTaxAmount],
                [tblPayment].[OtherPaymentTaxIsApplied],
                [tblUnitMstr].[UnitNo]                                     AS [UnitId]
        FROM
                [dbo].[tblPayment]
            INNER JOIN
                [dbo].[tblUnitMstr]
                    ON [tblUnitMstr].[RecId] = [tblPayment].[UnitId]
        WHERE
                [tblPayment].[Remarks] = 'OTHER PAYMENT'

    END;
GO

