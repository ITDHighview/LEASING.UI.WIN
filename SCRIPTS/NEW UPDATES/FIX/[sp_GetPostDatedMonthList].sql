USE [LEASINGDB]
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_GetPostDatedMonthList]
    -- Add the parameters for the stored procedure here
    @FromDate VARCHAR(10) = NULL,
    @EndDate  VARCHAR(10) = NULL,
    --@Rental   VARCHAR(10) = NULL,
    @XML      XML
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        CREATE TABLE [#tblAdvancePayment]
            (
                [Months] VARCHAR(10)
            );
        IF (@XML IS NOT NULL)
            BEGIN
                INSERT INTO [#tblAdvancePayment]
                    (
                        [Months]
                    )
                            SELECT
                                [ParaValues].[data].[value]('c1[1]', 'VARCHAR(10)')
                            FROM
                                @XML.[nodes]('/Table1') AS [ParaValues]([data]);
            END;

        -- Insert statements for procedure here

        DECLARE @MonthsCount INT = DATEDIFF(MONTH, CONVERT(DATE, @FromDate, 101), CONVERT(DATE, @EndDate, 101));

        CREATE TABLE [#GeneratedMonths]
            (
                [Month] DATE
            );
        WITH [MonthsCTE]
        AS (   SELECT
                   CONVERT(DATE, @FromDate) AS [Month]
               UNION ALL
               SELECT
                   CASE
                       WHEN DAY(DATEADD(MONTH, 1, [MonthsCTE].[Month])) < DAY(@FromDate)
                           THEN
                           CONVERT(
                                      DATE,
                                      IIF(MONTH([MonthsCTE].[Month]) = 2,
                                          DATEADD(
                                                     DAY, DAY(@FromDate) - 1,
                                                     DATEADD(
                                                                MONTH,
                                                                MONTH(DATEADD(
                                                                                 MONTH, 1,
                                                                                 CONVERT(DATE, [MonthsCTE].[Month])
                                                                             )
                                                                     ) - 1,
                                                                DATEADD(
                                                                           YEAR,
                                                                           YEAR(DATEADD(
                                                                                           MONTH, 1,
                                                                                           CONVERT(
                                                                                                      DATE,
                                                                                                      [MonthsCTE].[Month]
                                                                                                  )
                                                                                       )
                                                                               ) - 1900, '1900-01-01'
                                                                       )
                                                            )
                                                 ),
                                          DATEADD(MONTH, 1, [MonthsCTE].[Month]))
                                  )
                       ELSE
                           DATEADD(MONTH, 1, [MonthsCTE].[Month])
                   END
               FROM
                   [MonthsCTE]
               WHERE
                   DATEADD(MONTH, 1, [MonthsCTE].[Month]) <= @EndDate)
        INSERT INTO [#GeneratedMonths]
            (
                [Month]
            )
                    SELECT
                        [MonthsCTE].[Month]
                    FROM
                        [MonthsCTE]
        OPTION (MAXRECURSION 0);



        DELETE FROM
        [#GeneratedMonths]
        WHERE
            [#GeneratedMonths].[Month] IN
                (
                    SELECT
                        [#tblAdvancePayment].[Months]
                    FROM
                        [#tblAdvancePayment]
                );
        SELECT
            ROW_NUMBER() OVER (ORDER BY
                                   [#GeneratedMonths].[Month] ASC
                              )                                   [seq],
            CONVERT(VARCHAR(20), [#GeneratedMonths].[Month], 107) AS [Dates]
        FROM
            [#GeneratedMonths];



        DROP TABLE [#GeneratedMonths];
        DROP TABLE [#tblAdvancePayment];
    END;
GO

