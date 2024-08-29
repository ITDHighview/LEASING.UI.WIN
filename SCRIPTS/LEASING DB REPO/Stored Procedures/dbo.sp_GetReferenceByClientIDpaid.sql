SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC [sp_GetReferenceByClientID] 'INDV10000002'
-- =============================================
CREATE   PROCEDURE [dbo].[sp_GetReferenceByClientIDpaid]
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
            CONVERT(VARCHAR(20), [tblUnitReference].[TransactionDate], 107)                            AS [TransactionDate],
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
            [tblUnitReference].[IsUnitMoveOut],
            CASE
                WHEN ISNULL([tblUnitReference].[IsDone], 0) = 1
                     AND ISNULL([tblUnitReference].[IsTerminated], 0) = 0
                    THEN
                    'CONTRACT DONE'
                WHEN ISNULL([tblUnitReference].[IsTerminated], 0) = 1
                     AND ISNULL([tblUnitReference].[IsDone], 0) = 1
                    THEN
                    'CONTRACT TERMINATED'
                ELSE
                    'ON-GOING'
            END                                                                                        AS [CLientReferenceStatus],
            IIF(ISNULL([tblUnitReference].[Unit_IsParking], 0) = 1, 'TYPE OF PARKING', 'TYPE OF UNIT') AS [TypeOf]
        FROM
            [dbo].[tblUnitReference]
        WHERE
            [tblUnitReference].[ClientID] = @ClientID
            AND ISNULL([tblUnitReference].[IsSignedContract], 0) = 1
            AND ISNULL([tblUnitReference].[IsUnitMove], 0) = 1
            AND ISNULL([tblUnitReference].[IsTerminated], 0) = 0
            AND ISNULL([tblUnitReference].[IsDone], 0) = 0
            AND ISNULL([tblUnitReference].[IsUnitMoveOut], 0) = 0
            AND ISNULL([tblUnitReference].[IsPaid], 0) = 1;

    END;
GO
