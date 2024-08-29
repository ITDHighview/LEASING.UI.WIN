SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC [sp_GetMonthLedgerByRefIdAndClientId] @ReferenceID =10000000, @ClientID = 'INDV10000000'
-- =============================================
CREATE   PROCEDURE [dbo].[sp_GetMonthLedgerByRefIdAndClientId]
    @ReferenceID INT,
    @ClientID    VARCHAR(50) = NULL
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;
        DECLARE @RefId AS VARCHAR(30) = '';
        DECLARE @IsFullPayment BIT = 0;
        SELECT
            @RefId         = [tblUnitReference].[RefId],
            @IsFullPayment = [tblUnitReference].[IsFullPayment]
        FROM
            [dbo].[tblUnitReference] WITH (NOLOCK)
        WHERE
            [tblUnitReference].[RecId] = @ReferenceID;
        -- Insert statements for procedure here

        CREATE TABLE [#TempLedger]
            (
                [seq]        INT,
                [LedgAmount] DECIMAL(18, 2),
                [LedgMonth]  VARCHAR(20),
                [Remarks]    VARCHAR(500)
            )

        IF @IsFullPayment = 1
            BEGIN
                INSERT INTO [#TempLedger]
                    (
                        [seq],
                        [LedgAmount],
                        [LedgMonth],
                        [Remarks]
                    )
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
                                'FOR SECURITY DEPOSIT'               AS [Remarks]
                            FROM
                                [dbo].[tblUnitReference] WITH (NOLOCK)
                            WHERE
                                [tblUnitReference].[RecId] = @ReferenceID
                                AND ISNULL([tblUnitReference].[SecDeposit], 0) > 0
                            UNION
                            SELECT
                                0                                                       [seq],
                                [tblMonthLedger].[LedgRentalAmount],
                                CONVERT(VARCHAR(20), [tblMonthLedger].[LedgMonth], 107) AS [LedgMonth],
                                'FOR FULL PAYMENT'                                      AS [Remarks]
                            FROM
                                [dbo].[tblMonthLedger] WITH (NOLOCK)
                            WHERE
                                [tblMonthLedger].[ReferenceID] = @ReferenceID
                                AND [tblMonthLedger].[ClientID] = @ClientID
                            ORDER BY
                                [seq] ASC;
            END;
        ELSE
            BEGIN
                INSERT INTO [#TempLedger]
                    (
                        [seq],
                        [LedgAmount],
                        [LedgMonth],
                        [Remarks]
                    )
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
                                'FOR SECURITY DEPOSIT'               AS [Remarks]
                            FROM
                                [dbo].[tblUnitReference] WITH (NOLOCK)
                            WHERE
                                [tblUnitReference].[RecId] = @ReferenceID
                                AND ISNULL([tblUnitReference].[SecDeposit], 0) > 0
                            UNION
                            SELECT
                                0                                                       [seq],
                                [tblMonthLedger].[LedgRentalAmount],
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



        SELECT
            ROW_NUMBER() OVER (ORDER BY
                                   CAST([#TempLedger].[LedgMonth] AS DATE) ASC
                              )                           [seq],
            FORMAT(SUM([#TempLedger].[LedgAmount]), 'N2') AS [LedgAmount],
            [#TempLedger].[LedgMonth],
            [#TempLedger].[Remarks]
        FROM
            [#TempLedger]
        GROUP BY
            [#TempLedger].[LedgMonth],
            [#TempLedger].[Remarks]
        ORDER BY
            [seq] ASC

        DROP TABLE [#TempLedger]
    END;
GO
