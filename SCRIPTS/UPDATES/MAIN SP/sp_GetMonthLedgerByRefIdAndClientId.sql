USE [LEASINGDB];
GO
/****** Object:  StoredProcedure [dbo].[sp_GetMonthLedgerByRefIdAndClientId]    Script Date: 11/9/2023 9:59:43 PM ******/
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetMonthLedgerByRefIdAndClientId]
    @ReferenceID INT,
    @ClientID    VARCHAR(50) = NULL
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;
        DECLARE @RefId AS VARCHAR(30) = '';
        SELECT
            @RefId = [tblUnitReference].[RefId]
        FROM
            [dbo].[tblUnitReference] WITH (NOLOCK)
        WHERE
            [tblUnitReference].[RecId] = @ReferenceID;
        -- Insert statements for procedure here
        SELECT
            0                                    AS [seq],
            (
                SELECT
                    [tblUnitReference].[SecDeposit]
                FROM
                    [dbo].[tblUnitReference] WITH (NOLOCK)
                WHERE
                    [tblUnitReference].[RecId] = @ReferenceID
            )                                    AS [LedgAmount],
            CONVERT(VARCHAR(20), GETDATE(), 107) AS [LedgMonth],
            'FOR 3 MONTHS SECURITY DEPOSIT'      AS [Remarks]
        UNION
        SELECT
            ROW_NUMBER() OVER (ORDER BY
                                   [tblMonthLedger].[LedgMonth] ASC
                              )                                     [seq],
            [tblMonthLedger].[LedgAmount],
            CONVERT(VARCHAR(20), [tblMonthLedger].[LedgMonth], 107) AS [LedgMonth],
            IIF(
                [tblMonthLedger].[LedgMonth] IN
                    (
                        SELECT
                            [tblAdvancePayment].[Months]
                        FROM
                            [dbo].[tblAdvancePayment] WITH (NOLOCK)
                        WHERE
                            [tblAdvancePayment].[RefId] = @RefId
                    ),
                'FOR ADVANCE PAYMENT',
                'FOR POST DATED CHECK')                             AS [Remarks]
        FROM
            [dbo].[tblMonthLedger] WITH (NOLOCK)
        WHERE
            [tblMonthLedger].[ReferenceID] = @ReferenceID
            AND [tblMonthLedger].[ClientID] = @ClientID
        ORDER BY
            [seq] ASC;

    END;
