USE [LEASINGDB]
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC [sp_GetUnitAvailableById] 1
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_GetUnitAvailableById] @UnitNo INT
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT
                [tblProjectMstr].[ProjectName],
                [tblProjectMstr].[ProjectType],
                [tblUnitMstr].[RecId],
                IIF([tblUnitMstr].[FloorType] = '--SELECT--', '', ISNULL([tblUnitMstr].[FloorType], '')) AS [FloorType],
                FORMAT(ISNULL([tblUnitMstr].[SecAndMainWithVatAmount], 0), 'N2')                         AS [SecurityAndMaintenance],
                [tblUnitMstr].[Vat]                                                                      AS [Unit_Vat],
                [tblUnitMstr].[BaseRental]                                                               AS [Unit_BaseRental],
                [tblUnitMstr].[BaseRentalVatAmount]                                                      AS [Unit_BaseRentalVatAmount],
                IIF(ISNULL([tblUnitMstr].[IsNonVat], 0) = 0,
                [tblUnitMstr].[BaseRentalWithVatAmount],
                [tblUnitMstr].[BaseRental])                                                              AS [Unit_BaseRentalWithVatAmount],
                [tblUnitMstr].[TotalRental]                                                              AS [Unit_TotalRental],
                [tblUnitMstr].[Tax]                                                                      AS [Unit_Tax],
                [tblUnitMstr].[BaseRentalTax]                                                            AS [Unit_TaxAmount]
        FROM
                [dbo].[tblUnitMstr] WITH (NOLOCK)
            LEFT JOIN
                [dbo].[tblProjectMstr] WITH (NOLOCK)
                    ON [tblUnitMstr].[ProjectId] = [tblProjectMstr].[RecId]
            LEFT JOIN
                [dbo].[tblRatesSettings] WITH (NOLOCK)
                    ON [tblProjectMstr].[ProjectType] = [tblRatesSettings].[ProjectType]
        WHERE
                [tblUnitMstr].[RecId] = @UnitNo
                AND ISNULL([tblUnitMstr].[IsActive], 0) = 1
                AND [tblUnitMstr].[UnitStatus] = 'VACANT'
        ORDER BY
                [tblUnitMstr].[UnitSequence] DESC;
    END;
GO

