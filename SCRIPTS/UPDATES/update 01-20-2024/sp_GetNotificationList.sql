--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [sp_GetNotificationList]

-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN

    SELECT 'MARK JASON' AS [Client],
           'INDV102220221' AS [ClientID],
           'REF12313215' AS [ContractID],
           'Jan 01,2024' AS [ForMonth],
           '1500.00' AS [Amounth],
           'DUE' AS [Status]
    UNION
    SELECT 'XGENBOY' AS [Client],
           'INDV102220465' AS [ClientID],
           'REF12314356' AS [ContractID],
           'Jan 01,2024' AS [ForMonth],
           '1800.00' AS [Amounth],
           'COMMING' AS [Status]
    UNION
    SELECT 'VHON' AS [Client],
           'INDV102220465' AS [ClientID],
           'REF12314356' AS [ContractID],
           'Jan 01,2024' AS [ForMonth],
           '1800.00' AS [Amounth],
           'COMMING' AS [Status]
		    UNION
    SELECT 'VHON12' AS [Client],
           'INDV102220465' AS [ClientID],
           'REF12314356' AS [ContractID],
           'Jan 01,2024' AS [ForMonth],
           '1800.00' AS [Amounth],
           'COMMING' AS [Status]
		   		    UNION
    SELECT 'VHONasd' AS [Client],
           'INDV102220465' AS [ClientID],
           'REF12314356' AS [ContractID],
           'Jan 01,2024' AS [ForMonth],
           '1800.00' AS [Amounth],
           'COMMING' AS [Status]
		   UNION
		    SELECT 'VHONaasddfd' AS [Client],
           'INDV102220465' AS [ClientID],
           'REF12314356' AS [ContractID],
           'Jan 01,2024' AS [ForMonth],
           '1800.00' AS [Amounth],
           'COMMING' AS [Status]
		   UNION
		      SELECT 'VHONerd' AS [Client],
           'INDV102220465' AS [ClientID],
           'REF12314356' AS [ContractID],
           'Jan 01,2024' AS [ForMonth],
           '1800.00' AS [Amounth],
           'COMMING' AS [Status]
END;
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO