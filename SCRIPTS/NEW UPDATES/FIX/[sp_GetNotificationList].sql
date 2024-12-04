USE [LEASINGDB]
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE OR ALTER PROCEDURE [dbo].[sp_GetNotificationList]

-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
    BEGIN


        CREATE TABLE [#tempAdvancePayment]
            (
                [RecId]            [BIGINT] IDENTITY(1, 1),
                [MonthLedgerRecId] [BIGINT],
                [ReferenceID]      [BIGINT],
                [LedgMonth]        [DATE],
                [Amount]           [DECIMAL](18, 2)
            )

        INSERT INTO [#tempAdvancePayment]
            (
                [MonthLedgerRecId],
                [ReferenceID],
                [LedgMonth],
                [Amount]
            )
                    SELECT
                            [tblMonthLedger].[Recid],
                            [tblMonthLedger].[ReferenceID],
                            [tblMonthLedger].[LedgMonth],
                            ISNULL([tblAdvancePayment].[Amount], 0)
                    FROM
                            [dbo].[tblMonthLedger]
                        INNER JOIN
                            [dbo].[tblAdvancePayment]
                                ON [tblAdvancePayment].[Months] = [tblMonthLedger].[LedgMonth]
                                   AND [tblAdvancePayment].[RefId] = CONCAT(
                                                                               'REF',
                                                                               CAST([tblMonthLedger].[ReferenceID] AS VARCHAR(150))
                                                                           )


        --SELECT
        --    *
        --FROM
        --    [#tempAdvancePayment]


        SELECT
                [tblClientMstr].[ClientName]                                                                                 AS [Client],
                [tblUnitReference].[ClientID]                                                                                AS [ClientID],
                [tblUnitReference].[RefId]                                                                                   AS [ContractID],
                CONVERT(VARCHAR(15), [tblMonthLedger].[LedgMonth], 107)                                                      AS [ForMonth],
                FORMAT((ISNULL([tblMonthLedger].[LedgRentalAmount], 0) + ISNULL([tblMonthLedger].[PenaltyAmount], 0)), 'N2') AS [Amount],
                'HOLD'                                                                                                       AS [Status]
        FROM
                [dbo].[tblUnitReference] WITH (NOLOCK)
            LEFT JOIN
                [dbo].[tblMonthLedger] WITH (NOLOCK)
                    ON [tblMonthLedger].[ReferenceID] = [tblUnitReference].[RecId]
            LEFT JOIN
                [dbo].[tblClientMstr] WITH (NOLOCK)
                    ON [tblClientMstr].[ClientID] = [tblUnitReference].[ClientID]
        WHERE
                ISNULL([tblMonthLedger].[IsHold], 0) = 1
                AND ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                AND ISNULL([tblUnitReference].[IsTerminated], 0) = 0
                AND [tblMonthLedger].[LedgMonth] NOT IN
                        (
                            SELECT
                                [#tempAdvancePayment].[LedgMonth]
                            FROM
                                [#tempAdvancePayment]
                            WHERE
                                [#tempAdvancePayment].[ReferenceID] = [tblMonthLedger].[ReferenceID]
                        )
        UNION
        SELECT
                [tblClientMstr].[ClientName]                                                                                 AS [Client],
                [tblUnitReference].[ClientID]                                                                                AS [ClientID],
                [tblUnitReference].[RefId]                                                                                   AS [ContractID],
                CONVERT(VARCHAR(15), [tblMonthLedger].[LedgMonth], 107)                                                      AS [ForMonth],
                FORMAT((ISNULL([tblMonthLedger].[LedgRentalAmount], 0) + ISNULL([tblMonthLedger].[PenaltyAmount], 0)), 'N2') AS [Amount],
                'HOLD'                                                                                                       AS [Status]
        FROM
                [dbo].[tblUnitReference] WITH (NOLOCK)
            LEFT JOIN
                [dbo].[tblMonthLedger] WITH (NOLOCK)
                    ON [tblMonthLedger].[ReferenceID] = [tblUnitReference].[RecId]
            LEFT JOIN
                [dbo].[tblClientMstr] WITH (NOLOCK)
                    ON [tblClientMstr].[ClientID] = [tblUnitReference].[ClientID]
        WHERE
                ISNULL([tblMonthLedger].[IsHold], 0) = 1
                AND ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                AND ISNULL([tblUnitReference].[IsTerminated], 0) = 0
                AND [tblMonthLedger].[LedgMonth] IN
                        (
                            SELECT
                                [#tempAdvancePayment].[LedgMonth]
                            FROM
                                [#tempAdvancePayment]
                            WHERE
                                [#tempAdvancePayment].[ReferenceID] = [tblMonthLedger].[ReferenceID]
                        )
        UNION
        SELECT
                [tblClientMstr].[ClientName]                                                                                 AS [Client],
                [tblUnitReference].[ClientID]                                                                                AS [ClientID],
                [tblUnitReference].[RefId]                                                                                   AS [ContractID],
                CONVERT(VARCHAR(15), [tblMonthLedger].[LedgMonth], 107)                                                      AS [ForMonth],
                FORMAT((ISNULL([tblMonthLedger].[LedgRentalAmount], 0) + ISNULL([tblMonthLedger].[PenaltyAmount], 0)), 'N2') AS [Amount],
                'DUE'                                                                                                        AS [Status]
        FROM
                [dbo].[tblUnitReference] WITH (NOLOCK)
            LEFT JOIN
                [dbo].[tblMonthLedger] WITH (NOLOCK)
                    ON [tblMonthLedger].[ReferenceID] = [tblUnitReference].[RecId]
            LEFT JOIN
                [dbo].[tblClientMstr] WITH (NOLOCK)
                    ON [tblClientMstr].[ClientID] = [tblUnitReference].[ClientID]
        WHERE
                ISNULL([tblMonthLedger].[IsPaid], 0) = 0
                AND ISNULL([tblUnitReference].[IsPaid], 0) = 1
                AND ISNULL([tblUnitReference].[IsTerminated], 0) = 0
                AND CONVERT(DATE, [tblMonthLedger].[LedgMonth], 103) <= CONVERT(DATE, GETDATE(), 103)
                AND [tblMonthLedger].[LedgMonth] NOT IN
                        (
                            SELECT
                                [#tempAdvancePayment].[LedgMonth]
                            FROM
                                [#tempAdvancePayment]
                            WHERE
                                [#tempAdvancePayment].[ReferenceID] = [tblMonthLedger].[ReferenceID]
                        )
        UNION
        SELECT
                [tblClientMstr].[ClientName]                                 AS [Client],
                [tblUnitReference].[ClientID]                                AS [ClientID],
                [tblUnitReference].[RefId]                                   AS [ContractID],
                CONVERT(VARCHAR(15), [#tempAdvancePayment].[LedgMonth], 107) AS [ForMonth],
                FORMAT((ISNULL([#tempAdvancePayment].[Amount], 0)), 'N2')    AS [Amount],
                'DUE'                                                        AS [Status]
        FROM
                [dbo].[tblUnitReference] WITH (NOLOCK)
            LEFT JOIN
                [dbo].[tblMonthLedger] WITH (NOLOCK)
                    ON [tblMonthLedger].[ReferenceID] = [tblUnitReference].[RecId]
            INNER JOIN
                [dbo].[#tempAdvancePayment] WITH (NOLOCK)
                    ON [#tempAdvancePayment].[ReferenceID] = [tblMonthLedger].[ReferenceID]
            LEFT JOIN
                [dbo].[tblClientMstr] WITH (NOLOCK)
                    ON [tblClientMstr].[ClientID] = [tblUnitReference].[ClientID]
        WHERE
                ISNULL([tblMonthLedger].[IsPaid], 0) = 0
                AND ISNULL([tblUnitReference].[IsPaid], 0) = 1
                AND ISNULL([tblUnitReference].[IsTerminated], 0) = 0
                AND ISNULL([tblUnitReference].[IsSignedContract], 0) = 1
                AND ISNULL([tblUnitReference].[IsUnitMove], 0) = 1
                AND CONVERT(DATE, [tblMonthLedger].[LedgMonth], 103) <= CONVERT(DATE, GETDATE(), 103)
                AND [tblMonthLedger].[LedgMonth] IN
                        (
                            SELECT
                                [#tempAdvancePayment].[LedgMonth]
                            FROM
                                [#tempAdvancePayment]
                            WHERE
                                [#tempAdvancePayment].[ReferenceID] = [tblMonthLedger].[ReferenceID]
                        )
                AND ISNULL([tblUnitReference].[IsDeclineUnit], 0) = 0
    END;

    DROP TABLE IF EXISTS [#tempAdvancePayment]
GO

