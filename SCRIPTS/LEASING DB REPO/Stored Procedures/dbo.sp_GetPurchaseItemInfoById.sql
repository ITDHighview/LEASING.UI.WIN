SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC sp_GetPurchaseItemInfoById @RecId = 2
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetPurchaseItemInfoById] @RecId INT
AS
    BEGIN

        SET NOCOUNT ON;

        SELECT
                [tblProjPurchItem].[RecId],
                [tblProjPurchItem].[PurchItemID],
                [tblProjPurchItem].[ProjectId],
                [tblProjectMstr].[ProjectName],
                [tblProjectMstr].[ProjectAddress],
                ISNULL([tblProjPurchItem].[Descriptions], '')                               AS [Descriptions],
                ISNULL(CONVERT(VARCHAR(10), [tblProjPurchItem].[DatePurchase], 1), '')      AS [DatePurchase],
                ISNULL([tblProjPurchItem].[UnitAmount], 0)                                  AS [UnitAmount],
                CAST(ISNULL([tblProjPurchItem].[Amount], 0) AS DECIMAL(10, 2))              AS [Amount],
                CAST(ISNULL([tblProjPurchItem].[TotalAmount], 0) AS DECIMAL(10, 2))         AS [TotalAmount],
                ISNULL([tblProjPurchItem].[Remarks], '')                                    AS [Remarks],
                IIF(ISNULL([tblProjPurchItem].[IsActive], 0) = 1, 'ACTIVE', 'IN-ACTIVE')    AS [IsActive],
                ISNULL([tblProjPurchItem].[EncodedBy], 0)                                   AS [EncodedBy],
                IIF(ISNULL([tblProjPurchItem].[EncodedBy], 0) = 1, 'ADMINISTRATOR', '')     AS [EncodedName],
                ISNULL(CONVERT(VARCHAR(10), [tblProjPurchItem].[EncodedDate], 1), '')       AS [EncodedDate],
                ISNULL([tblProjPurchItem].[LastChangedBy], 0)                               AS [LastChangedBy],
                IIF(ISNULL([tblProjPurchItem].[LastChangedBy], 0) = 1, 'ADMINISTRATOR', '') AS [LastChangedName],
                ISNULL(CONVERT(VARCHAR(10), [tblProjPurchItem].[LastChangedDate], 1), '')   AS [LastChangedDate],
                ISNULL([tblProjPurchItem].[ComputerName], '')                               AS [ComputerName],
                ISNULL([tblProjPurchItem].[UnitNumber], '')                                 AS [UnitNumber],
                ISNULL([tblProjPurchItem].[UnitID], 0)                                      AS [UnitID]
        FROM
                [dbo].[tblProjPurchItem]
            LEFT JOIN
                [dbo].[tblProjectMstr]
                    ON [tblProjectMstr].[RecId] = [tblProjPurchItem].[ProjectId]
        WHERE
                [tblProjPurchItem].[RecId] = @RecId;



    END;

GO
