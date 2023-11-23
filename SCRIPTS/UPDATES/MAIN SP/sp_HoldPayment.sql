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
ALTER PROCEDURE [dbo].[sp_HoldPayment]
    @ReferenceID VARCHAR(50) = NULL,
    @Recid       INT         = NULL
--,@EncodedBy INT = NULL
--,@ComputerName VARCHAR(20) = null
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        -- Insert statements for procedure here
        UPDATE
            [dbo].[tblMonthLedger]
        SET
            [tblMonthLedger].[IsHold] = 1
        WHERE
            [Recid] = @Recid
            AND [tblMonthLedger].[ReferenceID] =
                (
                    SELECT
                        [tblUnitReference].[RecId]
                    FROM
                        [dbo].[tblUnitReference]
                    WHERE
                        [tblUnitReference].[RefId] = @ReferenceID
                );

        IF (@@ROWCOUNT > 0)
            BEGIN
                SELECT
                    'SUCCESS' AS [Message_Code];
            END;

    --select IIF(COUNT(*)>0,'IN-PROGRESS','PAYMENT DONE') AS PAYMENT_STATUS from tblMonthLedger where ReferenceID = substring(@ReferenceID,4,11) and ISNULL(IsPaid,0)=0
    END;
GO
