SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--EXEC [GenerateInsertsMomths] @StartDate = '07/31/2023',@MonthsCount = 3
CREATE PROCEDURE [dbo].[GenerateInsertsMomths]
    @StartDate   DATE,
    @MonthsCount INT
AS
    BEGIN

        CREATE TABLE [#GeneratedMonths]
            (
                [Month] DATE
            );
        WITH [MonthsCTE]
        AS (   SELECT
                   @StartDate AS [Month]
               UNION ALL
               SELECT
                   DATEADD(MONTH, 1, [MonthsCTE].[Month])
               FROM
                   [MonthsCTE]
               WHERE
                   DATEADD(MONTH, 1, [MonthsCTE].[Month]) <= DATEADD(MONTH, @MonthsCount - 1, @StartDate))
        INSERT INTO [#GeneratedMonths]
            (
                [Month]
            )
                    SELECT
                        [MonthsCTE].[Month]
                    FROM
                        [MonthsCTE];


        INSERT INTO [dbo].[sample_table]
            (
                [Month],
                [data]
            )
                    SELECT
                        [#GeneratedMonths].[Month],
                        'test'
                    FROM
                        [#GeneratedMonths];

        DROP TABLE [#GeneratedMonths];

    END;

GO
