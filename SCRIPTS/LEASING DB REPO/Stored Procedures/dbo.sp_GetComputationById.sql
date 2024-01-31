SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC [sp_GetComputationById] 10000000
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetComputationById] @RecId INT = NULL
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    DECLARE @TotalForPayment AS DECIMAL(18, 2) = 0;
    SELECT @TotalForPayment = SUM([tblMonthLedger].[LedgAmount])
    FROM [dbo].[tblMonthLedger]
    WHERE [tblMonthLedger].[ReferenceID] = @RecId;
    SELECT [tblUnitReference].[RecId],
           [tblUnitReference].[RefId],
           ISNULL([tblUnitReference].[ClientID], '') AS [ClientID],
           [tblUnitReference].[ProjectId],
           ISNULL([tblProjectMstr].[ProjectName], '') AS [ProjectName],
           ISNULL([tblProjectMstr].[ProjectAddress], '') AS [ProjectAddress],
           ISNULL([tblProjectMstr].[ProjectType], '') AS [ProjectType],
           ISNULL([tblUnitReference].[InquiringClient], '') AS [InquiringClient],
           ISNULL([tblUnitReference].[ClientMobile], '') AS [ClientMobile],
           [tblUnitReference].[UnitId],
           ISNULL([tblUnitReference].[UnitNo], '') AS [UnitNo],
           ISNULL([tblUnitMstr].[FloorType], '') AS [FloorType],
           ISNULL(CONVERT(VARCHAR(10), [tblUnitReference].[StatDate], 1), '') AS [StatDate],
           ISNULL(CONVERT(VARCHAR(10), [tblUnitReference].[FinishDate], 1), '') AS [FinishDate],
           ISNULL(CONVERT(VARCHAR(10), [tblUnitReference].[TransactionDate], 1), '') AS [TransactionDate],
           CAST(ISNULL([tblUnitReference].[Rental], 0) AS DECIMAL(10, 2)) AS [Rental],
           CAST(ISNULL([tblUnitReference].[SecAndMaintenance], 0) AS DECIMAL(10, 2)) AS [SecAndMaintenance],
           CAST(ISNULL([tblUnitReference].[TotalRent], 0) AS DECIMAL(10, 2)) AS [TotalRent],
           CAST(ISNULL([tblUnitReference].[AdvancePaymentAmount], 0) AS DECIMAL(10, 2)) AS [AdvancePaymentAmount],
           CAST(ISNULL([tblUnitReference].[SecDeposit], 0) AS DECIMAL(10, 2)) AS [SecDeposit],
           CAST(ISNULL([tblUnitReference].[Total], 0) AS DECIMAL(10, 2)) AS [Total],
           [tblUnitReference].[EncodedBy],
           [tblUnitReference].[EncodedDate],
           [tblUnitReference].[IsActive],
           [tblUnitReference].[ComputerName],
           ISNULL([tblUnitReference].[AdvancePaymentAmount], 0) AS [TwoMonAdvance],
           IIF(ISNULL([tblUnitReference].[IsFullPayment], 0) = 1,
               @TotalForPayment + ISNULL([tblUnitReference].[SecDeposit], 0),
               CAST(ISNULL([tblUnitReference].[AdvancePaymentAmount], 0) + ISNULL([tblUnitReference].[SecDeposit], 0) AS DECIMAL(10, 2))) AS [TotalForPayment],
           ISNULL([tblUnitReference].[IsUnitMoveOut], 0) AS [IsUnitMoveOut],
           (
               SELECT IIF(COUNT(*) > 0, 'IN-PROGRESS', 'CLOSED')
               FROM [dbo].[tblMonthLedger] WITH (NOLOCK)
               WHERE [tblMonthLedger].[ReferenceID] = @RecId
                     AND ISNULL([tblMonthLedger].[IsPaid], 0) = 0
           ) AS [PaymentStatus],
           (
               SELECT TOP 1
                      ISNULL(CONVERT(VARCHAR(10), [tblPayment].[EncodedDate], 1), '')
               FROM [dbo].[tblPayment] WITH (NOLOCK)
               WHERE [tblPayment].[RefId] = 'REF' + CONVERT(VARCHAR, @RecId)
               ORDER BY [tblPayment].[EncodedDate] DESC
           ) AS [LastPaymentDate],
           IIF(ISNULL([tblUnitReference].[IsSignedContract], 0) = 1, 'DONE', '') AS [ContractSignStatus],
           ISNULL(CONVERT(VARCHAR(10), [tblUnitReference].[SignedContractDate], 1), '') AS [ContractSignedDate],
           IIF(ISNULL([tblUnitReference].[IsUnitMove], 0) = 1, 'DONE', '') AS [MoveinStatus],
           ISNULL(CONVERT(VARCHAR(10), [tblUnitReference].[UnitMoveInDate], 1), '') AS [MoveInDate],
           IIF(ISNULL([tblUnitReference].[IsUnitMoveOut], 0) = 1, 'DONE', '') AS [MoveOutStatus],
           ISNULL(CONVERT(VARCHAR(10), [tblUnitReference].[UnitMoveOutDate], 1), '') AS [MoveOutDate],
           IIF(ISNULL([tblUnitReference].[IsTerminated], 0) = 1, 'YES', '') AS [TerminationStatus],
           ISNULL(CONVERT(VARCHAR(10), [tblUnitReference].[TerminationDate], 1), '') AS [TerminationDate],
           IIF(ISNULL([tblUnitReference].[IsDone], 0) = 1, 'CLOSED', 'IN-PROGRESS') AS [ContractStatus],
           ISNULL(CONVERT(VARCHAR(10), [tblUnitReference].[ContactDoneDate], 1), '') AS [ContractCloseDate],
           [PAYMENT].[TotalPayAMount] AS [TotalPayAMount]
    FROM [dbo].[tblUnitReference] WITH (NOLOCK)
        INNER JOIN [dbo].[tblProjectMstr] WITH (NOLOCK)
            ON [tblUnitReference].[ProjectId] = [tblProjectMstr].[RecId]
        INNER JOIN [dbo].[tblUnitMstr] WITH (NOLOCK)
            ON [tblUnitMstr].[RecId] = [tblUnitReference].[UnitId]
        OUTER APPLY
    (
        SELECT ISNULL(SUM([tblTransaction].[PaidAmount]), 0) AS [TotalPayAMount]
        FROM [dbo].[tblTransaction]
        WHERE [tblUnitReference].[RefId] = [tblTransaction].[RefId]
        GROUP BY [tblTransaction].[RefId]
    ) [PAYMENT]
    WHERE [tblUnitReference].[RecId] = @RecId;
END;
GO
