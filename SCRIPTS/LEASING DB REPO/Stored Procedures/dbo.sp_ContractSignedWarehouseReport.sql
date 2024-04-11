SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_ContractSignedWarehouseReport] @RefId AS VARCHAR(20) = NULL
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
    BEGIN
        SET NOCOUNT ON;


        SELECT
                DAY([dbo].[tblUnitReference].[EncodedDate])                                                                 AS [ThisDayOf],
                DATENAME(MONTH, [dbo].[tblUnitReference].[EncodedDate])                                                     AS [InMonth],
                DATENAME(YEAR, [dbo].[tblUnitReference].[EncodedDate])                                                      AS [OfYear],
                CONVERT(VARCHAR(10), [tblUnitReference].[StatDate], 103) + ' - '
                + CONVERT(VARCHAR(10), [tblUnitReference].[FinishDate], 103)                                                AS [ByAndBetween],
                UPPER([tblCompany].[CompanyName])                                                                           AS [CompanyName],
                [tblCompany].[CompanyAddress]                                                                               AS [CompanyAddress],
                [tblCompany].[CompanyOwnerName]                                                                             AS [CompanyOwnerName],
                [tblClientMstr].[ClientName]                                                                                AS [LesseeName],            ---CLIENT NAME
                'Certificate of Title No. 001-2021003286'                                                                   AS [CertificateOfTitle],
                'Under The Trade Name Of'                                                                                   AS [UnderTheTradeNameOf],   ---CLIENT UNDER OF?
                [tblClientMstr].[PostalAddress]                                                                             AS [LesseeAddress],         ---CLIENT ADDRESS


                UPPER([tblProjectMstr].[ProjectName])                                                                       AS [TheLessorIsTheOwnerOf], ---PROJECT NAME
                [tblProjectMstr].[ProjectAddress]                                                                           AS [Situated],              ---PROJECT ADDRESS

                [tblUnitMstr].[UnitNo]                                                                                      AS [LeasedUnit],            ---UNIT NUMBER
                [tblUnitMstr].[AreaSqm]                                                                                     AS [AreaOf],                ---UNIT AREA

                UPPER([dbo].[fnNumberToWordsWithDecimalMain]([tblUnitMstr].[AreaSqm]))                                      AS [AreaByWord],            ---UNIT AREA

                CONVERT(VARCHAR(20), [tblUnitReference].[StatDate], 107)                                                    AS [YearStarting],
                CONVERT(VARCHAR(20), [tblUnitReference].[FinishDate], 107)                                                  AS [YearEnding],
                CONVERT(VARCHAR(20), [tblUnitReference].[StatDate], 107) + ' - '
                + CONVERT(VARCHAR(20), [tblUnitReference].[FinishDate], 107)                                                AS [PeriodCover],
                UPPER([dbo].[fnNumberToWordsWithDecimal]([tblUnitReference].[TotalRent])) + ' PESOS ONLY ('
                + CAST([tblUnitReference].[TotalRent] AS VARCHAR(100)) + ')'                                                AS [RentalForLeased_AmountInWords],
                UPPER([dbo].[fnNumberToWordsWithDecimal]([tblUnitReference].[SecAndMaintenance])) + '('
                + CAST([tblUnitReference].[SecAndMaintenance] AS VARCHAR(100)) + ')'                                        AS [AsShareInSecAndMaint_AmountInWords],
                UPPER([dbo].[fnNumberToWordsWithDecimal]([tblUnitReference].[TotalRent])) + '('
                + CAST([tblUnitReference].[TotalRent] AS VARCHAR(100)) + ')'                                                AS [TotalAmountInYear_AmountInWords],
                CAST([tblUnitReference].[Unit_Vat] AS VARCHAR(100)) + ' %'                                                  AS [VatPercentage_WithWords],
                CAST([tblUnitReference].[PenaltyPct] AS VARCHAR(100)) + ' %'                                                AS [PenaltyPercentage_WithWords],
                [tblClientMstr].[ClientName]                                                                                AS [Lessee],
                [tblUnitReference].[Unit_TotalRental]                                                                       AS [MonthlyRentalOfVat],
                [tblUnitReference].[Unit_BaseRentalVatAmount]                                                               AS [Vatlessor],
                [tblUnitReference].[Unit_TaxAmount]                                                                         AS [WithHoldingTax],
                [tblUnitReference].[Unit_TotalRental]                                                                       AS [RentDuePerMonth],
                [tblUnitReference].[GenVat]                                                                                 AS [VatDisplay],
                [tblUnitReference].[WithHoldingTax]                                                                         AS [TaxDisplay],
                [tblUnitReference].[Unit_SecAndMainAmount]                                                                  AS [SecBaseAmount],
                [dbo].[fnGetSecVatAmount]([tblUnitReference].[UnitId])                                                      AS [SecVatAmount],
                [tblUnitReference].[Unit_SecAndMainWithVatAmount]                                                           AS [SecRentDue],
                [tblUnitReference].[Unit_TotalRental]                                                                       AS [TotalRentAmount],
                UPPER([dbo].[fnNumberToWordsWithDecimal]([tblUnitReference].[SecDeposit])) + 'PESOS ONLY ' + ' ('
                + CAST(ISNULL([tblUnitReference].[SecDeposit], 0) AS VARCHAR(50)) + ') '                                    AS [SecDepositByWords],
                UPPER([dbo].[fnNumberToWordsWithDecimal]([dbo].[fnGetTotalMonthAdvanceAmount]([tblUnitReference].[RefId])))
                + 'PESOS ONLY ' + ' ('
                + CAST(ISNULL([dbo].[fnGetTotalMonthAdvanceAmount]([tblUnitReference].[RefId]), 0) AS VARCHAR(50)) + ') '   AS [MonthAdvanceByWords],
                UPPER([dbo].[fnNumberToWordsWithDecimal]([dbo].[fnGetTotalMonthPostDatedAmount]([tblUnitReference].[RecId])))
                + 'PESOS ONLY ' + ' ('
                + CAST(ISNULL([dbo].[fnGetTotalMonthPostDatedAmount]([tblUnitReference].[RecId]), 0) AS VARCHAR(50)) + ') ' AS [TotalMonthPostDatedAmountInWords],
                [dbo].[fnGetAdvancePeriodCover]([tblUnitReference].[RefId])                                                 AS [AdvanceMonthPeriodCover],
                [dbo].[fnGetPostDatedPeriodCover]([tblUnitReference].[RecId])                                               AS [PostDatedPeriodCover],
                CAST([tblUnitReference].[SecDeposit] / [tblUnitReference].[TotalRent] AS INT)                               AS [SecDepositCount],
                [dbo].[fnGetAdvanceMonthCount]([dbo].[tblUnitReference].[RefId])                                            AS [MonthAdvanceCount],
                [dbo].[fnGetPostDatedMonthCount]([tblUnitReference].[RecId])                                                AS [PostDatedCheckCount],
                [dbo].[fnNumberToWordsWithDecimal]([dbo].[fnGetPostDatedMonthCount]([tblUnitReference].[RecId]))            AS [PostDatedCheckCountbyWord],
                CAST(DATENAME(DAY, [tblUnitReference].[StatDate]) AS VARCHAR(50))                                           AS [PostDatedDay],
                [dbo].[fnGetClientIsRenewal]([dbo].[tblUnitReference].[ClientID], [dbo].[tblUnitReference].[ProjectId])
                + '(' + UPPER([dbo].[fnGetProjectTypeByUnitId]([dbo].[tblUnitReference].[UnitId])) + ')'                    AS [ContractTitle]
        --[fnGetTotalMonthPostDatedAmount]
        FROM
                [dbo].[tblUnitReference] WITH (NOLOCK)
            INNER JOIN
                [dbo].[tblProjectMstr] WITH (NOLOCK)
                    ON [dbo].[tblUnitReference].[ProjectId] = [tblProjectMstr].[RecId]
            INNER JOIN
                [dbo].[tblCompany] WITH (NOLOCK)
                    ON [tblProjectMstr].[CompanyId] = [tblCompany].[RecId]
            INNER JOIN
                [dbo].[tblClientMstr] WITH (NOLOCK)
                    ON [tblUnitReference].[ClientID] = [tblClientMstr].[ClientID]
            INNER JOIN
                [dbo].[tblUnitMstr] WITH (NOLOCK)
                    ON [dbo].[tblUnitReference].[UnitId] = [tblUnitMstr].[RecId]
        WHERE
                [tblUnitReference].[RefId] = @RefId
    END;
GO
