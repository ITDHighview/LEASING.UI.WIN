SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO

CREATE OR ALTER PROCEDURE [dbo].[sp_GetProjectStatusCount]
    @ProjectId AS INT         = NULL,
    @UnitStatus   VARCHAR(15) = NULL,
    @ProjStatus   VARCHAR(15) = NULL
AS
    BEGIN
        SET NOCOUNT ON;
        IF @ProjectId = 0
           AND @ProjStatus = '--ALL--'
           AND
               (
                   @UnitStatus = ''
                   OR @UnitStatus = '--ALL--'
               )
            BEGIN
                SELECT
                    (
                        SELECT
                            COUNT(*)
                        FROM
                            [dbo].[tblUnitMstr]
                        WHERE
                            --[tblUnitMstr].[ProjectId] = @ProjectId
                            ISNULL([tblUnitMstr].[UnitStatus], '') = 'VACANT'
                    ) AS [VACANT_COUNT],
                    (
                        SELECT
                            COUNT(*)
                        FROM
                            [dbo].[tblUnitMstr]
                        WHERE
                            --[tblUnitMstr].[ProjectId] = @ProjectId
                            ISNULL([tblUnitMstr].[UnitStatus], '') = 'MOVE-IN'
                    ) AS [OCCUPIED_COUNT],
                    (
                        SELECT
                            COUNT(*)
                        FROM
                            [dbo].[tblUnitMstr]
                        WHERE
                            --[tblUnitMstr].[ProjectId] = @ProjectId
                            ISNULL([tblUnitMstr].[UnitStatus], '') = 'RESERVED'
                    ) AS [RESERVED_COUNT],
                    (
                        SELECT
                            COUNT(*)
                        FROM
                            [dbo].[tblUnitMstr]
                        WHERE
                            --[tblUnitMstr].[ProjectId] = @ProjectId
                            ISNULL([tblUnitMstr].[UnitStatus], '') = 'NOT AVAILABLE'
                    ) AS [NOT_AVAILABLE_COUNT],
                    (
                        SELECT
                            COUNT(*)
                        FROM
                            [dbo].[tblUnitMstr]
                        WHERE
                            --[tblUnitMstr].[ProjectId] = @ProjectId
                            ISNULL([tblUnitMstr].[UnitStatus], '') = 'HOLD'
                    ) AS [HOLD_COUNT]
            END
        ELSE IF @ProjectId = 0
                AND @ProjStatus = '--ALL--'
                AND @UnitStatus <> '--ALL--'
            BEGIN
                SELECT
                    IIF(@UnitStatus = 'VACANT',
                        (
                            SELECT
                                COUNT(*)
                            FROM
                                [dbo].[tblUnitMstr]
                            WHERE
                                --[tblUnitMstr].[ProjectId] = @ProjectId
                                ISNULL([tblUnitMstr].[UnitStatus], '') = 'VACANT'
                        ),
                        0) AS [VACANT_COUNT],
                    IIF(@UnitStatus = 'MOVE-IN',
                        (
                            SELECT
                                COUNT(*)
                            FROM
                                [dbo].[tblUnitMstr]
                            WHERE
                                --[tblUnitMstr].[ProjectId] = @ProjectId
                                ISNULL([tblUnitMstr].[UnitStatus], '') = 'MOVE-IN'
                        ),
                        0) AS [OCCUPIED_COUNT],
                    IIF(@UnitStatus = 'RESERVED',
                        (
                            SELECT
                                COUNT(*)
                            FROM
                                [dbo].[tblUnitMstr]
                            WHERE
                                --[tblUnitMstr].[ProjectId] = @ProjectId
                                ISNULL([tblUnitMstr].[UnitStatus], '') = 'RESERVED'
                        ),
                        0) AS [RESERVED_COUNT],
                    IIF(@UnitStatus = 'NOT AVAILABLE',
                        (
                            SELECT
                                COUNT(*)
                            FROM
                                [dbo].[tblUnitMstr]
                            WHERE
                                --[tblUnitMstr].[ProjectId] = @ProjectId
                                ISNULL([tblUnitMstr].[UnitStatus], '') = 'NOT AVAILABLE'
                        ),
                        0) AS [NOT_AVAILABLE_COUNT],
                    IIF(@UnitStatus = 'HOLD',
                        (
                            SELECT
                                COUNT(*)
                            FROM
                                [dbo].[tblUnitMstr]
                            WHERE
                                --[tblUnitMstr].[ProjectId] = @ProjectId
                                ISNULL([tblUnitMstr].[UnitStatus], '') = 'HOLD'
                        ),
                        0) AS [HOLD_COUNT]
            END
        ELSE IF @ProjectId > 0
                AND @ProjStatus <> '--ALL--'
                AND
                    (
                        @UnitStatus = ''
                        OR @UnitStatus = '--ALL--'
                    )
            BEGIN
                SELECT
                    (
                        SELECT
                            COUNT(*)
                        FROM
                            [dbo].[tblUnitMstr]
                        WHERE
                            [tblUnitMstr].[ProjectId] = @ProjectId
                            AND ISNULL([tblUnitMstr].[UnitStatus], '') = 'VACANT'
                    ) AS [VACANT_COUNT],
                    (
                        SELECT
                            COUNT(*)
                        FROM
                            [dbo].[tblUnitMstr]
                        WHERE
                            [tblUnitMstr].[ProjectId] = @ProjectId
                            AND ISNULL([tblUnitMstr].[UnitStatus], '') = 'MOVE-IN'
                    ) AS [OCCUPIED_COUNT],
                    (
                        SELECT
                            COUNT(*)
                        FROM
                            [dbo].[tblUnitMstr]
                        WHERE
                            [tblUnitMstr].[ProjectId] = @ProjectId
                            AND ISNULL([tblUnitMstr].[UnitStatus], '') = 'RESERVED'
                    ) AS [RESERVED_COUNT],
                    (
                        SELECT
                            COUNT(*)
                        FROM
                            [dbo].[tblUnitMstr]
                        WHERE
                            [tblUnitMstr].[ProjectId] = @ProjectId
                            AND ISNULL([tblUnitMstr].[UnitStatus], '') = 'NOT AVAILABLE'
                    ) AS [NOT_AVAILABLE_COUNT],
                    (
                        SELECT
                            COUNT(*)
                        FROM
                            [dbo].[tblUnitMstr]
                        WHERE
                            [tblUnitMstr].[ProjectId] = @ProjectId
                            AND ISNULL([tblUnitMstr].[UnitStatus], '') = 'HOLD'
                    ) AS [HOLD_COUNT]
            END
        ELSE IF @ProjectId > 0
                AND @ProjStatus <> '--ALL--'
                AND
                    (
                        @UnitStatus <> ''
                        OR @UnitStatus <> '--ALL--'
                    )
            BEGIN
                SELECT
                    IIF(@UnitStatus = 'VACANT',
                        (
                            SELECT
                                COUNT(*)
                            FROM
                                [dbo].[tblUnitMstr]
                            WHERE
                                [tblUnitMstr].[ProjectId] = @ProjectId
                                AND ISNULL([tblUnitMstr].[UnitStatus], '') = 'VACANT'
                        ),
                        0) AS [VACANT_COUNT],
                    IIF(@UnitStatus = 'MOVE-IN',
                        (
                            SELECT
                                COUNT(*)
                            FROM
                                [dbo].[tblUnitMstr]
                            WHERE
                                [tblUnitMstr].[ProjectId] = @ProjectId
                                AND ISNULL([tblUnitMstr].[UnitStatus], '') = 'MOVE-IN'
                        ),
                        0) AS [OCCUPIED_COUNT],
                    IIF(@UnitStatus = 'RESERVED',
                        (
                            SELECT
                                COUNT(*)
                            FROM
                                [dbo].[tblUnitMstr]
                            WHERE
                                [tblUnitMstr].[ProjectId] = @ProjectId
                                AND ISNULL([tblUnitMstr].[UnitStatus], '') = 'RESERVED'
                        ),
                        0) AS [RESERVED_COUNT],
                    IIF(@UnitStatus = 'NOT AVAILABLE',
                        (
                            SELECT
                                COUNT(*)
                            FROM
                                [dbo].[tblUnitMstr]
                            WHERE
                                [tblUnitMstr].[ProjectId] = @ProjectId
                                AND ISNULL([tblUnitMstr].[UnitStatus], '') = 'NOT AVAILABLE'
                        ),
                        0) AS [NOT_AVAILABLE_COUNT],
                    IIF(@UnitStatus = 'HOLD',
                        (
                            SELECT
                                COUNT(*)
                            FROM
                                [dbo].[tblUnitMstr]
                            WHERE
                                [tblUnitMstr].[ProjectId] = @ProjectId
                                AND ISNULL([tblUnitMstr].[UnitStatus], '') = 'HOLD'
                        ),
                        0) AS [HOLD_COUNT]
            END

    END
GO

