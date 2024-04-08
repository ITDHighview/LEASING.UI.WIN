SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetUnitById] @RecId INT
AS
BEGIN

    SET NOCOUNT ON;

    SELECT [tblUnitMstr].[RecId],
           [tblUnitMstr].[ProjectId],
           ISNULL([tblProjectMstr].[ProjectName], '') AS [ProjectName],
           [tblUnitMstr].[UnitDescription],
           ISNULL([tblUnitMstr].[FloorNo], 0) AS [FloorNo],
           ISNULL([tblUnitMstr].[AreaSqm], 0) AS [AreaSqm],
           ISNULL([tblUnitMstr].[AreaRateSqm], 0) AS [AreaRateSqm],
            ISNULL([tblUnitMstr].[AreaTotalAmount] , 0) AS [AreaTotalAmount],
           ISNULL([tblUnitMstr].[FloorType], '') AS [FloorType],
           ISNULL([tblUnitMstr].[BaseRental], 0) AS [BaseRental],
           [tblUnitMstr].[GenVat],
           [tblUnitMstr].[SecurityAndMaintenance],
           [tblUnitMstr].[SecurityAndMaintenanceVat],
           ISNULL([tblUnitMstr].[UnitStatus], '') AS [UnitStatus],
           ISNULL([tblUnitMstr].[DetailsofProperty], '') AS [DetailsofProperty],
           ISNULL([tblUnitMstr].[UnitNo], '') AS [UnitNo],
           ISNULL([tblUnitMstr].[UnitSequence], 0) AS [UnitSequence],
           [tblUnitMstr].[clientID],
           [tblUnitMstr].[Tennant],
           ISNULL([tblUnitMstr].[IsParking],0) AS [IsParking],
           IIF(ISNULL([tblUnitMstr].[IsParking], 0) = 1, 'PARKING', 'UNIT') AS [UnitDescription],
           [tblUnitMstr].[IsNonVat],
           [tblUnitMstr].[BaseRentalVatAmount],
           [tblUnitMstr].[BaseRentalWithVatAmount],
           [tblUnitMstr].[BaseRentalTax],
           [tblUnitMstr].[TotalRental],
           [tblUnitMstr].[SecAndMainAmount],
           [tblUnitMstr].[SecAndMainVatAmount],
           [tblUnitMstr].[SecAndMainWithVatAmount],
           COALESCE([tblUnitMstr].[Vat],'') AS [Vat],
           [tblUnitMstr].[Tax],
           [tblUnitMstr].[TaxAmount],
           [tblProjectMstr].[RecId],
           [tblProjectMstr].[LocId],
           [tblProjectMstr].[ProjectName],
           [tblProjectMstr].[Descriptions],
           IIF(ISNULL([tblUnitMstr].[IsActive], 0) = 1, 'ACTIVE', 'IN-ACTIVE') AS [IsActive],
           [tblProjectMstr].[ProjectAddress],
           [tblProjectMstr].[ProjectType],
           [tblProjectMstr].[CompanyId]
    FROM [dbo].[tblUnitMstr]
        INNER JOIN [dbo].[tblProjectMstr]
            ON [tblUnitMstr].[ProjectId] = [tblProjectMstr].[RecId]
    WHERE [tblUnitMstr].[RecId] = @RecId
    ORDER BY [tblUnitMstr].[FloorNo],
             [tblUnitMstr].[UnitSequence] DESC;
END;
GO
