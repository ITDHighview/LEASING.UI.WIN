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
                    ON  [tblMonthLedger].[ReferenceID] = [tblUnitReference].[RecId]
            LEFT JOIN
                [dbo].[tblClientMstr] WITH (NOLOCK)
                    ON  [tblClientMstr].[ClientID] = [tblUnitReference].[ClientID] 
        WHERE
                ISNULL([tblMonthLedger].[IsHold], 0) = 1
                
                --AND ISNULL([tblUnitReference].[IsSignedContract], 0) = 1
                --AND ISNULL([tblUnitReference].[IsUnitMove], 0) = 1
                AND ISNULL([tblUnitReference].[IsTerminated], 0) = 0
        --AND ISNULL([tblUnitReference].[IsUnitMoveOut], 0) = 0
        --AND CONVERT(VARCHAR(10), [tblMonthLedger].[LedgMonth], 103) >= CONVERT(VARCHAR(10), GETDATE(), 103)
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
                    ON  [tblMonthLedger].[ReferenceID] = [tblUnitReference].[RecId] 
            LEFT JOIN
                [dbo].[tblClientMstr] WITH (NOLOCK)
                    ON  [tblClientMstr].[ClientID] = [tblUnitReference].[ClientID]
        WHERE
                
                 ISNULL([tblMonthLedger].[IsPaid], 0) = 0
                --AND ISNULL([tblUnitReference].[IsSignedContract], 0) = 1
                --AND ISNULL([tblUnitReference].[IsUnitMove], 0) = 1
                AND ISNULL([tblUnitReference].[IsTerminated], 0) = 0
                --AND ISNULL([tblUnitReference].[IsUnitMoveOut], 0) = 0
                AND CONVERT(DATE,[tblMonthLedger].[LedgMonth],103) <= CONVERT(DATE,GETDATE(),103)

    --AND CONVERT(VARCHAR(10), [tblMonthLedger].[LedgMonth], 103) < CONVERT(VARCHAR(10), GETDATE(), 103)


    --OR
    --    (
    --        ISNULL([tblMonthLedger].[IsHold], 0) = 0
    --        AND ISNULL([tblMonthLedger].[IsPaid], 0) = 1
    --        AND ISNULL([tblUnitReference].[IsSignedContract], 0) = 1
    --        AND ISNULL([tblUnitReference].[IsUnitMove], 0) = 1
    --        AND ISNULL([tblUnitReference].[IsTerminated], 0) = 0
    --        AND ISNULL([tblUnitReference].[IsUnitMoveOut], 0) = 0
    --        AND CONVERT(VARCHAR(10), GETDATE(), 103) = CONVERT(VARCHAR(10), [tblMonthLedger].[LedgMonth], 103)
    --    )
    --UNION
    --SELECT [tblClientMstr].[ClientName] AS [Client],
    --       [tblUnitReference].[ClientID] AS [ClientID],
    --       [tblUnitReference].[RefId] AS [ContractID],
    --       CONVERT(VARCHAR(15), [tblMonthLedger].[LedgMonth], 107) AS [ForMonth],
    --       CAST([tblMonthLedger].[LedgAmount] AS DECIMAL(18, 2)) AS [Amount],
    --       'FOR FOLLOW-UP' AS [Status]
    --FROM [dbo].[tblUnitReference] WITH (NOLOCK)
    --    LEFT JOIN [dbo].[tblMonthLedger] WITH (NOLOCK)
    --        ON [tblUnitReference].[RecId] = [tblMonthLedger].[ReferenceID]
    --    INNER JOIN [dbo].[tblClientMstr] WITH (NOLOCK)
    --        ON [tblUnitReference].[ClientID] = [tblClientMstr].[ClientID]
    --WHERE ISNULL([tblMonthLedger].[IsHold], 0) = 0
    --      AND ISNULL([tblMonthLedger].[IsPaid], 0) = 0
    --      AND DATEDIFF(DAY, CONVERT(DATE, GETDATE(), 103), CONVERT(DATE, [tblMonthLedger].[LedgMonth], 103)) < 7
    END;
GO

