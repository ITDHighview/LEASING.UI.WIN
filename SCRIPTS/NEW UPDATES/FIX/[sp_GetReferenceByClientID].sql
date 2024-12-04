USE [LEASINGDB]
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC [sp_GetReferenceByClientID] 'INDV10000002'
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_GetReferenceByClientID]
    -- Add the parameters for the stored procedure here
    @ClientID VARCHAR(50) = NULL
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        -- Insert statements for procedure here
        SELECT
            [tblUnitReference].[RecId],
            [tblUnitReference].[RefId],
            [tblUnitReference].[ProjectId],
            [tblUnitReference].[InquiringClient],
            [tblUnitReference].[ClientMobile],
            [tblUnitReference].[UnitId],
            [tblUnitReference].[UnitNo],
            [tblUnitReference].[StatDate],
            [tblUnitReference].[FinishDate],
            [tblUnitReference].[TransactionDate],
            [tblUnitReference].[Rental],
            [tblUnitReference].[SecAndMaintenance],
            [tblUnitReference].[TotalRent],
            [tblUnitReference].[AdvancePaymentAmount],
            [tblUnitReference].[SecDeposit],
            [tblUnitReference].[Total],
            [tblUnitReference].[EncodedBy],
            [tblUnitReference].[EncodedDate],
            [tblUnitReference].[LastCHangedBy],
            [tblUnitReference].[LastChangedDate],
            [tblUnitReference].[IsActive],
            [tblUnitReference].[ComputerName],
            [tblUnitReference].[ClientID],
            [tblUnitReference].[IsPaid],
            [tblUnitReference].[IsDone],
            [tblUnitReference].[HeaderRefId],
            [tblUnitReference].[IsSignedContract],
            [tblUnitReference].[IsUnitMove],
            CASE
                --when ISNULL(IsSignedContract, 0) = 1  and ISNULL(IsUnitMove, 0) = 0 and  ISNULL(IsDone, 0) = 0 and  ISNULL(IsTerminated, 0) = 0 then
                --    'CONTRACT SIGNED'
                --when ISNULL(IsUnitMove, 0) = 1 and ISNULL(IsSignedContract, 0) = 1  and  ISNULL(IsDone, 0) = 0 and  ISNULL(IsTerminated, 0) = 0 then
                --    'MOVE-IN'
                WHEN ISNULL([tblUnitReference].[IsDone], 0) = 1
                     AND ISNULL([tblUnitReference].[IsUnitMoveOut], 0) = 1
                     AND ISNULL([tblUnitReference].[IsTerminated], 0) = 0
                     AND ISNULL([tblUnitReference].[IsUnitMoveOut], 0) = 1
                     AND ISNULL([tblUnitReference].[IsPaid], 0) = 1
                     AND ISNULL([tblUnitReference].[IsSignedContract], 0) = 1
                     AND ISNULL([tblUnitReference].[IsUnitMove], 0) = 1
                     AND ISNULL([tblUnitReference].[IsDeclineUnit], 0) = 0
                    THEN
                    'CLOSED'
                                --'CONTRACT DONE'
                WHEN ISNULL([tblUnitReference].[IsTerminated], 0) = 1
                     AND
                         (
                             ISNULL([tblUnitReference].[IsDone], 0) = 1
                             OR ISNULL([tblUnitReference].[IsDone], 0) = 0
                         )
                     AND ISNULL([tblUnitReference].[IsUnitMoveOut], 0) = 1
                     AND ISNULL([tblUnitReference].[IsPaid], 0) = 1
                     AND ISNULL([tblUnitReference].[IsSignedContract], 0) = 1
                     AND ISNULL([tblUnitReference].[IsUnitMove], 0) = 1
                     AND ISNULL([tblUnitReference].[IsDeclineUnit], 0) = 0
                    THEN
                    'TERMINATED'
                                --'CONTRACT TERMINATED'
                WHEN ISNULL([tblUnitReference].[IsPaid], 0) = 1
                     AND ISNULL([tblUnitReference].[IsSignedContract], 0) = 0
                     AND ISNULL([tblUnitReference].[IsUnitMove], 0) = 0
                     AND ISNULL([tblUnitReference].[IsUnitMoveOut], 0) = 0
                     AND ISNULL([tblUnitReference].[IsTerminated], 0) = 0
                     AND ISNULL([tblUnitReference].[IsDone], 0) = 0
                     AND ISNULL([tblUnitReference].[IsDeclineUnit], 0) = 0
                    THEN
                    'GENERATED' --ledger generated
                WHEN ISNULL([tblUnitReference].[IsPaid], 0) = 1
                     AND ISNULL([tblUnitReference].[IsSignedContract], 0) = 1
                     AND ISNULL([tblUnitReference].[IsUnitMove], 0) = 1
                     AND ISNULL([tblUnitReference].[IsUnitMoveOut], 0) = 0
                     AND ISNULL([tblUnitReference].[IsTerminated], 0) = 0
                     AND ISNULL([tblUnitReference].[IsDone], 0) = 0
                     AND ISNULL([tblUnitReference].[IsDeclineUnit], 0) = 0
                    THEN
                    'ON-GOING'  --ledger generated       
                WHEN ISNULL([tblUnitReference].[IsPaid], 0) = 0
                     AND ISNULL([tblUnitReference].[IsSignedContract], 0) = 0
                     AND ISNULL([tblUnitReference].[IsUnitMove], 0) = 0
                     AND ISNULL([tblUnitReference].[IsUnitMoveOut], 0) = 0
                     AND ISNULL([tblUnitReference].[IsTerminated], 0) = 0
                     AND ISNULL([tblUnitReference].[IsDone], 0) = 0
                     AND ISNULL([tblUnitReference].[IsDeclineUnit], 0) = 1
                    THEN
                    'DECLINED'  --Declined      
                ELSE
                    'N/A'
            END                 AS [CLientReferenceStatus],
            IIF(
                ISNULL([tblUnitReference].[AdvancePaymentAmount], 0) = 0
                AND ISNULL([tblUnitReference].[SecDeposit], 0) = 0,
                'TYPE OF PARKING',
                'TYPE OF UNIT') AS [TypeOf]
        FROM
            [dbo].[tblUnitReference]
        WHERE
            [tblUnitReference].[ClientID] = @ClientID;
    --and ISNULL(IsPaid, 0) = 1
    --and ISNULL(IsTerminated, 0) = 0
    --and ISNULL(IsDone, 0) = 0
    END;
GO

