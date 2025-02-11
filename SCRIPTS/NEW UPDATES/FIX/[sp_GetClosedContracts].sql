USE [LEASINGDB]
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_GetClosedContracts]
-- Add the parameters for the stored procedure here

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
                IIF(ISNULL([tblUnitReference].[IsTerminated], 0) = 1, 'EARLY TERMINATION', 'CONTRACT DONE') AS [Contract_Status],
                ISNULL([tblUnitReference].[ContractTerminationRemarks], 0)                                  AS [ContractTerminationRemarks]
        FROM
                [dbo].[tblUnitReference] WITH (NOLOCK)
            INNER JOIN
                [dbo].[tblUnitMstr] WITH (NOLOCK)
                    ON [tblUnitReference].[UnitId] = [tblUnitMstr].[RecId]
        WHERE
                ISNULL([tblUnitReference].[IsPaid], 0) = 1
                AND ISNULL([tblUnitReference].[IsDone], 0) = 1
                AND ISNULL([tblUnitReference].[IsSignedContract], 0) = 1
                AND ISNULL([tblUnitReference].[IsUnitMove], 0) = 1
                AND ISNULL([tblUnitReference].[IsUnitMoveOut], 0) = 1
                AND ISNULL([tblUnitReference].[IsPaid], 0) = 1
                AND ISNULL([tblUnitReference].[IsTerminated], 0) = 0
                OR ISNULL([tblUnitReference].[IsTerminated], 0) = 1
                   AND ISNULL([tblUnitReference].[IsPaid], 0) = 1
                   AND ISNULL([tblUnitReference].[IsDone], 0) = 1
                   AND ISNULL([tblUnitReference].[IsSignedContract], 0) = 1
                   AND ISNULL([tblUnitReference].[IsUnitMove], 0) = 1
                   AND ISNULL([tblUnitReference].[IsUnitMoveOut], 0) = 1;



    --and ISNULL(tblUnitMstr.IsParking, 0) = 0
    END;
GO

