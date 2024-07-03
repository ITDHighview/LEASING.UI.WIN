USE [LEASINGDB]

DECLARE @n CHAR(1)
SET @n = CHAR(10)

DECLARE @stmt NVARCHAR(MAX)

-- procedures
SELECT
    @stmt
    = ISNULL(@stmt + @n, '') + N'drop procedure [' + SCHEMA_NAME([procedures].[schema_id]) + N'].['
      + [procedures].[name] + N']'
FROM
    [sys].[procedures]


-- check constraints
SELECT
    @stmt
    = ISNULL(@stmt + @n, '') + N'alter table [' + SCHEMA_NAME([check_constraints].[schema_id]) + N'].['
      + OBJECT_NAME([check_constraints].[parent_object_id]) + N']    drop constraint [' + [check_constraints].[name]
      + N']'
FROM
    [sys].[check_constraints]

-- functions
SELECT
    @stmt
    = ISNULL(@stmt + @n, '') + N'drop function [' + SCHEMA_NAME([objects].[schema_id]) + N'].[' + [objects].[name]
      + N']'
FROM
    [sys].[objects]
WHERE
    [objects].[type] IN (
                            'FN', 'IF', 'TF'
                        )

-- views
SELECT
    @stmt = ISNULL(@stmt + @n, '') + N'drop view [' + SCHEMA_NAME([views].[schema_id]) + N'].[' + [views].[name] + N']'
FROM
    [sys].[views]

-- foreign keys
SELECT
    @stmt
    = ISNULL(@stmt + @n, '') + N'alter table [' + SCHEMA_NAME([foreign_keys].[schema_id]) + N'].['
      + OBJECT_NAME([foreign_keys].[parent_object_id]) + N'] drop constraint [' + [foreign_keys].[name] + N']'
FROM
    [sys].[foreign_keys]

-- tables
SELECT
    @stmt
    = ISNULL(@stmt + @n, '') + N'drop table [' + SCHEMA_NAME([tables].[schema_id]) + N'].[' + [tables].[name] + N']'
FROM
    [sys].[tables]

-- user defined types
SELECT
    @stmt = ISNULL(@stmt + @n, '') + N'drop type [' + SCHEMA_NAME([types].[schema_id]) + N'].[' + [types].[name] + N']'
FROM
    [sys].[types]
WHERE
    [types].[is_user_defined] = 1


EXEC [sys].[sp_executesql]
    @stmt