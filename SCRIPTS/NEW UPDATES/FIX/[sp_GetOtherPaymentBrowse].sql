USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetClientTypeAndID]    Script Date: 10/15/2024 12:44:04 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
            [tblPayment].[PayID]                                       AS PaymentID,
            [tblPayment].[TranId],
            --[tblPayment].[Amount],
            [tblPayment].[ForMonth],
            [tblPayment].[Remarks],
            [tblPayment].[EncodedBy],
            [tblPayment].[EncodedDate]                                 AS PaymentDate,
            [tblPayment].[LastChangedBy],
            [tblPayment].[LastChangedDate],
            [tblPayment].[ComputerName],
            [tblPayment].[IsActive],
            [tblPayment].[RefId],
            [tblPayment].[Notes],
            [tblPayment].[LedgeRecid],
            [tblPayment].[ClientID]                                    AS Client,
            [tblPayment].[OtherPaymentTypeName]                        AS PaymentType,
            FORMAT(ISNULL([tblPayment].[OtherPaymentAmount], 0), 'N2') AS Amount,
            [tblPayment].[OtherPaymentVatPCT],
            [tblPayment].[OtherPaymentVatAmount],
            [tblPayment].[OtherPaymentIsVatApplied],
            [tblPayment].[OtherPaymentTaxPCT],
            [tblPayment].[OtherPaymentTaxAmount],
            [tblPayment].[OtherPaymentTaxIsApplied]
        FROM
            [dbo].[tblPayment]
        WHERE
            [tblPayment].[Remarks] = 'OTHER PAYMENT'

    END;
