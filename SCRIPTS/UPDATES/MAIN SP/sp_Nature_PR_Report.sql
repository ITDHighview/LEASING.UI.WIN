--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
ALTER PROCEDURE [sp_Nature_PR_Report]
AS
    BEGIN
        SET NOCOUNT ON;


        CREATE TABLE [#TMP]
            (
                [client_no]     VARCHAR(50),
                [lot_area]      DECIMAL(18, 2),
                [Res_pay]       DECIMAL(18, 2),
                [Cash_sale]     DECIMAL(18, 2),
                [DP_Pay]        DECIMAL(18, 2),
                [MA_Pay]        DECIMAL(18, 2),
                [VAT]           DECIMAL(18, 2),
                [Others]        DECIMAL(18, 2),
                [Tot_Cash]      DECIMAL(18, 2),
                [Tot_Chk]       DECIMAL(18, 2),
                [Tot_Pay]       DECIMAL(18, 2),
                [PR_No]         VARCHAR(50),
                [Penalty]       DECIMAL(18, 2),
                [phase]         VARCHAR(50),
                [tran_date]     DATE,
                [interest]      DECIMAL(18, 2),
                [tcost]         DECIMAL(18, 2),
                [tcp]           DECIMAL(18, 2),
                [tin]           VARCHAR(50),
                [AmountInWords] VARCHAR(MAX),
            );


        INSERT INTO [#TMP]
            (
                [client_no],
                [lot_area],
                [Res_pay],
                [Cash_sale],
                [DP_Pay],
                [MA_Pay],
                [VAT],
                [Others],
                [Tot_Cash],
                [Tot_Chk],
                [Tot_Pay],
                [PR_No],
                [Penalty],
                [phase],
                [tran_date],
                [interest],
                [tcost],
                [tcp],
                [tin],
                [AmountInWords]
            )
        VALUES
            (
                'INV10000010',            -- client_no - varchar(50)
                3.75,                     -- lot_area - decimal(18, 2)
                100,                      -- Res_pay - decimal(18, 2)
                50,                       -- Cash_sale - decimal(18, 2)
                100,                      -- DP_Pay - decimal(18, 2)
                100,                      -- MA_Pay - decimal(18, 2)
                10,                       -- VAT - decimal(18, 2)
                100,                      -- Others - decimal(18, 2)
                100,                      -- Tot_Cash - decimal(18, 2)
                100,                      -- Tot_Chk - decimal(18, 2)
                100,                      -- Tot_Pay - decimal(18, 2)
                '12345689',               -- PR_No - varchar(50)
                100,                      -- Penalty - decimal(18, 2)
                'DEMO PHASE',             -- phase - varchar(50)
                CONVERT(DATE, GETDATE()), -- tran_date - date
                100,                      -- interest - decimal(18, 2)
                100,                      -- tcost - decimal(18, 2)
                100,                      -- tcp - decimal(18, 2)
                '12312123', 8662.50       -- tin - varchar(50)
            );

        SELECT
            [#TMP].[client_no],
            [#TMP].[lot_area],
            [#TMP].[Res_pay],
            [#TMP].[Cash_sale],
            [#TMP].[DP_Pay],
            [#TMP].[MA_Pay],
            [#TMP].[VAT],
            [#TMP].[Others],
            [#TMP].[Tot_Cash],
            [#TMP].[Tot_Chk],
            [#TMP].[Tot_Pay],
            [#TMP].[PR_No],
            [#TMP].[Penalty],
            [#TMP].[phase],
            [#TMP].[tran_date],
            [#TMP].[interest],
            [#TMP].[tcost],
            [#TMP].[tcp],
            [#TMP].[tin],
            [#TMP].[AmountInWords]
        FROM
            [#TMP];


        DROP TABLE [#TMP];
    END;
GO
