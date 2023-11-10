USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetClientById]    Script Date: 11/9/2023 9:56:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetClientById] 
@ClientID VARCHAR(50)
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  SELECT 
	ClientID,
	IIF(ISNULL(ClientType,'') ='INDV', 'INDIVIDUAL','CORPORATE') AS ClientType,
    ISNULL(ClientName,'') AS ClientName,
    ISNULL(Age,0) AS Age,
    ISNULL(PostalAddress,'') AS PostalAddress,
    ISNULL(convert(VARCHAR(10),DateOfBirth,103),'') AS DateOfBirth,
    ISNULL(TelNumber,0) AS TelNumber,
    IIF(ISNULL(Gender,0)= 1 ,'MALE','FEMALE') AS Gender,
    ISNULL(Nationality,'') AS Nationality,
    ISNULL(Occupation,'') AS Occupation,
    ISNULL(AnnualIncome,0) AS AnnualIncome,
    ISNULL(EmployerName,'') AS EmployerName,
    ISNULL(EmployerAddress,'') AS EmployerAddress,
    ISNULL(SpouseName,'') AS SpouseName,
    ISNULL(ChildrenNames,'') AS ChildrenNames,
    ISNULL(TotalPersons,0) AS TotalPersons,
    ISNULL(MaidName,'') AS MaidName,
    ISNULL(DriverName,'') AS DriverName,
    ISNULL(VisitorsPerDay,0) AS VisitorsPerDay,
    ISNULL(IsTwoMonthAdvanceRental,0) AS IsTwoMonthAdvanceRental,
    ISNULL(IsThreeMonthSecurityDeposit,0) AS IsThreeMonthSecurityDeposit,
    ISNULL(Is10PostDatedChecks,0) AS Is10PostDatedChecks,
    ISNULL(IsPhotoCopyValidID,0) AS IsPhotoCopyValidID,
    ISNULL(Is2X2Picture,0) AS Is2X2Picture,
    ISNULL(BuildingSecretary,0) AS BuildingSecretary,
    ISNULL(EncodedDate,'') AS EncodedDate,
    ISNULL(EncodedBy,0) AS EncodedBy,    
    ISNULL(ComputerName,'') AS ComputerName,
  IIF(ISNULL(IsActive,0) = 1,'ACTIVE','IN-ACTIVE') AS IsActive FROM tblClientMstr WHERE ClientID = @ClientID
END
