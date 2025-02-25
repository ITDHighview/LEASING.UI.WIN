USE [LEASINGDB]
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
CREATE OR ALTER PROCEDURE [dbo].[sp_ApplyMonthLyPenalty] @ReferenceID AS BIGINT
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
    BEGIN
        DECLARE @Message_Code VARCHAR(MAX) = '';
        DECLARE @ErrorMessage NVARCHAR(MAX) = N'';
        /*Check if the penalty stop when it reach the specific date to penalty*/

        IF
            (
                SELECT
                    ISNULL([tblUnitReference].[IsContractApplyMonthlyPenalty], 0)
                FROM
                    [dbo].[tblUnitReference]
                WHERE
                    [tblUnitReference].[RecId] = @ReferenceID
            ) = 1
            BEGIN
                UPDATE
                    [dbo].[tblMonthLedger]
                SET
                    [tblMonthLedger].[PenaltyAmount] = IIF([tblMonthLedger].[PenaltyAmount] > 0,
                                                           [tblMonthLedger].[PenaltyAmount],
                                                           [dbo].[fnGetPenaltyResultAmount](
                                                                                               [tblMonthLedger].[LedgMonth],
                                                                                               @ReferenceID,
                                                                                               [tblMonthLedger].[LedgRentalAmount]
                                                                                           )),
                    [tblMonthLedger].[IsForMonthlyPenalty] = IIF(
                                                                 DATEDIFF(
                                                                             DAY, [tblMonthLedger].[LedgMonth],
                                                                             CAST(GETDATE() AS DATE)
                                                                         ) >
                                                                    (
                                                                        SELECT
                                                                            MIN([tblPenaltySetup].[DayCount]) AS [DayCount]
                                                                        FROM
                                                                            [dbo].[tblPenaltySetup]
                                                                        WHERE
                                                                            [tblPenaltySetup].[IsForPenalty] = 1
                                                                    ),
                                                                 1,
                                                                 0)
                WHERE
                    [tblMonthLedger].[ReferenceID] = @ReferenceID
                    AND
                        (
                            ISNULL([tblMonthLedger].[IsPaid], 0) = 0
                            OR ISNULL([tblMonthLedger].[IsHold], 0) = 0
                        )
                    AND [tblMonthLedger].[Remarks] <> 'PENALTY'
                    AND ISNULL([tblMonthLedger].[IsForMonthlyPenalty], 0) = 0
                    AND ISNULL([tblMonthLedger].[IsPenaltyApplied], 0) = 0
                    AND ISNULL([tblMonthLedger].[IsFreeMonth], 0) = 0
            END
   
        IF @@ROWCOUNT > 0
            BEGIN
                SET @Message_Code = 'SUCCESS'
            END

        SET @ErrorMessage = ERROR_MESSAGE()
        IF @ErrorMessage <> ''
            BEGIN

                INSERT INTO [dbo].[ErrorLog]
                    (
                        [ProcedureName],
                        [ErrorMessage],
                        [LogDateTime]
                    )
                VALUES
                    (
                        'sp_ApplyMonthLyPenalty', @ErrorMessage, GETDATE()
                    );


            END

        --SELECT
        --    @ErrorMessage AS [ErrorMessage],
        --    @Message_Code AS [Message_Code];

    END
GO

