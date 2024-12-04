USE [LEASINGDB]
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC [sp_GetQuickContractDetailsInquiry] @RefId = 'REF10000000'
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_GetQuickContractDetailsInquiry] @RefId VARCHAR(20) = NULL
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;


        SELECT
                [tblUnitReference].[RecId],
                [tblUnitReference].[RefId],
                ISNULL([tblUnitReference].[ClientID], '')                                       AS [ClientID],
                [tblUnitReference].[ProjectId],
                ISNULL([tblProjectMstr].[ProjectName], '')                                      AS [ProjectName],
                ISNULL([tblProjectMstr].[ProjectAddress], '')                                   AS [ProjectAddress],
                ISNULL([tblProjectMstr].[ProjectType], '')                                      AS [ProjectType],
                ISNULL([tblUnitReference].[InquiringClient], '')                                AS [InquiringClient],
                ISNULL([tblUnitReference].[ClientMobile], '')                                   AS [ClientMobile],
                [tblUnitReference].[UnitId],
                ISNULL([tblUnitReference].[UnitNo], '')                                         AS [UnitNo],
                ISNULL([tblUnitMstr].[FloorType], '')                                           AS [FloorType],
                ISNULL(CONVERT(VARCHAR(20), [tblUnitReference].[StatDate], 107), '')            AS [StatDate],
                ISNULL(CONVERT(VARCHAR(20), [tblUnitReference].[FinishDate], 107), '')          AS [FinishDate],
                ISNULL(CONVERT(VARCHAR(20), [tblUnitReference].[TransactionDate], 107), '')     AS [TransactionDate],
                CAST(ISNULL([tblUnitReference].[Rental], 0) AS DECIMAL(10, 2))                  AS [Rental],
                CAST(ISNULL([tblUnitReference].[SecAndMaintenance], 0) AS DECIMAL(10, 2))       AS [SecAndMaintenance],
                CAST(ISNULL([tblUnitReference].[TotalRent], 0) AS DECIMAL(10, 2))               AS [TotalRent],
                CAST(ISNULL([tblUnitReference].[AdvancePaymentAmount], 0) AS DECIMAL(10, 2))    AS [AdvancePaymentAmount],
                CAST(ISNULL([tblUnitReference].[SecDeposit], 0) AS DECIMAL(10, 2))              AS [SecDeposit],
                CAST(ISNULL([tblUnitReference].[Total], 0) AS DECIMAL(10, 2))                   AS [Total],
                [tblUnitReference].[EncodedBy],
                [tblUnitReference].[EncodedDate],
                [tblUnitReference].[IsActive],
                [tblUnitReference].[ComputerName],
                ISNULL([tblUnitReference].[AdvancePaymentAmount], 0)                            AS [TwoMonAdvance],
                ISNULL([tblUnitReference].[IsUnitMoveOut], 0)                                   AS [IsUnitMoveOut],
                ISNULL([tblUnitReference].[IsPaid], 0)                                          AS [PaymentStatus],
                ISNULL([tblUnitReference].[IsSignedContract], 0)                                AS [ContractSignStatus],
                ISNULL([tblUnitReference].[IsUnitMove], 0)                                      AS [MoveinStatus],
                ISNULL([tblUnitReference].[IsUnitMoveOut], 0)                                   AS [MoveOutStatus],
                ISNULL([tblUnitReference].[IsTerminated], 0)                                    AS [TerminationStatus],
                ISNULL([tblUnitReference].[IsDone], 0)                                          AS [ContractStatus],
                ISNULL([tblUnitReference].[IsDeclineUnit], 0)                                   AS [IsDeclineUnit],
                IIF(ISNULL([tblUnitReference].[IsDeclineUnit], 0) = 1, 'DECLINED CONTRACT', '') AS [DeclineUnitlabel],
                [PAYMENT].[TotalPayAMount]                                                      AS [TotalPayAMount]
        FROM
                [dbo].[tblUnitReference] WITH (NOLOCK)
            INNER JOIN
                [dbo].[tblProjectMstr] WITH (NOLOCK)
                    ON [tblUnitReference].[ProjectId] = [tblProjectMstr].[RecId]
            INNER JOIN
                [dbo].[tblUnitMstr] WITH (NOLOCK)
                    ON [tblUnitMstr].[RecId] = [tblUnitReference].[UnitId]
            OUTER APPLY
                (
                    SELECT
                        ISNULL(SUM([tblTransaction].[ReceiveAmount]), 0) AS [TotalPayAMount]
                    FROM
                        [dbo].[tblTransaction]
                    WHERE
                        [tblUnitReference].[RefId] = [tblTransaction].[RefId]
                    GROUP BY
                        [tblTransaction].[RefId]
                ) [PAYMENT]
        WHERE
                [tblUnitReference].[RefId] = @RefId
    --AND ISNULL([tblUnitReference].[IsDeclineUnit], 0) = 0
    END;
GO

