SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_ContractSignedCommercialReport] @RefId AS VARCHAR(20) = NULL
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    SET NOCOUNT ON;



    CREATE TABLE [#temptable]
    (
        [ThisDay] NVARCHAR(20),
        [OfMonth] NVARCHAR(20),
        [OfYear] NVARCHAR(20),
        [ProjectName] NVARCHAR(50),
        [ProjectAddress] NVARCHAR(500),
		[CertificateOfTitle] NVARCHAR(500),
        [ClientName] NVARCHAR(100),
        [ClientAddress] NVARCHAR(500),
        [UnitNo] NVARCHAR(20),
        [UnitArea] NVARCHAR(20),
        [StartDate] NVARCHAR(20),
        [EndDate] NVARCHAR(20),
        [RentalAmountInWords] NVARCHAR(500),
        [SecAndSecurityAmountInWords] NVARCHAR(500),
        [TotalAmountInWords] NVARCHAR(500),
        [VATPCT] NVARCHAR(50),
        [PeriodCovered] NVARCHAR(50),
        [MonthlyRentalNetofVatAmount] NVARCHAR(50),
        [WithHoldingAmount] NVARCHAR(50),
        [VatAmount] NVARCHAR(50),
        [RentDueToLessorPerMonth] NVARCHAR(50),
        [CUSAMonthlyRentalNetofVatAmount] NVARCHAR(50),
        [CUSAWithHoldingAmount] NVARCHAR(50),
        [CUSAVatAmount] NVARCHAR(50),
        [CUSARentDueToLessorPerMonth] NVARCHAR(50),
        [TotalAmountAll] NVARCHAR(50),
    );

  INSERT INTO [#temptable]
  (
      [ThisDay],
      [OfMonth],
      [OfYear],
      [ProjectName],
      [ProjectAddress],
      [CertificateOfTitle],
      [ClientName],
      [ClientAddress],
      [UnitNo],
      [UnitArea],
      [StartDate],
      [EndDate],
      [RentalAmountInWords],
      [SecAndSecurityAmountInWords],
      [TotalAmountInWords],
      [VATPCT],
      [PeriodCovered],
      [MonthlyRentalNetofVatAmount],
      [WithHoldingAmount],
      [VatAmount],
      [RentDueToLessorPerMonth],
      [CUSAMonthlyRentalNetofVatAmount],
      [CUSAWithHoldingAmount],
      [CUSAVatAmount],
      [CUSARentDueToLessorPerMonth],
      [TotalAmountAll]
  )
  VALUES
  (   NULL, -- ThisDay - nvarchar(20)
      NULL, -- OfMonth - nvarchar(20)
      NULL, -- OfYear - nvarchar(20)
      NULL, -- ProjectName - nvarchar(50)
      NULL, -- ProjectAddress - nvarchar(500)
      NULL, -- CertificateOfTitle - nvarchar(500)
      NULL, -- ClientName - nvarchar(100)
      NULL, -- ClientAddress - nvarchar(500)
      NULL, -- UnitNo - nvarchar(20)
      NULL, -- UnitArea - nvarchar(20)
      NULL, -- StartDate - nvarchar(20)
      NULL, -- EndDate - nvarchar(20)
      NULL, -- RentalAmountInWords - nvarchar(500)
      NULL, -- SecAndSecurityAmountInWords - nvarchar(500)
      NULL, -- TotalAmountInWords - nvarchar(500)
      NULL, -- VATPCT - nvarchar(50)
      NULL, -- PeriodCovered - nvarchar(50)
      NULL, -- MonthlyRentalNetofVatAmount - nvarchar(50)
      NULL, -- WithHoldingAmount - nvarchar(50)
      NULL, -- VatAmount - nvarchar(50)
      NULL, -- RentDueToLessorPerMonth - nvarchar(50)
      NULL, -- CUSAMonthlyRentalNetofVatAmount - nvarchar(50)
      NULL, -- CUSAWithHoldingAmount - nvarchar(50)
      NULL, -- CUSAVatAmount - nvarchar(50)
      NULL, -- CUSARentDueToLessorPerMonth - nvarchar(50)
      NULL  -- TotalAmountAll - nvarchar(50)
      )

 SELECT [#temptable].[ThisDay],
        [#temptable].[OfMonth],
        [#temptable].[OfYear],
        [#temptable].[ProjectName],
        [#temptable].[ProjectAddress],
        [#temptable].[ClientName],
        [#temptable].[ClientAddress],
        [#temptable].[UnitNo],
        [#temptable].[UnitArea],
        [#temptable].[StartDate],
        [#temptable].[EndDate],
        [#temptable].[RentalAmountInWords],
        [#temptable].[SecAndSecurityAmountInWords],
        [#temptable].[TotalAmountInWords],
        [#temptable].[VATPCT],
        [#temptable].[PeriodCovered],
        [#temptable].[MonthlyRentalNetofVatAmount],
        [#temptable].[WithHoldingAmount],
        [#temptable].[VatAmount],
        [#temptable].[RentDueToLessorPerMonth],
        [#temptable].[CUSAMonthlyRentalNetofVatAmount],
        [#temptable].[CUSAWithHoldingAmount],
        [#temptable].[CUSAVatAmount],
        [#temptable].[CUSARentDueToLessorPerMonth],
        [#temptable].[TotalAmountAll]
FROM [#temptable];
END;
GO
