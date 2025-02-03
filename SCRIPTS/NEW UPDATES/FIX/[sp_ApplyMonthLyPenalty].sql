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
        --DECLARE @TotalRent DECIMAL(18, 2) = NULL
        --DECLARE @PenaltyPct DECIMAL(18, 2) = NULL
        --DECLARE @RefId VARCHAR(150) = ''
        --DECLARE @PenaltyApplyInMonth INT = 0
        --DECLARE @PenaltyApplyInYear INT = 0
        --DECLARE @ClientID NVARCHAR(150) = NULL

        --SELECT
        --    @PenaltyApplyInMonth = ISNULL([tblMonthlyPenaltySetting].[PenaltyApplyInMonth], 0),
        --    @PenaltyApplyInYear  = ISNULL([tblMonthlyPenaltySetting].[PenaltyApplyInYear], 0)
        --FROM
        --    [dbo].[tblMonthlyPenaltySetting]

        --SELECT
        --    @TotalRent  = [tblUnitReference].[TotalRent],
        --    @PenaltyPct = [tblUnitReference].[PenaltyPct],
        --    @ClientID   = [tblUnitReference].[ClientID]
        --FROM
        --    [dbo].[tblUnitReference] WITH (NOLOCK)
        --WHERE
        --    [tblUnitReference].[RecId] = @ReferenceID
        /*Check if the penalty stop when it reach the specific date to penalty*/
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
            --AND MONTH([tblMonthLedger].[LedgMonth]) >= @PenaltyApplyInMonth
            --AND YEAR([tblMonthLedger].[LedgMonth]) = @PenaltyApplyInYear
            --AND MONTH([tblMonthLedger].[EncodedDate]) >= @PenaltyApplyInMonth
            --AND YEAR([tblMonthLedger].[EncodedDate]) = @PenaltyApplyInYear
            AND [tblMonthLedger].[Remarks] <> 'PENALTY'
            AND ISNULL([tblMonthLedger].[IsForMonthlyPenalty], 0) = 0
            AND ISNULL([tblMonthLedger].[IsPenaltyApplied], 0) = 0
            AND ISNULL([tblMonthLedger].[IsFreeMonth], 0) = 0



        /*it is use to check the total amount with penalty*/
        --UPDATE
        --    [dbo].[tblMonthLedger]
        --SET
        --    [tblMonthLedger].[ActualAmount] = [tblMonthLedger].[LedgRentalAmount]
        --                                      + ISNULL([tblMonthLedger].[PenaltyAmount], 0)
        --WHERE
        --    [tblMonthLedger].[ReferenceID] = @ReferenceID
        --    AND
        --        (
        --            ISNULL([tblMonthLedger].[IsPaid], 0) = 0
        --            OR ISNULL([tblMonthLedger].[IsHold], 0) = 1
        --        )

        --IF
        --    (
        --        SELECT
        --            COUNT(*)
        --        FROM
        --            [dbo].[tblMonthLedger]
        --        WHERE
        --            [tblMonthLedger].[ReferenceID] = @ReferenceID
        --            AND
        --                (
        --                    ISNULL([tblMonthLedger].[IsPaid], 0) = 0
        --                    OR ISNULL([tblMonthLedger].[IsHold], 0) = 0
        --                )
        --            AND ISNULL([tblMonthLedger].[IsForMonthlyPenalty], 0) = 1
        --            AND ISNULL([tblMonthLedger].[IsPenaltyApplied], 0) = 0
        --            AND [tblMonthLedger].[Remarks] <> 'PENALTY'
        --            AND ISNULL([tblMonthLedger].[IsFreeMonth], 0) = 0
        --    ) > 0
        --    BEGIN
        --        INSERT INTO [dbo].[tblMonthLedger]
        --            (
        --                [ReferenceID],
        --                [ClientID],
        --                [LedgMonth],
        --                [LedgAmount],
        --                [IsPaid],
        --                [EncodedBy],
        --                [EncodedDate],
        --                [ComputerName],
        --                [TransactionID],
        --                [IsHold],
        --                [BalanceAmount],
        --                [PenaltyAmount],
        --                [ActualAmount],
        --                [LedgRentalAmount],
        --                [Remarks],
        --                [Unit_ProjectType],
        --                [Unit_IsNonVat],
        --                [Unit_BaseRentalVatAmount],
        --                [Unit_BaseRentalWithVatAmount],
        --                [Unit_BaseRentalTax],
        --                [Unit_TotalRental],
        --                [Unit_SecAndMainAmount],
        --                [Unit_SecAndMainVatAmount],
        --                [Unit_SecAndMainWithVatAmount],
        --                [Unit_Vat],
        --                [Unit_Tax],
        --                [Unit_TaxAmount],
        --                [Unit_IsParking],
        --                [Unit_AreaTotalAmount],
        --                [Unit_AreaSqm],
        --                [Unit_AreaRateSqm],
        --                [IsRenewal],
        --                [CompanyORNo],
        --                [REF],
        --                [BNK_ACCT_NAME],
        --                [BNK_ACCT_NUMBER],
        --                [BNK_NAME],
        --                [SERIAL_NO],
        --                [ModeType],
        --                [CompanyPRNo],
        --                [BankBranch],
        --                [CheckDate],
        --                [ReceiptDate],
        --                [PaymentRemarks]
        --            )
        --        VALUES
        --            (
        --                @ReferenceID, -- ReferenceID - bigint
        --                @ClientID,    -- ClientID - varchar(500)
        --                (
        --                    SELECT DISTINCT TOP 1
        --                           [tblMonthLedger].[LedgMonth]
        --                    FROM
        --                           [dbo].[tblMonthLedger]
        --                    WHERE
        --                           [tblMonthLedger].[ReferenceID] = @ReferenceID
        --                           AND
        --                               (
        --                                   ISNULL([tblMonthLedger].[IsPaid], 0) = 0
        --                                   OR ISNULL([tblMonthLedger].[IsHold], 0) = 0
        --                               )
        --                           AND ISNULL([tblMonthLedger].[IsForMonthlyPenalty], 0) = 1
        --                           AND ISNULL([tblMonthLedger].[IsPenaltyApplied], 0) = 0
        --                           AND ISNULL([tblMonthLedger].[IsFreeMonth], 0) = 0
        --                ),            -- LedgMonth - date
        --                (
        --                    SELECT
        --                        SUM([tblMonthLedger].[PenaltyAmount])
        --                    FROM
        --                        [dbo].[tblMonthLedger]
        --                    WHERE
        --                        [tblMonthLedger].[ReferenceID] = @ReferenceID
        --                        AND
        --                            (
        --                                ISNULL([tblMonthLedger].[IsPaid], 0) = 0
        --                                OR ISNULL([tblMonthLedger].[IsHold], 0) = 0
        --                            )
        --                        AND ISNULL([tblMonthLedger].[IsForMonthlyPenalty], 0) = 1
        --                        AND ISNULL([tblMonthLedger].[IsPenaltyApplied], 0) = 0
        --                        AND ISNULL([tblMonthLedger].[IsFreeMonth], 0) = 0
        --                ),            -- LedgAmount - decimal(18, 2)
        --                NULL,         -- IsPaid - bit
        --                1,            -- EncodedBy - int
        --                GETDATE(),    -- EncodedDate - datetime
        --                HOST_NAME(),  -- ComputerName - varchar(30)
        --                NULL,         -- TransactionID - varchar(500)
        --                NULL,         -- IsHold - bit
        --                NULL,         -- BalanceAmount - decimal(18, 2)
        --                NULL,         -- PenaltyAmount - decimal(18, 2)
        --                NULL,         -- ActualAmount - decimal(18, 2)
        --                (
        --                    SELECT
        --                        SUM([tblMonthLedger].[PenaltyAmount])
        --                    FROM
        --                        [dbo].[tblMonthLedger]
        --                    WHERE
        --                        [tblMonthLedger].[ReferenceID] = @ReferenceID
        --                        AND
        --                            (
        --                                ISNULL([tblMonthLedger].[IsPaid], 0) = 0
        --                                OR ISNULL([tblMonthLedger].[IsHold], 0) = 0
        --                            )
        --                        AND ISNULL([tblMonthLedger].[IsForMonthlyPenalty], 0) = 1
        --                        AND ISNULL([tblMonthLedger].[IsPenaltyApplied], 0) = 0
        --                        AND ISNULL([tblMonthLedger].[IsFreeMonth], 0) = 0
        --                ),            -- LedgRentalAmount - decimal(18, 2)
        --                'PENALTY',    -- Remarks - varchar(500)
        --                NULL,         -- Unit_ProjectType - varchar(150)
        --                NULL,         -- Unit_IsNonVat - bit
        --                NULL,         -- Unit_BaseRentalVatAmount - decimal(18, 2)
        --                NULL,         -- Unit_BaseRentalWithVatAmount - decimal(18, 2)
        --                NULL,         -- Unit_BaseRentalTax - decimal(18, 2)
        --                NULL,         -- Unit_TotalRental - decimal(18, 2)
        --                NULL,         -- Unit_SecAndMainAmount - decimal(18, 2)
        --                NULL,         -- Unit_SecAndMainVatAmount - decimal(18, 2)
        --                NULL,         -- Unit_SecAndMainWithVatAmount - decimal(18, 2)
        --                NULL,         -- Unit_Vat - decimal(18, 2)
        --                NULL,         -- Unit_Tax - decimal(18, 2)
        --                NULL,         -- Unit_TaxAmount - decimal(18, 2)
        --                NULL,         -- Unit_IsParking - bit
        --                NULL,         -- Unit_AreaTotalAmount - decimal(18, 2)
        --                NULL,         -- Unit_AreaSqm - decimal(18, 2)
        --                NULL,         -- Unit_AreaRateSqm - decimal(18, 2)
        --                NULL,         -- IsRenewal - bit
        --                NULL,         -- CompanyORNo - varchar(200)
        --                NULL,         -- REF - varchar(200)
        --                NULL,         -- BNK_ACCT_NAME - varchar(200)
        --                NULL,         -- BNK_ACCT_NUMBER - varchar(200)
        --                NULL,         -- BNK_NAME - varchar(200)
        --                NULL,         -- SERIAL_NO - varchar(200)
        --                NULL,         -- ModeType - varchar(20)
        --                NULL,         -- CompanyPRNo - varchar(50)
        --                NULL,         -- BankBranch - varchar(250)
        --                NULL,         -- CheckDate - datetime
        --                NULL,         -- ReceiptDate - datetime
        --                NULL          -- PaymentRemarks - nvarchar(4000)
        --            )
        --    END


        --IF @@ROWCOUNT > 0
        --    BEGIN
        --        UPDATE
        --            [dbo].[tblMonthLedger]
        --        SET
        --            [tblMonthLedger].[IsPenaltyApplied] = 1
        --        WHERE
        --            [tblMonthLedger].[ReferenceID] = @ReferenceID
        --            AND
        --                (
        --                    ISNULL([tblMonthLedger].[IsPaid], 0) = 0
        --                    OR ISNULL([tblMonthLedger].[IsHold], 0) = 0
        --                )
        --            AND ISNULL([tblMonthLedger].[IsForMonthlyPenalty], 0) = 1
        --            AND ISNULL([tblMonthLedger].[IsPenaltyApplied], 0) = 0
        --            AND ISNULL([tblMonthLedger].[IsFreeMonth], 0) = 0
        --    END
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

        SELECT
            @ErrorMessage AS [ErrorMessage],
            @Message_Code AS [Message_Code];

    END
GO

