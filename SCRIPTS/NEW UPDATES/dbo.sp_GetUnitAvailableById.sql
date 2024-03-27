SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC [sp_GetUnitAvailableById] 1
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetUnitAvailableById] @UnitNo INT
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
    --DECLARE @BaseWithVatAmount DECIMAL(18, 2) = 0;
    DECLARE @OrignalAmount DECIMAL(18, 2) = 0;


    --SELECT @BaseWithVatAmount
    --    = CAST(ISNULL([tblUnitMstr].[BaseRental], 0)
    --           + (((ISNULL([tblUnitMstr].[BaseRental], 0) * ISNULL([tblRatesSettings].[GenVat], 0)) / 100)) AS DECIMAL(18, 2))
    --FROM [dbo].[tblUnitMstr] WITH (NOLOCK)
    --    LEFT JOIN [dbo].[tblProjectMstr] WITH (NOLOCK)
    --        ON [tblUnitMstr].[ProjectId] = [tblProjectMstr].[RecId]
    --    LEFT JOIN [dbo].[tblRatesSettings] WITH (NOLOCK)
    --        ON [tblProjectMstr].[ProjectType] = [tblRatesSettings].[ProjectType]
    --WHERE [tblUnitMstr].[RecId] = @UnitNo
    --      AND ISNULL([tblUnitMstr].[IsActive], 0) = 1
    --      AND [tblUnitMstr].[UnitStatus] = 'VACANT';

    SELECT @OrignalAmount = ISNULL([tblUnitMstr].[BaseRental], 0)
    FROM [dbo].[tblUnitMstr] WITH (NOLOCK)
        LEFT JOIN [dbo].[tblProjectMstr] WITH (NOLOCK)
            ON [tblUnitMstr].[ProjectId] = [tblProjectMstr].[RecId]
        LEFT JOIN [dbo].[tblRatesSettings] WITH (NOLOCK)
            ON [tblProjectMstr].[ProjectType] = [tblRatesSettings].[ProjectType]
    WHERE [tblUnitMstr].[RecId] = @UnitNo
          AND ISNULL([tblUnitMstr].[IsActive], 0) = 1
          AND [tblUnitMstr].[UnitStatus] = 'VACANT';


    SELECT [tblProjectMstr].[ProjectName],
           [tblProjectMstr].[ProjectType],
           [tblUnitMstr].[RecId],
           IIF([tblUnitMstr].[FloorType] = '--SELECT--', '', ISNULL([tblUnitMstr].[FloorType], '')) AS [FloorType],
           CAST((@OrignalAmount - ((@OrignalAmount * ISNULL([tblRatesSettings].[WithHoldingTax], 0)) / 100))
            + ((ISNULL([tblUnitMstr].[BaseRental], 0) * ISNULL([tblRatesSettings].[GenVat], 0)) / 100)
          AS DECIMAL(18,2) ) AS [BaseRental]

    --CAST(ISNULL([tblUnitMstr].[BaseRental], 0)
    --     + (((ISNULL([tblUnitMstr].[BaseRental], 0) * ISNULL([tblRatesSettings].[GenVat], 0)) / 100)
    --        - ((@BaseWithVatAmount * ISNULL([tblRatesSettings].[WithHoldingTax], 0)) / 100)
    --       ) AS DECIMAL(18, 2)) AS [BaseRental]
    FROM [dbo].[tblUnitMstr] WITH (NOLOCK)
        LEFT JOIN [dbo].[tblProjectMstr] WITH (NOLOCK)
            ON [tblUnitMstr].[ProjectId] = [tblProjectMstr].[RecId]
        LEFT JOIN [dbo].[tblRatesSettings] WITH (NOLOCK)
            ON [tblProjectMstr].[ProjectType] = [tblRatesSettings].[ProjectType]
    WHERE [tblUnitMstr].[RecId] = @UnitNo
          AND ISNULL([tblUnitMstr].[IsActive], 0) = 1
          AND [tblUnitMstr].[UnitStatus] = 'VACANT'
    ORDER BY [tblUnitMstr].[UnitSequence] DESC;
END;
GO
