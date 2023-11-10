USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUnitByProjectId]    Script Date: 11/9/2023 10:02:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetUnitByProjectId] 
			@ProjectId INT 
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  SELECT tblUnitMstr.RecId,
       tblUnitMstr.ProjectId,
       ISNULL(tblProjectMstr.ProjectName, '') AS ProjectName,
       IIF(ISNULL(tblUnitMstr.IsParking, 0) = 1, 'TYPE OF PARKING', 'TYPE OF UNIT') AS UnitDescription,
       ISNULL(tblUnitMstr.FloorNo, 0) AS FloorNo,
       ISNULL(tblUnitMstr.AreaSqm, 0) AS AreaSqm,
       ISNULL(tblUnitMstr.AreaRateSqm, 0) AS AreaRateSqm,
       ISNULL(tblUnitMstr.FloorType, '') AS FloorType,
       ISNULL(tblUnitMstr.BaseRental, 0) AS BaseRental,
       --,GenVat
       --,SecurityAndMaintenance
       --,SecurityAndMaintenanceVat
       IIF(ISNULL(tblUnitMstr.UnitStatus, '') <> 'RESERVED',
           ISNULL(tblUnitMstr.UnitStatus, ''),
           ISNULL(tblUnitMstr.UnitStatus, '') + ' TO : ' + ISNULL(CAST(tblUnitReference.ClientID as VARCHAR(20)), '')
           + ' - ' + tblUnitReference.InquiringClient) AS UnitStatus,
       ISNULL(tblUnitMstr.UnitStatus, '') AS UnitStat,
       ISNULL(tblUnitMstr.DetailsofProperty, '') as DetailsofProperty,
       ISNULL(tblUnitMstr.UnitNo, '') AS UnitNo,
       --,UnitSequence
       --,EndodedBy
       --,EndodedDate
       --,LastChangedBy
       --,LastChangedDate
       IIF(ISNULL(tblUnitMstr.IsActive, 0) = 1, 'ACTIVE', 'IN-ACTIVE') AS IsActive
--,ComputerName
--,clientID
--,Tennant


FROm tblUnitMstr WITH (NOLOCK)
    INNER JOIN tblProjectMstr WITH (NOLOCK)
        ON tblUnitMstr.ProjectId = tblProjectMstr.RecId
    LEFT JOIN tblUnitReference WITH (NOLOCK)
        ON tblUnitMstr.RecId = tblUnitReference.UnitId
WHERE tblUnitMstr.ProjectId = @ProjectId
      and ISNULL(tblUnitReference.IsDone, 0) = 0
ORDER BY tblProjectMstr.ProjectName,
         tblUnitMstr.UnitSequence DESC
END
