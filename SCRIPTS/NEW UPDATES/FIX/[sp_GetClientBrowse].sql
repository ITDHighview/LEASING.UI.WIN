CREATE OR ALTER PROCEDURE [sp_GetClientBrowse]
AS
    BEGIN
        SET NOCOUNT ON
        SELECT
            [tblClientMstr].[RecId],
            [tblClientMstr].[ClientID],
            [tblClientMstr].[ClientType],
            [tblClientMstr].[ClientName],
            [tblClientMstr].[Age],
            [tblClientMstr].[PostalAddress],
            [tblClientMstr].[DateOfBirth],
            [tblClientMstr].[Gender],
            [tblClientMstr].[TelNumber],
            [tblClientMstr].[Nationality],
            [tblClientMstr].[Occupation],
            [tblClientMstr].[AnnualIncome],
            [tblClientMstr].[EmployerName],
            [tblClientMstr].[EmployerAddress],
            [tblClientMstr].[SpouseName],
            [tblClientMstr].[ChildrenNames],
            [tblClientMstr].[TotalPersons],
            [tblClientMstr].[MaidName],
            [tblClientMstr].[DriverName],
            [tblClientMstr].[VisitorsPerDay],
            [tblClientMstr].[IsTwoMonthAdvanceRental],
            [tblClientMstr].[IsThreeMonthSecurityDeposit],
            [tblClientMstr].[Is10PostDatedChecks],
            [tblClientMstr].[IsPhotoCopyValidID],
            [tblClientMstr].[Is2X2Picture],
            [tblClientMstr].[BuildingSecretary],
            [tblClientMstr].[EncodedDate],
            [tblClientMstr].[EncodedBy],
            [tblClientMstr].[LastChangedBy],
            [tblClientMstr].[LastChangedDate],
            [tblClientMstr].[IsActive],
            [tblClientMstr].[ComputerName],
            [tblClientMstr].[IsMap],
            [tblClientMstr].[TIN_No]
        FROM
            [dbo].[tblClientMstr]
        WHERE
            ISNULL([tblClientMstr].[IsActive], 0) = 1
			ORDER BY [tblClientMstr].[ClientName] 
    END
GO
