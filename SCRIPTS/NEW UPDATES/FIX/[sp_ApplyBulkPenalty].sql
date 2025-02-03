USE [LEASINGDB]
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
GO
CREATE OR ALTER PROCEDURE [sp_ApplyBulkPenalty]
    @XML            XML,
    @ReferenceID AS BIGINT,
    @EncodedBy AS   INT
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
    BEGIN
        DECLARE @Message_Code VARCHAR(MAX) = '';
        DECLARE @ErrorMessage NVARCHAR(MAX) = N'';

        CREATE TABLE [#tblSelectedMonth]
            (
                [SelectedMonth] DATE
            );
        IF (@XML IS NOT NULL)
            BEGIN
                INSERT INTO [#tblSelectedMonth]
                    (
                        [SelectedMonth]
                    )
                            SELECT
                                [ParaValues].[data].[value]('c1[1]', 'DATE')
                            --[ParaValues].[data].[value]('c2[1]', 'DECIMAL(18,2)')
                            FROM
                                @XML.[nodes]('/Table1') AS [ParaValues]([data]);
            END;




        INSERT INTO [dbo].[tblMonthLedger]
            (
                [ReferenceID],
                [ClientID],
                [LedgMonth],
                [LedgAmount],
                [IsPaid],
                [EncodedBy],
                [EncodedDate],
                [ComputerName],
                [TransactionID],
                [IsHold],
                [BalanceAmount],
                [PenaltyAmount],
                [ActualAmount],
                [LedgRentalAmount],
                [Remarks],
                [Unit_ProjectType],
                [Unit_IsNonVat],
                [Unit_BaseRentalVatAmount],
                [Unit_BaseRentalWithVatAmount],
                [Unit_BaseRentalTax],
                [Unit_TotalRental],
                [Unit_SecAndMainAmount],
                [Unit_SecAndMainVatAmount],
                [Unit_SecAndMainWithVatAmount],
                [Unit_Vat],
                [Unit_Tax],
                [Unit_TaxAmount],
                [Unit_IsParking],
                [Unit_AreaTotalAmount],
                [Unit_AreaSqm],
                [Unit_AreaRateSqm],
                [IsRenewal],
                [CompanyORNo],
                [REF],
                [BNK_ACCT_NAME],
                [BNK_ACCT_NUMBER],
                [BNK_NAME],
                [SERIAL_NO],
                [ModeType],
                [CompanyPRNo],
                [BankBranch],
                [CheckDate],
                [ReceiptDate],
                [PaymentRemarks]
            )
                    SELECT
                        [TML].[ReferenceID], -- ReferenceID - bigint
                        [TML].[ClientID],    -- ClientID - varchar(500)
                        [TML].[LedgMonth],   -- LedgMonth - date
                        [Penalty].[Amount],  -- LedgAmount - decimal(18, 2)
                        NULL,                -- IsPaid - bit
                        @EncodedBy,          -- EncodedBy - int
                        GETDATE(),           -- EncodedDate - datetime
                        HOST_NAME(),         -- ComputerName - varchar(30)
                        NULL,                -- TransactionID - varchar(500)
                        NULL,                -- IsHold - bit
                        NULL,                -- BalanceAmount - decimal(18, 2)
                        NULL,                -- PenaltyAmount - decimal(18, 2)
                        NULL,                -- ActualAmount - decimal(18, 2)
                        [Penalty].[Amount],  -- LedgRentalAmount - decimal(18, 2)
                        'PENALTY',           -- Remarks - varchar(500)
                        NULL,                -- Unit_ProjectType - varchar(150)
                        NULL,                -- Unit_IsNonVat - bit
                        NULL,                -- Unit_BaseRentalVatAmount - decimal(18, 2)
                        NULL,                -- Unit_BaseRentalWithVatAmount - decimal(18, 2)
                        NULL,                -- Unit_BaseRentalTax - decimal(18, 2)
                        NULL,                -- Unit_TotalRental - decimal(18, 2)
                        NULL,                -- Unit_SecAndMainAmount - decimal(18, 2)
                        NULL,                -- Unit_SecAndMainVatAmount - decimal(18, 2)
                        NULL,                -- Unit_SecAndMainWithVatAmount - decimal(18, 2)
                        NULL,                -- Unit_Vat - decimal(18, 2)
                        NULL,                -- Unit_Tax - decimal(18, 2)
                        NULL,                -- Unit_TaxAmount - decimal(18, 2)
                        NULL,                -- Unit_IsParking - bit
                        NULL,                -- Unit_AreaTotalAmount - decimal(18, 2)
                        NULL,                -- Unit_AreaSqm - decimal(18, 2)
                        NULL,                -- Unit_AreaRateSqm - decimal(18, 2)
                        NULL,                -- IsRenewal - bit
                        NULL,                -- CompanyORNo - varchar(200)
                        NULL,                -- REF - varchar(200)
                        NULL,                -- BNK_ACCT_NAME - varchar(200)
                        NULL,                -- BNK_ACCT_NUMBER - varchar(200)
                        NULL,                -- BNK_NAME - varchar(200)
                        NULL,                -- SERIAL_NO - varchar(200)
                        NULL,                -- ModeType - varchar(20)
                        NULL,                -- CompanyPRNo - varchar(50)
                        NULL,                -- BankBranch - varchar(250)
                        NULL,                -- CheckDate - datetime
                        NULL,                -- ReceiptDate - datetime
                        NULL                 -- PaymentRemarks - nvarchar(4000)
                    FROM
                        [dbo].[tblMonthLedger] [TML]
                        CROSS APPLY
                        (
                            SELECT
                                FORMAT(ISNULL(SUM([tblMonthLedger].[PenaltyAmount]), 0), 'N2') AS [Amount]
                            FROM
                                [dbo].[tblMonthLedger]
                            WHERE
                                [tblMonthLedger].[LedgMonth] = [TML].[LedgMonth]
                                AND [tblMonthLedger].[ReferenceID] = @ReferenceID
                                AND ISNULL([tblMonthLedger].[IsForMonthlyPenalty], 0) = 1
                            GROUP BY
                                [tblMonthLedger].[LedgMonth]
                        )                      AS [Penalty]
                    WHERE
                        [TML].[ReferenceID] = @ReferenceID
                        --AND
                        --    (
                        --        ISNULL([TML].[IsPaid], 0) = 0
                        --        OR ISNULL([TML].[IsHold], 0) = 0
                        --    )
                        --AND ISNULL([TML].[IsForMonthlyPenalty], 0) = 1
                        --AND ISNULL([TML].[IsPenaltyApplied], 0) = 0
                        AND [TML].[Remarks] <> 'PENALTY'
                        --AND ISNULL([TML].[IsFreeMonth], 0) = 0
                        AND [TML].[LedgMonth] IN
                                (
                                    SELECT
                                        [#tblSelectedMonth].[SelectedMonth]
                                    FROM
                                        [#tblSelectedMonth]
                                )



        IF @@ROWCOUNT > 0
            BEGIN
                UPDATE
                    [dbo].[tblMonthLedger]
                SET
                    [tblMonthLedger].[IsPenaltyApplied] = 1
                WHERE
                    [tblMonthLedger].[ReferenceID] = @ReferenceID
                    --AND
                    --    (
                    --        ISNULL([tblMonthLedger].[IsPaid], 0) = 0
                    --        OR ISNULL([tblMonthLedger].[IsHold], 0) = 0
                    --    )
                    --AND ISNULL([tblMonthLedger].[IsForMonthlyPenalty], 0) = 1
                    --AND ISNULL([tblMonthLedger].[IsPenaltyApplied], 0) = 0
                    --AND ISNULL([tblMonthLedger].[IsFreeMonth], 0) = 0
					AND [tblMonthLedger].[Remarks] <> 'PENALTY'
                    AND [tblMonthLedger].[LedgMonth] IN
                            (
                                SELECT
                                    [#tblSelectedMonth].[SelectedMonth]
                                FROM
                                    [#tblSelectedMonth]
                            )

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
                        'sp_SaveComputation', @ErrorMessage, GETDATE()
                    );


            END

        SELECT
            @ErrorMessage AS [ErrorMessage],
            @Message_Code AS [Message_Code];

        DROP TABLE [#tblSelectedMonth];
    END




GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO