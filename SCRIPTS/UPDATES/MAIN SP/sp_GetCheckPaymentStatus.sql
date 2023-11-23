-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetCheckPaymentStatus] @ReferenceID VARCHAR(50) = NULL
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        -- Insert statements for procedure here
        IF EXISTS
            (
                SELECT
                    *
                FROM
                    [dbo].[tblMonthLedger]
                WHERE
                    [tblMonthLedger].[ReferenceID] = SUBSTRING(@ReferenceID, 4, 11)
            )
            BEGIN
                SELECT
                    IIF(COUNT(*) > 0, 'IN-PROGRESS', 'PAYMENT DONE') AS [PAYMENT_STATUS]
                FROM
                    [dbo].[tblMonthLedger]
                WHERE
                    [tblMonthLedger].[ReferenceID] = SUBSTRING(@ReferenceID, 4, 11)
                    AND ISNULL([tblMonthLedger].[IsPaid], 0) = 0;
            END;
        ELSE
            BEGIN
                SELECT
                    '' AS [PAYMENT_STATUS];
            END;
    END;
GO
