SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[sp_ContractSignedResidentialReport] @RefId AS VARCHAR(20) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT DAY([dbo].[tblUnitReference].[EncodedDate]) AS [ThisDayOf],
           DATENAME(MONTH, [dbo].[tblUnitReference].[EncodedDate]) AS [InMonth],
           DATENAME(YEAR, [dbo].[tblUnitReference].[EncodedDate]) AS [OfYear],
           CONVERT(VARCHAR(10), [tblUnitReference].[StatDate], 103) + ' - '
           + CONVERT(VARCHAR(10), [tblUnitReference].[FinishDate], 103) AS [ByAndBetween],
           UPPER([tblCompany].[CompanyName]) + ', a corporation duly '
           + 'organized and existing under Philippine laws with office address at ' + [tblCompany].[CompanyAddress]
           + ', represented herein by its Chief ' + 'Operating Officer, ' + UPPER([tblCompany].[CompanyOwnerName])
           + ' hereinafter referred to as the LESSOR' AS [CompanyInfo],
           [tblCompany].[CompanyAddress] AS [CompanyAddress],
           [tblCompany].[CompanyOwnerName] AS [CompanyOwnerName],
           [tblClientMstr].[ClientName] AS [LesseeName],                     ---CLIENT NAME
           'Under The Trade Name Of' AS [UnderTheTradeNameOf],               ---CLIENT UNDER OF?
           [tblClientMstr].[PostalAddress] AS [LesseeAddress],               ---CLIENT ADDRESS

           UPPER([tblProjectMstr].[ProjectName]) AS [TheLessorIsTheOwnerOf], ---PROJECT NAME
           [tblProjectMstr].[ProjectAddress] AS [Situated],                  ---PROJECT ADDRESS

           [tblUnitMstr].[UnitNo] AS [LeasedUnit],                           ---UNIT NUMBER
           [tblUnitMstr].[AreaSqm] AS [AreaOf],                              ---UNIT AREA

           CONVERT(VARCHAR(20), [tblUnitReference].[StatDate], 107) AS [YearStarting],
           CONVERT(VARCHAR(20), [tblUnitReference].[FinishDate], 107) AS [YearEnding],
           UPPER([dbo].[fnNumberToWordsWithDecimal]([tblUnitReference].[Rental])) + '('
           + CAST([tblUnitReference].[Rental] AS VARCHAR(100)) + ')' AS [RentalForLeased_AmountInWords],
           UPPER([dbo].[fnNumberToWordsWithDecimal]([tblUnitReference].[SecAndMaintenance])) + '('
           + CAST([tblUnitReference].[SecAndMaintenance] AS VARCHAR(100)) + ')' AS [AsShareInSecAndMaint_AmountInWords],
           UPPER([dbo].[fnNumberToWordsWithDecimal]([tblUnitReference].[TotalRent])) + '('
           + CAST([tblUnitReference].[TotalRent] AS VARCHAR(100)) + ')' AS [TotalAmountInYear_AmountInWords],
           CAST([tblUnitReference].[GenVat] AS VARCHAR(100)) + ' %' AS [VatPercentage_WithWords],
           [tblClientMstr].[ClientName] AS [Lessee]
    FROM [dbo].[tblUnitReference] WITH (NOLOCK)
        INNER JOIN [dbo].[tblProjectMstr] WITH (NOLOCK)
            ON [dbo].[tblUnitReference].[ProjectId] = [tblProjectMstr].[RecId]
        INNER JOIN [dbo].[tblCompany] WITH (NOLOCK)
            ON [tblProjectMstr].[CompanyId] = [tblCompany].[RecId]
        INNER JOIN [dbo].[tblClientMstr] WITH (NOLOCK)
            ON [tblUnitReference].[ClientID] = [tblClientMstr].[ClientID]
        INNER JOIN [dbo].[tblUnitMstr] WITH (NOLOCK)
            ON [dbo].[tblUnitReference].[UnitId] = [tblUnitMstr].[RecId]
    WHERE [tblUnitReference].[RefId] = @RefId


END;
GO
