SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [dbo].[sp_GetClientList]
AS
    BEGIN

        SET NOCOUNT ON;

        SELECT
            ISNULL([tblClientMstr].[ClientID], '')                                AS [ClientID],
            CASE
                WHEN ISNULL([tblClientMstr].[ClientType], '') = 'INDV'
                    THEN
                    'INDIVIDUAL'
                WHEN ISNULL([tblClientMstr].[ClientType], '') = 'CORP'
                    THEN
                    'CORPORATE'
                WHEN ISNULL([tblClientMstr].[ClientType], '') = 'PART'
                    THEN
                    'PARTNERSHIP'
                ELSE
                    'N|A'
            END                                                                   AS [ClientType],
            ISNULL([tblClientMstr].[ClientName], '')                              AS [ClientName],
            ISNULL([tblClientMstr].[Age], 0)                                      AS [Age],
            ISNULL([tblClientMstr].[PostalAddress], '')                           AS [PostalAddress],
            ISNULL(CONVERT(VARCHAR(10), [tblClientMstr].[DateOfBirth], 101), '')  AS [DateOfBirth],
            ISNULL([tblClientMstr].[TelNumber], 0)                                AS [TelNumber],
            IIF(ISNULL([tblClientMstr].[Gender], 0) = 1, 'MALE', 'FEMALE')        AS [Gender],
            ISNULL([tblClientMstr].[Nationality], '')                             AS [Nationality],
            ISNULL([tblClientMstr].[Occupation], '')                              AS [Occupation],
            ISNULL([tblClientMstr].[AnnualIncome], 0)                             AS [AnnualIncome],
            ISNULL([tblClientMstr].[EmployerName], '')                            AS [EmployerName],
            ISNULL([tblClientMstr].[EmployerAddress], '')                         AS [EmployerAddress],
            ISNULL([tblClientMstr].[SpouseName], '')                              AS [SpouseName],
            ISNULL([tblClientMstr].[ChildrenNames], '')                           AS [ChildrenNames],
            ISNULL([tblClientMstr].[TotalPersons], 0)                             AS [TotalPersons],
            ISNULL([tblClientMstr].[MaidName], '')                                AS [MaidName],
            ISNULL([tblClientMstr].[DriverName], '')                              AS [DriverName],
            ISNULL([tblClientMstr].[VisitorsPerDay], 0)                           AS [VisitorsPerDay],
            ISNULL([tblClientMstr].[IsTwoMonthAdvanceRental], 0)                  AS [IsTwoMonthAdvanceRental],
            ISNULL([tblClientMstr].[IsThreeMonthSecurityDeposit], 0)              AS [IsThreeMonthSecurityDeposit],
            ISNULL([tblClientMstr].[Is10PostDatedChecks], 0)                      AS [Is10PostDatedChecks],
            ISNULL([tblClientMstr].[IsPhotoCopyValidID], 0)                       AS [IsPhotoCopyValidID],
            ISNULL([tblClientMstr].[Is2X2Picture], 0)                             AS [Is2X2Picture],
            ISNULL([tblClientMstr].[BuildingSecretary], 0)                        AS [BuildingSecretary],
            ISNULL([tblClientMstr].[EncodedDate], '')                             AS [EncodedDate],
            ISNULL([tblClientMstr].[EncodedBy], 0)                                AS [EncodedBy],
            ISNULL([tblClientMstr].[ComputerName], '')                            AS [ComputerName],
            IIF(ISNULL([tblClientMstr].[IsActive], 0) = 1, 'ACTIVE', 'IN-ACTIVE') AS [IsActive],
            ISNULL([tblClientMstr].[TIN_No], '')                                  AS [TIN_No]
        FROM
            [dbo].[tblClientMstr];
    END;
GO
