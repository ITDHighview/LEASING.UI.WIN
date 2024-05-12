SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE   PROCEDURE [dbo].[sp_GetPostDatedMonthList]
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
                   DATEADD(MONTH, 1, [MonthsCTE].[Month])
               FROM
                   [MonthsCTE]
               WHERE
                   DATEADD(MONTH, 1, [MonthsCTE].[Month]) <= DATEADD(MONTH, @MonthsCount - 1, CONVERT(DATE, @FromDate)))
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
