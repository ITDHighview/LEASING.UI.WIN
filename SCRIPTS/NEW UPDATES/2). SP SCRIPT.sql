USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[demo_REPORT]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[demo_REPORT]
AS
    BEGIN
        SET NOCOUNT ON;


        CREATE TABLE [#TMP]
            (
                [client_no] VARCHAR(50),
                [lot_area]  DECIMAL(18, 2),
                [Res_pay]   DECIMAL(18, 2),
                [Cash_sale] DECIMAL(18, 2),
                [DP_Pay]    DECIMAL(18, 2),
                [MA_Pay]    DECIMAL(18, 2),
                [VAT]       DECIMAL(18, 2),
                [Others]    DECIMAL(18, 2),
                [Tot_Cash]  DECIMAL(18, 2),
                [Tot_Chk]   DECIMAL(18, 2),
                [Tot_Pay]   DECIMAL(18, 2),
                [PR_No]     VARCHAR(50),
                [Penalty]   DECIMAL(18, 2),
                [phase]     VARCHAR(50),
                [tran_date] DATE,
                [interest]  DECIMAL(18, 2),
                [tcost]     DECIMAL(18, 2),
                [tcp]       DECIMAL(18, 2),
                [tin]       VARCHAR(50),
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
                [tin]
            )
        VALUES
            (
                'INV10000010', -- client_no - varchar(50)
                3.75, -- lot_area - decimal(18, 2)
                100, -- Res_pay - decimal(18, 2)
                50, -- Cash_sale - decimal(18, 2)
                100, -- DP_Pay - decimal(18, 2)
                100, -- MA_Pay - decimal(18, 2)
                10, -- VAT - decimal(18, 2)
                100, -- Others - decimal(18, 2)
                100, -- Tot_Cash - decimal(18, 2)
                100, -- Tot_Chk - decimal(18, 2)
                100, -- Tot_Pay - decimal(18, 2)
                '12345689', -- PR_No - varchar(50)
                100, -- Penalty - decimal(18, 2)
                'DEMO PHASE', -- phase - varchar(50)
                CONVERT(DATE,GETDATE()), -- tran_date - date
                100, -- interest - decimal(18, 2)
                100, -- tcost - decimal(18, 2)
                100, -- tcp - decimal(18, 2)
                '12312123'  -- tin - varchar(50)
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
            [#TMP].[tin]
        FROM
            [#TMP];


        DROP TABLE [#TMP];
    END;
GO
/****** Object:  StoredProcedure [dbo].[GenerateInsertsMomths]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[GenerateStringWithIdentity_DEBUG]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GenerateStringWithIdentity_DEBUG]
AS
BEGIN
    DECLARE @IdentityNumber INT
    DECLARE @GeneratedString VARCHAR(50)

    -- Get the latest identity value
    SELECT @IdentityNumber = IDENT_CURRENT('demoTable')+1

    -- Increment the identity value if it is less than 100
    IF @IdentityNumber < 1000
        SET @IdentityNumber = 1000

    -- Generate the string
    SET @GeneratedString = 'CORP-' + RIGHT('00' + CAST(@IdentityNumber + 1 AS VARCHAR(10)), 3)

    -- Output the generated string
    SELECT @GeneratedString AS GeneratedString
END
GO
/****** Object:  StoredProcedure [dbo].[sp_ActivateLocationById]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_ActivateLocationById] @RecId INT
AS
    BEGIN

        SET NOCOUNT ON;

        UPDATE
            [dbo].[tblLocationMstr]
        SET
            [tblLocationMstr].[IsActive] = 1
        WHERE
            [tblLocationMstr].[RecId] = @RecId;

        IF (@@ROWCOUNT > 0)
            BEGIN

                SELECT
                    'SUCCESS' AS [Message_Code];

            END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ActivatePojectById]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_ActivatePojectById] @RecId INT
AS
    BEGIN

        SET NOCOUNT ON;

        UPDATE
            [dbo].[tblProjectMstr]
        SET
            [tblProjectMstr].[IsActive] = 1
        WHERE
            [tblProjectMstr].[RecId] = @RecId;

        IF (@@ROWCOUNT > 0)
            BEGIN

                SELECT
                    'SUCCESS' AS [Message_Code];

            END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_activatePurchaseItemById]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC sp_GetPurchaseItemInfoById @RecId = 2
-- =============================================
CREATE PROCEDURE [dbo].[sp_activatePurchaseItemById] @RecId INT
AS
    BEGIN

        SET NOCOUNT ON;

        UPDATE
            [dbo].[tblProjPurchItem]
        SET
            [tblProjPurchItem].[IsActive] = 1
        WHERE
            [tblProjPurchItem].[RecId] = @RecId;


        IF (@@ROWCOUNT > 0)
            BEGIN
                SELECT
                    'SUCCESS' AS [Message_Code];
            END;


    END;

GO
/****** Object:  StoredProcedure [dbo].[sp_CheckContractProjectType]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_CheckContractProjectType] @RefId AS VARCHAR(20) = NULL
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT
                [tblUnitReference].[RefId],
                [tblUnitReference].[UnitId],
                [tblUnitMstr].[UnitNo],
                [tblUnitMstr].[FloorType],
                IIF(ISNULL([tblUnitReference].[Unit_IsParking], 0) = 1, 'PARKING', 'UNIT') AS [UnitType],
                [tblProjectMstr].[ProjectType]
        FROM
                [dbo].[tblUnitReference]
            INNER JOIN
                [dbo].[tblUnitMstr]
                    ON [tblUnitMstr].[RecId] = [tblUnitReference].[UnitId]
            INNER JOIN
                [dbo].[tblProjectMstr]
                    ON [tblUnitMstr].[ProjectId] = [tblProjectMstr].[RecId]
        WHERE
                [tblUnitReference].[RefId] = @RefId;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CheckHoldPenalty]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_CheckHoldPenalty]
--@parameter_name AS INT
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN

    DECLARE @startDate DATE = '2023-01-01'; -- Replace with your actual start date
    DECLARE @endDate DATE = '2023-01-30'; -- Replace with your actual end date
    DECLARE @thresholdDays INT = 30; -- Replace with your desired threshold
    DECLARE @initialAmount DECIMAL(10, 2) = 1000; -- Replace with your initial amount

    DECLARE @dateDifference INT = DATEDIFF(DAY, @startDate, @endDate);
    DECLARE @totalMonths INT;
    DECLARE @remainingDays INT;
    DECLARE @penaltyPercentage DECIMAL(5, 2);
    DECLARE @penaltyAmount DECIMAL(10, 2);
    DECLARE @message NVARCHAR(100);

    SET @totalMonths = DATEDIFF(MONTH, @startDate, @endDate);
    SET @remainingDays = @dateDifference - (@totalMonths * @thresholdDays);

    -- Calculate penalty based on the conditions
    IF @dateDifference > @thresholdDays
    BEGIN
        -- Calculate penalty percentage based on the number of months
        SET @penaltyPercentage = @totalMonths * 3.00; -- 3% penalty per month

        -- Calculate penalty amount
        SET @penaltyAmount = (@penaltyPercentage / 100) * @initialAmount;

        SET @message = N'Penalty: ' + CAST(@penaltyAmount AS NVARCHAR(20));
    END;
    ELSE
    BEGIN
        SET @message = N'No Penalty';
    END;

    PRINT 'Total Months: ' + CAST(@totalMonths AS NVARCHAR(10)) + ', Remaining Days: '
          + CAST(@remainingDays AS NVARCHAR(10));
    PRINT 'Message: ' + @message;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CheckIfOrIsEmpty]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_CheckIfOrIsEmpty] @TranId AS VARCHAR(30) = NULL
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    SELECT [tblReceipt].[RecId],
           [tblReceipt].[RcptID],
           [tblReceipt].[TranId],
           --[tblReceipt].[Amount],
           --[tblReceipt].[Description],
           --[tblReceipt].[Remarks],
           --[tblReceipt].[EncodedBy],
           --[tblReceipt].[EncodedDate],
           --[tblReceipt].[LastChangedBy],
           --[tblReceipt].[LastChangedDate],
           --[tblReceipt].[ComputerName],
           --[tblReceipt].[IsActive],
           --[tblReceipt].[PaymentMethod],
           ISNULL([tblReceipt].[CompanyORNo], '') AS [CompanyORNo],
           --[tblReceipt].[BankAccountName],
           --[tblReceipt].[BankAccountNumber],
           --[tblReceipt].[BankName],
           --[tblReceipt].[SerialNo],
           --[tblReceipt].[REF],
           ISNULL([tblReceipt].[CompanyPRNo], '') AS [CompanyPRNo]
    FROM [dbo].[tblReceipt]
    WHERE [tblReceipt].[TranId] = @TranId;


END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CheckOrNumber]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--EXEC [sp_CheckOrNumber] '234234234'
CREATE PROCEDURE [dbo].[sp_CheckOrNumber] @CompanyORNo AS VARCHAR(100) = NULL
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT
            1 AS [IsExist]
        FROM
            [dbo].[tblPaymentMode]
        WHERE
            [tblPaymentMode].[CompanyORNo] = @CompanyORNo;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CheckPRNumber]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--EXEC [sp_CheckOrNumber] '234234234'
CREATE PROCEDURE [dbo].[sp_CheckPRNumber] @CompanyPRNo AS VARCHAR(100) = NULL
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT
            1 AS [IsExist]
        FROM
            [dbo].[tblPaymentMode]
        WHERE
            [tblPaymentMode].[CompanyPRNo] = @CompanyPRNo;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_CloseContract]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_CloseContract]
    @ReferenceID  VARCHAR(50) = NULL,
    @EncodedBy    INT         = NULL,
    @ComputerName VARCHAR(20) = NULL
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        DECLARE @Message_Code NVARCHAR(MAX);

        -- Insert statements for procedure here
        UPDATE
            [dbo].[tblUnitReference]
        SET
            [tblUnitReference].[IsDone] = 1,
            [tblUnitReference].[LastCHangedBy] = @EncodedBy,
            [tblUnitReference].[ContactDoneDate] = GETDATE()
        WHERE
            [tblUnitReference].[RefId] = @ReferenceID;

        IF (@@ROWCOUNT > 0)
            BEGIN
                -- Log a success event
                INSERT INTO [dbo].[LoggingEvent]
                    (
                        [EventType],
                        [EventMessage]
                    )
                VALUES
                    (
                        'SUCCESS',
                        'Result From : sp_CloseContract -(' + @ReferenceID
                        + ': IsDone=1) tblUnitReference updated successfully'
                    );

                SET @Message_Code = N'SUCCESS';
            END;
        ELSE
            BEGIN
                -- Log an error event
                INSERT INTO [dbo].[LoggingEvent]
                    (
                        [EventType],
                        [EventMessage]
                    )
                VALUES
                    (
                        'ERROR', 'Result From : sp_CloseContract -' + 'No rows affected in tblUnitReference table'
                    );

            END;

        UPDATE
            [dbo].[tblUnitMstr]
        SET
            [tblUnitMstr].[UnitStatus] = 'HOLD'
        --LastChangedBy = @EncodedBy,
        --ComputerName = @ComputerName,
        --LastChangedDate = GETDATE()
        WHERE
            [RecId] =
            (
                SELECT
                    [tblUnitReference].[UnitId]
                FROM
                    [dbo].[tblUnitReference] WITH (NOLOCK)
                WHERE
                    [tblUnitReference].[RefId] = @ReferenceID
            );
        IF (@@ROWCOUNT > 0)
            BEGIN
                -- Log a success event
                INSERT INTO [dbo].[LoggingEvent]
                    (
                        [EventType],
                        [EventMessage]
                    )
                VALUES
                    (
                        'SUCCESS',
                        'Result From : sp_CloseContract -(UnitStatus= HOLD) tblUnitMstr updated successfully'
                    );

                SET @Message_Code = N'SUCCESS';
            END;
        ELSE
            BEGIN
                -- Log an error event
                INSERT INTO [dbo].[LoggingEvent]
                    (
                        [EventType],
                        [EventMessage]
                    )
                VALUES
                    (
                        'ERROR', 'Result From : sp_CloseContract -' + 'No rows affected in tblUnitMstr table'
                    );

            END;
        -- Log the error message
        DECLARE @ErrorMessage NVARCHAR(MAX);
        SET @ErrorMessage = ERROR_MESSAGE();

        IF @ErrorMessage <> ''
            BEGIN
                -- Log an error event
                INSERT INTO [dbo].[LoggingEvent]
                    (
                        [EventType],
                        [EventMessage]
                    )
                VALUES
                    (
                        'ERROR', 'From : sp_CloseContract -' + @ErrorMessage
                    );

                -- Insert into a logging table
                INSERT INTO [dbo].[ErrorLog]
                    (
                        [ProcedureName],
                        [ErrorMessage],
                        [LogDateTime]
                    )
                VALUES
                    (
                        'sp_CloseContract', @ErrorMessage, GETDATE()
                    );

                -- Return an error message				
                SET @Message_Code = @ErrorMessage;
            END;

        SELECT
            @Message_Code AS [Message_Code];

    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ConrtactSignedByPass]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ConrtactSignedByPass]
    @ReferenceId      VARCHAR(500) = NULL
   
AS
    BEGIN                 
        -- Update the flag in tblUnitReference
        
            BEGIN
                UPDATE
                    [dbo].[tblUnitReference]
                SET
                    [tblUnitReference].[IsSignedContract] = 1,
                    [tblUnitReference].[SignedContractDate] = GETDATE()
                WHERE
                    [tblUnitReference].[RefId] = @ReferenceId;

                IF (@@ROWCOUNT > 0)
                    BEGIN
                        -- Log a success event
                        INSERT INTO [dbo].[LoggingEvent]
                            (
                                [EventType],
                                [EventMessage]
                            )
                        VALUES
                            (
                                'SUCCESS',
                                'Result From : sp_ConrtactSignedByPass -' + '(' + @ReferenceId
                                + ': IsSignedContract = 1 ) UnitReference updated successfully'
                            );

                        SELECT
                            'SUCCESS' AS [Message_Code];
                    END;
                ELSE
                    BEGIN

                        -- Log an error event
                        INSERT INTO [dbo].[LoggingEvent]
                            (
                                [EventType],
                                [EventMessage]
                            )
                        VALUES
                            (
                                'ERROR', 'Result From : sp_ConrtactSignedByPass -' + 'No rows affected in UnitReference table'
                            );
                    END;
            END;
        -- Log the error message
        DECLARE @ErrorMessage NVARCHAR(MAX);
        SET @ErrorMessage = ERROR_MESSAGE();


        IF @ErrorMessage <> ''
            BEGIN
                -- Log an error event
                INSERT INTO [dbo].[LoggingEvent]
                    (
                        [EventType],
                        [EventMessage]
                    )
                VALUES
                    (
                        'ERROR', 'From : sp_ConrtactSignedByPass -' + @ErrorMessage
                    );

                -- Insert into a logging table
                INSERT INTO [dbo].[ErrorLog]
                    (
                        [ProcedureName],
                        [ErrorMessage],
                        [LogDateTime]
                    )
                VALUES
                    (
                        'sp_ConrtactSignedByPass', @ErrorMessage, GETDATE()
                    );

                -- Return an error message
                SELECT
                    'ERROR'       AS [Message_Code],
                    @ErrorMessage AS [ErrorMessage];
            END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ContractSignedCommercialReport]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_ContractSignedCommercialReport] @RefId AS VARCHAR(20) = NULL
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
    BEGIN
        SET NOCOUNT ON;



        SELECT
                DAY([dbo].[tblUnitReference].[EncodedDate])                                                                 AS [ThisDayOf],
                DATENAME(MONTH, [dbo].[tblUnitReference].[EncodedDate])                                                     AS [InMonth],
                DATENAME(YEAR, [dbo].[tblUnitReference].[EncodedDate])                                                      AS [OfYear],
                CONVERT(VARCHAR(10), [tblUnitReference].[StatDate], 103) + ' - '
                + CONVERT(VARCHAR(10), [tblUnitReference].[FinishDate], 103)                                                AS [ByAndBetween],
                [tblCompany].[CompanyName]                                                                                  AS [CompanyName],
                [tblCompany].[CompanyAddress]                                                                               AS [CompanyAddress],
                [tblCompany].[CompanyOwnerName]                                                                             AS [CompanyOwnerName],
                [tblClientMstr].[ClientName]                                                                                AS [LesseeName],            ---CLIENT NAME
                'Certificate of Title No. 001-2021003286'                                                                   AS [CertificateOfTitle],
                'Under The Trade Name Of'                                                                                   AS [UnderTheTradeNameOf],   ---CLIENT UNDER OF?
                [tblClientMstr].[PostalAddress]                                                                             AS [LesseeAddress],         ---CLIENT ADDRESS


                UPPER([tblProjectMstr].[ProjectName])                                                                       AS [TheLessorIsTheOwnerOf], ---PROJECT NAME
                [tblProjectMstr].[ProjectAddress]                                                                           AS [Situated],              ---PROJECT ADDRESS

                [tblUnitMstr].[UnitNo]                                                                                      AS [LeasedUnit],            ---UNIT NUMBER
                [tblUnitMstr].[AreaSqm]                                                                                     AS [AreaOf],                ---UNIT AREA

                UPPER([dbo].[fnNumberToWordsWithDecimalMain]([tblUnitMstr].[AreaSqm])) + 'decimeters'                       AS [AreaByWord],            ---UNIT AREA

                CONVERT(VARCHAR(20), [tblUnitReference].[StatDate], 107)                                                    AS [YearStarting],
                CONVERT(VARCHAR(20), [tblUnitReference].[FinishDate], 107)                                                  AS [YearEnding],
                CONVERT(VARCHAR(20), [tblUnitReference].[StatDate], 107) + ' - '
                + CONVERT(VARCHAR(20), [tblUnitReference].[FinishDate], 107)                                                AS [PeriodCover],
                UPPER([dbo].[fnNumberToWordsWithDecimal]([tblUnitReference].[TotalRent])) + ' PESOS ONLY ('
                + CAST([tblUnitReference].[TotalRent] AS VARCHAR(100)) + ')'                                                AS [RentalForLeased_AmountInWords],
                UPPER([dbo].[fnNumberToWordsWithDecimal]([tblUnitReference].[SecAndMaintenance])) + '('
                + CAST([tblUnitReference].[SecAndMaintenance] AS VARCHAR(100)) + ')'                                        AS [AsShareInSecAndMaint_AmountInWords],
                UPPER([dbo].[fnNumberToWordsWithDecimal]([tblUnitReference].[TotalRent])) + '('
                + CAST([tblUnitReference].[TotalRent] AS VARCHAR(100)) + ')'                                                AS [TotalAmountInYear_AmountInWords],
                CAST([tblUnitReference].[Unit_Vat] AS VARCHAR(100)) + ' %'                                                  AS [VatPercentage_WithWords],
                CAST([tblUnitReference].[PenaltyPct] AS VARCHAR(100)) + ' %'                                                AS [PenaltyPercentage_WithWords],
                [tblClientMstr].[ClientName]                                                                                AS [Lessee],
                [tblUnitReference].[Unit_TotalRental]                                                                       AS [MonthlyRentalOfVat],
                [tblUnitReference].[Unit_BaseRentalVatAmount]                                                               AS [Vatlessor],
                [tblUnitReference].[Unit_TaxAmount]                                                                         AS [WithHoldingTax],
                [tblUnitReference].[Unit_TotalRental]                                                                       AS [RentDuePerMonth],
                [tblUnitReference].[GenVat]                                                                                 AS [VatDisplay],
                [tblUnitReference].[WithHoldingTax]                                                                         AS [TaxDisplay],
                [dbo].[fnGetBaseSecAmount]([tblUnitReference].[UnitId])                                                     AS [SecBaseAmount],
                [dbo].[fnGetSecVatAmount]([tblUnitReference].[UnitId])                                                      AS [SecVatAmount],
                [dbo].[fnGetBaseSecAmount]([tblUnitReference].[UnitId])
                + [dbo].[fnGetSecVatAmount]([tblUnitReference].[UnitId])                                                    AS [SecRentDue],
                [tblUnitReference].[Unit_TotalRental]                                                                       AS [TotalRentAmount],
                UPPER([dbo].[fnNumberToWordsWithDecimal]([tblUnitReference].[SecDeposit])) + 'PESOS ONLY ' + ' ('
                + CAST(ISNULL([tblUnitReference].[SecDeposit], 0) AS VARCHAR(50)) + ') '                                    AS [SecDepositByWords],
                UPPER([dbo].[fnNumberToWordsWithDecimal]([dbo].[fnGetTotalMonthAdvanceAmount]([tblUnitReference].[RefId])))
                + 'PESOS ONLY ' + ' ('
                + CAST(ISNULL([dbo].[fnGetTotalMonthAdvanceAmount]([tblUnitReference].[RefId]), 0) AS VARCHAR(50)) + ') '   AS [MonthAdvanceByWords],
                UPPER([dbo].[fnNumberToWordsWithDecimal]([dbo].[fnGetTotalMonthPostDatedAmount]([tblUnitReference].[RecId])))
                + 'PESOS ONLY ' + ' ('
                + CAST(ISNULL([dbo].[fnGetTotalMonthPostDatedAmount]([tblUnitReference].[RecId]), 0) AS VARCHAR(50)) + ') ' AS [TotalMonthPostDatedAmount],
                [dbo].[fnGetAdvancePeriodCover]([tblUnitReference].[RefId])                                                 AS [AdvanceMonthPeriodCover],
                [dbo].[fnGetPostDatedPeriodCover]([tblUnitReference].[RecId])                                               AS [PostDatedPeriodCover],
                CAST([tblUnitReference].[SecDeposit] / [tblUnitReference].[TotalRent] AS INT)                               AS [SecDepositCount],
                [dbo].[fnGetAdvanceMonthCount]([dbo].[tblUnitReference].[RefId])                                            AS [MonthAdvanceCount],
                [dbo].[fnGetPostDatedMonthCount]([tblUnitReference].[RecId])                                                AS [PostDatedCheckCount],
                [dbo].[fnNumberToWordsWithDecimal]([dbo].[fnGetPostDatedMonthCount]([tblUnitReference].[RecId]))            AS [PostDatedCheckCountbyWord],
                CAST(DATENAME(DAY, [tblUnitReference].[StatDate]) AS VARCHAR(50))                                           AS [PostDatedDay],
                [dbo].[fnGetClientIsRenewal]([dbo].[tblUnitReference].[ClientID], [dbo].[tblUnitReference].[ProjectId])
                + '(' + UPPER([dbo].[fnGetProjectTypeByUnitId]([dbo].[tblUnitReference].[UnitId])) + ')'                    AS [ContractTitle]
        FROM
                [dbo].[tblUnitReference] WITH (NOLOCK)
            INNER JOIN
                [dbo].[tblProjectMstr] WITH (NOLOCK)
                    ON [dbo].[tblUnitReference].[ProjectId] = [tblProjectMstr].[RecId]
            INNER JOIN
                [dbo].[tblCompany] WITH (NOLOCK)
                    ON [tblProjectMstr].[CompanyId] = [tblCompany].[RecId]
            INNER JOIN
                [dbo].[tblClientMstr] WITH (NOLOCK)
                    ON [tblUnitReference].[ClientID] = [tblClientMstr].[ClientID]
            INNER JOIN
                [dbo].[tblUnitMstr] WITH (NOLOCK)
                    ON [dbo].[tblUnitReference].[UnitId] = [tblUnitMstr].[RecId]
        WHERE
                [tblUnitReference].[RefId] = @RefId
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ContractSignedParkingReport]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ContractSignedParkingReport] @RefId AS VARCHAR(20) = NULL
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT
                DAY([dbo].[tblUnitReference].[EncodedDate])                                                                                                     AS [ThisDayOf],
                DATENAME(MONTH, [dbo].[tblUnitReference].[EncodedDate])                                                                                         AS [InMonth],
                DATENAME(YEAR, [dbo].[tblUnitReference].[EncodedDate])                                                                                          AS [OfYear],
                CONVERT(VARCHAR(10), [tblUnitReference].[StatDate], 103) + ' - '
                + CONVERT(VARCHAR(10), [tblUnitReference].[FinishDate], 103)                                                                                    AS [ByAndBetween],
                UPPER([tblCompany].[CompanyName])                                                                                                               AS [CompanyName],
                [tblCompany].[CompanyAddress]                                                                                                                   AS [CompanyAddress],
                [tblCompany].[CompanyOwnerName]                                                                                                                 AS [CompanyOwnerName],
                [tblClientMstr].[ClientName]                                                                                                                    AS [LesseeName],            ---CLIENT NAME
                'Under The Trade Name Of'                                                                                                                       AS [UnderTheTradeNameOf],   ---CLIENT UNDER OF?
                [tblClientMstr].[PostalAddress]                                                                                                                 AS [LesseeAddress],         ---CLIENT ADDRESS

                UPPER([tblProjectMstr].[ProjectName])                                                                                                           AS [TheLessorIsTheOwnerOf], ---PROJECT NAME
                [tblProjectMstr].[ProjectAddress]                                                                                                               AS [Situated],              ---PROJECT ADDRESS

                [tblUnitMstr].[UnitNo]                                                                                                                          AS [LeasedUnit],            ---UNIT NUMBER
                [tblUnitMstr].[AreaSqm]                                                                                                                         AS [AreaOf],                ---UNIT AREA

                CONVERT(VARCHAR(20), [tblUnitReference].[StatDate], 107)                                                                                        AS [YearStarting],
                CONVERT(VARCHAR(20), [tblUnitReference].[FinishDate], 107)                                                                                      AS [YearEnding],
                UPPER([dbo].[fnNumberToWordsWithDecimal]([tblUnitReference].[Unit_BaseRentalWithVatAmount])) + '('
                + CAST([tblUnitReference].[Unit_BaseRentalWithVatAmount] AS VARCHAR(100)) + ')'                                                                 AS [RentalForLeased_AmountInWords],
                UPPER([dbo].[fnNumberToWordsWithDecimal]([tblUnitReference].[Unit_SecAndMainWithVatAmount])) + '('
                + CAST([tblUnitReference].[Unit_SecAndMainWithVatAmount] AS VARCHAR(100)) + ')'                                                                 AS [AsShareInSecAndMaint_AmountInWords],
                UPPER([dbo].[fnNumberToWordsWithDecimal]([tblUnitReference].[TotalRent])) + '('
                + CAST([tblUnitReference].[TotalRent] AS VARCHAR(100)) + ')'                                                                                    AS [TotalAmountInYear_AmountInWords],
                CAST([tblUnitReference].[GenVat] AS VARCHAR(100)) + ' %'                                                                                        AS [VatPercentage_WithWords],
                [tblClientMstr].[ClientName]                                                                                                                    AS [Lessee],
                [dbo].[fnGetClientIsRenewal]([dbo].[tblUnitReference].[ClientID], [dbo].[tblUnitReference].[ProjectId])
                + '(' + 'PARKING' + ')'                                                                                                                         AS [ContractTitle],
                CAST(CONCAT(
                               CONVERT(VARCHAR(10), [tblUnitReference].[StatDate], 101), '-',
                               CONVERT(VARCHAR(10), [tblUnitReference].[FinishDate], 101)
                           ) AS VARCHAR(150))                                                                                                                   AS [TPeriodCoverd],
                CAST(CAST([tblUnitReference].[Unit_BaseRentalWithVatAmount] - [tblUnitReference].[Unit_BaseRentalVatAmount] AS DECIMAL(18, 2)) AS VARCHAR(150)) AS [TMonthlyRental],
                CAST([tblUnitReference].[Unit_SecAndMainAmount] AS VARCHAR(150))                                                                                AS [TSecurityandMaintenance],
                CONCAT(CAST([tblUnitReference].[Unit_Vat] AS VARCHAR(150)), ' % VAT')                                                                           AS [TLableVAT],
                CAST(CAST([tblUnitReference].[Unit_BaseRentalVatAmount] + [tblUnitReference].[Unit_SecAndMainVatAmount] AS DECIMAL(18, 2)) AS VARCHAR(150))     AS [TVAT],
                CAST([tblUnitReference].[Unit_TotalRental] AS VARCHAR(150))                                                                                     AS [TTotalMonthlyRental],
				CAST(DATENAME(DAY,[tblUnitReference].[StatDate])AS VARCHAR(150)) AS [DayOfMonth]
        FROM
                [dbo].[tblUnitReference] WITH (NOLOCK)
            INNER JOIN
                [dbo].[tblProjectMstr] WITH (NOLOCK)
                    ON [dbo].[tblUnitReference].[ProjectId] = [tblProjectMstr].[RecId]
            INNER JOIN
                [dbo].[tblCompany] WITH (NOLOCK)
                    ON [tblProjectMstr].[CompanyId] = [tblCompany].[RecId]
            INNER JOIN
                [dbo].[tblClientMstr] WITH (NOLOCK)
                    ON [tblUnitReference].[ClientID] = [tblClientMstr].[ClientID]
            INNER JOIN
                [dbo].[tblUnitMstr] WITH (NOLOCK)
                    ON [dbo].[tblUnitReference].[UnitId] = [tblUnitMstr].[RecId]
        WHERE
                [tblUnitReference].[RefId] = @RefId


    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ContractSignedResidentialReport]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_ContractSignedResidentialReport] @RefId AS VARCHAR(20) = NULL
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT
                DAY([dbo].[tblUnitReference].[EncodedDate])                                                                                                     AS [ThisDayOf],
                DATENAME(MONTH, [dbo].[tblUnitReference].[EncodedDate])                                                                                         AS [InMonth],
                DATENAME(YEAR, [dbo].[tblUnitReference].[EncodedDate])                                                                                          AS [OfYear],
                CONVERT(VARCHAR(10), [tblUnitReference].[StatDate], 103) + ' - '
                + CONVERT(VARCHAR(10), [tblUnitReference].[FinishDate], 103)                                                                                    AS [ByAndBetween],
                UPPER([tblCompany].[CompanyName])                                                                                                               AS [CompanyName],
                [tblCompany].[CompanyAddress]                                                                                                                   AS [CompanyAddress],
                [tblCompany].[CompanyOwnerName]                                                                                                                 AS [CompanyOwnerName],
                [tblClientMstr].[ClientName]                                                                                                                    AS [LesseeName],            ---CLIENT NAME
                'Under The Trade Name Of'                                                                                                                       AS [UnderTheTradeNameOf],   ---CLIENT UNDER OF?
                [tblClientMstr].[PostalAddress]                                                                                                                 AS [LesseeAddress],         ---CLIENT ADDRESS

                UPPER([tblProjectMstr].[ProjectName])                                                                                                           AS [TheLessorIsTheOwnerOf], ---PROJECT NAME
                [tblProjectMstr].[ProjectAddress]                                                                                                               AS [Situated],              ---PROJECT ADDRESS

                [tblUnitMstr].[UnitNo]                                                                                                                          AS [LeasedUnit],            ---UNIT NUMBER
                [tblUnitMstr].[AreaSqm]                                                                                                                         AS [AreaOf],                ---UNIT AREA

                CONVERT(VARCHAR(20), [tblUnitReference].[StatDate], 107)                                                                                        AS [YearStarting],
                CONVERT(VARCHAR(20), [tblUnitReference].[FinishDate], 107)                                                                                      AS [YearEnding],
                UPPER([dbo].[fnNumberToWordsWithDecimal]([tblUnitReference].[Unit_BaseRentalWithVatAmount])) + '('
                + CAST([tblUnitReference].[Unit_BaseRentalWithVatAmount] AS VARCHAR(100)) + ')'                                                                 AS [RentalForLeased_AmountInWords],
                UPPER([dbo].[fnNumberToWordsWithDecimal]([tblUnitReference].[Unit_SecAndMainWithVatAmount])) + '('
                + CAST([tblUnitReference].[Unit_SecAndMainWithVatAmount] AS VARCHAR(100)) + ')'                                                                 AS [AsShareInSecAndMaint_AmountInWords],
                UPPER([dbo].[fnNumberToWordsWithDecimal]([tblUnitReference].[TotalRent])) + '('
                + CAST([tblUnitReference].[TotalRent] AS VARCHAR(100)) + ')'                                                                                    AS [TotalAmountInYear_AmountInWords],
                CAST([tblUnitReference].[GenVat] AS VARCHAR(100)) + ' %'                                                                                        AS [VatPercentage_WithWords],
                [tblClientMstr].[ClientName]                                                                                                                    AS [Lessee],
                [dbo].[fnGetClientIsRenewal]([dbo].[tblUnitReference].[ClientID], [dbo].[tblUnitReference].[ProjectId])
                + '(' + UPPER([dbo].[fnGetProjectTypeByUnitId]([dbo].[tblUnitReference].[UnitId])) + ')'                                                        AS [ContractTitle],
                CAST(CONCAT(
                               CONVERT(VARCHAR(10), [tblUnitReference].[StatDate], 101), '-',
                               CONVERT(VARCHAR(10), [tblUnitReference].[FinishDate], 101)
                           ) AS VARCHAR(150))                                                                                                                   AS [TPeriodCoverd],
                CAST(CAST([tblUnitReference].[Unit_BaseRentalWithVatAmount] - [tblUnitReference].[Unit_BaseRentalVatAmount] AS DECIMAL(18, 2)) AS VARCHAR(150)) AS [TMonthlyRental],
                CAST([tblUnitReference].[Unit_SecAndMainAmount] AS VARCHAR(150))                                                                                AS [TSecurityandMaintenance],
                CONCAT(CAST([tblUnitReference].[Unit_Vat] AS VARCHAR(150)), ' % VAT')                                                                           AS [TLableVAT],
                CAST(CAST([tblUnitReference].[Unit_BaseRentalVatAmount] + [tblUnitReference].[Unit_SecAndMainVatAmount] AS DECIMAL(18, 2)) AS VARCHAR(150))     AS [TVAT],
                CAST([tblUnitReference].[Unit_TotalRental] AS VARCHAR(150))                                                                                     AS [TTotalMonthlyRental]
        FROM
                [dbo].[tblUnitReference] WITH (NOLOCK)
            INNER JOIN
                [dbo].[tblProjectMstr] WITH (NOLOCK)
                    ON [dbo].[tblUnitReference].[ProjectId] = [tblProjectMstr].[RecId]
            INNER JOIN
                [dbo].[tblCompany] WITH (NOLOCK)
                    ON [tblProjectMstr].[CompanyId] = [tblCompany].[RecId]
            INNER JOIN
                [dbo].[tblClientMstr] WITH (NOLOCK)
                    ON [tblUnitReference].[ClientID] = [tblClientMstr].[ClientID]
            INNER JOIN
                [dbo].[tblUnitMstr] WITH (NOLOCK)
                    ON [dbo].[tblUnitReference].[UnitId] = [tblUnitMstr].[RecId]
        WHERE
                [tblUnitReference].[RefId] = @RefId


    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ContractSignedWarehouseReport]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_ContractSignedWarehouseReport] @RefId AS VARCHAR(20) = NULL
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
    BEGIN
        SET NOCOUNT ON;


        SELECT
                DAY([dbo].[tblUnitReference].[EncodedDate])                                                                 AS [ThisDayOf],
                DATENAME(MONTH, [dbo].[tblUnitReference].[EncodedDate])                                                     AS [InMonth],
                DATENAME(YEAR, [dbo].[tblUnitReference].[EncodedDate])                                                      AS [OfYear],
                CONVERT(VARCHAR(10), [tblUnitReference].[StatDate], 103) + ' - '
                + CONVERT(VARCHAR(10), [tblUnitReference].[FinishDate], 103)                                                AS [ByAndBetween],
                UPPER([tblCompany].[CompanyName])                                                                           AS [CompanyName],
                [tblCompany].[CompanyAddress]                                                                               AS [CompanyAddress],
                [tblCompany].[CompanyOwnerName]                                                                             AS [CompanyOwnerName],
                [tblClientMstr].[ClientName]                                                                                AS [LesseeName],            ---CLIENT NAME
                'Certificate of Title No. 001-2021003286'                                                                   AS [CertificateOfTitle],
                'Under The Trade Name Of'                                                                                   AS [UnderTheTradeNameOf],   ---CLIENT UNDER OF?
                [tblClientMstr].[PostalAddress]                                                                             AS [LesseeAddress],         ---CLIENT ADDRESS


                UPPER([tblProjectMstr].[ProjectName])                                                                       AS [TheLessorIsTheOwnerOf], ---PROJECT NAME
                [tblProjectMstr].[ProjectAddress]                                                                           AS [Situated],              ---PROJECT ADDRESS

                [tblUnitMstr].[UnitNo]                                                                                      AS [LeasedUnit],            ---UNIT NUMBER
                [tblUnitMstr].[AreaSqm]                                                                                     AS [AreaOf],                ---UNIT AREA

                UPPER([dbo].[fnNumberToWordsWithDecimalMain]([tblUnitMstr].[AreaSqm]))                                      AS [AreaByWord],            ---UNIT AREA

                CONVERT(VARCHAR(20), [tblUnitReference].[StatDate], 107)                                                    AS [YearStarting],
                CONVERT(VARCHAR(20), [tblUnitReference].[FinishDate], 107)                                                  AS [YearEnding],
                CONVERT(VARCHAR(20), [tblUnitReference].[StatDate], 107) + ' - '
                + CONVERT(VARCHAR(20), [tblUnitReference].[FinishDate], 107)                                                AS [PeriodCover],
                UPPER([dbo].[fnNumberToWordsWithDecimal]([tblUnitReference].[TotalRent])) + ' PESOS ONLY ('
                + CAST([tblUnitReference].[TotalRent] AS VARCHAR(100)) + ')'                                                AS [RentalForLeased_AmountInWords],
                UPPER([dbo].[fnNumberToWordsWithDecimal]([tblUnitReference].[SecAndMaintenance])) + '('
                + CAST([tblUnitReference].[SecAndMaintenance] AS VARCHAR(100)) + ')'                                        AS [AsShareInSecAndMaint_AmountInWords],
                UPPER([dbo].[fnNumberToWordsWithDecimal]([tblUnitReference].[TotalRent])) + '('
                + CAST([tblUnitReference].[TotalRent] AS VARCHAR(100)) + ')'                                                AS [TotalAmountInYear_AmountInWords],
                CAST([tblUnitReference].[Unit_Vat] AS VARCHAR(100)) + ' %'                                                  AS [VatPercentage_WithWords],
                CAST([tblUnitReference].[PenaltyPct] AS VARCHAR(100)) + ' %'                                                AS [PenaltyPercentage_WithWords],
                [tblClientMstr].[ClientName]                                                                                AS [Lessee],
                [tblUnitReference].[Unit_TotalRental]                                                                       AS [MonthlyRentalOfVat],
                [tblUnitReference].[Unit_BaseRentalVatAmount]                                                               AS [Vatlessor],
                [tblUnitReference].[Unit_TaxAmount]                                                                         AS [WithHoldingTax],
                [tblUnitReference].[Unit_TotalRental]                                                                       AS [RentDuePerMonth],
                [tblUnitReference].[GenVat]                                                                                 AS [VatDisplay],
                [tblUnitReference].[WithHoldingTax]                                                                         AS [TaxDisplay],
                [tblUnitReference].[Unit_SecAndMainAmount]                                                                  AS [SecBaseAmount],
                [dbo].[fnGetSecVatAmount]([tblUnitReference].[UnitId])                                                      AS [SecVatAmount],
                [tblUnitReference].[Unit_SecAndMainWithVatAmount]                                                           AS [SecRentDue],
                [tblUnitReference].[Unit_TotalRental]                                                                       AS [TotalRentAmount],
                UPPER([dbo].[fnNumberToWordsWithDecimal]([tblUnitReference].[SecDeposit])) + 'PESOS ONLY ' + ' ('
                + CAST(ISNULL([tblUnitReference].[SecDeposit], 0) AS VARCHAR(50)) + ') '                                    AS [SecDepositByWords],
                UPPER([dbo].[fnNumberToWordsWithDecimal]([dbo].[fnGetTotalMonthAdvanceAmount]([tblUnitReference].[RefId])))
                + 'PESOS ONLY ' + ' ('
                + CAST(ISNULL([dbo].[fnGetTotalMonthAdvanceAmount]([tblUnitReference].[RefId]), 0) AS VARCHAR(50)) + ') '   AS [MonthAdvanceByWords],
                UPPER([dbo].[fnNumberToWordsWithDecimal]([dbo].[fnGetTotalMonthPostDatedAmount]([tblUnitReference].[RecId])))
                + 'PESOS ONLY ' + ' ('
                + CAST(ISNULL([dbo].[fnGetTotalMonthPostDatedAmount]([tblUnitReference].[RecId]), 0) AS VARCHAR(50)) + ') ' AS [TotalMonthPostDatedAmountInWords],
                [dbo].[fnGetAdvancePeriodCover]([tblUnitReference].[RefId])                                                 AS [AdvanceMonthPeriodCover],
                [dbo].[fnGetPostDatedPeriodCover]([tblUnitReference].[RecId])                                               AS [PostDatedPeriodCover],
                CAST([tblUnitReference].[SecDeposit] / [tblUnitReference].[TotalRent] AS INT)                               AS [SecDepositCount],
                [dbo].[fnGetAdvanceMonthCount]([dbo].[tblUnitReference].[RefId])                                            AS [MonthAdvanceCount],
                [dbo].[fnGetPostDatedMonthCount]([tblUnitReference].[RecId])                                                AS [PostDatedCheckCount],
                [dbo].[fnNumberToWordsWithDecimal]([dbo].[fnGetPostDatedMonthCount]([tblUnitReference].[RecId]))            AS [PostDatedCheckCountbyWord],
                CAST(DATENAME(DAY, [tblUnitReference].[StatDate]) AS VARCHAR(50))                                           AS [PostDatedDay],
                [dbo].[fnGetClientIsRenewal]([dbo].[tblUnitReference].[ClientID], [dbo].[tblUnitReference].[ProjectId])
                + '(' + UPPER([dbo].[fnGetProjectTypeByUnitId]([dbo].[tblUnitReference].[UnitId])) + ')'                    AS [ContractTitle]
        --[fnGetTotalMonthPostDatedAmount]
        FROM
                [dbo].[tblUnitReference] WITH (NOLOCK)
            INNER JOIN
                [dbo].[tblProjectMstr] WITH (NOLOCK)
                    ON [dbo].[tblUnitReference].[ProjectId] = [tblProjectMstr].[RecId]
            INNER JOIN
                [dbo].[tblCompany] WITH (NOLOCK)
                    ON [tblProjectMstr].[CompanyId] = [tblCompany].[RecId]
            INNER JOIN
                [dbo].[tblClientMstr] WITH (NOLOCK)
                    ON [tblUnitReference].[ClientID] = [tblClientMstr].[ClientID]
            INNER JOIN
                [dbo].[tblUnitMstr] WITH (NOLOCK)
                    ON [dbo].[tblUnitReference].[UnitId] = [tblUnitMstr].[RecId]
        WHERE
                [tblUnitReference].[RefId] = @RefId
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_DeActivateLocationById]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_DeActivateLocationById] @RecId INT
AS
    BEGIN

        SET NOCOUNT ON;

        UPDATE
            [dbo].[tblLocationMstr]
        SET
            [tblLocationMstr].[IsActive] = 0
        WHERE
            [tblLocationMstr].[RecId] = @RecId;

        IF (@@ROWCOUNT > 0)
            BEGIN

                SELECT
                    'SUCCESS' AS [Message_Code];

            END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_DeActivatePojectById]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_DeActivatePojectById] @RecId INT
AS
    BEGIN

        SET NOCOUNT ON;

        UPDATE
            [dbo].[tblProjectMstr]
        SET
            [tblProjectMstr].[IsActive] = 0
        WHERE
            [tblProjectMstr].[RecId] = @RecId;

        IF (@@ROWCOUNT > 0)
            BEGIN

                SELECT
                    'SUCCESS' AS [Message_Code];

            END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_DeactivatePurchaseItemById]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC sp_GetPurchaseItemInfoById @RecId = 2
-- =============================================
CREATE PROCEDURE [dbo].[sp_DeactivatePurchaseItemById] @RecId INT
AS
    BEGIN

        SET NOCOUNT ON;

        UPDATE
            [dbo].[tblProjPurchItem]
        SET
            [tblProjPurchItem].[IsActive] = 0
        WHERE
            [tblProjPurchItem].[RecId] = @RecId;


        IF (@@ROWCOUNT > 0)
            BEGIN
                SELECT
                    'SUCCESS' AS [Message_Code];
            END;


    END;

GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteBankName]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_DeleteBankName] @BankName VARCHAR(50) = NULL
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        DECLARE @Message_Code VARCHAR(MAX) = '';
        -- Insert statements for procedure here
        IF EXISTS
            (
                SELECT
                    [tblBankName].[BankName]
                FROM
                    [dbo].[tblBankName]
                WHERE
                    [tblBankName].[BankName] = @BankName
            )
            BEGIN

                DELETE FROM
                [dbo].[tblBankName]
                WHERE
                    [tblBankName].[BankName] = @BankName;
                IF (@@ROWCOUNT > 0)
                    BEGIN
                        SET @Message_Code = 'SUCCESS';
                    END;
            END;

        SELECT
            @Message_Code AS [Message_Code];
    END;

GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteFile]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_DeleteFile] @FilePath NVARCHAR(500)
AS
    BEGIN
        DELETE FROM
        [dbo].[Files]
        WHERE
            [Files].[FilePath] = @FilePath;
        -- Log a success event    
        IF (@@ROWCOUNT > 0)
            BEGIN
                -- Log a success event
                INSERT INTO [dbo].[LoggingEvent]
                    (
                        [EventType],
                        [EventMessage]
                    )
                VALUES
                    (
                        'SUCCESS', 'Result From : sp_DeleteFile -(' + @FilePath + ') File deleted successfully'
                    );

                SELECT
                    'SUCCESS' AS [Message_Code];
            END;
        ELSE
            BEGIN


                -- Log an error event
                INSERT INTO [dbo].[LoggingEvent]
                    (
                        [EventType],
                        [EventMessage]
                    )
                VALUES
                    (
                        'ERROR', 'Result From : sp_DeleteFile -' + 'No rows affected in Files table'
                    );
            END;
        -- Log the error message
        DECLARE @ErrorMessage NVARCHAR(MAX);
        SET @ErrorMessage = ERROR_MESSAGE();


        IF @ErrorMessage <> ''
            BEGIN
                -- Log an error event
                INSERT INTO [dbo].[LoggingEvent]
                    (
                        [EventType],
                        [EventMessage]
                    )
                VALUES
                    (
                        'ERROR', 'From : sp_DeleteFile -' + @ErrorMessage
                    );

                -- Insert into a logging table
                INSERT INTO [dbo].[ErrorLog]
                    (
                        [ProcedureName],
                        [ErrorMessage],
                        [LogDateTime]
                    )
                VALUES
                    (
                        'sp_DeleteFile', 'From : sp_DeleteFile -' + @ErrorMessage, GETDATE()
                    );

                -- Return an error message
                SELECT
                    'ERROR'       AS [Message_Code],
                    @ErrorMessage AS [ErrorMessage];
            END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteLocationById]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_DeleteLocationById] 
					@RecId INT
					
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


	DELETE FROM tblLocationMstr WHERE RecId = @RecId

	if(@@ROWCOUNT > 0)
	BEGIN

	SELECT 'SUCCESS' AS Message_Code

	END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_DeletePojectById]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_DeletePojectById] @RecId INT
AS
    BEGIN

        SET NOCOUNT ON;


        DELETE FROM
        [dbo].[tblProjectMstr]
        WHERE
            [tblProjectMstr].[RecId] = @RecId;

        IF (@@ROWCOUNT > 0)
            BEGIN

                SELECT
                    'SUCCESS' AS [Message_Code];

            END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_DeletePurchaseItemById]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_DeletePurchaseItemById] @RecId INT
AS
    BEGIN

        SET NOCOUNT ON;


        DELETE FROM
        [dbo].[tblProjPurchItem]
        WHERE
            [tblProjPurchItem].[RecId] = @RecId;

        IF (@@ROWCOUNT > 0)
            BEGIN

                SELECT
                    'SUCCESS' AS [Message_Code];

            END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_DeleteUnitReferenceById]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_DeleteUnitReferenceById]
    @RecId  INT,
    @UnitId INT
AS
    BEGIN

        SET NOCOUNT ON;

        UPDATE
            [dbo].[tblUnitMstr]
        SET
            [tblUnitMstr].[UnitStatus] = 'VACANT'
        WHERE
            [tblUnitMstr].[RecId] = @UnitId;
        DELETE FROM
        [dbo].[tblUnitReference]
        WHERE
            [tblUnitReference].[RecId] = @RecId;

        IF (@@ROWCOUNT > 0)
            BEGIN

                SELECT
                    'SUCCESS' AS [Message_Code];

            END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GeneralReport]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_GeneralReport]
AS
BEGIN




    CREATE TABLE [#Temp]
    (
        [Dates] VARCHAR(500),
        [ORNumber] VARCHAR(500),
        [PRNumber] VARCHAR(500),
        [ApplicableMonth] VARCHAR(500),
        [Tenant] VARCHAR(500),
        [Unit] VARCHAR(500),
        [SecurityDeposit] VARCHAR(500),
        [BaseRental] VARCHAR(500),
        [Penalty] VARCHAR(500),
        [Vat] VARCHAR(500),
        [SecurityMaintenance] VARCHAR(500),
        [Tax] VARCHAR(500),
        [Total] VARCHAR(500),
        [Remarks] VARCHAR(500)
    )


	INSERT INTO [#Temp]
	(
	    [Dates],
	    [ORNumber],
	    [PRNumber],
	    [ApplicableMonth],
	    [Tenant],
	    [Unit],
	    [SecurityDeposit],
	    [BaseRental],
	    [Penalty],
	    [Vat],
	    [SecurityMaintenance],
	    [Tax],
	    [Total],
	    [Remarks]
	)
	VALUES
	(   NULL, -- Dates - varchar(500)
	    NULL, -- ORNumber - varchar(500)
	    NULL, -- PRNumber - varchar(500)
	    NULL, -- ApplicableMonth - varchar(500)
	    NULL, -- Tenant - varchar(500)
	    NULL, -- Unit - varchar(500)
	    NULL, -- SecurityDeposit - varchar(500)
	    NULL, -- BaseRental - varchar(500)
	    NULL, -- Penalty - varchar(500)
	    NULL, -- Vat - varchar(500)
	    NULL, -- SecurityMaintenance - varchar(500)
	    NULL, -- Tax - varchar(500)
	    NULL, -- Total - varchar(500)
	    NULL  -- Remarks - varchar(500)
	    )

--		SELECT CONVERT(VARCHAR(20), [tblTransaction].[EncodedDate], 103) AS [Dates],
--       [tblTransaction].[TranID] AS [TransactionNumber],
--       [tblTransaction].[ReceiveAmount] AS [Amount],
--       ISNULL([MonthLedger].[ActualAmountReceivePerMonth], [tblTransaction].[ReceiveAmount]) AS [ActualAmountReceivePerMonth],
--       [tblClientMstr].[ClientName] AS [Tenant]
--FROM [dbo].[tblTransaction]
--    CROSS APPLY
--(
--    SELECT SUM([tblMonthLedger].[ActualAmount]) AS [ActualAmountReceivePerMonth]
--    FROM [dbo].[tblMonthLedger]
--    WHERE [tblTransaction].[TranID] = [tblMonthLedger].[TransactionID]
--    GROUP BY [tblMonthLedger].[TransactionID]
--) [MonthLedger]
--    INNER JOIN [dbo].[tblUnitReference]
--        ON [tblTransaction].[RefId] = [tblUnitReference].[RefId]
--    INNER JOIN [dbo].[tblClientMstr]
--        ON [tblUnitReference].[ClientID] = [tblClientMstr].[ClientID]
--WHERE [tblUnitReference].[RefId] = 'REF10000000'


SELECT *
FROM [dbo].[tblUnitReference]
SELECT *
FROM [dbo].[tblTransaction]
SELECT *
FROM [dbo].[tblMonthLedger]


	SELECT [#Temp].[Dates],
       [#Temp].[ORNumber],
       [#Temp].[PRNumber],
       [#Temp].[ApplicableMonth],
       [#Temp].[Tenant],
       [#Temp].[Unit],
       [#Temp].[SecurityDeposit],
       [#Temp].[BaseRental],
       [#Temp].[Penalty],
       [#Temp].[Vat],
       [#Temp].[SecurityMaintenance],
       [#Temp].[Tax],
       [#Temp].[Total],
       [#Temp].[Remarks]
FROM [#Temp]


END
GO
/****** Object:  StoredProcedure [dbo].[sp_GenerateBulkPayment]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GenerateBulkPayment]
    -- Add the parameters for the stored procedure here
    @RefId VARCHAR(50) = NULL,
    @PaidAmount DECIMAL(18, 2) = NULL, ---Is Actual Amount From Payment Mode (Due Amount)
    @ReceiveAmount DECIMAL(18, 2) = NULL,
    @ChangeAmount DECIMAL(18, 2) = NULL,
    @SecAmountADV DECIMAL(18, 2) = NULL,
    @EncodedBy INT = NULL,
    @ComputerName VARCHAR(30) = NULL,
    @CompanyORNo VARCHAR(30) = NULL,
    @CompanyPRNo VARCHAR(30) = NULL,
    @BankAccountName VARCHAR(30) = NULL,
    @BankAccountNumber VARCHAR(30) = NULL,
    @BankName VARCHAR(30) = NULL,
    @SerialNo VARCHAR(30) = NULL,
    @PaymentRemarks VARCHAR(100) = NULL,
    @REF VARCHAR(100) = NULL,
    @BankBranch VARCHAR(100) = NULL,
    @ModeType VARCHAR(20) = NULL,
    @XML XML
AS
BEGIN TRY
    SET NOCOUNT ON;
    DECLARE @ReturnMessage VARCHAR(200)
    DECLARE @TranRecId BIGINT = 0
    DECLARE @TranID VARCHAR(50) = ''
    DECLARE @RcptRecId BIGINT = 0
    DECLARE @RcptID VARCHAR(50) = ''
    DECLARE @ApplicableMonth1 DATE = NULL
    DECLARE @ApplicableMonth2 DATE = NULL
    DECLARE @IsFullPayment BIT = 0
    DECLARE @TotalRent DECIMAL(18, 2) = NULL
    DECLARE @PenaltyPct DECIMAL(18, 2) = NULL
    DECLARE @ActualAmount DECIMAL(18, 2) = NULL
    DECLARE @AmountToDeduct DECIMAL(18, 2)
    DECLARE @ForMonth DATE
    DECLARE @RefRecId BIGINT = NULL
    DECLARE @ForMonthRecID BIGINT = NULL

    DECLARE @ActualLedgeAMount BIGINT = NULL

    CREATE TABLE [#tblBulkPostdatedMonth]
    (
        [Recid] VARCHAR(10)
    )
    IF (@XML IS NOT NULL)
    BEGIN
        INSERT INTO [#tblBulkPostdatedMonth]
        (
            [Recid]
        )
        SELECT [ParaValues].[data].[value]('c1[1]', 'VARCHAR(10)')
        FROM @XML.[nodes]('/Table1') AS [ParaValues]([data])
    END

    SELECT @TotalRent = [tblUnitReference].[TotalRent],
           @PenaltyPct = [tblUnitReference].[PenaltyPct],
           @RefRecId = [tblUnitReference].[RecId]
    FROM [dbo].[tblUnitReference] WITH (NOLOCK)
    WHERE [tblUnitReference].[RefId] = @RefId

    UPDATE [dbo].[tblMonthLedger]
    SET [tblMonthLedger].[ActualAmount] = [tblMonthLedger].[LedgRentalAmount]
                                          + ISNULL([tblMonthLedger].[PenaltyAmount], 0)
    WHERE [tblMonthLedger].[ReferenceID] = @RefRecId
          AND
          (
              ISNULL([tblMonthLedger].[IsPaid], 0) = 0
              OR ISNULL([tblMonthLedger].[IsHold], 0) = 1
          )

    BEGIN TRANSACTION

    INSERT INTO [dbo].[tblTransaction]
    (
        [RefId],
        [PaidAmount],
        [ReceiveAmount],
        [ActualAmountPaid],
        [ChangeAmount], ---Not Assigned
        [Remarks],
        [EncodedBy],
        [EncodedDate],
        [ComputerName],
        [IsActive]
    )
    VALUES
    (@RefId, @PaidAmount, @ReceiveAmount, @ReceiveAmount, @ChangeAmount, 'FOLLOW-UP PAYMENT', @EncodedBy, GETDATE(),
     @ComputerName, 1);

    SET @TranRecId = @@IDENTITY
    SELECT @TranID = [tblTransaction].[TranID]
    FROM [dbo].[tblTransaction] WITH (NOLOCK)
    WHERE [tblTransaction].[RecId] = @TranRecId


    DECLARE [CursorName] CURSOR FOR
    SELECT IIF([tblMonthLedger].[BalanceAmount] > 0,
               [tblMonthLedger].[BalanceAmount],
               IIF([tblMonthLedger].[ActualAmount] > 0,
                   CAST([tblMonthLedger].[ActualAmount] AS DECIMAL(18, 2)),
                   [tblMonthLedger].[LedgRentalAmount])) AS [Amount],
           [tblMonthLedger].[LedgMonth],
           [tblMonthLedger].[Recid],
           [tblMonthLedger].[LedgAmount]
    FROM [dbo].[tblMonthLedger] WITH (NOLOCK)
    WHERE [tblMonthLedger].[ReferenceID] =
    (
        SELECT [tblUnitReference].[RecId]
        FROM [dbo].[tblUnitReference] WITH (NOLOCK)
        WHERE [tblUnitReference].[RefId] = @RefId
    )
          AND [tblMonthLedger].[Recid] IN
              (
                  SELECT [#tblBulkPostdatedMonth].[Recid]
                  FROM [#tblBulkPostdatedMonth] WITH (NOLOCK)
              )
          AND
          (
              ISNULL([tblMonthLedger].[IsPaid], 0) = 0
              OR ISNULL([tblMonthLedger].[IsHold], 0) = 1
          )
    ORDER BY [tblMonthLedger].[LedgMonth] ASC

    OPEN [CursorName]

    FETCH NEXT FROM [CursorName]
    INTO @AmountToDeduct,
         @ForMonth,
         @ForMonthRecID,
         @ActualLedgeAMount

    WHILE @@FETCH_STATUS = 0
    BEGIN


        SELECT @ActualAmount = [tblTransaction].[ActualAmountPaid]
        FROM [dbo].[tblTransaction]
        WHERE [tblTransaction].[RecId] = @TranRecId
        IF @ActualAmount > 0
        BEGIN
            UPDATE [dbo].[tblTransaction]
            SET [tblTransaction].[ActualAmountPaid] = [tblTransaction].[ActualAmountPaid] - @AmountToDeduct
            WHERE [tblTransaction].[RecId] = @TranRecId

            IF @ActualAmount >= @AmountToDeduct
            BEGIN
                UPDATE [dbo].[tblMonthLedger]
                SET [tblMonthLedger].[IsPaid] = 1,
                    [tblMonthLedger].[IsHold] = 0,
                    [tblMonthLedger].[CompanyORNo] = @CompanyORNo,
                    [tblMonthLedger].[CompanyPRNo] = @CompanyPRNo,
                    [tblMonthLedger].[REF] = @REF,
                    [tblMonthLedger].[BNK_ACCT_NAME] = @BankAccountName,
                    [tblMonthLedger].[BNK_ACCT_NUMBER] = @BankAccountNumber,
                    [tblMonthLedger].[BNK_NAME] = @BankName,
                    [tblMonthLedger].[SERIAL_NO] = @SerialNo,
                    [tblMonthLedger].[ModeType] = @ModeType,
                    [tblMonthLedger].[BankBranch] = @BankBranch,
                    [tblMonthLedger].[BalanceAmount] = 0,
                    [tblMonthLedger].[TransactionID] = @TranID
                WHERE [tblMonthLedger].[LedgMonth] = @ForMonth
                      AND
                      (
                          ISNULL([tblMonthLedger].[IsPaid], 0) = 0
                          OR ISNULL([tblMonthLedger].[IsHold], 0) = 1
                      )
                      AND [tblMonthLedger].[Recid] = @ForMonthRecID
                BEGIN
                    INSERT INTO [dbo].[tblPayment]
                    (
                        [TranId],
                        [RefId],
                        [Amount],
                        [ForMonth],
                        [Remarks],
                        [EncodedBy],
                        [EncodedDate],
                        [ComputerName],
                        [IsActive],
                        [Notes],
                        [LedgeRecid]
                    )
                    SELECT @TranID AS [TranId],
                           @RefId AS [RefId],
                           @AmountToDeduct AS [Amount], ---THIS IS NOT A ACTUAL AMOUNT PAID  FOR FUTURE JOIN TRAN TO PAYMENT TRANID TO GET THE ACTUAL SUM PAYMENT                   
                           [tblMonthLedger].[LedgMonth] AS [ForMonth],
                           'FOLLOW-UP PAYMENT' AS [Remarks],
                           @EncodedBy,
                           GETDATE(),                   --Dated payed
                           @ComputerName,
                           1,
                           [tblMonthLedger].[Remarks],
                           [tblMonthLedger].[Recid]
                    FROM [dbo].[tblMonthLedger] WITH (NOLOCK)
                    WHERE [tblMonthLedger].[ReferenceID] =
                    (
                        SELECT [tblUnitReference].[RecId]
                        FROM [dbo].[tblUnitReference] WITH (NOLOCK)
                        WHERE [tblUnitReference].[RefId] = @RefId
                    )
                          AND [tblMonthLedger].[Recid] IN ( @ForMonthRecID )
                END

            END
            ELSE IF @ActualAmount < @AmountToDeduct
            BEGIN
                UPDATE [dbo].[tblMonthLedger]
                SET [tblMonthLedger].[IsHold] = 1,
                    [tblMonthLedger].[CompanyORNo] = @CompanyORNo,
                    [tblMonthLedger].[CompanyPRNo] = @CompanyPRNo,
                    [tblMonthLedger].[REF] = @REF,
                    [tblMonthLedger].[BNK_ACCT_NAME] = @BankAccountName,
                    [tblMonthLedger].[BNK_ACCT_NUMBER] = @BankAccountNumber,
                    [tblMonthLedger].[BNK_NAME] = @BankName,
                    [tblMonthLedger].[SERIAL_NO] = @SerialNo,
                    [tblMonthLedger].[ModeType] = @ModeType,
                    [tblMonthLedger].[BankBranch] = @BankBranch,
                    [tblMonthLedger].[BalanceAmount] = ABS(@ActualAmount - @AmountToDeduct),
                    [tblMonthLedger].[TransactionID] = @TranID --- TRN WILL CHANGE IF ALWAYS A PAYMENT FOR BALANCE AMOUNT
                WHERE [tblMonthLedger].[LedgMonth] = @ForMonth
                      AND
                      (
                          ISNULL([tblMonthLedger].[IsPaid], 0) = 0
                          OR ISNULL([tblMonthLedger].[IsHold], 0) = 1
                      )
                      AND [tblMonthLedger].[Recid] = @ForMonthRecID

                INSERT INTO [dbo].[tblPayment]
                (
                    [TranId],
                    [RefId],
                    [Amount],
                    [ForMonth],
                    [Remarks],
                    [EncodedBy],
                    [EncodedDate],
                    [ComputerName],
                    [IsActive],
                    [Notes],
                    [LedgeRecid]
                )
                SELECT @TranID AS [TranId],
                       @RefId AS [RefId],
                       [tblMonthLedger].[LedgRentalAmount] - ABS(@ActualAmount - @AmountToDeduct) AS [Amount], ---THIS IS NOT A ACTUAL AMOUNT PAID  FOR FUTURE JOIN TRAN TO PAYMENT TRANID TO GET THE ACTUAL SUM PAYMENT                   
                       [tblMonthLedger].[LedgMonth] AS [ForMonth],
                       'FOLLOW-UP PAYMENT' AS [Remarks],
                       @EncodedBy,
                       GETDATE(),                                                                              --Dated payed
                       @ComputerName,
                       1,
                       [tblMonthLedger].[Remarks],
                       [tblMonthLedger].[Recid]
                FROM [dbo].[tblMonthLedger] WITH (NOLOCK)
                WHERE [tblMonthLedger].[ReferenceID] =
                (
                    SELECT [tblUnitReference].[RecId]
                    FROM [dbo].[tblUnitReference] WITH (NOLOCK)
                    WHERE [tblUnitReference].[RefId] = @RefId
                )
                      AND [tblMonthLedger].[Recid] IN ( @ForMonthRecID )

            END
        END

        FETCH NEXT FROM [CursorName]
        INTO @AmountToDeduct,
             @ForMonth,
             @ForMonthRecID,
             @ActualLedgeAMount
    END

    CLOSE [CursorName]
    DEALLOCATE [CursorName]

    UPDATE [dbo].[tblUnitReference]
    SET [tblUnitReference].[IsPaid] = 1
    WHERE [tblUnitReference].[RefId] = @RefId;


    INSERT INTO [dbo].[tblReceipt]
    (
        [TranId],
        [Amount],
        [Description],
        [Remarks],
        [EncodedBy],
        [EncodedDate],
        [ComputerName],
        [IsActive],
        [PaymentMethod],
        [CompanyORNo],
        [CompanyPRNo],
        [BankAccountName],
        [BankAccountNumber],
        [BankName],
        [SerialNo],
        [REF],
        [BankBranch],
        [RefId]
    )
    VALUES
    (@TranID, @ReceiveAmount, 'FOLLOW-UP PAYMENT', @PaymentRemarks, @EncodedBy, GETDATE(), @ComputerName, 1, @ModeType,
     @CompanyORNo, @CompanyPRNo, @BankAccountName, @BankAccountNumber, @BankName, @SerialNo, @REF, @BankBranch, @RefId);

    SET @RcptRecId = @@IDENTITY
    SELECT @RcptID = [tblReceipt].[RcptID]
    FROM [dbo].[tblReceipt] WITH (NOLOCK)
    WHERE [tblReceipt].[RecId] = @RcptRecId

    INSERT INTO [dbo].[tblPaymentMode]
    (
        [RcptID],
        [CompanyORNo],
        [CompanyPRNo],
        [REF],
        [BNK_ACCT_NAME],
        [BNK_ACCT_NUMBER],
        [BNK_NAME],
        [SERIAL_NO],
        [ModeType],
        [BankBranch]
    )
    VALUES
    (@RcptID, @CompanyORNo, @CompanyPRNo, @REF, @BankAccountName, @BankAccountNumber, @BankName, @SerialNo, @ModeType,
     @BankBranch);


    IF (@TranID <> '' AND @@ROWCOUNT > 0)
    BEGIN

        SET @ReturnMessage = 'SUCCESS';
    END
    ELSE
    BEGIN
        SET @ReturnMessage = ERROR_MESSAGE()
    END;
    SELECT @ReturnMessage AS [Message_Code],
           @RcptID AS [ReceiptID],
           @TranID AS [TranID]

    COMMIT TRANSACTION
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION

    SET @ReturnMessage = ERROR_MESSAGE()
    SELECT @ReturnMessage AS [ReturnMessage]
END CATCH
DROP TABLE [#tblBulkPostdatedMonth]


GO
/****** Object:  StoredProcedure [dbo].[sp_GenerateFirstPayment]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GenerateFirstPayment]
    -- Add the parameters for the stored procedure here
    @RefId VARCHAR(50) = NULL,
    @PaidAmount DECIMAL(18, 2) = NULL,
    @ReceiveAmount DECIMAL(18, 2) = NULL,
    @ChangeAmount DECIMAL(18, 2) = NULL,
    @SecAmountADV DECIMAL(18, 2) = NULL,
    @EncodedBy INT = NULL,
    @ComputerName VARCHAR(30) = NULL,
    @CompanyORNo VARCHAR(30) = NULL,
    @CompanyPRNo VARCHAR(30) = NULL,
    @BankAccountName VARCHAR(30) = NULL,
    @BankAccountNumber VARCHAR(30) = NULL,
    @BankName VARCHAR(30) = NULL,
    @SerialNo VARCHAR(30) = NULL,
    @PaymentRemarks VARCHAR(100) = NULL,
    @REF VARCHAR(100) = NULL,
    @BankBranch VARCHAR(100) = NULL,
    @ModeType VARCHAR(20) = NULL
AS
BEGIN TRY
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
    DECLARE @ReturnMessage VARCHAR(200);
    DECLARE @TranRecId BIGINT = 0;
    DECLARE @TranID VARCHAR(50) = '';
    DECLARE @RcptRecId BIGINT = 0;
    DECLARE @RcptID VARCHAR(50) = '';
    DECLARE @ApplicableMonth1 DATE = NULL;
    DECLARE @ApplicableMonth2 DATE = NULL;
    DECLARE @IsFullPayment BIT = 0;
    DECLARE @ActualAmount DECIMAL(18, 2) = NULL
    -- Insert statements for procedure here

    SELECT @IsFullPayment = ISNULL([tblUnitReference].[IsFullPayment], 0)
    FROM [dbo].[tblUnitReference]
    WHERE [tblUnitReference].[RefId] = @RefId;

    BEGIN TRANSACTION;

    INSERT INTO [dbo].[tblTransaction]
    (
        [RefId],
        [PaidAmount],
        [ReceiveAmount],
        [ActualAmountPaid],
        [ChangeAmount], ---Not Assigned
        [Remarks],
        [EncodedBy],
        [EncodedDate],
        [ComputerName],
        [IsActive]
    )
    VALUES
    (@RefId, @PaidAmount, @ReceiveAmount, @ReceiveAmount, @ChangeAmount,
     IIF(@IsFullPayment = 1,
         'FULL PAYMENT',
         IIF(@PaidAmount > @ReceiveAmount, 'PARTIAL - FIRST PAYMENT', 'FIRST PAYMENT')), @EncodedBy, GETDATE(),
     @ComputerName, 1);

    SET @TranRecId = @@IDENTITY;
    SELECT @TranID = [tblTransaction].[TranID]
    FROM [dbo].[tblTransaction]
    WHERE [tblTransaction].[RecId] = @TranRecId;

    SELECT @ActualAmount = [tblTransaction].[ActualAmountPaid]
    FROM [dbo].[tblTransaction]
    WHERE [tblTransaction].[RecId] = @TranRecId

    --1). IF Paid Amount > Actual amount ---IS Partial Payment-
    --2). Create A flag in UnitReference As Partial Payment--- Only for First Payment
    --3). Save The Balance Amount-IN UnitReference FirtsPaymentBalanceAmount
    --4). if parial payment dont insert in payment the security and maintenance only after will payall and datepay will be the final date last pay

    --IN PAYMENT HISTORy TO GET THE TRANSACTION FOR FIRST PARTIAL PAYMENT SUM THE AMOUNT OF [Remarks]= 'PARTIAL - FIRST PAYMENT' 
    --then MAP the MAX transactionid to tblpayment then display the payment history

    IF @IsFullPayment = 0
    BEGIN
        IF @PaidAmount > @ActualAmount
        BEGIN

            --PARTIAL PAYMENT

            UPDATE [dbo].[tblUnitReference]
            SET [tblUnitReference].[IsPartialPayment] = 1,
                [tblUnitReference].[FirtsPaymentBalanceAmount] = ABS(@PaidAmount - @ActualAmount)
            WHERE [tblUnitReference].[RefId] = @RefId

            INSERT INTO [dbo].[tblReceipt]
            (
                [TranId],
                [Amount],
                [Description],
                [Remarks],
                [EncodedBy],
                [EncodedDate],
                [ComputerName],
                [IsActive],
                [PaymentMethod],
                [CompanyORNo],
                [CompanyPRNo],
                [BankAccountName],
                [BankAccountNumber],
                [BankName],
                [SerialNo],
                [REF],
                [BankBranch],
                [RefId]
            )
            VALUES
            (@TranID, @ReceiveAmount, 'PARTIAL - FIRST PAYMENT', @PaymentRemarks, @EncodedBy, GETDATE(), @ComputerName,
             1  , @ModeType, @CompanyORNo, @CompanyPRNo, @BankAccountName, @BankAccountNumber, @BankName, @SerialNo,
             @REF, @BankBranch, @RefId);

            SET @RcptRecId = @@IDENTITY;
            SELECT @RcptID = [tblReceipt].[RcptID]
            FROM [dbo].[tblReceipt] WITH (NOLOCK)
            WHERE [tblReceipt].[RecId] = @RcptRecId;

            INSERT INTO [dbo].[tblPaymentMode]
            (
                [RcptID],
                [CompanyORNo],
                [CompanyPRNo],
                [REF],
                [BNK_ACCT_NAME],
                [BNK_ACCT_NUMBER],
                [BNK_NAME],
                [SERIAL_NO],
                [ModeType],
                [BankBranch]
            )
            VALUES
            (@RcptID, @CompanyORNo, @CompanyPRNo, @REF, @BankAccountName, @BankAccountNumber, @BankName, @SerialNo,
             @ModeType, @BankBranch);

        END
        ELSE
        BEGIN
            UPDATE [dbo].[tblUnitReference]
            SET [tblUnitReference].[FirtsPaymentBalanceAmount] = 0
            WHERE [tblUnitReference].[RefId] = @RefId
            INSERT INTO [dbo].[tblPayment]
            (
                [TranId],
                [RefId],
                [Amount],
                [ForMonth],
                [Remarks],
                [Notes],
                [EncodedBy],
                [EncodedDate],
                [ComputerName],
                [IsActive],
                [LedgeRecid]
            )
            SELECT @TranID AS [TranId],
                   @RefId AS [RefId],
                   [tblMonthLedger].[LedgRentalAmount] AS [Amount],
                   [tblMonthLedger].[LedgMonth] AS [ForMonth],
                   'MONTHS ADVANCE' AS [Remarks],
                   [tblMonthLedger].[Remarks] AS [Notes],
                   @EncodedBy,
                   GETDATE(), --Dated payed
                   @ComputerName,
                   1,
                   [tblMonthLedger].[Recid]
            FROM [dbo].[tblMonthLedger] WITH (NOLOCK)
            WHERE [tblMonthLedger].[ReferenceID] =
            (
                SELECT [tblUnitReference].[RecId]
                FROM [dbo].[tblUnitReference] WITH (NOLOCK)
                WHERE [tblUnitReference].[RefId] = @RefId
            )
                  AND [tblMonthLedger].[LedgMonth] IN
                      (
                          SELECT [tblAdvancePayment].[Months]
                          FROM [dbo].[tblAdvancePayment] WITH (NOLOCK)
                          WHERE [tblAdvancePayment].[RefId] = @RefId
                      )
                  AND ISNULL([tblMonthLedger].[IsPaid], 0) = 0
                  AND ISNULL([tblMonthLedger].[TransactionID], '') = ''
            UNION
            SELECT @TranID AS [TranId],
                   @RefId AS [RefId],
                   @SecAmountADV AS [Amount],
                   CONVERT(DATE, GETDATE()) AS [ForMonth],
                   'SECURITY DEPOSIT' AS [Remarks],
                   NULL,
                   @EncodedBy,
                   GETDATE(),
                   @ComputerName,
                   1,
                   0

            UPDATE [dbo].[tblUnitReference]
            SET [tblUnitReference].[IsPaid] = 1
            WHERE [tblUnitReference].[RefId] = @RefId;

            UPDATE [dbo].[tblMonthLedger]
            SET [tblMonthLedger].[IsPaid] = 1,
                [tblMonthLedger].[CompanyORNo] = @CompanyORNo,
                [tblMonthLedger].[CompanyPRNo] = @CompanyPRNo,
                [tblMonthLedger].[REF] = @REF,
                [tblMonthLedger].[BNK_ACCT_NAME] = @BankAccountName,
                [tblMonthLedger].[BNK_ACCT_NUMBER] = @BankAccountNumber,
                [tblMonthLedger].[BNK_NAME] = @BankName,
                [tblMonthLedger].[SERIAL_NO] = @SerialNo,
                [tblMonthLedger].[ModeType] = @ModeType,
                [tblMonthLedger].[BankBranch] = @BankBranch,
                [tblMonthLedger].[TransactionID] = @TranID
            WHERE [tblMonthLedger].[ReferenceID] =
            (
                SELECT [tblUnitReference].[RecId]
                FROM [dbo].[tblUnitReference] WITH (NOLOCK)
                WHERE [tblUnitReference].[RefId] = @RefId
            )
                  AND [tblMonthLedger].[LedgMonth] IN
                      (
                          SELECT [tblAdvancePayment].[Months]
                          FROM [dbo].[tblAdvancePayment] WITH (NOLOCK)
                          WHERE [tblAdvancePayment].[RefId] = @RefId
                      )
                  AND ISNULL([tblMonthLedger].[IsPaid], 0) = 0
                  AND ISNULL([tblMonthLedger].[TransactionID], '') = '';

            INSERT INTO [dbo].[tblReceipt]
            (
                [TranId],
                [Amount],
                [Description],
                [Remarks],
                [EncodedBy],
                [EncodedDate],
                [ComputerName],
                [IsActive],
                [PaymentMethod],
                [CompanyORNo],
                [CompanyPRNo],
                [BankAccountName],
                [BankAccountNumber],
                [BankName],
                [SerialNo],
                [REF],
                [BankBranch],
                [RefId]
            )
            VALUES
            (@TranID, @PaidAmount, 'FIRST PAYMENT', @PaymentRemarks, @EncodedBy, GETDATE(), @ComputerName, 1,
             @ModeType, @CompanyORNo, @CompanyPRNo, @BankAccountName, @BankAccountNumber, @BankName, @SerialNo, @REF,
             @BankBranch, @RefId);

            SET @RcptRecId = @@IDENTITY;
            SELECT @RcptID = [tblReceipt].[RcptID]
            FROM [dbo].[tblReceipt] WITH (NOLOCK)
            WHERE [tblReceipt].[RecId] = @RcptRecId;

            INSERT INTO [dbo].[tblPaymentMode]
            (
                [RcptID],
                [CompanyORNo],
                [CompanyPRNo],
                [REF],
                [BNK_ACCT_NAME],
                [BNK_ACCT_NUMBER],
                [BNK_NAME],
                [SERIAL_NO],
                [ModeType],
                [BankBranch]
            )
            VALUES
            (@RcptID, @CompanyORNo, @CompanyPRNo, @REF, @BankAccountName, @BankAccountNumber, @BankName, @SerialNo,
             @ModeType, @BankBranch);
        END
    END
    ELSE IF @IsFullPayment = 1
    BEGIN


        BEGIN
            UPDATE [dbo].[tblUnitReference]
            SET [tblUnitReference].[FirtsPaymentBalanceAmount] = 0
            WHERE [tblUnitReference].[RefId] = @RefId


            UPDATE [dbo].[tblUnitReference]
            SET [tblUnitReference].[IsPaid] = 1
            WHERE [tblUnitReference].[RefId] = @RefId;


            UPDATE [dbo].[tblMonthLedger]
            SET [tblMonthLedger].[IsPaid] = 1,
                [tblMonthLedger].[CompanyORNo] = @CompanyORNo,
                [tblMonthLedger].[CompanyPRNo] = @CompanyPRNo,
                [tblMonthLedger].[REF] = @REF,
                [tblMonthLedger].[BNK_ACCT_NAME] = @BankAccountName,
                [tblMonthLedger].[BNK_ACCT_NUMBER] = @BankAccountNumber,
                [tblMonthLedger].[BNK_NAME] = @BankName,
                [tblMonthLedger].[SERIAL_NO] = @SerialNo,
                [tblMonthLedger].[ModeType] = @ModeType,
                [tblMonthLedger].[BankBranch] = @BankBranch,
                [tblMonthLedger].[TransactionID] = @TranID
            WHERE [tblMonthLedger].[ReferenceID] =
            (
                SELECT [tblUnitReference].[RecId]
                FROM [dbo].[tblUnitReference] WITH (NOLOCK)
                WHERE [tblUnitReference].[RefId] = @RefId
            )
                  AND ISNULL([IsPaid], 0) = 0
                  AND ISNULL([tblMonthLedger].[TransactionID], '') = '';

            INSERT INTO [dbo].[tblReceipt]
            (
                [TranId],
                [Amount],
                [Description],
                [Remarks],
                [EncodedBy],
                [EncodedDate],
                [ComputerName],
                [IsActive],
                [PaymentMethod],
                [CompanyORNo],
                [CompanyPRNo],
                [BankAccountName],
                [BankAccountNumber],
                [BankName],
                [SerialNo],
                [REF],
                [BankBranch],
                [RefId]
            )
            VALUES
            (@TranID, @PaidAmount, 'FULL PAYMENT', @PaymentRemarks, @EncodedBy, GETDATE(), @ComputerName, 1, @ModeType,
             @CompanyORNo, @CompanyPRNo, @BankAccountName, @BankAccountNumber, @BankName, @SerialNo, @REF, @BankBranch,
             @RefId);

            SET @RcptRecId = @@IDENTITY;
            SELECT @RcptID = [tblReceipt].[RcptID]
            FROM [dbo].[tblReceipt] WITH (NOLOCK)
            WHERE [tblReceipt].[RecId] = @RcptRecId;

            INSERT INTO [dbo].[tblPaymentMode]
            (
                [RcptID],
                [CompanyORNo],
                [CompanyPRNo],
                [REF],
                [BNK_ACCT_NAME],
                [BNK_ACCT_NUMBER],
                [BNK_NAME],
                [SERIAL_NO],
                [ModeType],
                [BankBranch]
            )
            VALUES
            (@RcptID, @CompanyORNo, @CompanyPRNo, @REF, @BankAccountName, @BankAccountNumber, @BankName, @SerialNo,
             @ModeType, @BankBranch);
        END

    END;

    IF (@TranID <> '' AND @@ROWCOUNT > 0)
    BEGIN

        SET @ReturnMessage = 'SUCCESS';
    END;
    ELSE
    BEGIN
        SET @ReturnMessage = ERROR_MESSAGE();
    END;
    SELECT @ReturnMessage AS [Message_Code],
           @TranID AS [TranID];

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    SET @ReturnMessage = ERROR_MESSAGE();
    SELECT @ReturnMessage AS [ReturnMessage];
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_GenerateLedger]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC [sp_GenerateLedger] 
CREATE PROCEDURE [dbo].[sp_GenerateLedger]
    @FromDate VARCHAR(10) = NULL,
    @EndDate VARCHAR(10) = NULL,
    @LedgAmount DECIMAL(18, 2) = NULL,
    @Rental DECIMAL(18, 2) = NULL,
    @SecAndMaintenance DECIMAL(18, 2) = NULL,
    @ComputationID INT = NULL,
    @ClientID VARCHAR(30) = NULL,
    @EncodedBy INT = NULL,
    @ComputerName VARCHAR(30) = NULL,
    @UnitId INT = NULL,
    @IsRenewal BIGINT = 0
AS
BEGIN

    --DECLARE @StartDate VARCHAR(10) = '08/02/2023';
    --DECLARE @EndDate VARCHAR(10) = '05/02/2024';
    --SELECT DATEDIFF(MONTH, CONVERT(DATE, @StartDate, 101), CONVERT(DATE, @EndDate, 101)) AS NumberOfMonths;


    DECLARE @MonthsCount INT = DATEDIFF(MONTH, CONVERT(DATE, @FromDate, 101), CONVERT(DATE, @EndDate, 101));
    DECLARE @ProjectType AS VARCHAR(20) = '';

    DECLARE @Unit_IsParking AS BIT = 0;
    DECLARE @Unit_IsNonVat AS BIT = 0;
    DECLARE @Unit_AreaSqm AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_AreaRateSqm AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_AreaTotalAmount AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_BaseRentalVatAmount AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_BaseRentalWithVatAmount AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_BaseRentalTax AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_TotalRental AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_SecAndMainAmount AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_SecAndMainVatAmount AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_SecAndMainWithVatAmount AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_Vat AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_Tax AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_TaxAmount AS DECIMAL(18, 2) = 0;

    SELECT @ProjectType = [tblProjectMstr].[ProjectType],
           @Unit_IsParking = [tblUnitMstr].[IsParking],
           @Unit_IsNonVat = [tblUnitMstr].[IsNonVat],
           @Unit_AreaSqm = [tblUnitMstr].[AreaSqm],
           @Unit_AreaRateSqm = [tblUnitMstr].[AreaRateSqm],
           @Unit_AreaTotalAmount = [tblUnitMstr].[AreaTotalAmount],
           @Unit_BaseRentalVatAmount = [tblUnitMstr].[BaseRentalVatAmount],
           @Unit_BaseRentalWithVatAmount = [tblUnitMstr].[BaseRentalWithVatAmount],
           @Unit_BaseRentalTax = [tblUnitMstr].[BaseRentalTax],
           @Unit_TotalRental = [tblUnitMstr].[TotalRental],
           @Unit_SecAndMainAmount = [tblUnitMstr].[SecAndMainAmount],
           @Unit_SecAndMainVatAmount = [tblUnitMstr].[SecAndMainVatAmount],
           @Unit_SecAndMainWithVatAmount = [tblUnitMstr].[SecAndMainWithVatAmount],
           @Unit_Vat = [tblUnitMstr].[Vat],
           @Unit_Tax = [tblUnitMstr].[Tax],
           @Unit_TaxAmount = [tblUnitMstr].[TaxAmount]
    FROM [dbo].[tblUnitMstr] WITH (NOLOCK)
        INNER JOIN [dbo].[tblProjectMstr] WITH (NOLOCK)
            ON [tblUnitMstr].[ProjectId] = [tblProjectMstr].[RecId]
    WHERE [tblUnitMstr].[RecId] = @UnitId;

    CREATE TABLE [#GeneratedMonths]
    (
        [Month] DATE
    );
    WITH [MonthsCTE]
    AS (SELECT CONVERT(DATE, @FromDate) AS [Month]
        UNION ALL
        SELECT DATEADD(MONTH, 1, [MonthsCTE].[Month])
        FROM [MonthsCTE]
        WHERE DATEADD(MONTH, 1, [MonthsCTE].[Month]) <= DATEADD(MONTH, @MonthsCount - 1, CONVERT(DATE, @FromDate)))
    INSERT INTO [#GeneratedMonths]
    (
        [Month]
    )
    SELECT [MonthsCTE].[Month]
    FROM [MonthsCTE];



    INSERT INTO [dbo].[tblMonthLedger]
    (
        [LedgMonth],
        [LedgAmount],
        [LedgRentalAmount],
        [ReferenceID],
        [ClientID],
        [IsPaid],
        [EncodedBy],
        [EncodedDate],
        [ComputerName],
        [Remarks],
        [Unit_IsNonVat],
        [Unit_AreaSqm],
        [Unit_AreaRateSqm],
        [Unit_AreaTotalAmount],
        [Unit_BaseRentalVatAmount],
        [Unit_BaseRentalWithVatAmount],
        [Unit_BaseRentalTax],
        [Unit_TotalRental],
        [Unit_SecAndMainAmount],
        [Unit_SecAndMainVatAmount],
        [Unit_SecAndMainWithVatAmount],
        [Unit_Vat],
        [Unit_Tax],
        [Unit_TaxAmount],
        [Unit_ProjectType],
        [Unit_IsParking],
        [IsRenewal]
    )
    SELECT [#GeneratedMonths].[Month],
           @LedgAmount,
           @Rental,
           @ComputationID,
           @ClientID,
           0,
           @EncodedBy,
           GETDATE(),
           @ComputerName,
           'RENTAL NET OF VAT',
           @Unit_IsNonVat,
           @Unit_AreaSqm,
           @Unit_AreaRateSqm,
           @Unit_AreaTotalAmount,
           @Unit_BaseRentalVatAmount,
           @Unit_BaseRentalWithVatAmount,
           @Unit_BaseRentalTax,
           @Unit_TotalRental,
           @Unit_SecAndMainAmount,
           @Unit_SecAndMainVatAmount,
           @Unit_SecAndMainWithVatAmount,
           @Unit_Vat,
           @Unit_Tax,
           @Unit_TaxAmount,
           @ProjectType,
           @Unit_IsParking,
           @IsRenewal
    FROM [#GeneratedMonths]
    UNION
    SELECT [#GeneratedMonths].[Month],
           @LedgAmount,
           @SecAndMaintenance,
           @ComputationID,
           @ClientID,
           0,
           @EncodedBy,
           GETDATE(),
           @ComputerName,
           'SECURITY AND MAINTENANCE NET OF VAT',
           @Unit_IsNonVat,
           @Unit_AreaSqm,
           @Unit_AreaRateSqm,
           @Unit_AreaTotalAmount,
           @Unit_BaseRentalVatAmount,
           @Unit_BaseRentalWithVatAmount,
           @Unit_BaseRentalTax,
           @Unit_TotalRental,
           @Unit_SecAndMainAmount,
           @Unit_SecAndMainVatAmount,
           @Unit_SecAndMainWithVatAmount,
           @Unit_Vat,
           @Unit_Tax,
           @Unit_TaxAmount,
           @ProjectType,
           @Unit_IsParking,
           @IsRenewal
    FROM [#GeneratedMonths]
    WHERE @SecAndMaintenance IS NOT NULL
    IF (@@ROWCOUNT > 0)
    BEGIN
        UPDATE [dbo].[tblUnitReference]
        SET [tblUnitReference].[ClientID] = @ClientID,
            [tblUnitReference].[LastCHangedBy] = @EncodedBy,
            [tblUnitReference].[LastChangedDate] = GETDATE(),
            [tblUnitReference].[ComputerName] = @ComputerName
        WHERE [tblUnitReference].[RecId] = @ComputationID;


        SELECT 'SUCCESS' AS [Message_Code];
    END;

    DROP TABLE [#GeneratedMonths];


END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GenerateSecondPaymentParking]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GenerateSecondPaymentParking]
    -- Add the parameters for the stored procedure here
    @RefId VARCHAR(50) = NULL,
    @PaidAmount DECIMAL(18, 2) = NULL,
    @ReceiveAmount DECIMAL(18, 2) = NULL,
    @ChangeAmount DECIMAL(18, 2) = NULL,
    @EncodedBy INT = NULL,
    @ComputerName VARCHAR(30) = NULL,
    @CompanyORNo VARCHAR(30) = NULL,
    @CompanyPRNo VARCHAR(30) = NULL,
    @BankAccountName VARCHAR(30) = NULL,
    @BankAccountNumber VARCHAR(30) = NULL,
    @BankName VARCHAR(30) = NULL,
    @SerialNo VARCHAR(30) = NULL,
    @PaymentRemarks VARCHAR(100) = NULL,
    @REF VARCHAR(100) = NULL,
    @ModeType VARCHAR(10) = NULL,
    @ledgerRecId INT = NULL
AS
BEGIN TRY
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
    DECLARE @ReturnMessage VARCHAR(200);
    DECLARE @TranRecId BIGINT = 0;
    DECLARE @TranID VARCHAR(50) = '';
    DECLARE @RcptRecId BIGINT = 0;
    DECLARE @RcptID VARCHAR(50) = '';
    DECLARE @LedgeMonth DATE = NULL;

    BEGIN TRANSACTION;
    INSERT INTO [dbo].[tblTransaction]
    (
        [RefId],
        [PaidAmount],
        [ReceiveAmount],
        [ChangeAmount],
        [Remarks],
        [EncodedBy],
        [EncodedDate],
        [ComputerName],
        [IsActive]
    )
    VALUES
    (@RefId, @PaidAmount, @ReceiveAmount, @ChangeAmount, 'FOLLOW-UP PAYMENT', @EncodedBy, GETDATE(), @ComputerName, 1);

    SET @TranRecId = @@IDENTITY;
    SELECT @TranID = [tblTransaction].[TranID]
    FROM [dbo].[tblTransaction]
    WHERE [tblTransaction].[RecId] = @TranRecId;

    SELECT @LedgeMonth = [tblMonthLedger].[LedgMonth]
    FROM [dbo].[tblMonthLedger]
    WHERE ISNULL([tblMonthLedger].[IsPaid], 0) = 0
          AND ISNULL([tblMonthLedger].[TransactionID], '') = ''
          AND [tblMonthLedger].[ReferenceID] =
          (
              SELECT [tblUnitReference].[RecId]
              FROM [dbo].[tblUnitReference]
              WHERE [tblUnitReference].[RefId] = @RefId
          )
          AND [tblMonthLedger].[Recid] = @ledgerRecId;
    INSERT INTO [dbo].[tblPayment]
    (
        [TranId],
        [RefId],
        [Amount],
        [ForMonth],
        [Remarks],
        [EncodedBy],
        [EncodedDate],
        [ComputerName],
        [IsActive]
    )
    SELECT @TranID AS [TranId],
           @RefId AS [RefId],
           [tblMonthLedger].[LedgAmount] AS [Amount],
           [tblMonthLedger].[LedgMonth] AS [ForMonth],
           'FOLLOW-UP PAYMENT' AS [Remarks],
           @EncodedBy,
           GETDATE(), --Dated payed
           @ComputerName,
           1
    FROM [dbo].[tblMonthLedger]
    WHERE [tblMonthLedger].[LedgMonth] = @LedgeMonth
          AND ISNULL([tblMonthLedger].[IsPaid], 0) = 0
          AND ISNULL([tblMonthLedger].[TransactionID], '') = ''
          AND [tblMonthLedger].[ReferenceID] =
          (
              SELECT [tblUnitReference].[RecId]
              FROM [dbo].[tblUnitReference]
              WHERE [tblUnitReference].[RefId] = @RefId
          )
          AND [tblMonthLedger].[Recid] = @ledgerRecId;


    UPDATE [dbo].[tblMonthLedger]
    SET [tblMonthLedger].[IsPaid] = 1,
        [tblMonthLedger].[IsHold] = 0,
        [tblMonthLedger].[TransactionID] = @TranID
    WHERE [tblMonthLedger].[LedgMonth] = @LedgeMonth
          AND ISNULL([IsPaid], 0) = 0
          AND ISNULL([tblMonthLedger].[TransactionID], '') = ''
          AND [tblMonthLedger].[ReferenceID] =
          (
              SELECT [tblUnitReference].[RecId]
              FROM [dbo].[tblUnitReference]
              WHERE [tblUnitReference].[RefId] = @RefId
          )
          AND [Recid] = @ledgerRecId;


    INSERT INTO [dbo].[tblReceipt]
    (
        [TranId],
        [Amount],
        [Description],
        [Remarks],
        [EncodedBy],
        [EncodedDate],
        [ComputerName],
        [IsActive],
        [PaymentMethod],
        [CompanyORNo],
        [CompanyPRNo],
        [BankAccountName],
        [BankAccountNumber],
        [BankName],
        [SerialNo],
        [REF]
    )
    VALUES
    (@TranID, @PaidAmount, 'FOLLOW-UP PAYMENT', @PaymentRemarks, @EncodedBy, GETDATE(), @ComputerName, 1, @ModeType,
     @CompanyORNo, @CompanyPRNo, @BankAccountName, @BankAccountNumber, @BankName, @SerialNo, @REF);

    SET @RcptRecId = @@IDENTITY;
    SELECT @RcptID = [tblReceipt].[RcptID]
    FROM [dbo].[tblReceipt]
    WHERE [tblReceipt].[RecId] = @RcptRecId;

    INSERT INTO [dbo].[tblPaymentMode]
    (
        [RcptID],
        [CompanyORNo],
        [CompanyPRNo],
        [REF],
        [BNK_ACCT_NAME],
        [BNK_ACCT_NUMBER],
        [BNK_NAME],
        [SERIAL_NO],
        [ModeType]
    )
    VALUES
    (@RcptID, @CompanyORNo, @CompanyPRNo, @REF, @BankAccountName, @BankAccountNumber, @BankName, @SerialNo, @ModeType);


    IF (@TranID <> '' AND @@ROWCOUNT > 0)
    BEGIN
        SET @ReturnMessage = 'SUCCESS';
    END;
    ELSE
    BEGIN
        SET @ReturnMessage = ERROR_MESSAGE();
    END;
    SELECT @ReturnMessage AS [Message_Code];

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    SET @ReturnMessage = ERROR_MESSAGE();
    SELECT @ReturnMessage AS [ReturnMessage];
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_GenerateSecondPaymentUnit]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GenerateSecondPaymentUnit]
    -- Add the parameters for the stored procedure here
    @RefId VARCHAR(50) = NULL,
    @PaidAmount DECIMAL(18, 2) = NULL,
    @ReceiveAmount DECIMAL(18, 2) = NULL,
    @ChangeAmount DECIMAL(18, 2) = NULL,
    @EncodedBy INT = NULL,
    @ComputerName VARCHAR(30) = NULL,
    @CompanyORNo VARCHAR(30) = NULL,
    @CompanyPRNo VARCHAR(30) = NULL,
    @BankAccountName VARCHAR(30) = NULL,
    @BankAccountNumber VARCHAR(30) = NULL,
    @BankName VARCHAR(30) = NULL,
    @SerialNo VARCHAR(30) = NULL,
    @PaymentRemarks VARCHAR(100) = NULL,
    @REF VARCHAR(100) = NULL,
    @ModeType VARCHAR(50) = NULL,
    @ledgerRecId INT = NULL
AS
BEGIN TRY
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
    DECLARE @ReturnMessage VARCHAR(200);
    DECLARE @TranRecId BIGINT = 0;
    DECLARE @TranID VARCHAR(50) = '';
    DECLARE @RcptRecId BIGINT = 0;
    DECLARE @RcptID VARCHAR(50) = '';
    DECLARE @LedgeMonth DATE = NULL;

    BEGIN TRANSACTION;
    INSERT INTO [dbo].[tblTransaction]
    (
        [RefId],
        [PaidAmount],
        [ReceiveAmount],
        [ChangeAmount],
        [Remarks],
        [EncodedBy],
        [EncodedDate],
        [ComputerName],
        [IsActive]
    )
    VALUES
    (@RefId, @PaidAmount, @ReceiveAmount, @ChangeAmount, 'FOLLOW-UP PAYMENT', @EncodedBy, GETDATE(), @ComputerName, 1);

    SET @TranRecId = @@IDENTITY;
    SELECT @TranID = [tblTransaction].[TranID]
    FROM [dbo].[tblTransaction] WITH (NOLOCK)
    WHERE [tblTransaction].[RecId] = @TranRecId;

    SELECT @LedgeMonth = [tblMonthLedger].[LedgMonth]
    FROM [dbo].[tblMonthLedger] WITH (NOLOCK)
    WHERE ISNULL([tblMonthLedger].[IsPaid], 0) = 0
          AND ISNULL([tblMonthLedger].[TransactionID], '') = ''
          AND [tblMonthLedger].[ReferenceID] =
          (
              SELECT [tblUnitReference].[RecId]
              FROM [dbo].[tblUnitReference] WITH (NOLOCK)
              WHERE [tblUnitReference].[RefId] = @RefId
          )
          AND [tblMonthLedger].[Recid] = @ledgerRecId;
    INSERT INTO [dbo].[tblPayment]
    (
        [TranId],
        [RefId],
        [Amount],
        [ForMonth],
        [Remarks],
        [EncodedBy],
        [EncodedDate],
        [ComputerName],
        [IsActive]
    )
    SELECT @TranID AS [TranId],
           @RefId AS [RefId],
           [tblMonthLedger].[LedgAmount] AS [Amount],
           [tblMonthLedger].[LedgMonth] AS [ForMonth],
           'FOLLOW-UP PAYMENT' AS [Remarks],
           @EncodedBy,
           GETDATE(), --Dated payed
           @ComputerName,
           1
    FROM [dbo].[tblMonthLedger] WITH (NOLOCK)
    WHERE [tblMonthLedger].[LedgMonth] = @LedgeMonth
          AND ISNULL([tblMonthLedger].[IsPaid], 0) = 0
          AND ISNULL([tblMonthLedger].[TransactionID], '') = ''
          AND [tblMonthLedger].[ReferenceID] =
          (
              SELECT [tblUnitReference].[RecId]
              FROM [dbo].[tblUnitReference] WITH (NOLOCK)
              WHERE [tblUnitReference].[RefId] = @RefId
          )
          AND [tblMonthLedger].[Recid] = @ledgerRecId;


    UPDATE [dbo].[tblMonthLedger]
    SET [tblMonthLedger].[IsPaid] = 1,
        [tblMonthLedger].[IsHold] = 0,
        [tblMonthLedger].[TransactionID] = @TranID
    WHERE [tblMonthLedger].[LedgMonth] = @LedgeMonth
          AND ISNULL([IsPaid], 0) = 0
          AND ISNULL([tblMonthLedger].[TransactionID], '') = ''
          AND [tblMonthLedger].[ReferenceID] =
          (
              SELECT [tblUnitReference].[RecId]
              FROM [dbo].[tblUnitReference] WITH (NOLOCK)
              WHERE [tblUnitReference].[RefId] = @RefId
          )
          AND [Recid] = @ledgerRecId;


    INSERT INTO [dbo].[tblReceipt]
    (
        [TranId],
        [Amount],
        [Description],
        [Remarks],
        [EncodedBy],
        [EncodedDate],
        [ComputerName],
        [IsActive],
        [PaymentMethod],
        [CompanyORNo],
        [CompanyPRNo],
        [BankAccountName],
        [BankAccountNumber],
        [BankName],
        [SerialNo],
        [REF]
    )
    VALUES
    (@TranID, @PaidAmount, 'FOLLOW-UP PAYMENT', @PaymentRemarks, @EncodedBy, GETDATE(), @ComputerName, 1, @ModeType,
     @CompanyORNo, @CompanyPRNo, @BankAccountName, @BankAccountNumber, @BankName, @SerialNo, @REF);

    SET @RcptRecId = @@IDENTITY;
    SELECT @RcptID = [tblReceipt].[RcptID]
    FROM [dbo].[tblReceipt] WITH (NOLOCK)
    WHERE [tblReceipt].[RecId] = @RcptRecId;

    INSERT INTO [dbo].[tblPaymentMode]
    (
        [RcptID],
        [CompanyORNo],
        [CompanyPRNo],
        [REF],
        [BNK_ACCT_NAME],
        [BNK_ACCT_NUMBER],
        [BNK_NAME],
        [SERIAL_NO],
        [ModeType]
    )
    VALUES
    (@RcptID, @CompanyORNo, @CompanyPRNo, @REF, @BankAccountName, @BankAccountNumber, @BankName, @SerialNo, @ModeType);


    IF (@TranID <> '' AND @@ROWCOUNT > 0)
    BEGIN
        SET @ReturnMessage = 'SUCCESS';
    END;
    ELSE
    BEGIN
        SET @ReturnMessage = ERROR_MESSAGE();
    END;
    SELECT @ReturnMessage AS [Message_Code],
           @TranID AS [TranID];

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

    SET @ReturnMessage = ERROR_MESSAGE();
    SELECT @ReturnMessage AS [ReturnMessage];
END CATCH;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAnnouncement]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_GetAnnouncement]
AS
BEGIN
    SELECT ISNULL([tblAnnouncement].[AnnounceMessage], '') AS [AnnounceMessage]
    FROM [dbo].[tblAnnouncement]

END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAnnouncementCheck]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_GetAnnouncementCheck]
AS
BEGIN
    SELECT ISNULL([tblAnnouncement].[AnnounceMessage], '') AS [AnnounceMessage]
    FROM [dbo].[tblAnnouncement]

END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCheckPaymentStatus]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetCheckPaymentStatus] @ReferenceID VARCHAR(50) = NULL
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        -- Insert statements for procedure here
        IF EXISTS
            (
                SELECT
                    *
                FROM
                    [dbo].[tblMonthLedger]
                WHERE
                    [tblMonthLedger].[ReferenceID] = SUBSTRING(@ReferenceID, 4, 11)
            )
            BEGIN
                SELECT
                    IIF(COUNT(*) > 0, 'IN-PROGRESS', 'PAYMENT DONE') AS [PAYMENT_STATUS]
                FROM
                    [dbo].[tblMonthLedger]
                WHERE
                    [tblMonthLedger].[ReferenceID] = SUBSTRING(@ReferenceID, 4, 11)
                    AND ISNULL([tblMonthLedger].[IsPaid], 0) = 0;
            END;
        ELSE
            BEGIN
                SELECT
                    '' AS [PAYMENT_STATUS];
            END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetClientById]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetClientById] @ClientID VARCHAR(50)
AS
    BEGIN

        SET NOCOUNT ON;

        SELECT
            [tblClientMstr].[ClientID],
            IIF(ISNULL([tblClientMstr].[ClientType], '') = 'INDV', 'INDIVIDUAL', 'CORPORATE') AS [ClientType],
            ISNULL([tblClientMstr].[ClientName], '')                                          AS [ClientName],
            ISNULL([tblClientMstr].[Age], 0)                                                  AS [Age],
            ISNULL([tblClientMstr].[PostalAddress], '')                                       AS [PostalAddress],
            ISNULL(CONVERT(VARCHAR(10), [tblClientMstr].[DateOfBirth], 103), '')              AS [DateOfBirth],
            ISNULL([tblClientMstr].[TelNumber], 0)                                            AS [TelNumber],
            IIF(ISNULL([tblClientMstr].[Gender], 0) = 1, 'MALE', 'FEMALE')                    AS [Gender],
            ISNULL([tblClientMstr].[Nationality], '')                                         AS [Nationality],
            ISNULL([tblClientMstr].[Occupation], '')                                          AS [Occupation],
            ISNULL([tblClientMstr].[AnnualIncome], 0)                                         AS [AnnualIncome],
            ISNULL([tblClientMstr].[EmployerName], '')                                        AS [EmployerName],
            ISNULL([tblClientMstr].[EmployerAddress], '')                                     AS [EmployerAddress],
            ISNULL([tblClientMstr].[SpouseName], '')                                          AS [SpouseName],
            ISNULL([tblClientMstr].[ChildrenNames], '')                                       AS [ChildrenNames],
            ISNULL([tblClientMstr].[TotalPersons], 0)                                         AS [TotalPersons],
            ISNULL([tblClientMstr].[MaidName], '')                                            AS [MaidName],
            ISNULL([tblClientMstr].[DriverName], '')                                          AS [DriverName],
            ISNULL([tblClientMstr].[VisitorsPerDay], 0)                                       AS [VisitorsPerDay],
            ISNULL([tblClientMstr].[IsTwoMonthAdvanceRental], 0)                              AS [IsTwoMonthAdvanceRental],
            ISNULL([tblClientMstr].[IsThreeMonthSecurityDeposit], 0)                          AS [IsThreeMonthSecurityDeposit],
            ISNULL([tblClientMstr].[Is10PostDatedChecks], 0)                                  AS [Is10PostDatedChecks],
            ISNULL([tblClientMstr].[IsPhotoCopyValidID], 0)                                   AS [IsPhotoCopyValidID],
            ISNULL([tblClientMstr].[Is2X2Picture], 0)                                         AS [Is2X2Picture],
            ISNULL([tblClientMstr].[BuildingSecretary], 0)                                    AS [BuildingSecretary],
            ISNULL([tblClientMstr].[EncodedDate], '')                                         AS [EncodedDate],
            ISNULL([tblClientMstr].[EncodedBy], 0)                                            AS [EncodedBy],
            ISNULL([tblClientMstr].[ComputerName], '')                                        AS [ComputerName],
            IIF(ISNULL([tblClientMstr].[IsActive], 0) = 1, 'ACTIVE', 'IN-ACTIVE')             AS [IsActive],
			ISNULL(TIN_No,'') AS TIN_No
        FROM
            [dbo].[tblClientMstr]
        WHERE
            [tblClientMstr].[ClientID] = @ClientID;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetClientFileByFileId]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetClientFileByFileId]
    @ClientName VARCHAR(50),
    @Id         INT
AS
    BEGIN
        SELECT
            [Files].[Id],
            [Files].[FilePath],
            [Files].[FileData],
            [Files].[FileNames],
            [Files].[Notes],
            [Files].[Files]
        FROM
            [dbo].[Files]
        WHERE
            [Files].[ClientName] = @ClientName
            AND [Files].[Id] = @Id;
    END;


GO
/****** Object:  StoredProcedure [dbo].[sp_GetClientID]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetClientID] @ClientID VARCHAR(50) = NULL
AS
    BEGIN

        SET NOCOUNT ON;

        IF EXISTS
            (
                SELECT
                    1
                FROM
                    [dbo].[tblClientMstr]
                WHERE
                    [tblClientMstr].[ClientID] = @ClientID
            )
            BEGIN
                SELECT
                    [tblClientMstr].[ClientID],
                    '' AS [Message_Code]
                FROM
                    [dbo].[tblClientMstr] WITH (NOLOCK)
                WHERE
                    ISNULL([tblClientMstr].[ClientID], '') = @ClientID;
            END;
        ELSE
            BEGIN

                SELECT
                    ''                      AS [ClientID],
                    'THIS ID IS NOT EXIST ' AS [Message_Code];
            END;


    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetClientList]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetClientList]
AS
    BEGIN

        SET NOCOUNT ON;

        SELECT
            ISNULL([tblClientMstr].[ClientID], '')                                            AS [ClientID],
            IIF(ISNULL([tblClientMstr].[ClientType], '') = 'INDV', 'INDIVIDUAL', 'CORPORATE') AS [ClientType],
            ISNULL([tblClientMstr].[ClientName], '')                                          AS [ClientName],
            ISNULL([tblClientMstr].[Age], 0)                                                  AS [Age],
            ISNULL([tblClientMstr].[PostalAddress], '')                                       AS [PostalAddress],
            ISNULL(CONVERT(VARCHAR(10), [tblClientMstr].[DateOfBirth], 103), '')              AS [DateOfBirth],
            ISNULL([tblClientMstr].[TelNumber], 0)                                            AS [TelNumber],
            IIF(ISNULL([tblClientMstr].[Gender], 0) = 1, 'MALE', 'FEMALE')                    AS [Gender],
            ISNULL([tblClientMstr].[Nationality], '')                                         AS [Nationality],
            ISNULL([tblClientMstr].[Occupation], '')                                          AS [Occupation],
            ISNULL([tblClientMstr].[AnnualIncome], 0)                                         AS [AnnualIncome],
            ISNULL([tblClientMstr].[EmployerName], '')                                        AS [EmployerName],
            ISNULL([tblClientMstr].[EmployerAddress], '')                                     AS [EmployerAddress],
            ISNULL([tblClientMstr].[SpouseName], '')                                          AS [SpouseName],
            ISNULL([tblClientMstr].[ChildrenNames], '')                                       AS [ChildrenNames],
            ISNULL([tblClientMstr].[TotalPersons], 0)                                         AS [TotalPersons],
            ISNULL([tblClientMstr].[MaidName], '')                                            AS [MaidName],
            ISNULL([tblClientMstr].[DriverName], '')                                          AS [DriverName],
            ISNULL([tblClientMstr].[VisitorsPerDay], 0)                                       AS [VisitorsPerDay],
            ISNULL([tblClientMstr].[IsTwoMonthAdvanceRental], 0)                              AS [IsTwoMonthAdvanceRental],
            ISNULL([tblClientMstr].[IsThreeMonthSecurityDeposit], 0)                          AS [IsThreeMonthSecurityDeposit],
            ISNULL([tblClientMstr].[Is10PostDatedChecks], 0)                                  AS [Is10PostDatedChecks],
            ISNULL([tblClientMstr].[IsPhotoCopyValidID], 0)                                   AS [IsPhotoCopyValidID],
            ISNULL([tblClientMstr].[Is2X2Picture], 0)                                         AS [Is2X2Picture],
            ISNULL([tblClientMstr].[BuildingSecretary], 0)                                    AS [BuildingSecretary],
            ISNULL([tblClientMstr].[EncodedDate], '')                                         AS [EncodedDate],
            ISNULL([tblClientMstr].[EncodedBy], 0)                                            AS [EncodedBy],
            ISNULL([tblClientMstr].[ComputerName], '')                                        AS [ComputerName],
            IIF(ISNULL([tblClientMstr].[IsActive], 0) = 1, 'ACTIVE', 'IN-ACTIVE')             AS [IsActive],
			ISNULL(TIN_No,'') AS TIN_No
        FROM
            [dbo].[tblClientMstr];
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetClientReferencePaid]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetClientReferencePaid] @ClientID VARCHAR(30) = NULL
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT [tblClientMstr].[ClientID],
           [tblClientMstr].[ClientName],
           [tblUnitReference].[RefId]
    FROM [dbo].[tblClientMstr] WITH (NOLOCK)
        INNER JOIN [dbo].[tblUnitReference] WITH (NOLOCK)
            ON [tblClientMstr].[ClientID] = [tblUnitReference].[ClientID]
    WHERE ISNULL([tblUnitReference].[IsPaid], 0) = 1
          --AND ISNULL([tblUnitReference].[IsUnitMove], 0) = 0
          AND [tblClientMstr].[ClientID] = @ClientID;

END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetClientTypeAndID]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetClientTypeAndID] @ClientID VARCHAR(50) = NULL
AS
    BEGIN

        SET NOCOUNT ON;

        SELECT
            ISNULL([tblClientMstr].[ClientID], '')                                           AS [ClientID],
            IIF(ISNULL([tblClientMstr].[ClientType], '') = 'INV', 'INDIVIDUAL', 'CORPORATE') AS [ClientType]
        FROM
            [dbo].[tblClientMstr] WITH (NOLOCK)
        WHERE
            [ClientID] = @ClientID;

    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetClientUnitList]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC [sp_GetClientUnitList] 'CORP10000001'
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetClientUnitList] @ClientID VARCHAR(50) = NULL
AS
BEGIN

    SET NOCOUNT ON;


    SELECT [tblUnitReference].[RecId],
           [tblUnitReference].[UnitNo],
           ISNULL([tblProjectMstr].[ProjectName], '') + '-' + ISNULL([tblProjectMstr].[ProjectType], '') AS [ProjectName],
           ISNULL([tblUnitMstr].[DetailsofProperty], 'N/A') + ' - Type (' + ISNULL([tblUnitMstr].[FloorType], 'N/A')
           + ')' AS [DetailsofProperty],
           IIF(ISNULL([tblUnitMstr].[IsParking], 0) = 1, 'TYPE OF PARKING', 'TYPE OF UNIT') AS [TypeOf],
           case
               when isnull([tblUnitReference].[IsUnitMove], 0) = 0
                    and isnull([tblUnitReference].[IsUnitMoveOut], 0) = 0
                    and isnull([tblUnitReference].[IsSignedContract], 0) = 1 then
                   'RESERVED'
               when isnull([tblUnitReference].[IsSignedContract], 0) = 1
                    and isnull([tblUnitReference].[IsUnitMove], 0) = 1
                    and isnull([tblUnitReference].[IsUnitMoveOut], 0) = 0 then
                   'OCCUPIED'
               when isnull([tblUnitReference].[IsSignedContract], 0) = 1
                    and isnull([tblUnitReference].[IsUnitMove], 0) = 1
                    and isnull([tblUnitReference].[IsUnitMoveOut], 0) = 1
                    and isnull([tblUnitReference].[IsUnitMoveOut], 0) = 0
                    and isnull([tblUnitReference].IsDone, 0) = 0 then
                   'MOVE-OUT'
               when (
                        isnull([tblUnitReference].[IsSignedContract], 0) = 1
                        and isnull([tblUnitReference].[IsUnitMove], 0) = 1
                        and isnull([tblUnitReference].[IsUnitMoveOut], 0) = 1
                        and isnull([tblUnitReference].IsTerminated, 0) = 0
                        and isnull([tblUnitReference].IsDone, 0) = 1
                    )
                    or (
                           isnull([tblUnitReference].[IsSignedContract], 0) = 1
                           and isnull([tblUnitReference].[IsUnitMove], 0) = 1
                           and isnull([tblUnitReference].[IsUnitMoveOut], 0) = 1
                           and isnull([tblUnitReference].IsTerminated, 0) = 1
                           and isnull([tblUnitReference].IsDone, 0) = 1
                       ) then
                   'CLOSE CONTRACT'
               when isnull([tblUnitReference].[IsSignedContract], 0) = 1
                    and isnull([tblUnitReference].[IsUnitMove], 0) = 1
                    and isnull([tblUnitReference].[IsUnitMoveOut], 0) = 1
                    and isnull([tblUnitReference].IsDone, 0) = 0
                    and isnull([tblUnitReference].IsTerminated, 0) = 1 then
                   'EARLY TERMINATION'
               else
                   ''
           end as [UnitStatus]
    FROM [dbo].[tblUnitReference] WITH (NOLOCK)
        LEFT JOIN [dbo].[tblUnitMstr] WITH (NOLOCK)
            ON [tblUnitReference].[UnitId] = [tblUnitMstr].[RecId]
        INNER JOIN [dbo].[tblProjectMstr]
            ON [tblUnitReference].[ProjectId] = [tblProjectMstr].[RecId]
    WHERE [tblUnitReference].[ClientID] = @ClientID;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetClosedContracts]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetClosedContracts]
-- Add the parameters for the stored procedure here

AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        -- Insert statements for procedure here
        SELECT
                [tblUnitReference].[RecId],
                [tblUnitReference].[RefId],
                [tblUnitReference].[ProjectId],
                [tblUnitReference].[InquiringClient],
                [tblUnitReference].[ClientMobile],
                [tblUnitReference].[UnitId],
                [tblUnitReference].[UnitNo],
                [tblUnitReference].[StatDate],
                [tblUnitReference].[FinishDate],
                [tblUnitReference].[TransactionDate],
                [tblUnitReference].[Rental],
                [tblUnitReference].[SecAndMaintenance],
                [tblUnitReference].[TotalRent],
                [tblUnitReference].[AdvancePaymentAmount],
                [tblUnitReference].[SecDeposit],
                [tblUnitReference].[Total],
                [tblUnitReference].[EncodedBy],
                [tblUnitReference].[EncodedDate],
                [tblUnitReference].[LastCHangedBy],
                [tblUnitReference].[LastChangedDate],
                [tblUnitReference].[IsActive],
                [tblUnitReference].[ComputerName],
                [tblUnitReference].[ClientID],
                [tblUnitReference].[IsPaid],
                [tblUnitReference].[IsDone],
                [tblUnitReference].[HeaderRefId],
                [tblUnitReference].[IsSignedContract],
                [tblUnitReference].[IsUnitMove],
                IIF(ISNULL([tblUnitReference].[IsTerminated], 0) = 1, 'EARLY TERMINATION', 'CONTRACT DONE') AS [Contract_Status]
        FROM
                [dbo].[tblUnitReference] WITH (NOLOCK)
            INNER JOIN
                [dbo].[tblUnitMstr] WITH (NOLOCK)
                    ON [tblUnitReference].[UnitId] = [tblUnitMstr].[RecId]
        WHERE
                ISNULL([tblUnitReference].[IsPaid], 0) = 1
                AND ISNULL([tblUnitReference].[IsDone], 0) = 1
                AND ISNULL([tblUnitReference].[IsSignedContract], 0) = 1
                AND ISNULL([tblUnitReference].[IsUnitMove], 0) = 1
                AND ISNULL([tblUnitReference].[IsUnitMoveOut], 0) = 1
                AND ISNULL([tblUnitReference].[IsPaid], 0) = 1
                AND ISNULL([tblUnitReference].[IsTerminated], 0) = 0
                OR ISNULL([tblUnitReference].[IsTerminated], 0) = 1
                   AND ISNULL([tblUnitReference].[IsPaid], 0) = 1
                   AND ISNULL([tblUnitReference].[IsDone], 0) = 1
                   AND ISNULL([tblUnitReference].[IsSignedContract], 0) = 1
                   AND ISNULL([tblUnitReference].[IsUnitMove], 0) = 1
                   AND ISNULL([tblUnitReference].[IsUnitMoveOut], 0) = 1;



    --and ISNULL(tblUnitMstr.IsParking, 0) = 0
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCOMMERCIALSettings]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetCOMMERCIALSettings]
AS
BEGIN

    SET NOCOUNT ON;


    SELECT [tblRatesSettings].[ProjectType],
           ISNULL([tblRatesSettings].[GenVat], 0) AS [GenVat],
           ISNULL([tblRatesSettings].[SecurityAndMaintenance], 0) AS [SecurityAndMaintenance],
           ISNULL([tblRatesSettings].[WithHoldingTax], 0) AS [WithHoldingTax],
           ISNULL([tblRatesSettings].[PenaltyPct], 0) AS [PenaltyPct],
           [tblRatesSettings].[EncodedBy],
           [tblRatesSettings].[EncodedDate],
           [tblRatesSettings].[ComputerName]
    FROM [dbo].[tblRatesSettings]
    WHERE [tblRatesSettings].[ProjectType] = 'COMMERCIAL';

END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCompanyDetails]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_GetCompanyDetails] @RecId AS INT = NULL
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    SELECT [tblCompany].[RecId],
           [tblCompany].[CompanyName],
           [tblCompany].[CompanyAddress],
           [tblCompany].[CompanyTIN],
           [tblCompany].[CompanyOwnerName],
           [tblCompany].[Status],
           [tblCompany].[EncodedBy],
           [tblCompany].[EncodedDate],
           [tblCompany].[LastChangedBy],
           [tblCompany].[LastChangedDate],
           [tblCompany].[ComputerName]
    FROM [dbo].[tblCompany]
    WHERE [tblCompany].[RecId] = @RecId
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetCompanyList]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetCompanyList]
AS
BEGIN

    SET NOCOUNT ON;

    SELECT [tblCompany].[RecId],
           [tblCompany].[CompanyName],
           [tblCompany].[CompanyAddress],
           [tblCompany].[CompanyTIN],
           [tblCompany].[CompanyOwnerName],
           [tblCompany].[Status],
           [tblCompany].[EncodedBy],
           [tblCompany].[EncodedDate],
           [tblCompany].[LastChangedBy],
           [tblCompany].[LastChangedDate],
           [tblCompany].[ComputerName],
           IIF(ISNULL([tblCompany].[Status], 0) = 1, 'ACTIVE', 'IN-ACTIVE') AS [Status]
    FROM [dbo].[tblCompany]
    WHERE ISNULL([tblCompany].[Status], 0) = 1;

END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetComputationById]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC [sp_GetComputationById] 10000000
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetComputationById] @RecId INT = NULL
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    DECLARE @TotalForPayment AS DECIMAL(18, 2) = 0;
    SELECT @TotalForPayment = SUM([tblMonthLedger].[LedgRentalAmount])
    FROM [dbo].[tblMonthLedger]
    WHERE [tblMonthLedger].[ReferenceID] = @RecId;
    SELECT [tblUnitReference].[RecId],
           [tblUnitReference].[RefId],
           ISNULL([tblUnitReference].[ClientID], '') AS [ClientID],
           [tblUnitReference].[ProjectId],
           ISNULL([tblProjectMstr].[ProjectName], '') AS [ProjectName],
           ISNULL([tblProjectMstr].[ProjectAddress], '') AS [ProjectAddress],
           ISNULL([tblProjectMstr].[ProjectType], '') AS [ProjectType],
           ISNULL([tblUnitReference].[InquiringClient], '') AS [InquiringClient],
           ISNULL([tblUnitReference].[ClientMobile], '') AS [ClientMobile],
           [tblUnitReference].[UnitId],
           ISNULL([tblUnitReference].[UnitNo], '') AS [UnitNo],
           ISNULL([tblUnitMstr].[FloorType], '') AS [FloorType],
           ISNULL(CONVERT(VARCHAR(10), [tblUnitReference].[StatDate], 1), '') AS [StatDate],
           ISNULL(CONVERT(VARCHAR(10), [tblUnitReference].[FinishDate], 1), '') AS [FinishDate],
           ISNULL(CONVERT(VARCHAR(10), [tblUnitReference].[TransactionDate], 1), '') AS [TransactionDate],
           CAST(ISNULL([tblUnitReference].[Rental], 0) AS DECIMAL(10, 2)) AS [Rental],
           CAST(ISNULL([tblUnitReference].[SecAndMaintenance], 0) AS DECIMAL(10, 2)) AS [SecAndMaintenance],
           CAST(ISNULL([tblUnitReference].[TotalRent], 0) AS DECIMAL(10, 2)) AS [TotalRent],
           CAST(ISNULL([tblUnitReference].[AdvancePaymentAmount], 0) AS DECIMAL(10, 2)) AS [AdvancePaymentAmount],
           CAST(ISNULL([tblUnitReference].[SecDeposit], 0) AS DECIMAL(10, 2)) AS [SecDeposit],
           CAST(ISNULL([tblUnitReference].[Total], 0) AS DECIMAL(10, 2)) AS [Total],
           [tblUnitReference].[EncodedBy],
           [tblUnitReference].[EncodedDate],
           [tblUnitReference].[IsActive],
           [tblUnitReference].[ComputerName],
           ISNULL([tblUnitReference].[AdvancePaymentAmount], 0) AS [TwoMonAdvance],
           IIF(ISNULL([tblUnitReference].[IsFullPayment], 0) = 1,
               @TotalForPayment + ISNULL([tblUnitReference].[SecDeposit], 0),
               CAST((ISNULL([tblUnitReference].[AdvancePaymentAmount], 0) + ISNULL([tblUnitReference].[SecDeposit], 0))
                    - IIF(ISNULL([dbo].[tblUnitReference].[FirtsPaymentBalanceAmount], 0) > 0,
                          [PAYMENT].[TotalPayAMount],
                          0) AS DECIMAL(10, 2))) AS [TotalForPayment],
           ISNULL([tblUnitReference].[IsUnitMoveOut], 0) AS [IsUnitMoveOut],
           (
               SELECT IIF(COUNT(*) > 0, 'IN-PROGRESS', 'CLOSED')
               FROM [dbo].[tblMonthLedger] WITH (NOLOCK)
               WHERE [tblMonthLedger].[ReferenceID] = @RecId
                     AND ISNULL([tblMonthLedger].[IsPaid], 0) = 0
           ) AS [PaymentStatus],
           (
               SELECT TOP 1
                      ISNULL(CONVERT(VARCHAR(10), [tblPayment].[EncodedDate], 1), '')
               FROM [dbo].[tblPayment] WITH (NOLOCK)
               WHERE [tblPayment].[RefId] = 'REF' + CONVERT(VARCHAR, @RecId)
               ORDER BY [tblPayment].[EncodedDate] DESC
           ) AS [LastPaymentDate],
           IIF(ISNULL([tblUnitReference].[IsSignedContract], 0) = 1, 'DONE', '') AS [ContractSignStatus],
           ISNULL(CONVERT(VARCHAR(10), [tblUnitReference].[SignedContractDate], 1), '') AS [ContractSignedDate],
           IIF(ISNULL([tblUnitReference].[IsUnitMove], 0) = 1, 'DONE', '') AS [MoveinStatus],
           ISNULL(CONVERT(VARCHAR(10), [tblUnitReference].[UnitMoveInDate], 1), '') AS [MoveInDate],
           IIF(ISNULL([tblUnitReference].[IsUnitMoveOut], 0) = 1, 'DONE', '') AS [MoveOutStatus],
           ISNULL(CONVERT(VARCHAR(10), [tblUnitReference].[UnitMoveOutDate], 1), '') AS [MoveOutDate],
           IIF(ISNULL([tblUnitReference].[IsTerminated], 0) = 1, 'YES', '') AS [TerminationStatus],
           ISNULL(CONVERT(VARCHAR(10), [tblUnitReference].[TerminationDate], 1), '') AS [TerminationDate],
           IIF(ISNULL([tblUnitReference].[IsDone], 0) = 1, 'CLOSED', 'IN-PROGRESS') AS [ContractStatus],
           ISNULL(CONVERT(VARCHAR(10), [tblUnitReference].[ContactDoneDate], 1), '') AS [ContractCloseDate],
           CAST(ISNULL([PAYMENT].[TotalPayAMount], 0) AS DECIMAL(18, 2)) AS [TotalPayAMount],
           ISNULL([tblUnitReference].[FirtsPaymentBalanceAmount], 0) AS [FirtsPaymentBalanceAmount]
    FROM [dbo].[tblUnitReference] WITH (NOLOCK)
        INNER JOIN [dbo].[tblProjectMstr] WITH (NOLOCK)
            ON [tblUnitReference].[ProjectId] = [tblProjectMstr].[RecId]
        INNER JOIN [dbo].[tblUnitMstr] WITH (NOLOCK)
            ON [tblUnitMstr].[RecId] = [tblUnitReference].[UnitId]
        OUTER APPLY
    (
        SELECT ISNULL(SUM([tblTransaction].[ReceiveAmount]), 0) AS [TotalPayAMount]
        FROM [dbo].[tblTransaction]
        WHERE [tblUnitReference].[RefId] = [tblTransaction].[RefId]
        GROUP BY [tblTransaction].[RefId]
    ) [PAYMENT]
    WHERE [tblUnitReference].[RecId] = @RecId;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetComputationList]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- UNION THE SELECT OF PARKING LIST LATER ON
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetComputationList]
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    SELECT [tblUnitReference].[RecId],
           [tblUnitReference].[RefId],
           [tblUnitReference].[ProjectId],
           ISNULL([tblProjectMstr].[ProjectName], '') AS [ProjectName],
           ISNULL([tblProjectMstr].[ProjectAddress], '') AS [ProjectAddress],
           ISNULL([tblProjectMstr].[ProjectType], '') AS [ProjectType],
           ISNULL([tblUnitReference].[InquiringClient], '') AS [InquiringClient],
           ISNULL([tblUnitReference].[ClientID], '') AS [ClientID],
           ISNULL([tblUnitReference].[ClientMobile], '') AS [ClientMobile],
           [tblUnitReference].[UnitId],
           ISNULL([tblUnitReference].[UnitNo], '') AS [UnitNo],
           ISNULL([tblUnitMstr].[FloorType], '') AS [FloorType],
           ISNULL(CONVERT(VARCHAR(20), [tblUnitReference].[StatDate], 107), '') AS [StatDate],
           ISNULL(CONVERT(VARCHAR(20), [tblUnitReference].[FinishDate], 107), '') AS [FinishDate],
           ISNULL(CONVERT(VARCHAR(20), [tblUnitReference].[TransactionDate], 107), '') AS [TransactionDate],
           CAST(ISNULL([tblUnitReference].[Rental], 0) AS DECIMAL(10, 2)) AS [Rental],
           CAST(ISNULL([tblUnitReference].[SecAndMaintenance], 0) AS DECIMAL(10, 2)) AS [SecAndMaintenance],
           CAST(ISNULL([tblUnitReference].[TotalRent], 0) AS DECIMAL(10, 2)) AS [TotalRent],
           CAST(ISNULL([tblUnitReference].[AdvancePaymentAmount], 0) AS DECIMAL(10, 2)) AS [AdvancePaymentAmount],
           CAST(ISNULL([tblUnitReference].[SecDeposit], 0) AS DECIMAL(10, 2)) AS [SecDeposit],
           CAST(ISNULL([tblUnitReference].[Total], 0) AS DECIMAL(10, 2)) AS [Total],
           [tblUnitReference].[EncodedBy],
           [tblUnitReference].[EncodedDate],
           [tblUnitReference].[IsActive],
           [tblUnitReference].[ComputerName],
           IIF(ISNULL([tblUnitMstr].[IsParking], 0) = 1, 'TYPE OF PARKING', 'TYPE OF UNIT') AS [TypeOf],
           IIF(ISNULL([tblUnitReference].[IsFullPayment], 0) = 1, 'FULL PAYMENT', 'INSTALLMENT') AS [PaymentCategory],
		   IIF(ISNULL([tblUnitReference].[IsPartialPayment], 0) = 1, 'HOLD - PARTIAL PAYMENT', 'NEW') AS [TranStatus]--this for First Payment Flag AS Partial Payment
    FROM [dbo].[tblUnitReference] WITH (NOLOCK)
        INNER JOIN [dbo].[tblProjectMstr] WITH (NOLOCK)
            ON [tblUnitReference].[ProjectId] = [tblProjectMstr].[RecId]
        INNER JOIN [dbo].[tblUnitMstr] WITH (NOLOCK)
            ON [tblUnitMstr].[RecId] = [tblUnitReference].[UnitId]
    WHERE ISNULL([tblUnitReference].[IsPaid], 0) = 0;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetContractDetailsInquiry]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC [sp_GetComputationById] 10000000
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetContractDetailsInquiry] @RefId VARCHAR(20) = NULL
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;


    SELECT [tblUnitReference].[RecId],
           [tblUnitReference].[RefId],
           ISNULL([tblUnitReference].[ClientID], '') AS [ClientID],
           [tblUnitReference].[ProjectId],
           ISNULL([tblProjectMstr].[ProjectName], '') AS [ProjectName],
           ISNULL([tblProjectMstr].[ProjectAddress], '') AS [ProjectAddress],
           ISNULL([tblProjectMstr].[ProjectType], '') AS [ProjectType],
           ISNULL([tblUnitReference].[InquiringClient], '') AS [InquiringClient],
           ISNULL([tblUnitReference].[ClientMobile], '') AS [ClientMobile],
           [tblUnitReference].[UnitId],
           ISNULL([tblUnitReference].[UnitNo], '') AS [UnitNo],
           ISNULL([tblUnitMstr].[FloorType], '') AS [FloorType],
           ISNULL(CONVERT(VARCHAR(20), [tblUnitReference].[StatDate], 107), '') AS [StatDate],
           ISNULL(CONVERT(VARCHAR(20), [tblUnitReference].[FinishDate], 107), '') AS [FinishDate],
           ISNULL(CONVERT(VARCHAR(20), [tblUnitReference].[TransactionDate],107), '') AS [TransactionDate],
           CAST(ISNULL([tblUnitReference].[Rental], 0) AS DECIMAL(10, 2)) AS [Rental],
           CAST(ISNULL([tblUnitReference].[SecAndMaintenance], 0) AS DECIMAL(10, 2)) AS [SecAndMaintenance],
           CAST(ISNULL([tblUnitReference].[TotalRent], 0) AS DECIMAL(10, 2)) AS [TotalRent],
           CAST(ISNULL([tblUnitReference].[AdvancePaymentAmount], 0) AS DECIMAL(10, 2)) AS [AdvancePaymentAmount],
           CAST(ISNULL([tblUnitReference].[SecDeposit], 0) AS DECIMAL(10, 2)) AS [SecDeposit],
           CAST(ISNULL([tblUnitReference].[Total], 0) AS DECIMAL(10, 2)) AS [Total],
           [tblUnitReference].[EncodedBy],
           [tblUnitReference].[EncodedDate],
           [tblUnitReference].[IsActive],
           [tblUnitReference].[ComputerName],
           ISNULL([tblUnitReference].[AdvancePaymentAmount], 0) AS [TwoMonAdvance],
           ISNULL([tblUnitReference].[IsUnitMoveOut], 0) AS [IsUnitMoveOut],
           --IIF(ISNULL([tblUnitReference].[IsSignedContract], 0) = 1, 'DONE', '') AS [ContractSignStatus],
           --ISNULL(CONVERT(VARCHAR(10), [tblUnitReference].[SignedContractDate], 1), '') AS [ContractSignedDate],
           --IIF(ISNULL([tblUnitReference].[IsUnitMove], 0) = 1, 'DONE', '') AS [MoveinStatus],
           --ISNULL(CONVERT(VARCHAR(10), [tblUnitReference].[UnitMoveInDate], 1), '') AS [MoveInDate],
           --IIF(ISNULL([tblUnitReference].[IsUnitMoveOut], 0) = 1, 'DONE', '') AS [MoveOutStatus],
           --ISNULL(CONVERT(VARCHAR(10), [tblUnitReference].[UnitMoveOutDate], 1), '') AS [MoveOutDate],
           --IIF(ISNULL([tblUnitReference].[IsTerminated], 0) = 1, 'YES', '') AS [TerminationStatus],
           --ISNULL(CONVERT(VARCHAR(10), [tblUnitReference].[TerminationDate], 1), '') AS [TerminationDate],
           --IIF(ISNULL([tblUnitReference].[IsDone], 0) = 1, 'CLOSED', 'IN-PROGRESS') AS [ContractStatus],
           --ISNULL(CONVERT(VARCHAR(10), [tblUnitReference].[ContactDoneDate], 1), '') AS [ContractCloseDate],
		   ISNULL([tblUnitReference].[IsPaid], 0) AS [PaymentStatus],
           ISNULL([tblUnitReference].[IsSignedContract], 0) AS [ContractSignStatus],
           ISNULL([tblUnitReference].[IsUnitMove], 0) AS [MoveinStatus],
           ISNULL([tblUnitReference].[IsUnitMoveOut], 0) AS [MoveOutStatus],
           ISNULL([tblUnitReference].[IsTerminated], 0) AS [TerminationStatus],
           ISNULL([tblUnitReference].[IsDone], 0) AS [ContractStatus],
           [PAYMENT].[TotalPayAMount] AS [TotalPayAMount]
    FROM [dbo].[tblUnitReference] WITH (NOLOCK)
        INNER JOIN [dbo].[tblProjectMstr] WITH (NOLOCK)
            ON [tblUnitReference].[ProjectId] = [tblProjectMstr].[RecId]
        INNER JOIN [dbo].[tblUnitMstr] WITH (NOLOCK)
            ON [tblUnitMstr].[RecId] = [tblUnitReference].[UnitId]
        OUTER APPLY
    (
        SELECT ISNULL(SUM([tblTransaction].[ReceiveAmount]), 0) AS [TotalPayAMount]
        FROM [dbo].[tblTransaction]
        WHERE [tblUnitReference].[RefId] = [tblTransaction].[RefId]
        GROUP BY [tblTransaction].[RefId]
    ) [PAYMENT]
    WHERE [tblUnitReference].[RefId] = @RefId;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetContractList]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_GetContractList]
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT
            [tblUnitReference].[RecId],
            [tblUnitReference].[RefId],
            [tblUnitReference].[ProjectId],
            [tblUnitReference].[InquiringClient],
            [tblUnitReference].[ClientMobile],
            [tblUnitReference].[UnitId],
            [tblUnitReference].[UnitNo],
            CONVERT(VARCHAR(10), [tblUnitReference].[StatDate], 101)        AS [StatDate],
            CONVERT(VARCHAR(10), [tblUnitReference].[FinishDate], 101)      AS [FinishDate],
            CONVERT(VARCHAR(10), [tblUnitReference].[TransactionDate], 101) AS [TransactionDate],
            [tblUnitReference].[Rental],
            [tblUnitReference].[SecAndMaintenance],
            [tblUnitReference].[TotalRent],
            [tblUnitReference].[SecDeposit],
            [tblUnitReference].[Total],
            [tblUnitReference].[EncodedBy],
            [tblUnitReference].[EncodedDate],
            [tblUnitReference].[LastCHangedBy],
            [tblUnitReference].[LastChangedDate],
            [tblUnitReference].[IsActive],
            [tblUnitReference].[ComputerName],
            [tblUnitReference].[ClientID],
            [tblUnitReference].[IsPaid],
            [tblUnitReference].[IsDone],
            [tblUnitReference].[HeaderRefId],
            [tblUnitReference].[IsSignedContract],
            [tblUnitReference].[IsUnitMove],
            [tblUnitReference].[IsTerminated],
            [tblUnitReference].[GenVat],
            [tblUnitReference].[WithHoldingTax],
            [tblUnitReference].[IsUnitMoveOut],
            [tblUnitReference].[FirstPaymentDate],
            [tblUnitReference].[ContactDoneDate],
            [tblUnitReference].[SignedContractDate],
            [tblUnitReference].[UnitMoveInDate],
            [tblUnitReference].[UnitMoveOutDate],
            [tblUnitReference].[TerminationDate],
            [tblUnitReference].[AdvancePaymentAmount]
        FROM
            [dbo].[tblUnitReference];
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetControlList]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetControlList]
AS
    BEGIN

        SET NOCOUNT ON;

        SELECT
                [tblFormControlsMaster].[ControlId],
                [tblFormControlsMaster].[FormId],
                [tblForm].[FormDescription],
                [tblFormControlsMaster].[MenuId],
                [tblMenu].[MenuName],
                [tblFormControlsMaster].[ControlName],
                [tblFormControlsMaster].[ControlDescription],
                IIF(ISNULL([tblFormControlsMaster].[IsBackRoundControl], 0) = 1, 'YES', 'NO') AS [IsBackRoundControl],
                IIF(ISNULL([tblFormControlsMaster].[IsHeaderControl], 0) = 1, 'YES', 'NO')    AS [IsHeaderControl],
                IIF(ISNULL([tblFormControlsMaster].[IsDelete], 0) = 0, 'ACTIVE', 'IN-ACTIVE') AS [Status]
        FROM
                [dbo].[tblFormControlsMaster]
            INNER JOIN
                [dbo].[tblForm]
                    ON [tblFormControlsMaster].[FormId] = [tblForm].[FormId]
            INNER JOIN
                [dbo].[tblMenu]
                    ON [tblFormControlsMaster].[MenuId] = [tblMenu].[MenuId];

    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetControlListByGroupIdAndMenuId]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC [sp_GetControlListByGroupIdAndMenuId] 1,2
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetControlListByGroupIdAndMenuId]
    @MenuId  INT = NULL,
    @GroupId INT = NULL
AS
    BEGIN

        SET NOCOUNT ON;

        SELECT  DISTINCT
                [tblFormControlsMaster].[ControlId],
                [tblMenu].[MenuName],
                [tblFormControlsMaster].[ControlName],
                [tblFormControlsMaster].[ControlDescription],
                IIF(ISNULL([tblGroupFormControls].[IsVisible], 0) = 1, 'YES', 'NO') AS [IsVisible]
        FROM
                [dbo].[tblGroupFormControls]
            INNER JOIN
                [dbo].[tblFormControlsMaster]
                    ON [tblGroupFormControls].[FormId] = [tblFormControlsMaster].[FormId]
                       AND [tblGroupFormControls].[ControlId] = [tblFormControlsMaster].[ControlId]
            INNER JOIN
                [dbo].[tblMenu]
                    ON [tblFormControlsMaster].[MenuId] = [tblMenu].[MenuId]
        WHERE
                [tblGroupFormControls].[GroupId] = @GroupId
                AND [tblFormControlsMaster].[MenuId] = @MenuId
                AND ISNULL([tblFormControlsMaster].[IsBackRoundControl], 0) = 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getControlPermission]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC [sp_getControlPermission] 1
-- =============================================
CREATE PROCEDURE [dbo].[sp_getControlPermission] @GroupId INT = NULL
-- Add the parameters for the stored procedure here

AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        -- Insert statements for procedure here
        SELECT
                [tblForm].[FormName],
                [tblFormControlsMaster].[ControlName]         AS [ControlName],
                ISNULL([tblGroupFormControls].[IsVisible], 0) AS [Permission]
        FROM
                [dbo].[tblGroupFormControls]
            INNER JOIN
                [dbo].[tblFormControlsMaster]
                    ON [tblGroupFormControls].[ControlId] = [tblFormControlsMaster].[ControlId]
            INNER JOIN
                [dbo].[tblForm]
                    ON [tblFormControlsMaster].[FormId] = [tblForm].[FormId]
        WHERE
                ISNULL([tblFormControlsMaster].[IsBackRoundControl], 0) = 0
                AND [tblGroupFormControls].[GroupId] = @GroupId;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_getControlPermission_Debug]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_getControlPermission_Debug] 
@GroupId INT =NULL
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT 
		tblForm.FormName,
		tblFormControlsMaster.ControlName AS ControlName,
		ISNULL(tblGroupFormControls.IsVisible,0) AS Permission  
	FROM tblGroupFormControls
		INNER JOIN tblFormControlsMaster
			ON tblGroupFormControls.ControlId = tblFormControlsMaster.ControlId
		INNER JOIN tblForm
			ON tblFormControlsMaster.FormId = tblForm.FormId 
	WHERE ISNULL(tblFormControlsMaster.IsBackRoundControl,0)=0
	AND tblGroupFormControls.GroupId = @GroupId
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetFilesByClient]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetFilesByClient] @ClientName VARCHAR(50)
AS
    BEGIN
        SELECT
            [Files].[Id],
            [Files].[FilePath],
            [Files].[FileData],
            [Files].[FileNames],
            [Files].[Notes],
            [Files].[Files]
        FROM
            [dbo].[Files]
        WHERE
            [Files].[ClientName] = @ClientName;
    END;

GO
/****** Object:  StoredProcedure [dbo].[sp_GetFilesByClientAndReference]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetFilesByClientAndReference]
    @ClientName  VARCHAR(50) = NULL,
    @ReferenceID VARCHAR(20) = NULL
AS
    BEGIN
        SELECT
            [Files].[Id],
            [Files].[FilePath],
            [Files].[FileData],
            [Files].[FileNames],
            [Files].[Notes],
            [Files].[Files]
        FROM
            [dbo].[Files]
        WHERE
            [Files].[ClientName] = @ClientName
            AND [Files].[RefId] = @ReferenceID;
    END;

GO
/****** Object:  StoredProcedure [dbo].[sp_GetForContractSignedParkingList]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetForContractSignedParkingList]
-- Add the parameters for the stored procedure here

AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        -- Insert statements for procedure here
        SELECT
                [tblUnitReference].[RecId],
                [tblUnitReference].[RefId],
                [tblUnitReference].[ProjectId],
                [tblUnitReference].[InquiringClient],
                [tblUnitReference].[ClientMobile],
                [tblUnitReference].[UnitId],
                [tblUnitReference].[UnitNo],
                [tblUnitReference].[StatDate],
                [tblUnitReference].[FinishDate],
                [tblUnitReference].[TransactionDate],
                [tblUnitReference].[Rental],
                [tblUnitReference].[SecAndMaintenance],
                [tblUnitReference].[TotalRent],
                [tblUnitReference].[AdvancePaymentAmount],
                [tblUnitReference].[SecDeposit],
                [tblUnitReference].[Total],
                [tblUnitReference].[EncodedBy],
                [tblUnitReference].[EncodedDate],
                [tblUnitReference].[LastCHangedBy],
                [tblUnitReference].[LastChangedDate],
                [tblUnitReference].[IsActive],
                [tblUnitReference].[ComputerName],
                [tblUnitReference].[ClientID],
                [tblUnitReference].[IsPaid],
                [tblUnitReference].[IsDone],
                [tblUnitReference].[HeaderRefId],
                [tblUnitReference].[IsSignedContract],
                [tblUnitReference].[IsUnitMove],
                [tblUnitReference].[IsTerminated]
        FROM
                [dbo].[tblUnitReference] WITH (NOLOCK)
            INNER JOIN
                [dbo].[tblUnitMstr] WITH (NOLOCK)
                    ON [tblUnitReference].[UnitId] = [tblUnitMstr].[RecId]
        WHERE
                ISNULL([tblUnitReference].[IsPaid], 0) = 1
                AND ISNULL([tblUnitReference].[IsDone], 0) = 0
                AND ISNULL([tblUnitReference].[IsSignedContract], 0) = 0
                AND ISNULL([tblUnitReference].[IsUnitMove], 0) = 0
                AND ISNULL([tblUnitReference].[IsTerminated], 0) = 0
                AND ISNULL([tblUnitMstr].[IsParking], 0) = 1;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetForContractSignedUnitList]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetForContractSignedUnitList]
-- Add the parameters for the stored procedure here

AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        -- Insert statements for procedure here
        SELECT
                [tblUnitReference].[RecId],
                [tblUnitReference].[RefId],
                [tblUnitReference].[ProjectId],
                [tblUnitReference].[InquiringClient],
                [tblUnitReference].[ClientMobile],
                [tblUnitReference].[UnitId],
                [tblUnitReference].[UnitNo],
                [tblUnitReference].[StatDate],
                [tblUnitReference].[FinishDate],
                [tblUnitReference].[TransactionDate],
                [tblUnitReference].[Rental],
                [tblUnitReference].[SecAndMaintenance],
                [tblUnitReference].[TotalRent],
                [tblUnitReference].[AdvancePaymentAmount],
                [tblUnitReference].[SecDeposit],
                [tblUnitReference].[Total],
                [tblUnitReference].[EncodedBy],
                [tblUnitReference].[EncodedDate],
                [tblUnitReference].[LastCHangedBy],
                [tblUnitReference].[LastChangedDate],
                [tblUnitReference].[IsActive],
                [tblUnitReference].[ComputerName],
                [tblUnitReference].[ClientID],
                [tblUnitReference].[IsPaid],
                [tblUnitReference].[IsDone],
                [tblUnitReference].[HeaderRefId],
                [tblUnitReference].[IsSignedContract],
                [tblUnitReference].[IsUnitMove],
                [tblUnitReference].[IsTerminated]
        FROM
                [dbo].[tblUnitReference] WITH (NOLOCK)
            INNER JOIN
                [dbo].[tblUnitMstr] WITH (NOLOCK)
                    ON [tblUnitReference].[UnitId] = [tblUnitMstr].[RecId]
        WHERE
                ISNULL([tblUnitReference].[IsPaid], 0) = 1
                AND ISNULL([tblUnitReference].[IsDone], 0) = 0
                AND ISNULL([tblUnitReference].[IsSignedContract], 0) = 0
                AND ISNULL([tblUnitReference].[IsUnitMove], 0) = 0
                AND ISNULL([tblUnitReference].[IsTerminated], 0) = 0
                AND ISNULL([tblUnitMstr].[IsParking], 0) = 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetFormList]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetFormList]
AS
    BEGIN

        SET NOCOUNT ON;

        SELECT
            [tblForm].[FormId],
            [tblForm].[MenuId],
            [tblForm].[FormName],
            [tblForm].[FormDescription],
            [tblForm].[IsDelete]
        FROM
            [dbo].[tblForm];
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetFormListByGroupId]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC [sp_GetFormListByGroupId] 2
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetFormListByGroupId] @GroupId INT = NULL
AS
    BEGIN

        SET NOCOUNT ON;

        SELECT  DISTINCT
                [tblGroupFormControls].[FormId],
                [tblForm].[FormDescription]
        FROM
                [dbo].[tblGroupFormControls]
            INNER JOIN
                [dbo].[tblForm]
                    ON [tblGroupFormControls].[FormId] = [tblForm].[FormId]
        WHERE
                [tblGroupFormControls].[GroupId] = @GroupId;

    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetForMoveInParkingList]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetForMoveInParkingList]
-- Add the parameters for the stored procedure here

AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        -- Insert statements for procedure here
        SELECT
                [tblUnitReference].[RecId],
                [tblUnitReference].[RefId],
                [tblUnitReference].[ProjectId],
                [tblUnitReference].[InquiringClient],
                [tblUnitReference].[ClientMobile],
                [tblUnitReference].[UnitId],
                [tblUnitReference].[UnitNo],
                [tblUnitReference].[StatDate],
                [tblUnitReference].[FinishDate],
                [tblUnitReference].[TransactionDate],
                [tblUnitReference].[Rental],
                [tblUnitReference].[SecAndMaintenance],
                [tblUnitReference].[TotalRent],
                [tblUnitReference].[AdvancePaymentAmount],
                [tblUnitReference].[SecDeposit],
                [tblUnitReference].[Total],
                [tblUnitReference].[EncodedBy],
                [tblUnitReference].[EncodedDate],
                [tblUnitReference].[LastCHangedBy],
                [tblUnitReference].[LastChangedDate],
                [tblUnitReference].[IsActive],
                [tblUnitReference].[ComputerName],
                [tblUnitReference].[ClientID],
                [tblUnitReference].[IsPaid],
                [tblUnitReference].[IsDone],
                [tblUnitReference].[HeaderRefId],
                [tblUnitReference].[IsSignedContract],
                [tblUnitReference].[IsUnitMove],
                [tblUnitReference].[IsUnitMoveOut],
                [tblUnitReference].[IsTerminated]
        FROM
                [dbo].[tblUnitReference] WITH (NOLOCK)
            INNER JOIN
                [dbo].[tblUnitMstr] WITH (NOLOCK)
                    ON [tblUnitReference].[UnitId] = [tblUnitMstr].[RecId]
        WHERE
                ISNULL([tblUnitReference].[IsPaid], 0) = 1
                AND ISNULL([tblUnitReference].[IsDone], 0) = 0
                AND ISNULL([tblUnitReference].[IsSignedContract], 0) = 1
                AND ISNULL([tblUnitReference].[IsUnitMove], 0) = 0
                AND ISNULL([tblUnitReference].[IsUnitMoveOut], 0) = 0
                AND ISNULL([tblUnitReference].[IsTerminated], 0) = 0
                AND ISNULL([tblUnitMstr].[IsParking], 0) = 1;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetForMoveInUnitList]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetForMoveInUnitList]
-- Add the parameters for the stored procedure here

AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        -- Insert statements for procedure here
        SELECT
                [tblUnitReference].[RecId],
                [tblUnitReference].[RefId],
                [tblUnitReference].[ProjectId],
                [tblUnitReference].[InquiringClient],
                [tblUnitReference].[ClientMobile],
                [tblUnitReference].[UnitId],
                [tblUnitReference].[UnitNo],
                [tblUnitReference].[StatDate],
                [tblUnitReference].[FinishDate],
                [tblUnitReference].[TransactionDate],
                [tblUnitReference].[Rental],
                [tblUnitReference].[SecAndMaintenance],
                [tblUnitReference].[TotalRent],
                [tblUnitReference].[AdvancePaymentAmount],
                [tblUnitReference].[SecDeposit],
                [tblUnitReference].[Total],
                [tblUnitReference].[EncodedBy],
                [tblUnitReference].[EncodedDate],
                [tblUnitReference].[LastCHangedBy],
                [tblUnitReference].[LastChangedDate],
                [tblUnitReference].[IsActive],
                [tblUnitReference].[ComputerName],
                [tblUnitReference].[ClientID],
                [tblUnitReference].[IsPaid],
                [tblUnitReference].[IsDone],
                [tblUnitReference].[HeaderRefId],
                [tblUnitReference].[IsSignedContract],
                [tblUnitReference].[IsUnitMove],
                [tblUnitReference].[IsUnitMoveOut],
                [tblUnitReference].[IsTerminated]
        FROM
                [dbo].[tblUnitReference] WITH (NOLOCK)
            INNER JOIN
                [dbo].[tblUnitMstr] WITH (NOLOCK)
                    ON [tblUnitReference].[UnitId] = [tblUnitMstr].[RecId]
        WHERE
                ISNULL([tblUnitReference].[IsPaid], 0) = 1
                AND ISNULL([tblUnitReference].[IsDone], 0) = 0
                AND ISNULL([tblUnitReference].[IsSignedContract], 0) = 1
                AND ISNULL([tblUnitReference].[IsUnitMove], 0) = 0
                AND ISNULL([tblUnitReference].[IsUnitMoveOut], 0) = 0
                AND ISNULL([tblUnitReference].[IsTerminated], 0) = 0
                AND ISNULL([tblUnitMstr].[IsParking], 0) = 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetForMoveOutParkingList]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetForMoveOutParkingList]
-- Add the parameters for the stored procedure here

AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;
        -- Insert statements for procedure here
        SELECT
                [tblUnitReference].[RecId],
                [tblUnitReference].[RefId],
                [tblUnitReference].[ProjectId],
                [tblUnitReference].[InquiringClient],
                [tblUnitReference].[ClientMobile],
                [tblUnitReference].[UnitId],
                [tblUnitReference].[UnitNo],
                [tblUnitReference].[StatDate],
                [tblUnitReference].[FinishDate],
                [tblUnitReference].[TransactionDate],
                [tblUnitReference].[Rental],
                [tblUnitReference].[SecAndMaintenance],
                [tblUnitReference].[TotalRent],
                [tblUnitReference].[AdvancePaymentAmount],
                [tblUnitReference].[SecDeposit],
                [tblUnitReference].[Total],
                [tblUnitReference].[EncodedBy],
                [tblUnitReference].[EncodedDate],
                [tblUnitReference].[LastCHangedBy],
                [tblUnitReference].[LastChangedDate],
                [tblUnitReference].[IsActive],
                [tblUnitReference].[ComputerName],
                [tblUnitReference].[ClientID],
                [tblUnitReference].[IsPaid],
                [tblUnitReference].[IsDone],
                [tblUnitReference].[HeaderRefId],
                [tblUnitReference].[IsSignedContract],
                [tblUnitReference].[IsUnitMove],
                [tblUnitReference].[IsUnitMoveOut],
                [tblUnitReference].[IsTerminated]
        FROM
                [dbo].[tblUnitReference] WITH (NOLOCK)
            INNER JOIN
                [dbo].[tblUnitMstr] WITH (NOLOCK)
                    ON [tblUnitReference].[UnitId] = [tblUnitMstr].[RecId]
        WHERE
                ISNULL([tblUnitReference].[IsPaid], 0) = 1
                AND ISNULL([tblUnitReference].[IsSignedContract], 0) = 1
                AND ISNULL([tblUnitReference].[IsUnitMove], 0) = 1
                AND ISNULL([tblUnitReference].[IsUnitMoveOut], 0) = 1
                AND ISNULL([tblUnitMstr].[IsParking], 0) = 1
                AND ISNULL([tblUnitReference].[IsDone], 0) = 0
                AND ISNULL([tblUnitReference].[IsTerminated], 0) = 0
                OR ISNULL([tblUnitReference].[IsTerminated], 0) = 1
                   AND ISNULL([tblUnitReference].[IsSignedContract], 0) = 1
                   AND ISNULL([tblUnitReference].[IsUnitMove], 0) = 1
                   AND ISNULL([tblUnitReference].[IsUnitMoveOut], 0) = 1
                   AND ISNULL([tblUnitMstr].[IsParking], 0) = 1
                   AND ISNULL([tblUnitReference].[IsDone], 0) = 0;

    --and
    --(
    --    SELECT COUNT(*)
    --    from tblMonthLedger WITH (NOLOCK)
    --    where ReferenceID = tblUnitReference.RecId
    --          and ISNULL(IsPaid, 0) = 1
    --) > 0
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetForMoveOutUnitList]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetForMoveOutUnitList]
-- Add the parameters for the stored procedure here

AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        DECLARE @IsForMoveOut BIT = 0;

        -- Insert statements for procedure here
        SELECT
                [tblUnitReference].[RecId],
                [tblUnitReference].[RefId],
                [tblUnitReference].[ProjectId],
                [tblUnitReference].[InquiringClient],
                [tblUnitReference].[ClientMobile],
                [tblUnitReference].[UnitId],
                [tblUnitReference].[UnitNo],
                [tblUnitReference].[StatDate],
                [tblUnitReference].[FinishDate],
                [tblUnitReference].[TransactionDate],
                [tblUnitReference].[Rental],
                [tblUnitReference].[SecAndMaintenance],
                [tblUnitReference].[TotalRent],
                [tblUnitReference].[AdvancePaymentAmount],
                [tblUnitReference].[SecDeposit],
                [tblUnitReference].[Total],
                [tblUnitReference].[EncodedBy],
                [tblUnitReference].[EncodedDate],
                [tblUnitReference].[LastCHangedBy],
                [tblUnitReference].[LastChangedDate],
                [tblUnitReference].[IsActive],
                [tblUnitReference].[ComputerName],
                [tblUnitReference].[ClientID],
                [tblUnitReference].[IsPaid],
                [tblUnitReference].[IsDone],
                [tblUnitReference].[HeaderRefId],
                [tblUnitReference].[IsSignedContract],
                [tblUnitReference].[IsUnitMove],
                [tblUnitReference].[IsUnitMoveOut],
                [tblUnitReference].[IsTerminated]
        FROM
                [dbo].[tblUnitReference] WITH (NOLOCK)
            INNER JOIN
                [dbo].[tblUnitMstr] WITH (NOLOCK)
                    ON [tblUnitReference].[UnitId] = [tblUnitMstr].[RecId]
        WHERE
                ISNULL([tblUnitReference].[IsPaid], 0) = 1
                AND ISNULL([tblUnitReference].[IsSignedContract], 0) = 1
                AND ISNULL([tblUnitReference].[IsUnitMove], 0) = 1
                AND ISNULL([tblUnitReference].[IsUnitMoveOut], 0) = 1
                AND ISNULL([tblUnitMstr].[IsParking], 0) = 0
                AND ISNULL([tblUnitReference].[IsDone], 0) = 0
                AND ISNULL([tblUnitReference].[IsTerminated], 0) = 0
                OR ISNULL([tblUnitReference].[IsTerminated], 0) = 1
                   AND ISNULL([tblUnitReference].[IsSignedContract], 0) = 1
                   AND ISNULL([tblUnitReference].[IsUnitMove], 0) = 1
                   AND ISNULL([tblUnitReference].[IsUnitMoveOut], 0) = 1
                   AND ISNULL([tblUnitMstr].[IsParking], 0) = 0
                   AND ISNULL([tblUnitReference].[IsDone], 0) = 0;

    --and
    --(
    --    SELECT COUNT(*)
    --    from tblMonthLedger WITH (NOLOCK)
    --    where ReferenceID = tblUnitReference.RecId
    --          and ISNULL(IsPaid, 0) = 1
    --) > 0
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGroup]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetGroup] @UserId INT = NULL
AS
    BEGIN

        SELECT
                [tblUser].[UserId],
                [tblUser].[GroupId]    AS [Group_Code],
                [tblGroup].[GroupName] AS [Group_Name]
        FROM
                [dbo].[tblUser]
            INNER JOIN
                [dbo].[tblGroup]
                    ON [tblGroup].[GroupId] = [tblUser].[GroupId]
        WHERE
                [tblUser].[UserId] = @UserId;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGroupControlInfo]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_GetGroupControlInfo]
    @ControlId AS INT = NULL,
    @GroupId AS INT = NULL,
    @FormId AS INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT [tblGroupFormControls].[GroupControlId],
           [tblGroupFormControls].[FormId],
           [tblGroupFormControls].[ControlId],
           [tblGroupFormControls].[GroupId],
           [tblGroupFormControls].[IsVisible],
           [tblGroupFormControls].[IsDelete]
    FROM [dbo].[tblGroupFormControls]
    WHERE [tblGroupFormControls].[ControlId] = @ControlId
          AND [tblGroupFormControls].[GroupId] = @GroupId
          AND [tblGroupFormControls].[FormId] = @FormId;

END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetGroupList]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetGroupList]
AS
BEGIN

    SET NOCOUNT ON;
    MERGE INTO [dbo].[tblGroupFormControls] AS [target]
    USING
    (
        SELECT [tblFormControlsMaster].[FormId],
               [tblFormControlsMaster].[ControlId],
               [tblGroup].[GroupId],
               1 AS [IsVisible],
               0 AS [IsDelete]
        FROM [dbo].[tblFormControlsMaster]
            CROSS JOIN [dbo].[tblGroup]
    ) AS [source]
    ON [target].[FormId] = [source].[FormId]
       AND [target].[ControlId] = [source].[ControlId]
       AND [target].[GroupId] = [source].[GroupId]
    WHEN NOT MATCHED THEN
        INSERT
        (
            [FormId],
            [ControlId],
            [GroupId],
            [IsVisible],
            [IsDelete]
        )
        VALUES
        ([source].[FormId], [source].[ControlId], [source].[GroupId], [source].[IsVisible], [source].[IsDelete]);
    SELECT [tblGroup].[GroupId],
           [tblGroup].[GroupName],
           [tblGroup].[IsDelete]
    FROM [dbo].[tblGroup];

END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetInActiveLocationList]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetInActiveLocationList]
AS
    BEGIN

        SET NOCOUNT ON;

        SELECT
            [tblLocationMstr].[RecId],
            [tblLocationMstr].[Descriptions],
            [tblLocationMstr].[LocAddress],
            IIF(ISNULL([tblLocationMstr].[IsActive], 0) = 1, 'ACTIVE', 'IN-ACTIVE') AS [IsActive]
        FROM
            [dbo].[tblLocationMstr]
        WHERE
            ISNULL([IsActive], 0) = 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetInActiveProjectList]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetInActiveProjectList]
AS
    BEGIN

        SET NOCOUNT ON;


        SELECT
                [tblProjectMstr].[RecId],
                [tblProjectMstr].[LocId],
                [tblProjectMstr].[ProjectAddress],
                [tblLocationMstr].[Descriptions]                                       AS [LocationName],
                [tblProjectMstr].[ProjectName],
                [tblProjectMstr].[Descriptions],
                IIF(ISNULL([tblProjectMstr].[IsActive], 0) = 1, 'ACTIVE', 'IN-ACTIVE') AS [IsActive]
        FROM
                [dbo].[tblProjectMstr] WITH (NOLOCK)
            INNER JOIN
                [dbo].[tblLocationMstr] WITH (NOLOCK)
                    ON [tblLocationMstr].[RecId] = [tblProjectMstr].[LocId]
        WHERE
                ISNULL([tblProjectMstr].[IsActive], 0) = 0;

    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetInActivePurchaseItemList]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetInActivePurchaseItemList]
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
                ISNULL(CONVERT(VARCHAR(10), [tblProjPurchItem].[DatePurchase], 103), '')    AS [DatePurchase],
                CAST(ISNULL([tblProjPurchItem].[UnitAmount], 0) AS DECIMAL(10, 2))          AS [UnitAmount],
                CAST(ISNULL([tblProjPurchItem].[Amount], 0) AS DECIMAL(10, 2))              AS [Amount],
                CAST(ISNULL([tblProjPurchItem].[TotalAmount], 0) AS DECIMAL(10, 2))         AS [TotalAmount],
                ISNULL([tblProjPurchItem].[Remarks], '')                                    AS [Remarks],
                IIF(ISNULL([tblProjPurchItem].[IsActive], 0) = 1, 'ACTIVE', 'IN-ACTIVE')    AS [IsActive],
                ISNULL([tblProjPurchItem].[EncodedBy], 0)                                   AS [EncodedBy],
                ISNULL(CONVERT(VARCHAR(10), [tblProjPurchItem].[EncodedDate], 103), '')     AS [EncodedDate],
                ISNULL([tblProjPurchItem].[LastChangedBy], 0)                               AS [LastChangedBy],
                ISNULL(CONVERT(VARCHAR(10), [tblProjPurchItem].[LastChangedDate], 103), '') AS [LastChangedDate],
                ISNULL([tblProjPurchItem].[ComputerName], '')                               AS [ComputerName]
        FROM
                [dbo].[tblProjPurchItem]
            INNER JOIN
                [dbo].[tblProjectMstr]
                    ON [tblProjectMstr].[RecId] = [tblProjPurchItem].[ProjectId]
        WHERE
                ISNULL([tblProjPurchItem].[IsActive], 0) = 0;



    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetLatestFile]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetLatestFile]
AS
    BEGIN
        SELECT TOP 1
               [Files].[FilePath],
               [Files].[FileData]
        FROM
               [dbo].[Files]
        ORDER BY
               [Files].[Id] DESC;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetLedgerList]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC [sp_GetLedgerList] @ReferenceID =10000000, @ClientID='INDV10000000'
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetLedgerList]
    @ReferenceID BIGINT = NULL,
    @ClientID VARCHAR(150) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @TotalRent DECIMAL(18, 2) = NULL
    DECLARE @PenaltyPct DECIMAL(18, 2) = NULL

    SELECT @TotalRent = [tblUnitReference].[TotalRent],
           @PenaltyPct = [tblUnitReference].[PenaltyPct]
    FROM [dbo].[tblUnitReference] WITH (NOLOCK)
    WHERE [tblUnitReference].[RecId] = @ReferenceID

    /*Check if the penalty stop when it reach the specific date to penalty*/
    UPDATE [dbo].[tblMonthLedger]
    SET [tblMonthLedger].[PenaltyAmount] = IIF([tblMonthLedger].[PenaltyAmount] > 0,
                                               [tblMonthLedger].[PenaltyAmount],
                                               CASE
                                                   WHEN DATEDIFF(
                                                                    DAY,
                                                                    [tblMonthLedger].[LedgMonth],
                                                                    CAST(GETDATE() AS DATE)
                                                                ) < 30 THEN
                                                       0
                                                   WHEN DATEDIFF(
                                                                    DAY,
                                                                    [tblMonthLedger].[LedgMonth],
                                                                    CAST(GETDATE() AS DATE)
                                                                ) = 30 THEN
                                                       --CAST(((@TotalRent * @PenaltyPct) / 100) AS DECIMAL(18, 2))
                                                       CAST((([tblMonthLedger].[LedgRentalAmount] * @PenaltyPct) / 100) AS DECIMAL(18, 2))
                                                   WHEN DATEDIFF(
                                                                    DAY,
                                                                    [tblMonthLedger].[LedgMonth],
                                                                    CAST(GETDATE() AS DATE)
                                                                ) >= 31
                                                        AND DATEDIFF(
                                                                        DAY,
                                                                        [tblMonthLedger].[LedgMonth],
                                                                        CAST(GETDATE() AS DATE)
                                                                    --) <= 31 THEN
                                                                    ) <= 60 THEN
                                                       --CAST((((@TotalRent * @PenaltyPct) / 100) * 2) AS DECIMAL(18, 2))
                                                       CAST(((([tblMonthLedger].[LedgRentalAmount] * @PenaltyPct) / 100)
                                                             * 2
                                                            ) AS DECIMAL(18, 2))
                                                   WHEN DATEDIFF(
                                                                    DAY,
                                                                    [tblMonthLedger].[LedgMonth],
                                                                    CAST(GETDATE() AS DATE)
                                                                ) = 60 THEN
                                                       --CAST((((@TotalRent * @PenaltyPct) / 100) * 3) AS DECIMAL(18, 2))
                                                       CAST(((([tblMonthLedger].[LedgRentalAmount] * @PenaltyPct) / 100)
                                                             * 3
                                                            ) AS DECIMAL(18, 2))
                                                   WHEN DATEDIFF(
                                                                    DAY,
                                                                    [tblMonthLedger].[LedgMonth],
                                                                    CAST(GETDATE() AS DATE)
                                                                ) >= 61 THEN
                                                       --CAST((((@TotalRent * @PenaltyPct) / 100) * 4) AS DECIMAL(18, 2))
                                                       CAST(((([tblMonthLedger].[LedgRentalAmount] * @PenaltyPct) / 100)
                                                             * 4
                                                            ) AS DECIMAL(18, 2))
                                                   ELSE
                                                       0
                                               END)
    WHERE [tblMonthLedger].[ReferenceID] = @ReferenceID
          AND
          (
              ISNULL([tblMonthLedger].[IsPaid], 0) = 0
              OR ISNULL([tblMonthLedger].[IsHold], 0) = 1
          )
		  AND MONTH([tblMonthLedger].[EncodedDate]) > 4
          AND YEAR([tblMonthLedger].[EncodedDate]) = 2024

    UPDATE [dbo].[tblMonthLedger]
    SET [tblMonthLedger].[ActualAmount] = [tblMonthLedger].[LedgRentalAmount]
                                          + ISNULL([tblMonthLedger].[PenaltyAmount], 0)
    WHERE [tblMonthLedger].[ReferenceID] = @ReferenceID
          AND
          (
              ISNULL([tblMonthLedger].[IsPaid], 0) = 0
              OR ISNULL([tblMonthLedger].[IsHold], 0) = 1
          )
          

    SELECT ROW_NUMBER() OVER (ORDER BY [tblMonthLedger].[LedgMonth] ASC) [seq],
           [tblMonthLedger].[Recid],
           [tblMonthLedger].[ReferenceID],
           [tblMonthLedger].[ClientID],
           --[tblMonthLedger].[LedgAmount]  + ISNULL([tblMonthLedger].[PenaltyAmount], 0) AS [LedgAmount],
           [tblMonthLedger].[LedgRentalAmount] + ISNULL([tblMonthLedger].[PenaltyAmount], 0) AS [LedgAmount],
           ISNULL([tblMonthLedger].[PenaltyAmount], 0) AS [PenaltyAmount],
           ISNULL([tblMonthLedger].[TransactionID], '') AS [TransactionID],
           CONVERT(VARCHAR(20), [tblMonthLedger].[LedgMonth], 107) AS [LedgMonth],
           [tblMonthLedger].[Remarks] AS [Remarks],
           --IIF(ISNULL(IsPaid, 0) = 1,
           --    'PAID',
           --    IIF(CONVERT(VARCHAR(20), LedgMonth, 107) = CONVERT(VARCHAR(20), GETDATE(), 107), 'FOR PAYMENT', 'PENDING')) As PaymentStatus,
           CASE
               WHEN ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                    AND ISNULL([tblMonthLedger].[IsHold], 0) = 0 THEN
                   'PAID'
               WHEN ISNULL([tblMonthLedger].[IsPaid], 0) = 0
                    AND ISNULL([tblMonthLedger].[IsHold], 0) = 1 THEN
                   'HOLD'
               WHEN CONVERT(VARCHAR(20), [tblMonthLedger].[LedgMonth], 107) = CONVERT(VARCHAR(20), GETDATE(), 107) THEN
                   'FOR PAYMENT'
               ELSE
                   'PENDING'
           END AS [PaymentStatus],
           --IIF(
           --    [tblMonthLedger].[BalanceAmount] <= 0
           --    AND [tblMonthLedger].[IsPaid] = 0,
           --    0,
           --    [tblMonthLedger].[LedgAmount] - [tblMonthLedger].[BalanceAmount]) AS [AmountPaid],
           IIF(
               ISNULL([tblMonthLedger].[IsPaid], 0) = 1
               OR
               (
                   ISNULL([tblMonthLedger].[IsHold], 0) = 1
                   AND [tblMonthLedger].[BalanceAmount] > 0
               ),
               ([tblMonthLedger].[ActualAmount]
                - (ISNULL([tblMonthLedger].[BalanceAmount], 0) + ISNULL([tblMonthLedger].[PenaltyAmount], 0))
               ),
               0) AS [AmountPaid],
           CAST(ABS(ISNULL([tblMonthLedger].[BalanceAmount], 0)) AS DECIMAL(18, 2)) AS [BalanceAmount]

    --'0.00' [PenaltyAmount]
    FROM [dbo].[tblMonthLedger]
    WHERE [tblMonthLedger].[ReferenceID] = @ReferenceID
          AND [tblMonthLedger].[ClientID] = @ClientID
    ORDER BY [seq] ASC;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetLedgerListOnQue]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetLedgerListOnQue]
    --@ReferenceID BIGINT = NULL,
    --@ClientID VARCHAR(50) = NULL
    @XML XML = NULL
AS
BEGIN

    SET NOCOUNT ON;

    CREATE TABLE [#tblBulkPostdatedMonth]
    (
        [Recid] VARCHAR(10)
    )
    IF (@XML IS NOT NULL)
    BEGIN
        INSERT INTO [#tblBulkPostdatedMonth]
        (
            [Recid]
        )
        SELECT [ParaValues].[data].[value]('c1[1]', 'VARCHAR(10)')
        FROM @XML.[nodes]('/Table1') AS [ParaValues]([data])
    END


    SELECT ROW_NUMBER() OVER (ORDER BY [tblMonthLedger].[LedgMonth] ASC) [seq],
           [tblMonthLedger].[Recid],
           [tblMonthLedger].[ReferenceID],
           [tblMonthLedger].[ClientID],
           [tblMonthLedger].[LedgRentalAmount] AS [LedgAmount],
           ISNULL([tblMonthLedger].[PenaltyAmount], 0) AS [PenaltyAmount],
           ISNULL([tblMonthLedger].[TransactionID], '') AS [TransactionID],
           CONVERT(VARCHAR(20), [tblMonthLedger].[LedgMonth], 107) AS [LedgMonth],
           '' AS [Remarks],
           CASE
               WHEN ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                    AND ISNULL([tblMonthLedger].[IsHold], 0) = 0 THEN
                   'PAID'
               WHEN ISNULL([tblMonthLedger].[IsPaid], 0) = 0
                    AND ISNULL([tblMonthLedger].[IsHold], 0) = 1 THEN
                   'HOLD'
               WHEN CONVERT(VARCHAR(20), [tblMonthLedger].[LedgMonth], 107) = CONVERT(VARCHAR(20), GETDATE(), 107) THEN
                   'FOR PAYMENT'
               ELSE
                   'PENDING'
           END AS [PaymentStatus],
           IIF(
               ISNULL([tblMonthLedger].[IsPaid], 0) = 1
               OR
               (
                   ISNULL([tblMonthLedger].[IsHold], 0) = 1
                   AND [tblMonthLedger].[BalanceAmount] > 0
               ),
               ([tblMonthLedger].[LedgRentalAmount] - ISNULL([tblMonthLedger].[BalanceAmount], 0)),
               0) AS [AmountPaid],
           CAST(ABS(ISNULL([tblMonthLedger].[BalanceAmount], 0)) AS DECIMAL(18, 2)) AS [BalanceAmount],
           --ISNULL([tblMonthLedger].[PaymentMode], '') AS [PaymentMode],
           --ISNULL([tblMonthLedger].[RcptID], '') AS [RcptID],
           ISNULL([tblMonthLedger].[CompanyORNo], '') AS [CompanyORNo],
           ISNULL([tblMonthLedger].[CompanyPRNo], '') AS [CompanyPRNo],
           ISNULL([tblMonthLedger].[REF], '') AS [REF],
           ISNULL([tblMonthLedger].[BNK_ACCT_NAME], '') AS [BNK_ACCT_NAME],
           ISNULL([tblMonthLedger].[BNK_ACCT_NUMBER], '') AS [BNK_ACCT_NUMBER],
           ISNULL([tblMonthLedger].[BNK_NAME], '') AS [BNK_NAME],
           ISNULL([tblMonthLedger].[SERIAL_NO], '') AS [SERIAL_NO],
           ISNULL([tblMonthLedger].[ModeType], '') AS [ModeType],
           ISNULL([tblMonthLedger].[BankBranch], '') AS [BankBranch]
    FROM [dbo].[tblMonthLedger]
    WHERE [tblMonthLedger].[Recid] IN
          (
              SELECT [#tblBulkPostdatedMonth].[Recid] FROM [#tblBulkPostdatedMonth]
          )
    ORDER BY [seq] ASC


    DROP TABLE [#tblBulkPostdatedMonth]
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetLedgerListOnQueTotalAMount]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetLedgerListOnQueTotalAMount] @XML XML = NULL
AS
BEGIN

    SET NOCOUNT ON;
    CREATE TABLE [#tblBulkAmount]
    (
        [LedgAmount] DECIMAL(18, 2)
    )
    CREATE TABLE [#tblBulkPostdatedMonth]
    (
        [Recid] VARCHAR(10)
    )
    IF (@XML IS NOT NULL)
    BEGIN
        INSERT INTO [#tblBulkPostdatedMonth]
        (
            [Recid]
        )
        SELECT [ParaValues].[data].[value]('c1[1]', 'VARCHAR(10)')
        FROM @XML.[nodes]('/Table1') AS [ParaValues]([data])
    END

    INSERT INTO [#tblBulkAmount]
    (
        [LedgAmount]
    )
    SELECT CASE
               WHEN ISNULL([tblMonthLedger].[BalanceAmount], 0) > 0 THEN
                   ISNULL([tblMonthLedger].[BalanceAmount], 0)
               ELSE
        (ISNULL([tblMonthLedger].[LedgRentalAmount],0) + ISNULL([tblMonthLedger].[PenaltyAmount], 0))
           END AS [LedgAmount]
    FROM [dbo].[tblMonthLedger]
    WHERE [tblMonthLedger].[Recid] IN
          (
              SELECT [#tblBulkPostdatedMonth].[Recid] FROM [#tblBulkPostdatedMonth]
          )


    SELECT SUM([#tblBulkAmount].[LedgAmount]) AS [TOTAL_AMOUNT]
    FROM [#tblBulkAmount] 

    DROP TABLE [#tblBulkPostdatedMonth]
    DROP TABLE [#tblBulkAmount]
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetLocationById]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetLocationById] @RecId INT
AS
    BEGIN

        SET NOCOUNT ON;

        SELECT
            [tblLocationMstr].[RecId],
            [tblLocationMstr].[Descriptions],
            [tblLocationMstr].[LocAddress],
            ISNULL([tblLocationMstr].[IsActive], 0) AS [IsActive]
        FROM
            [dbo].[tblLocationMstr]
        WHERE
            [tblLocationMstr].[RecId] = @RecId
            AND ISNULL([IsActive], 0) = 1;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetLocationList]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetLocationList]
AS
    BEGIN

        SET NOCOUNT ON;

        SELECT
            [tblLocationMstr].[RecId],
            [tblLocationMstr].[Descriptions],
            [tblLocationMstr].[LocAddress],
            IIF(ISNULL([tblLocationMstr].[IsActive], 0) = 1, 'ACTIVE', 'IN-ACTIVE') AS [IsActive]
        FROM
            [dbo].[tblLocationMstr]
        WHERE
            ISNULL([IsActive], 0) = 1;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetMenuList]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetMenuList]
AS
    BEGIN

        SET NOCOUNT ON;

        SELECT
            [tblMenu].[MenuId],
            [tblMenu].[MenuHeaderId],
            [tblMenu].[MenuName],
            [tblMenu].[MenuNameDescription],
            [tblMenu].[IsDelete]
        FROM
            [dbo].[tblMenu]
        WHERE
            ISNULL([tblMenu].[MenuHeaderId], 0) = 0;

    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetMenuListByFormId]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC [sp_GetMenuListByFormId] 1
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetMenuListByFormId] @FormId INT = NULL
AS
    BEGIN

        SET NOCOUNT ON;

        SELECT  DISTINCT
                [tblFormControlsMaster].[MenuId],
                [tblMenu].[MenuName]
        FROM
                [dbo].[tblFormControlsMaster]
            INNER JOIN
                [dbo].[tblMenu]
                    ON [tblFormControlsMaster].[MenuId] = [tblMenu].[MenuId]
        WHERE
                [tblFormControlsMaster].[FormId] = @FormId;

    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetMonthLedgerByRefIdAndClientId]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC [sp_GetMonthLedgerByRefIdAndClientId] @ReferenceID =10000000, @ClientID = 'INDV10000000'
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetMonthLedgerByRefIdAndClientId]
    @ReferenceID INT,
    @ClientID VARCHAR(50) = NULL
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
    DECLARE @RefId AS VARCHAR(30) = '';
    DECLARE @IsFullPayment BIT = 0;
    SELECT @RefId = [tblUnitReference].[RefId],
           @IsFullPayment = [tblUnitReference].[IsFullPayment]
    FROM [dbo].[tblUnitReference] WITH (NOLOCK)
    WHERE [tblUnitReference].[RecId] = @ReferenceID;
    -- Insert statements for procedure here

    CREATE TABLE [#TempLedger]
    (
        [seq] INT,
        [LedgAmount] DECIMAL(18, 2),
        [LedgMonth] VARCHAR(20),
        [Remarks] VARCHAR(500)
    )

    IF @IsFullPayment = 1
    BEGIN
        INSERT INTO [#TempLedger]
        (
            [seq],
            [LedgAmount],
            [LedgMonth],
            [Remarks]
        )
        SELECT 0 AS [seq],
               (
                   SELECT [tblUnitReference].[SecDeposit]
                   FROM [dbo].[tblUnitReference] WITH (NOLOCK)
                   WHERE [tblUnitReference].[RecId] = @ReferenceID
               ) AS [LedgAmount],
               CONVERT(VARCHAR(20), GETDATE(), 107) AS [LedgMonth],
               'FOR SECURITY DEPOSIT' AS [Remarks]
        FROM [dbo].[tblUnitReference] WITH (NOLOCK)
        WHERE [tblUnitReference].[RecId] = @ReferenceID
              AND ISNULL([tblUnitReference].[SecDeposit], 0) > 0
        UNION
        SELECT 0 [seq],
               [tblMonthLedger].[LedgRentalAmount],
               CONVERT(VARCHAR(20), [tblMonthLedger].[LedgMonth], 107) AS [LedgMonth],
               'FOR FULL PAYMENT' AS [Remarks]
        FROM [dbo].[tblMonthLedger] WITH (NOLOCK)
        WHERE [tblMonthLedger].[ReferenceID] = @ReferenceID
              AND [tblMonthLedger].[ClientID] = @ClientID
        ORDER BY [seq] ASC;
    END;
    ELSE
    BEGIN
        INSERT INTO [#TempLedger]
        (
            [seq],
            [LedgAmount],
            [LedgMonth],
            [Remarks]
        )
        SELECT 0 AS [seq],
               (
                   SELECT [tblUnitReference].[SecDeposit]
                   FROM [dbo].[tblUnitReference] WITH (NOLOCK)
                   WHERE [tblUnitReference].[RecId] = @ReferenceID
               ) AS [LedgAmount],
               CONVERT(VARCHAR(20), GETDATE(), 107) AS [LedgMonth],
               'FOR SECURITY DEPOSIT' AS [Remarks]
        FROM [dbo].[tblUnitReference] WITH (NOLOCK)
        WHERE [tblUnitReference].[RecId] = @ReferenceID
              AND ISNULL([tblUnitReference].[SecDeposit], 0) > 0
        UNION
        SELECT 0 [seq],
               [tblMonthLedger].[LedgRentalAmount],
               CONVERT(VARCHAR(20), [tblMonthLedger].[LedgMonth], 107) AS [LedgMonth],
               IIF(
                   [tblMonthLedger].[LedgMonth] IN
                   (
                       SELECT [tblAdvancePayment].[Months]
                       FROM [dbo].[tblAdvancePayment] WITH (NOLOCK)
                       WHERE [tblAdvancePayment].[RefId] = @RefId
                   ),
                   'FOR ADVANCE PAYMENT',
                   'FOR POST DATED CHECK') AS [Remarks]
        FROM [dbo].[tblMonthLedger] WITH (NOLOCK)
        WHERE [tblMonthLedger].[ReferenceID] = @ReferenceID
              AND [tblMonthLedger].[ClientID] = @ClientID
        ORDER BY [seq] ASC;
    END;



    SELECT ROW_NUMBER() OVER (ORDER BY CAST([#TempLedger].[LedgMonth] AS DATE) ASC) [seq],
           SUM([#TempLedger].[LedgAmount]) AS [LedgAmount],
           [#TempLedger].[LedgMonth],
           [#TempLedger].[Remarks]
    FROM [#TempLedger]
    GROUP BY [#TempLedger].[LedgMonth],
             [#TempLedger].[Remarks]
    ORDER BY [seq] ASC

    DROP TABLE [#TempLedger]
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetNotificationList]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_GetNotificationList]

-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN

    SELECT [tblClientMstr].[ClientName] AS [Client],
           [tblUnitReference].[ClientID] AS [ClientID],
           [tblUnitReference].[RefId] AS [ContractID],
           CONVERT(VARCHAR(15), [tblMonthLedger].[LedgMonth], 107) AS [ForMonth],
           CAST([tblMonthLedger].[LedgAmount] AS DECIMAL(18, 2)) AS [Amount],
           'HOLD' AS [Status]
    FROM [dbo].[tblUnitReference] WITH (NOLOCK)
        LEFT JOIN [dbo].[tblMonthLedger] WITH (NOLOCK)
            ON [tblUnitReference].[RecId] = [tblMonthLedger].[ReferenceID]
        INNER JOIN [dbo].[tblClientMstr] WITH (NOLOCK)
            ON [tblUnitReference].[ClientID] = [tblClientMstr].[ClientID]
    WHERE ISNULL([tblMonthLedger].[IsHold], 0) = 1
          AND CONVERT(VARCHAR(10), [tblMonthLedger].[LedgMonth], 103) > CONVERT(VARCHAR(10), GETDATE(), 103)
    UNION
    SELECT [tblClientMstr].[ClientName] AS [Client],
           [tblUnitReference].[ClientID] AS [ClientID],
           [tblUnitReference].[RefId] AS [ContractID],
           CONVERT(VARCHAR(15), [tblMonthLedger].[LedgMonth], 107) AS [ForMonth],
           CAST([tblMonthLedger].[LedgAmount] AS DECIMAL(18, 2)) AS [Amount],
           'DUE' AS [Status]
    FROM [dbo].[tblUnitReference] WITH (NOLOCK)
        LEFT JOIN [dbo].[tblMonthLedger] WITH (NOLOCK)
            ON [tblUnitReference].[RecId] = [tblMonthLedger].[ReferenceID]
        INNER JOIN [dbo].[tblClientMstr] WITH (NOLOCK)
            ON [tblUnitReference].[ClientID] = [tblClientMstr].[ClientID]
    WHERE (
              ISNULL([tblMonthLedger].[IsHold], 0) = 1
              AND ISNULL([tblMonthLedger].[IsPaid], 0) = 0
              AND CONVERT(VARCHAR(10), GETDATE(), 103) = CONVERT(VARCHAR(10), [tblMonthLedger].[LedgMonth], 103)
          )
          OR
          (
              ISNULL([tblMonthLedger].[IsHold], 0) = 0
              AND ISNULL([tblMonthLedger].[IsPaid], 0) = 0
              AND CONVERT(VARCHAR(10), GETDATE(), 103) = CONVERT(VARCHAR(10), [tblMonthLedger].[LedgMonth], 103)
          )
    --UNION
    --SELECT [tblClientMstr].[ClientName] AS [Client],
    --       [tblUnitReference].[ClientID] AS [ClientID],
    --       [tblUnitReference].[RefId] AS [ContractID],
    --       CONVERT(VARCHAR(15), [tblMonthLedger].[LedgMonth], 107) AS [ForMonth],
    --       CAST([tblMonthLedger].[LedgAmount] AS DECIMAL(18, 2)) AS [Amount],
    --       'FOR FOLLOW-UP' AS [Status]
    --FROM [dbo].[tblUnitReference] WITH (NOLOCK)
    --    LEFT JOIN [dbo].[tblMonthLedger] WITH (NOLOCK)
    --        ON [tblUnitReference].[RecId] = [tblMonthLedger].[ReferenceID]
    --    INNER JOIN [dbo].[tblClientMstr] WITH (NOLOCK)
    --        ON [tblUnitReference].[ClientID] = [tblClientMstr].[ClientID]
    --WHERE ISNULL([tblMonthLedger].[IsHold], 0) = 0
    --      AND ISNULL([tblMonthLedger].[IsPaid], 0) = 0
    --      AND DATEDIFF(DAY, CONVERT(DATE, GETDATE(), 103), CONVERT(DATE, [tblMonthLedger].[LedgMonth], 103)) < 7
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetParkingAvailableByProjectId]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC [sp_GetUnitAvailableByProjectId] @ProjectId = 1
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetParkingAvailableByProjectId] @ProjectId INT
AS
    BEGIN

        SET NOCOUNT ON;

        SELECT
            [tblUnitMstr].[RecId],
            ISNULL([tblUnitMstr].[UnitNo], '') AS [UnitNo]
        FROM
            [dbo].[tblUnitMstr] WITH (NOLOCK)
        WHERE
            [tblUnitMstr].[ProjectId] = @ProjectId
            AND ISNULL([tblUnitMstr].[IsActive], 0) = 1
            AND [tblUnitMstr].[UnitStatus] = 'VACANT'
            AND ISNULL([tblUnitMstr].[IsParking], 0) = 1
        ORDER BY
            [tblUnitMstr].[UnitSequence] DESC;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetParkingComputationList]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- UNION THE SELECT OF PARKING LIST LATER ON
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetParkingComputationList]
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        SELECT
                [tblUnitReference].[RecId],
                [tblUnitReference].[RefId],
                [tblUnitReference].[ProjectId],
                ISNULL([tblProjectMstr].[ProjectName], '')                                       AS [ProjectName],
                ISNULL([tblProjectMstr].[ProjectAddress], '')                                    AS [ProjectAddress],
                ISNULL([tblProjectMstr].[ProjectType], '')                                       AS [ProjectType],
                ISNULL([tblUnitReference].[InquiringClient], '')                                 AS [InquiringClient],
                ISNULL([tblUnitReference].[ClientMobile], '')                                    AS [ClientMobile],
                [tblUnitReference].[UnitId],
                ISNULL([tblUnitReference].[UnitNo], '')                                          AS [UnitNo],
                ISNULL([tblUnitMstr].[FloorType], '')                                            AS [FloorType],
                ISNULL(CONVERT(VARCHAR(20), [tblUnitReference].[StatDate], 107), '')             AS [StatDate],
                ISNULL(CONVERT(VARCHAR(20), [tblUnitReference].[FinishDate], 107), '')           AS [FinishDate],
                ISNULL(CONVERT(VARCHAR(20), [tblUnitReference].[TransactionDate], 107), '')      AS [TransactionDate],
                CAST(ISNULL([tblUnitReference].[Rental], 0) AS DECIMAL(10, 2))                   AS [Rental],
                CAST(ISNULL([tblUnitReference].[SecAndMaintenance], 0) AS DECIMAL(10, 2))        AS [SecAndMaintenance],
                CAST(ISNULL([tblUnitReference].[TotalRent], 0) AS DECIMAL(10, 2))                AS [TotalRent],
                CAST(ISNULL([tblUnitReference].[SecDeposit], 0) AS DECIMAL(10, 2))               AS [SecDeposit],
                CAST(ISNULL([tblUnitReference].[Total], 0) AS DECIMAL(10, 2))                    AS [Total],
                [tblUnitReference].[EncodedBy],
                [tblUnitReference].[EncodedDate],
                [tblUnitReference].[IsActive],
                [tblUnitReference].[ComputerName],
                IIF(ISNULL([tblUnitMstr].[IsParking], 0) = 1, 'TYPE OF PARKING', 'TYPE OF UNIT') AS [TypeOf]
        FROM
                [dbo].[tblUnitReference]
            INNER JOIN
                [dbo].[tblProjectMstr]
                    ON [tblUnitReference].[ProjectId] = [tblProjectMstr].[RecId]
            INNER JOIN
                [dbo].[tblUnitMstr]
                    ON [tblUnitMstr].[RecId] = [tblUnitReference].[UnitId]
        WHERE
                ISNULL([tblUnitReference].[IsPaid], 0) = 0
                AND ISNULL([tblUnitMstr].[IsParking], 0) = 1;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetPaymentListByReferenceId]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetPaymentListByReferenceId] @RefId VARCHAR(50) = NULL
AS
BEGIN

    SET NOCOUNT ON;


    SELECT [tblPayment].[RecId],
           [tblPayment].[PayID],
           [tblPayment].[TranId],
           [tblPayment].[Amount],
           ISNULL(CONVERT(VARCHAR(20), [tblPayment].[ForMonth], 107), '') AS [ForMonth],
           COALESCE([tblPayment].[Notes], [tblPayment].[Remarks]) AS [Remarks],
           [tblPayment].[EncodedBy],
           ISNULL(CONVERT(VARCHAR(20), [tblPayment].[EncodedDate], 107), '') AS [DatePayed],
           [tblPayment].[LastChangedBy],
           [tblPayment].[LastChangedDate],
           [tblPayment].[ComputerName],
           [tblPayment].[IsActive],
           [tblPayment].[RefId]
    FROM [dbo].[tblPayment]
    WHERE [tblPayment].[RefId] = @RefId
    ORDER BY [EncodedDate] ASC
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetPenaltyResult]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_GetPenaltyResult] @LedgerId AS INT = NULL
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN



    DECLARE @DateHold AS DATE = NULL;
    DECLARE @DayCount AS INT = 0;
    DECLARE @RefRecID AS INT = 0;

    SELECT @DateHold = [tblMonthLedger].[LedgMonth],
           @RefRecID = [tblMonthLedger].[ReferenceID]
    FROM [dbo].[tblMonthLedger]
    WHERE [tblMonthLedger].[Recid] = @LedgerId;
    SELECT @DayCount = DATEDIFF(DAY, @DateHold, CAST(GETDATE() AS DATE));

    IF @DayCount < 30
    BEGIN

        SELECT
            (
                SELECT [tblUnitReference].[TotalRent]
                FROM [dbo].[tblUnitReference]
                WHERE [tblUnitReference].[RecId] = @RefRecID
            ) AS [AmountToPay],
            0.00 AS [PenaltyAmount],
            @DayCount AS [DayCount],
            '(No Penalty)' AS [PenaltyStatus];
    END;
    ELSE IF @DayCount = 30
    BEGIN
        --return total rental plus 3 percent penalty
        SELECT
            (
                SELECT CAST([tblUnitReference].[TotalRent]
                            + (([tblUnitReference].[TotalRent] * [tblUnitReference].[PenaltyPct]) / 100) AS DECIMAL(18, 2))
                FROM [dbo].[tblUnitReference]
                WHERE [tblUnitReference].[RecId] = @RefRecID
            ) AS [AmountToPay],
            (
                SELECT CAST((([tblUnitReference].[TotalRent] * [tblUnitReference].[PenaltyPct]) / 100) AS DECIMAL(18, 2))
                FROM [dbo].[tblUnitReference]
                WHERE [tblUnitReference].[RecId] = @RefRecID
            ) AS [PenaltyAmount],
            @DayCount AS [DayCount],
            'With Penalty:(' + CAST(@DayCount AS VARCHAR(5)) + ') days' AS [PenaltyStatus];
    END;
    ELSE IF @DayCount >= 31 AND @DayCount <= 31
    BEGIN
        --return total rental plus 3 percent x2 penalty
        SELECT
            (
                SELECT CAST([tblUnitReference].[TotalRent]
                            + ((([tblUnitReference].[TotalRent] * [tblUnitReference].[PenaltyPct]) / 100) * 2) AS DECIMAL(18, 2))
                FROM [dbo].[tblUnitReference]
                WHERE [tblUnitReference].[RecId] = @RefRecID
            ) AS [AmountToPay],
            (
                SELECT CAST(((([tblUnitReference].[TotalRent] * [tblUnitReference].[PenaltyPct]) / 100) * 2) AS DECIMAL(18, 2))
                FROM [dbo].[tblUnitReference]
                WHERE [tblUnitReference].[RecId] = @RefRecID
            ) AS [PenaltyAmount],
            @DayCount AS [DayCount],
            'With Penalty x2:(' + CAST(@DayCount AS VARCHAR(5)) + ') days' AS [PenaltyStatus];
    END
    ELSE IF @DayCount = 60
    BEGIN
        --return total rental plus 3 percent x2 penalty
        SELECT
            (
                SELECT CAST([tblUnitReference].[TotalRent]
                            + ((([tblUnitReference].[TotalRent] * [tblUnitReference].[PenaltyPct]) / 100) * 3) AS DECIMAL(18, 2))
                FROM [dbo].[tblUnitReference]
                WHERE [tblUnitReference].[RecId] = @RefRecID
            ) AS [AmountToPay],
            (
                SELECT CAST(((([tblUnitReference].[TotalRent] * [tblUnitReference].[PenaltyPct]) / 100) * 3) AS DECIMAL(18, 2))
                FROM [dbo].[tblUnitReference]
                WHERE [tblUnitReference].[RecId] = @RefRecID
            ) AS [PenaltyAmount],
            @DayCount AS [DayCount],
            'With Penalty x3:(' + CAST(@DayCount AS VARCHAR(5)) + ') days' AS [PenaltyStatus];
    END
    ELSE IF @DayCount >= 61 
    BEGIN
        --return total rental plus 3 percent x2 penalty
        SELECT
            (
                SELECT CAST([tblUnitReference].[TotalRent]
                            + ((([tblUnitReference].[TotalRent] * [tblUnitReference].[PenaltyPct]) / 100) * 4) AS DECIMAL(18, 2))
                FROM [dbo].[tblUnitReference]
                WHERE [tblUnitReference].[RecId] = @RefRecID
            ) AS [AmountToPay],
            (
                SELECT CAST(((([tblUnitReference].[TotalRent] * [tblUnitReference].[PenaltyPct]) / 100) * 4) AS DECIMAL(18, 2))
                FROM [dbo].[tblUnitReference]
                WHERE [tblUnitReference].[RecId] = @RefRecID
            ) AS [PenaltyAmount],
            @DayCount AS [DayCount],
            'With Penalty x4:(' + CAST(@DayCount AS VARCHAR(5)) + ') days' AS [PenaltyStatus];
    END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetPostDatedCountMonth]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetPostDatedCountMonth]
    -- Add the parameters for the stored procedure here
    @FromDate VARCHAR(10) = NULL,
    @EndDate VARCHAR(10) = NULL,
    @Rental VARCHAR(10) = NULL,
    @SecMainRental VARCHAR(10) = NULL,
    @XML XML
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
        SELECT [ParaValues].[data].[value]('c1[1]', 'VARCHAR(10)')
        FROM @XML.[nodes]('/Table1') AS [ParaValues]([data]);
    END;

    -- Insert statements for procedure here

    DECLARE @MonthsCount INT = DATEDIFF(MONTH, CONVERT(DATE, @FromDate, 101), CONVERT(DATE, @EndDate, 101));

    CREATE TABLE [#GeneratedMonths]
    (
        [Month] DATE
    );
    WITH [MonthsCTE]
    AS (SELECT CONVERT(DATE, @FromDate) AS [Month]
        UNION ALL
        SELECT DATEADD(MONTH, 1, [MonthsCTE].[Month])
        FROM [MonthsCTE]
        WHERE DATEADD(MONTH, 1, [MonthsCTE].[Month]) <= DATEADD(MONTH, @MonthsCount - 1, CONVERT(DATE, @FromDate)))
    INSERT INTO [#GeneratedMonths]
    (
        [Month]
    )
    SELECT [MonthsCTE].[Month]
    FROM [MonthsCTE];



    DELETE FROM [#GeneratedMonths]
    WHERE [#GeneratedMonths].[Month] IN
          (
              SELECT [#tblAdvancePayment].[Months] FROM [#tblAdvancePayment]
          );
    SELECT ROW_NUMBER() OVER (ORDER BY [#GeneratedMonths].[Month] ASC) [seq],
           CONVERT(VARCHAR(20), [#GeneratedMonths].[Month], 107) AS [Dates],
           @Rental AS [Rental],
           @SecMainRental AS [SecMainRental],
           CAST(@Rental AS DECIMAL(18, 2)) + CAST(@SecMainRental AS DECIMAL(18, 2)) AS [TotalRental]
    FROM [#GeneratedMonths];



    DROP TABLE [#GeneratedMonths];
    DROP TABLE [#tblAdvancePayment];
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetPostDatedCountMonthParking]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetPostDatedCountMonthParking]
    @FromDate VARCHAR(10) = NULL,
    @EndDate VARCHAR(10) = NULL,
    @Rental VARCHAR(10) = NULL,
    @SecMainRental VARCHAR(10) = NULL
AS
BEGIN

    SET NOCOUNT ON;



    DECLARE @MonthsCount INT = DATEDIFF(MONTH, CONVERT(DATE, @FromDate, 101), CONVERT(DATE, @EndDate, 101));

    CREATE TABLE [#GeneratedMonths]
    (
        [Month] DATE
    );
    WITH [MonthsCTE]
    AS (SELECT CONVERT(DATE, @FromDate) AS [Month]
        UNION ALL
        SELECT DATEADD(MONTH, 1, [MonthsCTE].[Month])
        FROM [MonthsCTE]
        WHERE DATEADD(MONTH, 1, [MonthsCTE].[Month]) <= DATEADD(MONTH, @MonthsCount - 1, CONVERT(DATE, @FromDate)))
    INSERT INTO [#GeneratedMonths]
    (
        [Month]
    )
    SELECT [MonthsCTE].[Month]
    FROM [MonthsCTE];


    SELECT ROW_NUMBER() OVER (ORDER BY [#GeneratedMonths].[Month] ASC) [seq],
           CONVERT(VARCHAR(20), [#GeneratedMonths].[Month], 107) AS [Dates],
           @Rental AS [Rental],
           @SecMainRental AS [SecMainRental],
           CAST(@Rental AS DECIMAL(18, 2)) + CAST(@SecMainRental AS DECIMAL(18, 2)) AS [TotalRental]
    FROM [#GeneratedMonths];

    DROP TABLE [#GeneratedMonths];
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetPostDatedMonthList]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetPostDatedMonthList]
    -- Add the parameters for the stored procedure here
    @FromDate VARCHAR(10) = NULL,
    @EndDate VARCHAR(10) = NULL,
    --@Rental   VARCHAR(10) = NULL,
    @XML XML
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
        SELECT [ParaValues].[data].[value]('c1[1]', 'VARCHAR(10)')
        FROM @XML.[nodes]('/Table1') AS [ParaValues]([data]);
    END;

    -- Insert statements for procedure here

    DECLARE @MonthsCount INT = DATEDIFF(MONTH, CONVERT(DATE, @FromDate, 101), CONVERT(DATE, @EndDate, 101));

    CREATE TABLE [#GeneratedMonths]
    (
        [Month] DATE
    );
    WITH [MonthsCTE]
    AS (SELECT CONVERT(DATE, @FromDate) AS [Month]
        UNION ALL
        SELECT DATEADD(MONTH, 1, [MonthsCTE].[Month])
        FROM [MonthsCTE]
        WHERE DATEADD(MONTH, 1, [MonthsCTE].[Month]) <= DATEADD(MONTH, @MonthsCount - 1, CONVERT(DATE, @FromDate)))
    INSERT INTO [#GeneratedMonths]
    (
        [Month]
    )
    SELECT [MonthsCTE].[Month]
    FROM [MonthsCTE];



    DELETE FROM [#GeneratedMonths]
    WHERE [#GeneratedMonths].[Month] IN
          (
              SELECT [#tblAdvancePayment].[Months] FROM [#tblAdvancePayment]
          );
    SELECT ROW_NUMBER() OVER (ORDER BY [#GeneratedMonths].[Month] ASC) [seq],
           CONVERT(VARCHAR(20), [#GeneratedMonths].[Month], 107) AS [Dates]
    FROM [#GeneratedMonths];



    DROP TABLE [#GeneratedMonths];
    DROP TABLE [#tblAdvancePayment];
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetProjectById]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetProjectById] @RecId INT
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        SELECT
                [tblProjectMstr].[RecId],
                [tblProjectMstr].[ProjectType],
                [tblProjectMstr].[ProjectName],
                [tblProjectMstr].[Descriptions],
                [tblProjectMstr].[ProjectAddress],
                ISNULL([tblProjectMstr].[IsActive], 0) AS [IsActive],
                [tblLocationMstr].[Descriptions]       AS [LocationName],
                [tblLocationMstr].[RecId]              AS [LocationId]
        FROM
                [dbo].[tblProjectMstr]
            INNER JOIN
                [dbo].[tblLocationMstr]
                    ON [tblLocationMstr].[RecId] = [tblProjectMstr].[LocId]
        WHERE
                [tblProjectMstr].[RecId] = @RecId;
    END;

    --SELECT
    --    [tblProjectMstr].[RecId],
    --    [tblProjectMstr].[LocId],
    --    [tblProjectMstr].[ProjectName],
    --    [tblProjectMstr].[Descriptions],
    --    [tblProjectMstr].[IsActive],
    --    [tblProjectMstr].[ProjectAddress],
    --    [tblProjectMstr].[ProjectType]
    --FROM
    --    [dbo].[tblProjectMstr];
GO
/****** Object:  StoredProcedure [dbo].[sp_GetProjectList]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetProjectList]
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        -- Insert statements for procedure here
        SELECT
                [tblProjectMstr].[RecId],
                [tblProjectMstr].[LocId],
                [tblProjectMstr].[ProjectAddress],
                [tblLocationMstr].[Descriptions]                                       AS [LocationName],
                [tblProjectMstr].[ProjectName],
                [tblProjectMstr].[Descriptions],
                IIF(ISNULL([tblProjectMstr].[IsActive], 0) = 1, 'ACTIVE', 'IN-ACTIVE') AS [IsActive]
        FROM
                [dbo].[tblProjectMstr]
            INNER JOIN
                [dbo].[tblLocationMstr]
                    ON [tblLocationMstr].[RecId] = [tblProjectMstr].[LocId]
        WHERE
                ISNULL([tblProjectMstr].[IsActive], 0) = 1;

    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetProjectStatusCount]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_GetProjectStatusCount] @ProjectId AS INT = NULL

AS
BEGIN
    SELECT
        (
            SELECT COUNT(*)
            FROM [dbo].[tblUnitMstr]
            WHERE [tblUnitMstr].[ProjectId] = @ProjectId
                  AND ISNULL([tblUnitMstr].[UnitStatus], '') = 'VACANT'
        ) AS [VACANT_COUNT],
        (
            SELECT COUNT(*)
            FROM [dbo].[tblUnitMstr]
            WHERE [tblUnitMstr].[ProjectId] =@ProjectId
                  AND ISNULL([tblUnitMstr].[UnitStatus], '') = 'MOVE-IN'
        ) AS [OCCUPIED_COUNT],
        (
            SELECT COUNT(*)
            FROM [dbo].[tblUnitMstr]
            WHERE [tblUnitMstr].[ProjectId] = @ProjectId
                  AND ISNULL([tblUnitMstr].[UnitStatus], '') = 'RESERVED'
        ) AS [RESERVED_COUNT],
        (
            SELECT COUNT(*)
            FROM [dbo].[tblUnitMstr]
            WHERE [tblUnitMstr].[ProjectId] = @ProjectId
                  AND ISNULL([tblUnitMstr].[UnitStatus], '') = 'NOT AVAILABLE'
        ) AS [NOT_AVAILABLE_COUNT],
        (
            SELECT COUNT(*)
            FROM [dbo].[tblUnitMstr]
            WHERE [tblUnitMstr].[ProjectId] = @ProjectId
                  AND ISNULL([tblUnitMstr].[UnitStatus], '') = 'HOLD'
        ) AS [HOLD_COUNT]

END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetProjectTypeById]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetProjectTypeById] @RecId INT = NULL
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        -- Insert statements for procedure here

        SELECT
            [tblProjectMstr].[ProjectType]
        FROM
            [dbo].[tblProjectMstr]
        WHERE
            [tblProjectMstr].[RecId] = @RecId
            AND ISNULL([tblProjectMstr].[IsActive], 0) = 1;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetPurchaseItemById]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC sp_GetPurchaseItemById @RecId = 1002
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetPurchaseItemById] @RecId INT
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
                ISNULL(CONVERT(VARCHAR(10), [tblProjPurchItem].[DatePurchase], 103), '')    AS [DatePurchase],
                CAST(ISNULL([tblProjPurchItem].[UnitAmount], 0) AS DECIMAL(10, 2))          AS [UnitAmount],
                CAST(ISNULL([tblProjPurchItem].[Amount], 0) AS DECIMAL(10, 2))              AS [Amount],
                ISNULL([tblProjPurchItem].[Remarks], '')                                    AS [Remarks],
                IIF(ISNULL([tblProjPurchItem].[IsActive], 0) = 1, 'ACTIVE', 'IN-ACTIVE')    AS [IsActive],
                ISNULL([tblProjPurchItem].[EncodedBy], 0)                                   AS [EncodedBy],
                ISNULL(CONVERT(VARCHAR(10), [tblProjPurchItem].[EncodedDate], 103), '')     AS [EncodedDate],
                ISNULL([tblProjPurchItem].[LastChangedBy], 0)                               AS [LastChangedBy],
                ISNULL(CONVERT(VARCHAR(10), [tblProjPurchItem].[LastChangedDate], 103), '') AS [LastChangedDate],
                ISNULL([tblProjPurchItem].[ComputerName], '')                               AS [ComputerName]
        FROM
                [dbo].[tblProjPurchItem]
            LEFT JOIN
                [dbo].[tblProjectMstr]
                    ON [tblProjectMstr].[RecId] = [tblProjPurchItem].[ProjectId]
        WHERE
                [tblProjPurchItem].[ProjectId] = @RecId;



    END;

GO
/****** Object:  StoredProcedure [dbo].[sp_GetPurchaseItemInfoById]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[sp_GetPurchaseItemList]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetPurchaseItemList]
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
                ISNULL(CONVERT(VARCHAR(10), [tblProjPurchItem].[DatePurchase], 103), '')    AS [DatePurchase],
                ISNULL([tblProjPurchItem].[UnitAmount], 0)                                  AS [UnitAmount],
                CAST(ISNULL([tblProjPurchItem].[Amount], 0) AS DECIMAL(10, 2))              AS [Amount],
                CAST(ISNULL([tblProjPurchItem].[TotalAmount], 0) AS DECIMAL(10, 2))         AS [TotalAmount],
                ISNULL([tblProjPurchItem].[Remarks], '')                                    AS [Remarks],
                IIF(ISNULL([tblProjPurchItem].[IsActive], 0) = 1, 'ACTIVE', 'IN-ACTIVE')    AS [IsActive],
                ISNULL([tblProjPurchItem].[EncodedBy], 0)                                   AS [EncodedBy],
                ISNULL(CONVERT(VARCHAR(10), [tblProjPurchItem].[EncodedDate], 103), '')     AS [EncodedDate],
                ISNULL([tblProjPurchItem].[LastChangedBy], 0)                               AS [LastChangedBy],
                ISNULL(CONVERT(VARCHAR(10), [tblProjPurchItem].[LastChangedDate], 103), '') AS [LastChangedDate],
                ISNULL([tblProjPurchItem].[ComputerName], '')                               AS [ComputerName]
        FROM
                [dbo].[tblProjPurchItem]
            INNER JOIN
                [dbo].[tblProjectMstr]
                    ON [tblProjectMstr].[RecId] = [tblProjPurchItem].[ProjectId]
        WHERE
                ISNULL([tblProjPurchItem].[IsActive], 0) = 1
        ORDER BY
                [EncodedDate] DESC;



    END;

GO
/****** Object:  StoredProcedure [dbo].[sp_GetRateSettingsByType]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetRateSettingsByType] @ProjectType VARCHAR(20) = NULL
AS
BEGIN

    SET NOCOUNT ON;
    DECLARE @BaseWithVatAmount DECIMAL(18, 2) = 0;


    SELECT @BaseWithVatAmount
        = CAST(ISNULL([tblRatesSettings].[SecurityAndMaintenance], 0)
               + (((ISNULL([tblRatesSettings].[SecurityAndMaintenance], 0) * ISNULL([tblRatesSettings].[GenVat], 0))
                   / 100
                  )
                 ) AS DECIMAL(18, 2))
    FROM [dbo].[tblRatesSettings] WITH (NOLOCK)
    WHERE [tblRatesSettings].[ProjectType] = @ProjectType;


    SELECT [tblRatesSettings].[ProjectType],
           ISNULL([tblRatesSettings].[GenVat], 0) AS [GenVat],
           CAST(ISNULL([tblRatesSettings].[SecurityAndMaintenance], 0)
                + (((ISNULL([tblRatesSettings].[SecurityAndMaintenance], 0) * ISNULL([tblRatesSettings].[GenVat], 0))
                    / 100
                   )
                  ) AS DECIMAL(18, 2)) AS [SecurityAndMaintenance],
				  --- ((@BaseWithVatAmount * ISNULL([tblRatesSettings].[WithHoldingTax], 0)) / 100)
           ISNULL([tblRatesSettings].[SecurityAndMaintenanceVat], 0) AS [SecurityAndMaintenanceVat],
           ISNULL([tblRatesSettings].[IsSecAndMaintVat], 0) AS [IsSecAndMaintVat],
           ISNULL([tblRatesSettings].[WithHoldingTax], 0) AS [WithHoldingTax],
           ISNULL([tblRatesSettings].[PenaltyPct], 0) AS [PenaltyPct],
           ISNULL([tblRatesSettings].[EncodedBy], 0) AS [EncodedBy],
           ISNULL([tblRatesSettings].[EncodedDate], '1900-01-01') AS [EncodedDate],
           ISNULL([tblRatesSettings].[ComputerName], '') AS [ComputerName],
           IIF(ISNULL([tblRatesSettings].[GenVat], 0) > 0, 'INCLUSIVE OF VAT', 'EXCLUSIVE OF VAT') AS [labelVat]
    FROM [dbo].[tblRatesSettings] WITH (NOLOCK)
    WHERE [tblRatesSettings].[ProjectType] = @ProjectType;

END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetReceiptByRefId]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_GetReceiptByRefId] @RefId AS VARCHAR(50) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    --SELECT [tblTransaction].[RefId],
    --       [tblTransaction].[TranID],
    --       [tblReceipt].[RcptID],
    --       --[tblPayment].[PayID],
    --       [tblTransaction].[ReceiveAmount] AS [PaidAmount],
    --       CONVERT(VARCHAR(10), [tblTransaction].[EncodedDate], 101) AS [PayDate],
    --       ISNULL([tblReceipt].[CompanyORNo], '') AS [CompanyORNo],
    --       [tblReceipt].[BankAccountName],
    --       [tblReceipt].[BankAccountNumber],
    --       [tblReceipt].[BankName],
    --       [tblReceipt].[SerialNo],
    --       [tblReceipt].[REF],
    --       ISNULL([tblReceipt].[CompanyPRNo], '') AS [CompanyPRNo]
    --FROM [dbo].[tblTransaction]
    --    INNER JOIN [dbo].[tblReceipt]
    --        ON [tblTransaction].[TranID] = [tblReceipt].[TranId]
    --WHERE [tblTransaction].[RefId] = @RefId
    --UNION
    SELECT [tblTransaction].[RefId],
           [tblTransaction].[TranID],
           [tblReceipt].[RcptID],
           --[tblPayment].[PayID],
           [tblTransaction].[ReceiveAmount] AS [PaidAmount],
           CONVERT(VARCHAR(10), [tblTransaction].[EncodedDate], 101) AS [PayDate],
           ISNULL([tblReceipt].[CompanyORNo], '') AS [CompanyORNo],
           [tblReceipt].[BankAccountName],
           [tblReceipt].[BankAccountNumber],
           [tblReceipt].[BankName],
           [tblReceipt].[SerialNo],
           [tblReceipt].[REF],
           ISNULL([tblReceipt].[CompanyPRNo], '') AS [CompanyPRNo],
		   [tblReceipt].[BankBranch] AS [BankBranch],
		   [tblReceipt].[Description]
    FROM [dbo].[tblTransaction]
        --    OUTER APPLY
        --(
        --    SELECT SUM([tblPayment].[Amount]) AS [Amount],
        --           [tblPayment].[TranId],
        --           [tblPayment].[EncodedDate]
        --    FROM [dbo].[tblPayment]
        --    WHERE [tblTransaction].[TranID] = [tblPayment].[TranId]
        --    GROUP BY [tblPayment].[TranId],
        --             [tblPayment].[EncodedDate]
        --) [PAYMENT]
        INNER JOIN [dbo].[tblReceipt]
            ON [tblTransaction].[TranID] = [tblReceipt].[TranId]
    WHERE [tblTransaction].[RefId] = @RefId
    ORDER BY [tblTransaction].[EncodedDate]

END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetReferenceByClientID]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC [sp_GetReferenceByClientID] 'INDV10000002'
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetReferenceByClientID]
    -- Add the parameters for the stored procedure here
    @ClientID VARCHAR(50) = NULL
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        -- Insert statements for procedure here
        SELECT
            [tblUnitReference].[RecId],
            [tblUnitReference].[RefId],
            [tblUnitReference].[ProjectId],
            [tblUnitReference].[InquiringClient],
            [tblUnitReference].[ClientMobile],
            [tblUnitReference].[UnitId],
            [tblUnitReference].[UnitNo],
            [tblUnitReference].[StatDate],
            [tblUnitReference].[FinishDate],
            [tblUnitReference].[TransactionDate],
            [tblUnitReference].[Rental],
            [tblUnitReference].[SecAndMaintenance],
            [tblUnitReference].[TotalRent],
            [tblUnitReference].[AdvancePaymentAmount],
            [tblUnitReference].[SecDeposit],
            [tblUnitReference].[Total],
            [tblUnitReference].[EncodedBy],
            [tblUnitReference].[EncodedDate],
            [tblUnitReference].[LastCHangedBy],
            [tblUnitReference].[LastChangedDate],
            [tblUnitReference].[IsActive],
            [tblUnitReference].[ComputerName],
            [tblUnitReference].[ClientID],
            [tblUnitReference].[IsPaid],
            [tblUnitReference].[IsDone],
            [tblUnitReference].[HeaderRefId],
            [tblUnitReference].[IsSignedContract],
            [tblUnitReference].[IsUnitMove],
            CASE
                --when ISNULL(IsSignedContract, 0) = 1  and ISNULL(IsUnitMove, 0) = 0 and  ISNULL(IsDone, 0) = 0 and  ISNULL(IsTerminated, 0) = 0 then
                --    'CONTRACT SIGNED'
                --when ISNULL(IsUnitMove, 0) = 1 and ISNULL(IsSignedContract, 0) = 1  and  ISNULL(IsDone, 0) = 0 and  ISNULL(IsTerminated, 0) = 0 then
                --    'MOVE-IN'
                WHEN ISNULL([tblUnitReference].[IsDone], 0) = 1
                     AND ISNULL([tblUnitReference].[IsTerminated], 0) = 0
                    THEN
                    'CONTRACT DONE'
                WHEN ISNULL([tblUnitReference].[IsTerminated], 0) = 1
                     AND ISNULL([tblUnitReference].[IsDone], 0) = 1
                    THEN
                    'CONTRACT TERMINATED'
                ELSE
                    'ON-GOING'
            END                 AS [CLientReferenceStatus],
            IIF(
                ISNULL([tblUnitReference].[AdvancePaymentAmount], 0) = 0
                AND ISNULL([tblUnitReference].[SecDeposit], 0) = 0,
                'TYPE OF PARKING',
                'TYPE OF UNIT') AS [TypeOf]
        FROM
            [dbo].[tblUnitReference]
        WHERE
            [tblUnitReference].[ClientID] = @ClientID;
    --and ISNULL(IsPaid, 0) = 1
    --and ISNULL(IsTerminated, 0) = 0
    --and ISNULL(IsDone, 0) = 0
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetReferenceByClientIDpaid]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC [sp_GetReferenceByClientID] 'INDV10000002'
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetReferenceByClientIDpaid]
    -- Add the parameters for the stored procedure here
    @ClientID VARCHAR(50) = NULL
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        -- Insert statements for procedure here
        SELECT
            [tblUnitReference].[RecId],
            [tblUnitReference].[RefId],
            [tblUnitReference].[ProjectId],
            [tblUnitReference].[InquiringClient],
            [tblUnitReference].[ClientMobile],
            [tblUnitReference].[UnitId],
            [tblUnitReference].[UnitNo],
            [tblUnitReference].[StatDate],
            [tblUnitReference].[FinishDate],
            CONVERT(VARCHAR(20), [tblUnitReference].[TransactionDate], 107) as [TransactionDate],
            [tblUnitReference].[Rental],
            [tblUnitReference].[SecAndMaintenance],
            [tblUnitReference].[TotalRent],
            [tblUnitReference].[AdvancePaymentAmount],
            [tblUnitReference].[SecDeposit],
            [tblUnitReference].[Total],
            [tblUnitReference].[EncodedBy],
            [tblUnitReference].[EncodedDate],
            [tblUnitReference].[LastCHangedBy],
            [tblUnitReference].[LastChangedDate],
            [tblUnitReference].[IsActive],
            [tblUnitReference].[ComputerName],
            [tblUnitReference].[ClientID],
            [tblUnitReference].[IsPaid],
            [tblUnitReference].[IsDone],
            [tblUnitReference].[HeaderRefId],
            [tblUnitReference].[IsSignedContract],
            [tblUnitReference].[IsUnitMove],
            [tblUnitReference].[IsUnitMoveOut],
            CASE
                WHEN ISNULL([tblUnitReference].[IsDone], 0) = 1
                     AND ISNULL([tblUnitReference].[IsTerminated], 0) = 0
                    THEN
                    'CONTRACT DONE'
                WHEN ISNULL([tblUnitReference].[IsTerminated], 0) = 1
                     AND ISNULL([tblUnitReference].[IsDone], 0) = 1
                    THEN
                    'CONTRACT TERMINATED'
                ELSE
                    'ON-GOING'
            END                                                                                                       AS [CLientReferenceStatus],
            IIF(ISNULL([tblUnitReference].[SecDeposit], 0) = 0, 'TYPE OF PARKING', 'TYPE OF UNIT') AS [TypeOf]
        FROM
            [dbo].[tblUnitReference]
        WHERE
            [tblUnitReference].[ClientID] = @ClientID
            AND ISNULL([tblUnitReference].[IsSignedContract], 0) = 1
            AND ISNULL([tblUnitReference].[IsUnitMove], 0) = 1
            AND ISNULL([tblUnitReference].[IsTerminated], 0) = 0
            AND ISNULL([tblUnitReference].[IsDone], 0) = 0
            AND ISNULL([tblUnitReference].[IsUnitMoveOut], 0) = 0
            AND ISNULL([tblUnitReference].[IsPaid], 0) = 1;

    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetRESIDENTIALSettings]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetRESIDENTIALSettings]
AS
BEGIN

    SET NOCOUNT ON;


    SELECT [tblRatesSettings].[ProjectType],
           ISNULL([tblRatesSettings].[GenVat], 0) AS [GenVat],
           ISNULL([tblRatesSettings].[SecurityAndMaintenance], 0) AS [SecurityAndMaintenance],
           ISNULL([tblRatesSettings].[WithHoldingTax], 0) AS [WithHoldingTax],
           ISNULL([tblRatesSettings].[PenaltyPct], 0) AS [PenaltyPct],
           [tblRatesSettings].[EncodedBy],
           [tblRatesSettings].[EncodedDate],
           [tblRatesSettings].[ComputerName]
    FROM [dbo].[tblRatesSettings]
    WHERE [tblRatesSettings].[ProjectType] = 'RESIDENTIAL';

END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetSelecClient]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetSelecClient]
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;
        SELECT
            -1           AS [RecId],
            '--SELECT--' AS [ClientName]
        UNION
        SELECT
            [tblClientMstr].[RecId],
            ISNULL([tblClientMstr].[ClientName], '') AS [ClientName]
        FROM
            [dbo].[tblClientMstr] WITH (NOLOCK)
        WHERE
            ISNULL([tblClientMstr].[IsMap], 0) = 0;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetSelectCompany]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_GetSelectCompany]
AS
BEGIN

    SELECT -1 AS [RecId],
           '--SELECT--' AS [CompanyName]
    UNION
    SELECT [tblCompany].[RecId],
           [tblCompany].[CompanyName]
    FROM [dbo].[tblCompany]
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetTotalCountLabel]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_GetTotalCountLabel]

-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN

    SELECT
        (
            SELECT COUNT(*)FROM [dbo].[tblLocationMstr]
       ) AS [TotalLocation],
        (
            SELECT COUNT(*)FROM [dbo].[tblProjectMstr]
        ) AS [TotalProject],
        (
            SELECT COUNT(*)FROM [dbo].[tblClientMstr]
        ) AS [TotalClient],
        (
            SELECT COUNT(*)
            FROM [dbo].[tblUnitReference]
            WHERE ISNULL([tblUnitReference].[IsDone], 0) = 0
        ) AS [TotalActiveContract];
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUnitAvailableById]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC [sp_GetUnitAvailableById] 1
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetUnitAvailableById] @UnitNo INT
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;
    --DECLARE @BaseWithVatAmount DECIMAL(18, 2) = 0;
    --DECLARE @OrignalAmount DECIMAL(18, 2) = 0;


    --SELECT @BaseWithVatAmount
    --    = CAST(ISNULL([tblUnitMstr].[BaseRental], 0)
    --           + (((ISNULL([tblUnitMstr].[BaseRental], 0) * ISNULL([tblRatesSettings].[GenVat], 0)) / 100)) AS DECIMAL(18, 2))
    --FROM [dbo].[tblUnitMstr] WITH (NOLOCK)
    --    LEFT JOIN [dbo].[tblProjectMstr] WITH (NOLOCK)
    --        ON [tblUnitMstr].[ProjectId] = [tblProjectMstr].[RecId]
    --    LEFT JOIN [dbo].[tblRatesSettings] WITH (NOLOCK)
    --        ON [tblProjectMstr].[ProjectType] = [tblRatesSettings].[ProjectType]
    --WHERE [tblUnitMstr].[RecId] = @UnitNo
    --      AND ISNULL([tblUnitMstr].[IsActive], 0) = 1
    --      AND [tblUnitMstr].[UnitStatus] = 'VACANT';

    --SELECT @OrignalAmount = ISNULL([tblUnitMstr].[BaseRental], 0)
    --FROM [dbo].[tblUnitMstr] WITH (NOLOCK)
    --    LEFT JOIN [dbo].[tblProjectMstr] WITH (NOLOCK)
    --        ON [tblUnitMstr].[ProjectId] = [tblProjectMstr].[RecId]
    --    LEFT JOIN [dbo].[tblRatesSettings] WITH (NOLOCK)
    --        ON [tblProjectMstr].[ProjectType] = [tblRatesSettings].[ProjectType]
    --WHERE [tblUnitMstr].[RecId] = @UnitNo
    --      AND ISNULL([tblUnitMstr].[IsActive], 0) = 1
    --      AND [tblUnitMstr].[UnitStatus] = 'VACANT';


    SELECT [tblProjectMstr].[ProjectName],
           [tblProjectMstr].[ProjectType],
           [tblUnitMstr].[RecId],
           IIF([tblUnitMstr].[FloorType] = '--SELECT--', '', ISNULL([tblUnitMstr].[FloorType], '')) AS [FloorType],
          -- CAST((@OrignalAmount - ((@OrignalAmount * ISNULL([tblRatesSettings].[WithHoldingTax], 0)) / 100))
          --  + ((ISNULL([tblUnitMstr].[BaseRental], 0) * ISNULL([tblRatesSettings].[GenVat], 0)) / 100)
          --AS DECIMAL(18,2) ) AS [BaseRental]
		  [tblUnitMstr].[SecAndMainWithVatAmount] AS [SecurityAndMaintenance],
		  [tblUnitMstr].[BaseRentalWithVatAmount] AS [BaseRental]

    --CAST(ISNULL([tblUnitMstr].[BaseRental], 0)
    --     + (((ISNULL([tblUnitMstr].[BaseRental], 0) * ISNULL([tblRatesSettings].[GenVat], 0)) / 100)
    --        - ((@BaseWithVatAmount * ISNULL([tblRatesSettings].[WithHoldingTax], 0)) / 100)
    --       ) AS DECIMAL(18, 2)) AS [BaseRental]
    FROM [dbo].[tblUnitMstr] WITH (NOLOCK)
        LEFT JOIN [dbo].[tblProjectMstr] WITH (NOLOCK)
            ON [tblUnitMstr].[ProjectId] = [tblProjectMstr].[RecId]
        LEFT JOIN [dbo].[tblRatesSettings] WITH (NOLOCK)
            ON [tblProjectMstr].[ProjectType] = [tblRatesSettings].[ProjectType]
    WHERE [tblUnitMstr].[RecId] = @UnitNo
          AND ISNULL([tblUnitMstr].[IsActive], 0) = 1
          AND [tblUnitMstr].[UnitStatus] = 'VACANT'
    ORDER BY [tblUnitMstr].[UnitSequence] DESC;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUnitAvailableByProjectId]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC [sp_GetUnitAvailableByProjectId] @ProjectId = 1
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetUnitAvailableByProjectId] @ProjectId INT
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        SELECT
            [tblUnitMstr].[RecId],
            ISNULL([tblUnitMstr].[UnitNo], '') AS [UnitNo]
        FROM
            [dbo].[tblUnitMstr]
        WHERE
            [tblUnitMstr].[ProjectId] = @ProjectId
            AND ISNULL([tblUnitMstr].[IsActive], 0) = 1
            AND [tblUnitMstr].[UnitStatus] = 'VACANT'
            AND ISNULL([tblUnitMstr].[IsParking], 0) = 0
        ORDER BY
            [tblUnitMstr].[UnitSequence] DESC;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUnitById]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetUnitById] @RecId INT
AS
BEGIN

    SET NOCOUNT ON;

    SELECT [tblUnitMstr].[RecId],
           [tblUnitMstr].[ProjectId],
           ISNULL([tblProjectMstr].[ProjectName], '') AS [ProjectName],
           [tblUnitMstr].[UnitDescription],
           ISNULL([tblUnitMstr].[FloorNo], 0) AS [FloorNo],
           ISNULL([tblUnitMstr].[AreaSqm], 0) AS [AreaSqm],
           ISNULL([tblUnitMstr].[AreaRateSqm], 0) AS [AreaRateSqm],
            ISNULL([tblUnitMstr].[AreaTotalAmount] , 0) AS [AreaTotalAmount],
           ISNULL([tblUnitMstr].[FloorType], '') AS [FloorType],
           ISNULL([tblUnitMstr].[BaseRental], 0) AS [BaseRental],
           [tblUnitMstr].[GenVat],
           [tblUnitMstr].[SecurityAndMaintenance],
           [tblUnitMstr].[SecurityAndMaintenanceVat],
           ISNULL([tblUnitMstr].[UnitStatus], '') AS [UnitStatus],
           ISNULL([tblUnitMstr].[DetailsofProperty], '') AS [DetailsofProperty],
           ISNULL([tblUnitMstr].[UnitNo], '') AS [UnitNo],
           ISNULL([tblUnitMstr].[UnitSequence], 0) AS [UnitSequence],
           [tblUnitMstr].[clientID],
           [tblUnitMstr].[Tennant],
           ISNULL([tblUnitMstr].[IsParking],0) AS [IsParking],
           IIF(ISNULL([tblUnitMstr].[IsParking], 0) = 1, 'PARKING', 'UNIT') AS [UnitDescription],
           [tblUnitMstr].[IsNonVat],
           [tblUnitMstr].[BaseRentalVatAmount],
           [tblUnitMstr].[BaseRentalWithVatAmount],
           [tblUnitMstr].[BaseRentalTax],
           [tblUnitMstr].[TotalRental],
           [tblUnitMstr].[SecAndMainAmount],
           [tblUnitMstr].[SecAndMainVatAmount],
           [tblUnitMstr].[SecAndMainWithVatAmount],
           COALESCE([tblUnitMstr].[Vat],'') AS [Vat],
           [tblUnitMstr].[Tax],
           [tblUnitMstr].[TaxAmount],
           [tblProjectMstr].[RecId],
           [tblProjectMstr].[LocId],
           [tblProjectMstr].[ProjectName],
           [tblProjectMstr].[Descriptions],
           IIF(ISNULL([tblUnitMstr].[IsActive], 0) = 1, 'ACTIVE', 'IN-ACTIVE') AS [IsActive],
           [tblProjectMstr].[ProjectAddress],
           [tblProjectMstr].[ProjectType],
           [tblProjectMstr].[CompanyId]
    FROM [dbo].[tblUnitMstr]
        INNER JOIN [dbo].[tblProjectMstr]
            ON [tblUnitMstr].[ProjectId] = [tblProjectMstr].[RecId]
    WHERE [tblUnitMstr].[RecId] = @RecId
    ORDER BY [tblUnitMstr].[FloorNo],
             [tblUnitMstr].[UnitSequence] DESC;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUnitByProjectId]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetUnitByProjectId] @ProjectId INT
AS
    BEGIN

        SET NOCOUNT ON;

        SELECT  DISTINCT
                [tblUnitMstr].[RecId],
                [tblUnitMstr].[ProjectId],
                ISNULL([tblProjectMstr].[ProjectName], '')                                       AS [ProjectName],
                IIF(ISNULL([tblUnitMstr].[IsParking], 0) = 1, 'TYPE OF PARKING', 'TYPE OF UNIT') AS [UnitDescription],
                ISNULL([tblUnitMstr].[FloorNo], 0)                                               AS [FloorNo],
                ISNULL([tblUnitMstr].[AreaSqm], 0)                                               AS [AreaSqm],
                ISNULL([tblUnitMstr].[AreaRateSqm], 0)                                           AS [AreaRateSqm],
                ISNULL([tblUnitMstr].[FloorType], '')                                            AS [FloorType],
                ISNULL([tblUnitMstr].[BaseRental], 0)                                            AS [BaseRental],
                CASE
                    WHEN ISNULL([tblUnitMstr].[UnitStatus], '') = 'RESERVED'
                        THEN
                        ISNULL([tblUnitMstr].[UnitStatus], '') + ' TO : '
                        + ISNULL(CAST([tblUnitReference].[ClientID] AS VARCHAR(20)), '') + ' - '
                        + [tblUnitReference].[InquiringClient]
                    WHEN ISNULL([tblUnitMstr].[UnitStatus], '') = 'MOVE-IN'
                        THEN
                        ISNULL([tblUnitMstr].[UnitStatus], '') + '  : '
                        + ISNULL(CAST([tblUnitReference].[ClientID] AS VARCHAR(20)), '') + ' - '
                        + [tblUnitReference].[InquiringClient]
                    ELSE
                        ISNULL([tblUnitMstr].[UnitStatus], '')
                END                                                                          AS [UnitStatus],
                ISNULL([tblUnitMstr].[UnitStatus], '')                                           AS [UnitStat],
                ISNULL([tblUnitMstr].[DetailsofProperty], '')                                    AS [DetailsofProperty],
                ISNULL([tblUnitMstr].[UnitNo], '')                                               AS [UnitNo],
                IIF(ISNULL([tblUnitMstr].[IsActive], 0) = 1, 'ACTIVE', 'IN-ACTIVE')              AS [IsActive]
        FROM
                [dbo].[tblUnitMstr] WITH (NOLOCK)
            INNER JOIN
                [dbo].[tblProjectMstr] WITH (NOLOCK)
                    ON [tblUnitMstr].[ProjectId] = [tblProjectMstr].[RecId]
            LEFT JOIN
                [dbo].[tblUnitReference] WITH (NOLOCK)
                    ON [tblUnitMstr].[RecId] = [tblUnitReference].[UnitId]
        WHERE
                [tblUnitMstr].[ProjectId] = @ProjectId;

    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUnitComputationList]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- UNION THE SELECT OF PARKING LIST LATER ON
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetUnitComputationList]
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    SELECT [tblUnitReference].[RecId],
           [tblUnitReference].[RefId],
           [tblUnitReference].[ProjectId],
           ISNULL([tblProjectMstr].[ProjectName], '') AS [ProjectName],
           ISNULL([tblProjectMstr].[ProjectAddress], '') AS [ProjectAddress],
           ISNULL([tblProjectMstr].[ProjectType], '') AS [ProjectType],
           ISNULL([tblUnitReference].[InquiringClient], '') AS [InquiringClient],
           ISNULL([tblUnitReference].[ClientMobile], '') AS [ClientMobile],
           [tblUnitReference].[UnitId],
           ISNULL([tblUnitReference].[UnitNo], '') AS [UnitNo],
           ISNULL([tblUnitMstr].[FloorType], '') AS [FloorType],
           ISNULL(CONVERT(VARCHAR(20), [tblUnitReference].[StatDate], 107), '') AS [StatDate],
           ISNULL(CONVERT(VARCHAR(20), [tblUnitReference].[FinishDate], 107), '') AS [FinishDate],
           ISNULL(CONVERT(VARCHAR(20), [tblUnitReference].[TransactionDate], 107), '') AS [TransactionDate],
           CAST(ISNULL([tblUnitReference].[Rental], 0) AS DECIMAL(10, 2)) AS [Rental],
           CAST(ISNULL([tblUnitReference].[SecAndMaintenance], 0) AS DECIMAL(10, 2)) AS [SecAndMaintenance],
           CAST(ISNULL([tblUnitReference].[TotalRent], 0) AS DECIMAL(10, 2)) AS [TotalRent],
           CAST(ISNULL([tblUnitReference].[AdvancePaymentAmount], 0) AS DECIMAL(10, 2)) AS [AdvancePaymentAmount],
           CAST(ISNULL([tblUnitReference].[SecDeposit], 0) AS DECIMAL(10, 2)) AS [SecDeposit],
           CAST(ISNULL([tblUnitReference].[Total], 0) AS DECIMAL(10, 2)) AS [Total],
           [tblUnitReference].[EncodedBy],
           [tblUnitReference].[EncodedDate],
           [tblUnitReference].[IsActive],
           [tblUnitReference].[ComputerName],
           IIF(ISNULL([tblUnitMstr].[IsParking], 0) = 1, 'TYPE OF PARKING', 'TYPE OF UNIT') AS [TypeOf],
           IIF(ISNULL([tblUnitReference].[IsPartialPayment], 0) = 1, 'HOLD - PARTIAL PAYMENT', 'NEW') AS [TranStatus] --this for First Payment Flag AS Partial Payment
    FROM [dbo].[tblUnitReference]
        INNER JOIN [dbo].[tblProjectMstr]
            ON [tblUnitReference].[ProjectId] = [tblProjectMstr].[RecId]
        INNER JOIN [dbo].[tblUnitMstr]
            ON [tblUnitMstr].[RecId] = [tblUnitReference].[UnitId]
    WHERE ISNULL([tblUnitReference].[IsPaid], 0) = 0
          AND ISNULL([tblUnitMstr].[IsParking], 0) = 0;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUnitList]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetUnitList]
AS
BEGIN

    SET NOCOUNT ON;

    SELECT DISTINCT
           [tblUnitMstr].[RecId],
           [tblUnitMstr].[ProjectId],
           ISNULL([tblProjectMstr].[ProjectName], '') AS [ProjectName],
           IIF(ISNULL([tblUnitMstr].[IsParking], 0) = 1, 'TYPE OF PARKING', 'TYPE OF UNIT') AS [UnitDescription],
           ISNULL([tblUnitMstr].[FloorNo], 0) AS [FloorNo],
           ISNULL([tblUnitMstr].[AreaSqm], 0) AS [AreaSqm],
           ISNULL([tblUnitMstr].[AreaRateSqm], 0) AS [AreaRateSqm],
           ISNULL([tblUnitMstr].[FloorType], '') AS [FloorType],
           ISNULL([tblUnitMstr].[TotalRental], 0) AS [TotalMonthlyRental],
           CASE
               WHEN ISNULL([tblUnitMstr].[UnitStatus], '') = 'RESERVED' THEN
                   ISNULL([tblUnitMstr].[UnitStatus], '') + ' TO : '
                   + ISNULL(CAST([tblUnitReference].[ClientID] AS VARCHAR(20)), '') + ' - '
                   + [tblUnitReference].[InquiringClient]
               WHEN ISNULL([tblUnitMstr].[UnitStatus], '') = 'MOVE-IN' THEN
                   ISNULL([tblUnitMstr].[UnitStatus], '') + '  : '
                   + ISNULL(CAST([tblUnitReference].[ClientID] AS VARCHAR(20)), '') + ' - '
                   + [tblUnitReference].[InquiringClient]
               ELSE
                   ISNULL([tblUnitMstr].[UnitStatus], '')
           END AS [UnitStatus],
           ISNULL([tblUnitMstr].[UnitStatus], '') AS [UnitStat],
           ISNULL([tblUnitMstr].[DetailsofProperty], '') AS [DetailsofProperty],
           ISNULL([tblUnitMstr].[UnitNo], '') AS [UnitNo],
           IIF(ISNULL([tblUnitMstr].[IsActive], 0) = 1, 'ACTIVE', 'IN-ACTIVE') AS [IsActive],
           [tblUnitReference].[ClientID]
    FROM [dbo].[tblUnitMstr]
        INNER JOIN [dbo].[tblProjectMstr]
            ON [tblUnitMstr].[ProjectId] = [tblProjectMstr].[RecId]
        LEFT JOIN [dbo].[tblUnitReference]
            ON [tblUnitMstr].[RecId] = [tblUnitReference].[UnitId];

END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUnitListByProjectAndStatus]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetUnitListByProjectAndStatus]
@ProjectId INT = NULL,
@UnitStatus VARCHAR(15)=NULL

AS
    BEGIN

        SET NOCOUNT ON;


		IF @UnitStatus = '' OR @UnitStatus = '--ALL--'
			BEGIN
				SELECT  DISTINCT
						[tblUnitMstr].[RecId],
						[tblUnitMstr].[ProjectId],
						ISNULL([tblProjectMstr].[ProjectName], '')                                       AS [ProjectName],
						IIF(ISNULL([tblUnitMstr].[IsParking], 0) = 1, 'TYPE OF PARKING', 'TYPE OF UNIT') AS [UnitDescription],
						ISNULL([tblUnitMstr].[FloorNo], 0)                                               AS [FloorNo],
						ISNULL([tblUnitMstr].[AreaSqm], 0)                                               AS [AreaSqm],
						ISNULL([tblUnitMstr].[AreaRateSqm], 0)                                           AS [AreaRateSqm],
						IIF([tblUnitMstr].[FloorType]='--SELECT--','', ISNULL([tblUnitMstr].[FloorType], '')) AS [FloorType],
						ISNULL([tblUnitMstr].[BaseRental], 0)                                            AS [BaseRental],
						CASE
							WHEN ISNULL([tblUnitMstr].[UnitStatus], '') = 'RESERVED'
								THEN
								ISNULL([tblUnitMstr].[UnitStatus], '') + ' TO : '
								+ ISNULL(CAST([tblUnitReference].[ClientID] AS VARCHAR(20)), '') + ' - '
								+ [tblUnitReference].[InquiringClient]
							WHEN ISNULL([tblUnitMstr].[UnitStatus], '') = 'MOVE-IN'
								THEN
								ISNULL([tblUnitMstr].[UnitStatus], '') + '  : '
								+ ISNULL(CAST([tblUnitReference].[ClientID] AS VARCHAR(20)), '') + ' - '
								+ [tblUnitReference].[InquiringClient]
							ELSE
								ISNULL([tblUnitMstr].[UnitStatus], '')
						END                                                                          AS [UnitStatus],
						ISNULL([tblUnitMstr].[UnitStatus], '')                                           AS [UnitStat],
						ISNULL([tblUnitMstr].[DetailsofProperty], '')                                    AS [DetailsofProperty],
						ISNULL([tblUnitMstr].[UnitNo], '')                                               AS [UnitNo],
						IIF(ISNULL([tblUnitMstr].[IsActive], 0) = 1, 'ACTIVE', 'IN-ACTIVE')              AS [IsActive],
						[tblUnitReference].[ClientID]
				FROM
						[dbo].[tblUnitMstr] WITH(NOLOCK)
					INNER JOIN
						[dbo].[tblProjectMstr]  WITH(NOLOCK)
							ON [tblUnitMstr].[ProjectId] = [tblProjectMstr].[RecId]
					LEFT JOIN
						[dbo].[tblUnitReference]  WITH(NOLOCK)
							ON [tblUnitMstr].[RecId] = [tblUnitReference].[UnitId]
						WHERE	[tblProjectMstr].[RecId] = @ProjectId
			END
		ELSE
			BEGIN
					SELECT  DISTINCT
							[tblUnitMstr].[RecId],
							[tblUnitMstr].[ProjectId],
							ISNULL([tblProjectMstr].[ProjectName], '')                                       AS [ProjectName],
							IIF(ISNULL([tblUnitMstr].[IsParking], 0) = 1, 'TYPE OF PARKING', 'TYPE OF UNIT') AS [UnitDescription],
							ISNULL([tblUnitMstr].[FloorNo], 0)                                               AS [FloorNo],
							ISNULL([tblUnitMstr].[AreaSqm], 0)                                               AS [AreaSqm],
							ISNULL([tblUnitMstr].[AreaRateSqm], 0)                                           AS [AreaRateSqm],
							IIF([tblUnitMstr].[FloorType]='--SELECT--','', ISNULL([tblUnitMstr].[FloorType], '')) AS [FloorType],
							ISNULL([tblUnitMstr].[BaseRental], 0)                                            AS [BaseRental],
							CASE
								WHEN ISNULL([tblUnitMstr].[UnitStatus], '') = 'RESERVED'
									THEN
									ISNULL([tblUnitMstr].[UnitStatus], '') + ' TO : '
									+ ISNULL(CAST([tblUnitReference].[ClientID] AS VARCHAR(20)), '') + ' - '
									+ [tblUnitReference].[InquiringClient]
								WHEN ISNULL([tblUnitMstr].[UnitStatus], '') = 'MOVE-IN'
									THEN
									ISNULL([tblUnitMstr].[UnitStatus], '') + '  : '
									+ ISNULL(CAST([tblUnitReference].[ClientID] AS VARCHAR(20)), '') + ' - '
									+ [tblUnitReference].[InquiringClient]
								ELSE
									ISNULL([tblUnitMstr].[UnitStatus], '')
							END                                                                          AS [UnitStatus],
							ISNULL([tblUnitMstr].[UnitStatus], '')                                           AS [UnitStat],
							ISNULL([tblUnitMstr].[DetailsofProperty], '')                                    AS [DetailsofProperty],
							ISNULL([tblUnitMstr].[UnitNo], '')                                               AS [UnitNo],
							IIF(ISNULL([tblUnitMstr].[IsActive], 0) = 1, 'ACTIVE', 'IN-ACTIVE')              AS [IsActive],
							[tblUnitReference].[ClientID]
					FROM
							[dbo].[tblUnitMstr] WITH(NOLOCK)
						INNER JOIN
							[dbo].[tblProjectMstr]  WITH(NOLOCK)
								ON [tblUnitMstr].[ProjectId] = [tblProjectMstr].[RecId]
						LEFT JOIN
							[dbo].[tblUnitReference]  WITH(NOLOCK)
								ON [tblUnitMstr].[RecId] = [tblUnitReference].[UnitId]
							WHERE	[tblProjectMstr].[RecId] = @ProjectId
							and [tblUnitMstr].[UnitStatus] = @UnitStatus
				END
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserGroupList]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_GetUserGroupList]
  

AS
BEGIN
    SET NOCOUNT ON

	SELECT [tblGroup].[GroupId],
       [tblGroup].[GroupName],
       [tblGroup].[IsDelete]
FROM [dbo].[tblGroup];

END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserInfo]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--EXEC [sp_GetUserInfo] @UserId = 100000
CREATE PROCEDURE [dbo].[sp_GetUserInfo] @UserId INT = NULL
AS
BEGIN
    SET NOCOUNT ON;

    SELECT [tblUser].[GroupId],
           [dbo].[fn_GetUserGroupName]([tblUser].[UserId]) AS [GroupName],
           [tblUser].[StaffName],
           [tblUser].[Middlename],
           [tblUser].[Lastname],
           [tblUser].[EmailAddress],
           [tblUser].[Phone],
           [tblUser].[UserPassword],
           [tblUser].[UserName],
           IIF(ISNULL([tblUser].[IsDelete], 0) = 0, 'ACTIVE', 'IN-ACTIVE') AS [UserStatus]
    FROM [dbo].[tblUser]
    WHERE [tblUser].[UserId] = @UserId;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserList]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetUserList]
AS
    BEGIN
        SET NOCOUNT ON;

        SELECT
            [tblUser].[UserId],
            [tblUser].[GroupId],
            [tblUser].[UserName],
            [tblUser].[UserPassword],
            [tblUser].[UserPasswordIncrypt],
            [tblUser].[StaffName],
            [tblUser].[Middlename],
            [tblUser].[Lastname],
            [tblUser].[EmailAddress],
            [tblUser].[Phone],
            IIF(ISNULL([tblUser].[IsDelete],0)=1,'ACTIVE','IN-ACTIVE') AS UserStatus
        FROM
            [dbo].[tblUser];
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetUserPassword]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetUserPassword] @UserId VARCHAR(20) = NULL
AS
    BEGIN
        SET NOCOUNT ON;
        SELECT
            [tblUser].[UserId],
            [tblUser].[GroupId],
            [tblUser].[UserName],
            [tblUser].[UserPassword],
            [tblUser].[UserPasswordIncrypt],
            UPPER([tblUser].[StaffName]) AS [StaffName],
            [tblUser].[Middlename],
            [tblUser].[Lastname],
            [tblUser].[EmailAddress],
            [tblUser].[Phone],
            ISNULL([tblUser].[IsDelete], 0) AS [UserStatus]
        FROM
            [dbo].[tblUser]
        WHERE
            [tblUser].[UserName] = @UserId;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_GetWAREHOUSESettings]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_GetWAREHOUSESettings]
AS
BEGIN

    SET NOCOUNT ON;


    SELECT [tblRatesSettings].[ProjectType],
           ISNULL([tblRatesSettings].[GenVat], 0) AS [GenVat],
           ISNULL([tblRatesSettings].[SecurityAndMaintenance], 0) AS [SecurityAndMaintenance],
           ISNULL([tblRatesSettings].[WithHoldingTax], 0) AS [WithHoldingTax],
           ISNULL([tblRatesSettings].[PenaltyPct], 0) AS [PenaltyPct],
           [tblRatesSettings].[EncodedBy],
           [tblRatesSettings].[EncodedDate],
           [tblRatesSettings].[ComputerName]
    FROM [dbo].[tblRatesSettings]
    WHERE [tblRatesSettings].[ProjectType] = 'WAREHOUSE';

END;
GO
/****** Object:  StoredProcedure [dbo].[sp_HoldPayment]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_HoldPayment]
    @ReferenceID VARCHAR(50) = NULL,
    @Recid       INT         = NULL
--,@EncodedBy INT = NULL
--,@ComputerName VARCHAR(20) = null
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        -- Insert statements for procedure here
        UPDATE
            [dbo].[tblMonthLedger]
        SET
            [tblMonthLedger].[IsHold] = 1
        WHERE
            [Recid] = @Recid
            AND [tblMonthLedger].[ReferenceID] =
                (
                    SELECT
                        [tblUnitReference].[RecId]
                    FROM
                        [dbo].[tblUnitReference]
                    WHERE
                        [tblUnitReference].[RefId] = @ReferenceID
                );

        IF (@@ROWCOUNT > 0)
            BEGIN
                SELECT
                    'SUCCESS' AS [Message_Code];
            END;

    --select IIF(COUNT(*)>0,'IN-PROGRESS','PAYMENT DONE') AS PAYMENT_STATUS from tblMonthLedger where ReferenceID = substring(@ReferenceID,4,11) and ISNULL(IsPaid,0)=0
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_HoldPDCPayment]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_HoldPDCPayment]
    @CompanyORNo VARCHAR(30) = NULL,
    @CompanyPRNo VARCHAR(30) = NULL,
    @BankAccountName VARCHAR(30) = NULL,
    @BankAccountNumber VARCHAR(30) = NULL,
    @BankName VARCHAR(30) = NULL,
    @SerialNo VARCHAR(30) = NULL,
    @PaymentRemarks VARCHAR(100) = NULL,
    @REF VARCHAR(100) = NULL,
    @BankBranch VARCHAR(100) = NULL,
    @ModeType VARCHAR(20) = NULL,
    @XML XML

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    CREATE TABLE [#tblBulkPostdatedMonth]
    (
        [Recid] VARCHAR(10)
    )
    IF (@XML IS NOT NULL)
    BEGIN
        INSERT INTO [#tblBulkPostdatedMonth]
        (
            [Recid]
        )
        SELECT [ParaValues].[data].[value]('c1[1]', 'VARCHAR(10)')
        FROM @XML.[nodes]('/Table1') AS [ParaValues]([data])
    END

    -- Insert statements for procedure here
    UPDATE [dbo].[tblMonthLedger]
    SET [tblMonthLedger].[IsHold] = 1,
        [tblMonthLedger].[CompanyORNo] = @CompanyORNo,
        [tblMonthLedger].[CompanyPRNo] = @CompanyPRNo,
        [tblMonthLedger].[REF] = @REF,
        [tblMonthLedger].[BNK_ACCT_NAME] = @BankAccountName,
        [tblMonthLedger].[BNK_ACCT_NUMBER] = @BankAccountNumber,
        [tblMonthLedger].[BNK_NAME] = @BankName,
        [tblMonthLedger].[SERIAL_NO] = @SerialNo,
        [tblMonthLedger].[ModeType] = @ModeType,
        [tblMonthLedger].[BankBranch] = @BankBranch
	
    WHERE [tblMonthLedger].[Recid] IN
          (
              SELECT [#tblBulkPostdatedMonth].[Recid]
              FROM [#tblBulkPostdatedMonth] WITH (NOLOCK)
          )


    IF (@@ROWCOUNT > 0)
    BEGIN
        SELECT 'SUCCESS' AS [Message_Code];
    END;

--select IIF(COUNT(*)>0,'IN-PROGRESS','PAYMENT DONE') AS PAYMENT_STATUS from tblMonthLedger where ReferenceID = substring(@ReferenceID,4,11) and ISNULL(IsPaid,0)=0
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_LogError]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_LogError]
    @ProcedureName NVARCHAR(255) = NULL,
    @frmName       NVARCHAR(255) = NULL,
    @FormName      NVARCHAR(255) = NULL,
    @ErrorMessage  NVARCHAR(MAX) = NULL,
    @LogDateTime   DATETIME      = NULL,
    @UserId        INT           = NULL
AS
    BEGIN
        INSERT INTO [dbo].[ErrorLog]
            (
                [ProcedureName],
                [frmName],
                [FormName],
                [Category],
                [ErrorMessage],
                [UserId],
                [LogDateTime]
            )
        VALUES
            (
                @ProcedureName, @frmName, @FormName, 'APP', @ErrorMessage, @UserId, @LogDateTime
            );
    END;


GO
/****** Object:  StoredProcedure [dbo].[sp_MovedIn]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MovedIn]
    -- Add the parameters for the stored procedure here
    @ReferenceID VARCHAR(20) = NULL
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        DECLARE @Message_Code NVARCHAR(MAX);

        -- Insert statements for procedure here
        UPDATE
            [dbo].[tblUnitReference]
        SET
            [tblUnitReference].[IsUnitMove] = 1,
            [tblUnitReference].[UnitMoveInDate] = GETDATE()
        WHERE
            [tblUnitReference].[RefId] = @ReferenceID;
        -- Log a success event    
        IF (@@ROWCOUNT > 0)
            BEGIN
                -- Log a success event
                INSERT INTO [dbo].[LoggingEvent]
                    (
                        [EventType],
                        [EventMessage]
                    )
                VALUES
                    (
                        'SUCCESS',
                        'Result From : sp_MovedIn -(' + @ReferenceID
                        + ': IsUnitMove= 1) tblUnitReference updated successfully'
                    );

                SET @Message_Code = N'SUCCESS';

            END;
        ELSE
            BEGIN
                -- Log an error event
                INSERT INTO [dbo].[LoggingEvent]
                    (
                        [EventType],
                        [EventMessage]
                    )
                VALUES
                    (
                        'ERROR', 'Result From : sp_MovedIn -' + 'No rows affected in tblUnitReference table'
                    );

            END;

        UPDATE
            [dbo].[tblUnitMstr]
        SET
            [tblUnitMstr].[UnitStatus] = 'MOVE-IN'
        WHERE
            [RecId] =
            (
                SELECT
                    [tblUnitReference].[UnitId]
                FROM
                    [dbo].[tblUnitReference]
                WHERE
                    [tblUnitReference].[RefId] = @ReferenceID
            );
        -- Log a success event    
        IF (@@ROWCOUNT > 0)
            BEGIN
                -- Log a success event
                INSERT INTO [dbo].[LoggingEvent]
                    (
                        [EventType],
                        [EventMessage]
                    )
                VALUES
                    (
                        'SUCCESS', 'Result From : sp_MovedIn -(UnitStatus= Move-In) tblUnitMstr updated successfully'
                    );

                SET @Message_Code = N'SUCCESS';
            END;
        ELSE
            BEGIN
                -- Log an error event
                INSERT INTO [dbo].[LoggingEvent]
                    (
                        [EventType],
                        [EventMessage]
                    )
                VALUES
                    (
                        'ERROR', 'Result From : sp_MovedIn -' + 'No rows affected in tblUnitMstr table'
                    );

            END;
        -- Log the error message
        DECLARE @ErrorMessage NVARCHAR(MAX);
        SET @ErrorMessage = ERROR_MESSAGE();

        IF @ErrorMessage <> ''
            BEGIN
                -- Log an error event
                INSERT INTO [dbo].[LoggingEvent]
                    (
                        [EventType],
                        [EventMessage]
                    )
                VALUES
                    (
                        'ERROR', 'From : sp_MovedIn -' + @ErrorMessage
                    );

                -- Insert into a logging table
                INSERT INTO [dbo].[ErrorLog]
                    (
                        [ProcedureName],
                        [ErrorMessage],
                        [LogDateTime]
                    )
                VALUES
                    (
                        'sp_MovedIn', @ErrorMessage, GETDATE()
                    );

                -- Return an error message				
                SET @Message_Code = @ErrorMessage;
            END;

        SELECT
            @Message_Code AS [Message_Code];
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_MovedOut]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_MovedOut]
    -- Add the parameters for the stored procedure here
    @ReferenceID VARCHAR(20) = NULL
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        DECLARE @Message_Code NVARCHAR(MAX);

        -- Insert statements for procedure here
        UPDATE
            [dbo].[tblUnitReference]
        SET
            [tblUnitReference].[IsUnitMoveOut] = 1,
            [tblUnitReference].[UnitMoveOutDate] = GETDATE()
        WHERE
            [tblUnitReference].[RefId] = @ReferenceID;
        -- Log a success event    
        IF (@@ROWCOUNT > 0)
            BEGIN
                -- Log a success event
                INSERT INTO [dbo].[LoggingEvent]
                    (
                        [EventType],
                        [EventMessage]
                    )
                VALUES
                    (
                        'SUCCESS',
                        'Result From : sp_MovedOut -(' + @ReferenceID
                        + ': IsUnitMoveOut= 1) tblUnitReference updated successfully'
                    );

                SET @Message_Code = N'SUCCESS';
            END;
        ELSE
            BEGIN
                -- Log an error event
                INSERT INTO [dbo].[LoggingEvent]
                    (
                        [EventType],
                        [EventMessage]
                    )
                VALUES
                    (
                        'ERROR', 'Result From : sp_MovedOut -' + 'No rows affected in tblUnitReference table'
                    );

            END;

        UPDATE
            [dbo].[tblUnitMstr]
        SET
            [tblUnitMstr].[UnitStatus] = 'HOLD'
        WHERE
            [RecId] =
            (
                SELECT
                    [tblUnitReference].[UnitId]
                FROM
                    [dbo].[tblUnitReference]
                WHERE
                    [tblUnitReference].[RefId] = @ReferenceID
            );
        -- Log a success event    
        IF (@@ROWCOUNT > 0)
            BEGIN
                -- Log a success event
                INSERT INTO [dbo].[LoggingEvent]
                    (
                        [EventType],
                        [EventMessage]
                    )
                VALUES
                    (
                        'SUCCESS', 'Result From : sp_MovedOut -(UnitStatus= HOLD) tblUnitMstr updated successfully'
                    );

                SET @Message_Code = N'SUCCESS';
            END;
        ELSE
            BEGIN
                -- Log an error event
                INSERT INTO [dbo].[LoggingEvent]
                    (
                        [EventType],
                        [EventMessage]
                    )
                VALUES
                    (
                        'ERROR', 'Result From : sp_MovedOut -' + 'No rows affected in tblUnitMstr table'
                    );

            END;
        -- Log the error message
        DECLARE @ErrorMessage NVARCHAR(MAX);
        SET @ErrorMessage = ERROR_MESSAGE();

        IF @ErrorMessage <> ''
            BEGIN
                -- Log an error event
                INSERT INTO [dbo].[LoggingEvent]
                    (
                        [EventType],
                        [EventMessage]
                    )
                VALUES
                    (
                        'ERROR', 'From : sp_MovedOut -' + @ErrorMessage
                    );

                -- Insert into a logging table
                INSERT INTO [dbo].[ErrorLog]
                    (
                        [ProcedureName],
                        [ErrorMessage],
                        [LogDateTime]
                    )
                VALUES
                    (
                        'sp_MovedOut', @ErrorMessage, GETDATE()
                    );

                -- Return an error message
                SET @Message_Code = @ErrorMessage;
            END;

        SELECT
            @Message_Code AS [Message_Code];
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_MoveInAuthorization]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_MoveInAuthorization] @RefId AS VARCHAR(50) = NULL
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    SET NOCOUNT ON;

    CREATE TABLE [#tblTemp]
    (
        [DatePrint] VARCHAR(10),
        [ProjectName] VARCHAR(100),
        [ProjectAddress] VARCHAR(1000),
        [UnitNo] VARCHAR(50),
        [TenantName] VARCHAR(50),
        [Taddress] VARCHAR(1000),
        [MoveInDate] VARCHAR(10),
        [leasingStaff] VARCHAR(50),
        [leasingManager] VARCHAR(50),
        [Remakrs] VARCHAR(500),
    );

    INSERT INTO [#tblTemp]
    (
        [DatePrint],
        [ProjectName],
        [ProjectAddress],
        [UnitNo],
        [TenantName],
        [Taddress],
        [MoveInDate],
        [leasingStaff],
        [leasingManager],
        [Remakrs]
    )
    SELECT CONVERT(VARCHAR(10), GETDATE(), 111),                                -- DatePrint - varchar(10)
           ISNULL([tblProjectMstr].[ProjectName], '') AS [ProjectName],         -- ProjectName - varchar(100)
           'occupy Unit ' + ISNULL([tblUnitMstr].[UnitNo], '') + ' located at '
           + ISNULL([tblProjectMstr].[ProjectAddress], '') AS [ProjectAddress], -- ProjectAddress - varchar(1000)
           ISNULL([tblUnitMstr].[UnitNo], '') AS [UnitNo],                      -- UnitNo - varchar(50)
           ISNULL([tblClientMstr].[ClientName], '') AS [ClientName],            -- TenantName - varchar(50)
           ISNULL([tblClientMstr].[PostalAddress], '') AS [PostalAddress],      -- Taddress - varchar(1000)
           CONVERT(VARCHAR(10), GETDATE(), 111),                                -- MoveInDate - varchar(10)
           '',                                                                  -- leasingStaff - varchar(50)
           '',                                                                  -- leasingManager - varchar(50)
           ''                                                                   -- Remakrs - varchar(500)
    FROM [dbo].[tblUnitReference]
        INNER JOIN [dbo].[tblProjectMstr]
            ON [dbo].[tblUnitReference].[ProjectId] = [dbo].[tblProjectMstr].[RecId]
        INNER JOIN [dbo].[tblUnitMstr]
            ON [dbo].[tblUnitReference].[UnitId] = [dbo].[tblUnitMstr].[RecId]
        INNER JOIN [dbo].[tblClientMstr]
            ON [tblUnitReference].[ClientID] = [tblClientMstr].[ClientID]
    WHERE [tblUnitReference].[RefId] = @RefId;

    SELECT [#tblTemp].[DatePrint],
           [#tblTemp].[ProjectName],
           [#tblTemp].[ProjectAddress],
           [#tblTemp].[UnitNo],
           [#tblTemp].[TenantName],
           [#tblTemp].[Taddress],
           [#tblTemp].[MoveInDate],
           [#tblTemp].[leasingStaff],
           [#tblTemp].[leasingManager],
           [#tblTemp].[Remakrs]
    FROM [#tblTemp];
END;

DROP TABLE IF EXISTS [#tblTemp];
GO
/****** Object:  StoredProcedure [dbo].[sp_Nature_OR_Report]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
--EXEC [sp_Nature_OR_Report] @TranID = 'TRN10000000',@Mode = 'ADV',@PaymentLevel = 'FIRST'
--EXEC [sp_Nature_OR_Report] @TranID = 'TRN10000000',@Mode = 'SEC',@PaymentLevel = 'FIRST'
--EXEC [sp_Nature_OR_Report] @TranID = 'TRN10000004',@Mode = 'REN',@PaymentLevel = 'SECOND'
--EXEC [sp_Nature_OR_Report] @TranID = 'TRN10000004',@Mode = 'MAIN',@PaymentLevel = 'SECOND'
CREATE PROCEDURE [dbo].[sp_Nature_OR_Report]
    @TranID       VARCHAR(20) = NULL,
    @Mode         VARCHAR(50) = NULL,
    @PaymentLevel VARCHAR(50) = NULL
AS
    BEGIN
        SET NOCOUNT ON;


        DECLARE @combinedString VARCHAR(MAX);
        DECLARE @IsFullPayment BIT = 0;
        DECLARE @RefId VARCHAR(100) = '';


        IF NOT EXISTS
            (
                SELECT
                    1
                FROM
                    [dbo].[tblRecieptReport]
                WHERE
                    [tblRecieptReport].[TRANID] = @TranID
                    AND [tblRecieptReport].[Mode] = @Mode
                    AND [tblRecieptReport].[PaymentLevel] = @PaymentLevel
            )
            BEGIN
                SELECT
                    @IsFullPayment = ISNULL([tblUnitReference].[IsFullPayment], 0),
                    @RefId         = [tblUnitReference].[RefId]
                FROM
                    [dbo].[tblUnitReference]
                WHERE
                    [tblUnitReference].[RefId] =
                    (
                        SELECT TOP 1
                               [tblTransaction].[RefId]
                        FROM
                               [dbo].[tblTransaction]
                        WHERE
                               [tblTransaction].[TranID] = @TranID
                    );

                IF @IsFullPayment = 0
                    BEGIN
                        IF
                            (
                                SELECT
                                    COUNT(*)
                                FROM
                                    [dbo].[tblPayment]
                                WHERE
                                    [tblPayment].[TranId] = @TranID
                                    AND [tblPayment].[Remarks] NOT IN (
                                                                          'SECURITY DEPOSIT'
                                                                      )
                            ) > 5
                            BEGIN
                                IF @Mode = 'REN'
                                   AND @PaymentLevel = 'SECOND'
                                    BEGIN
                                        SELECT
                                            @combinedString
                                            =
                                            (
                                                SELECT  TOP 1
                                                        UPPER(DATENAME(MONTH, MIN([tblPayment].[ForMonth]))) + ' '
                                                        + CAST(YEAR(MIN([tblPayment].[ForMonth])) AS VARCHAR(4))
                                                FROM
                                                        [dbo].[tblPayment]
                                                    INNER JOIN
                                                        [dbo].[tblMonthLedger]
                                                            ON [tblMonthLedger].[LedgMonth] = [tblPayment].[ForMonth]
                                                               AND [tblMonthLedger].[Remarks] = [tblPayment].[Notes]
                                                               AND [tblMonthLedger].[TransactionID] = [tblPayment].[TranId]
                                                WHERE
                                                        [tblPayment].[TranId] = @TranID
                                                        AND [tblPayment].[Remarks] NOT IN (
                                                                                              'SECURITY DEPOSIT'
                                                                                          )
                                                        AND [tblPayment].[Notes] = 'RENTAL NET OF VAT'
                                                        AND ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                                            ) + ' TO '
                                            +
                                            (
                                                SELECT  TOP 1
                                                        UPPER(DATENAME(MONTH, MAX([tblPayment].[ForMonth]))) + ' '
                                                        + CAST(YEAR(MAX([tblPayment].[ForMonth])) AS VARCHAR(4))
                                                FROM
                                                        [dbo].[tblPayment]
                                                    INNER JOIN
                                                        [dbo].[tblMonthLedger]
                                                            ON [tblMonthLedger].[LedgMonth] = [tblPayment].[ForMonth]
                                                               AND [tblMonthLedger].[Remarks] = [tblPayment].[Notes]
                                                               AND [tblMonthLedger].[TransactionID] = [tblPayment].[TranId]
                                                WHERE
                                                        [tblPayment].[TranId] = @TranID
                                                        AND [tblPayment].[Remarks] NOT IN (
                                                                                              'SECURITY DEPOSIT'
                                                                                          )
                                                        AND [tblPayment].[Notes] = 'RENTAL NET OF VAT'
                                                        AND ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                                            )
                                    END

                                IF @Mode = 'MAIN'
                                   AND @PaymentLevel = 'SECOND'
                                    BEGIN

                                        SELECT
                                            @combinedString
                                            =
                                            (
                                                SELECT  TOP 1
                                                        UPPER(DATENAME(MONTH, MIN([tblPayment].[ForMonth]))) + ' '
                                                        + CAST(YEAR(MIN([tblPayment].[ForMonth])) AS VARCHAR(4))
                                                FROM
                                                        [dbo].[tblPayment]
                                                    INNER JOIN
                                                        [dbo].[tblMonthLedger]
                                                            ON [tblMonthLedger].[LedgMonth] = [tblPayment].[ForMonth]
                                                               AND [tblMonthLedger].[Remarks] = [tblPayment].[Notes]
                                                               AND [tblMonthLedger].[TransactionID] = [tblPayment].[TranId]
                                                WHERE
                                                        [tblPayment].[TranId] = @TranID
                                                        AND [tblPayment].[Remarks] NOT IN (
                                                                                              'SECURITY DEPOSIT'
                                                                                          )
                                                        AND [tblPayment].[Notes] = 'SECURITY AND MAINTENANCE NET OF VAT'
                                                        AND ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                                            ) + ' TO '
                                            +
                                            (
                                                SELECT  TOP 1
                                                        UPPER(DATENAME(MONTH, MAX([tblPayment].[ForMonth]))) + ' '
                                                        + CAST(YEAR(MAX([tblPayment].[ForMonth])) AS VARCHAR(4))
                                                FROM
                                                        [dbo].[tblPayment]
                                                    INNER JOIN
                                                        [dbo].[tblMonthLedger]
                                                            ON [tblMonthLedger].[LedgMonth] = [tblPayment].[ForMonth]
                                                               AND [tblMonthLedger].[Remarks] = [tblPayment].[Notes]
                                                               AND [tblMonthLedger].[TransactionID] = [tblPayment].[TranId]
                                                WHERE
                                                        [tblPayment].[TranId] = @TranID
                                                        AND [tblPayment].[Remarks] NOT IN (
                                                                                              'SECURITY DEPOSIT'
                                                                                          )
                                                        AND [tblPayment].[Notes] = 'SECURITY AND MAINTENANCE NET OF VAT'
                                                        AND ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                                            )
                                    END

                            END
                        ELSE
                            BEGIN
                                IF @Mode = 'SEC'
                                   AND @PaymentLevel = 'FIRST'
                                    BEGIN
                                        SELECT
                                            @combinedString
                                            = '('
                                              + CAST(CAST([dbo].[fnGetTotalSecDepositAmountCount](@RefId) AS INT) AS VARCHAR(50))
                                              + ')MONTH-SECURITY DEPOSIT'

                                    END
                                ELSE IF @Mode = 'ADV'
                                        AND @PaymentLevel = 'FIRST'
                                    BEGIN
                                        --SELECT @combinedString = 'ADVANCE PAYMENT'
                                        BEGIN
                                            SELECT
                                                @combinedString
                                                = COALESCE(@combinedString + '-', '')
                                                  + UPPER(DATENAME(MONTH, [tblPayment].[ForMonth])) + ' '
                                                  + CAST(YEAR([tblPayment].[ForMonth]) AS VARCHAR(4))
                                            FROM
                                                [dbo].[tblPayment]
                                            WHERE
                                                [tblPayment].[TranId] = @TranID
                                                AND [tblPayment].[Remarks] = 'MONTHS ADVANCE'
                                                AND ISNULL([tblPayment].[Notes], '') = ''


                                        END
                                    END
                                ELSE
                                    BEGIN

                                        IF @Mode = 'REN'
                                           AND @PaymentLevel = 'SECOND'
                                            BEGIN
                                                SELECT
                                                        @combinedString
                                                    = COALESCE(@combinedString + '-', '')
                                                      + UPPER(DATENAME(MONTH, [tblPayment].[ForMonth])) + ' '
                                                      + CAST(YEAR([tblPayment].[ForMonth]) AS VARCHAR(4))
                                                      + IIF(ISNULL([tblMonthLedger].[IsHold], 0) = 1, '(PARTIAL)', '')
                                                FROM
                                                        [dbo].[tblPayment]
                                                    INNER JOIN
                                                        [dbo].[tblMonthLedger]
                                                            ON [tblMonthLedger].[LedgMonth] = [tblPayment].[ForMonth]
                                                               AND [tblMonthLedger].[Remarks] = [tblPayment].[Notes]
                                                               AND [tblMonthLedger].[TransactionID] = [tblPayment].[TranId]
                                                WHERE
                                                        [tblPayment].[TranId] = @TranID
                                                        AND [tblPayment].[Remarks] NOT IN (
                                                                                              'SECURITY DEPOSIT'
                                                                                          )
                                                        AND [tblPayment].[Notes] = 'RENTAL NET OF VAT'
                                                        AND ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                                            END
                                        IF @Mode = 'MAIN'
                                           AND @PaymentLevel = 'SECOND'
                                            BEGIN
                                                SELECT
                                                        @combinedString
                                                    = COALESCE(@combinedString + '-', '')
                                                      + UPPER(DATENAME(MONTH, [tblPayment].[ForMonth])) + ' '
                                                      + CAST(YEAR([tblPayment].[ForMonth]) AS VARCHAR(4))
                                                      + IIF(ISNULL([tblMonthLedger].[IsHold], 0) = 1, '(PARTIAL)', '')
                                                FROM
                                                        [dbo].[tblPayment]
                                                    INNER JOIN
                                                        [dbo].[tblMonthLedger]
                                                            ON [tblMonthLedger].[LedgMonth] = [tblPayment].[ForMonth]
                                                               AND [tblMonthLedger].[Remarks] = [tblPayment].[Notes]
                                                               AND [tblMonthLedger].[TransactionID] = [tblPayment].[TranId]
                                                WHERE
                                                        [tblPayment].[TranId] = @TranID
                                                        AND [tblPayment].[Remarks] NOT IN (
                                                                                              'SECURITY DEPOSIT'
                                                                                          )
                                                        AND [tblPayment].[Notes] = 'SECURITY AND MAINTENANCE NET OF VAT'
                                                        AND ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                                            END


                                    END
                            END
                    END;


                IF @Mode = 'ADV'
                   AND @PaymentLevel = 'FIRST'
                    BEGIN
                        INSERT INTO [dbo].[tblRecieptReport]
                            (
                                [client_no],
                                [client_Name],
                                [client_Address],
                                [PR_No],
                                [OR_No],
                                [TIN_No],
                                [TransactionDate],
                                [AmountInWords],
                                [PaymentFor],      --PAYMENT DESCRIPTION
                                [TotalAmountInDigit],
                                [RENTAL],
                                [VAT],             --VAT AMOUNT
                                [VATPct],
                                [TOTAL],
                                [LESSWITHHOLDING], --TAX AMOUNT
                                [TOTALAMOUNTDUE],
                                [BANKNAME],
                                [PDCCHECKSERIALNO],
                                [USER],
                                [EncodedDate],
                                [TRANID],
                                [Mode],
                                [PaymentLevel],
                                [UnitNo],
                                [ProjectName],
                                [BankBranch],
                                [RENTAL_LESS_VAT],
                                [RENTAL_LESS_TAX]
                            )
                                    SELECT
                                        [CLIENT].[client_no]                                                                                               AS [client_no],
                                        [CLIENT].[client_Name]                                                                                             AS [client_Name],
                                        [CLIENT].[client_Address]                                                                                          AS [client_Address],
                                        [RECEIPT].[PR_No]                                                                                                  AS [PR_No],
                                        [RECEIPT].[OR_No]                                                                                                  AS [OR_No],
                                        [CLIENT].[TIN_No]                                                                                                  AS [TIN_No],
                                        [TRANSACTION].[TransactionDate]                                                                                    AS [TransactionDate],
                                        UPPER([dbo].[fnNumberToWordsWithDecimal](IIF(@IsFullPayment = 0,
                                                                                     [tblUnitReference].[AdvancePaymentAmount],
                                                                                     [tblUnitReference].[Total])
                                                                                )
                                             )                                                                                                             AS [AmountInWords],
                                        [PAYMENT].[PAYMENT_FOR]                                                                                            AS [PaymentFor],
                                        IIF(@IsFullPayment = 0,
                                            [tblUnitReference].[AdvancePaymentAmount],
                                            [tblUnitReference].[Total])                                                                                    AS [TotalAmountInDigit],
                                        IIF(@IsFullPayment = 0,
                                            [tblUnitReference].[AdvancePaymentAmount],
                                            [tblUnitReference].[Total])                                                                                    AS [RENTAL],
                                        CAST(([tblUnitReference].[Unit_BaseRentalVatAmount]
                                              + [tblUnitReference].[Unit_SecAndMainVatAmount]
                                             )
                                             * CAST([dbo].[fnGetAdvanceMonthCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150))   AS [VAT_AMOUNT],
                                        CAST([tblUnitReference].[Unit_Vat] AS VARCHAR(10)) + '% VAT'                                                       AS [VATPct],
                                        IIF(@IsFullPayment = 0,
                                            [tblUnitReference].[AdvancePaymentAmount],
                                            [tblUnitReference].[Total])                                                                                    AS [TOTAL],
                                        CAST([tblUnitReference].[Unit_BaseRentalTax]
                                             * CAST([dbo].[fnGetAdvanceMonthCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150))   AS [LESSWITHHOLDING],
                                        [tblUnitReference].[AdvancePaymentAmount]                                                                          AS [TOTALAMOUNTDUE],
                                        [RECEIPT].[BankName]                                                                                               AS [BANKNAME],
                                        [RECEIPT].[PDC_CHECK_SERIAL]                                                                                       AS [PDCCHECKSERIALNO],
                                        [TRANSACTION].[USER]                                                                                               AS [USER],
                                        GETDATE()                                                                                                          AS [EncodedDate],
                                        @TranID                                                                                                            AS [TRANID],
                                        @Mode                                                                                                              AS [Mode],
                                        @PaymentLevel                                                                                                      AS [PaymentLevel],
                                        [tblUnitReference].[UnitNo]                                                                                        AS [UnitNo],
                                        [dbo].[fnGetProjectNameById]([tblUnitReference].[ProjectId])                                                       AS [ProjectName],
                                        [RECEIPT].[BankBranch]                                                                                             AS [BankBranch],
                                        CAST(CAST(IIF(@IsFullPayment = 0,
                                                      IIF([tblUnitReference].[Unit_Tax] > 0,
                                                          ([tblUnitReference].[AdvancePaymentAmount]
                                                           + CAST([tblUnitReference].[Unit_BaseRentalTax]
                                                                  * [dbo].[fnGetAdvanceMonthCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2))
                                                          ),
                                                          [tblUnitReference].[AdvancePaymentAmount]),
                                                      [tblUnitReference].[Total]) AS DECIMAL(18, 2))
                                             - CAST(([dbo].[tblUnitReference].[Unit_BaseRentalVatAmount]
                                                     + [tblUnitReference].[Unit_SecAndMainVatAmount]
                                                    )
                                                    * [dbo].[fnGetAdvanceMonthCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150)) AS [RENTAL_LESS_VAT],
                                        CAST(IIF(@IsFullPayment = 0,
                                                 [tblUnitReference].[AdvancePaymentAmount],
                                                 [tblUnitReference].[Total]) AS VARCHAR(150))                                                              AS [RENTAL_LESS_TAX]
                                    FROM
                                        [dbo].[tblUnitReference]
                                        CROSS APPLY
                                        (
                                            SELECT
                                                [tblClientMstr].[ClientID]      AS [client_no],
                                                [tblClientMstr].[ClientName]    AS [client_Name],
                                                [tblClientMstr].[PostalAddress] AS [client_Address],
                                                [tblClientMstr].[TIN_No]        AS [TIN_No]
                                            FROM
                                                [dbo].[tblClientMstr]
                                            WHERE
                                                [tblClientMstr].[ClientID] = [tblUnitReference].[ClientID]
                                        ) [CLIENT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                [tblTransaction].[EncodedDate]                                   AS [TransactionDate],
                                                [tblTransaction].[TranID],
                                                ISNULL([dbo].[fn_GetUserName]([tblTransaction].[EncodedBy]), '') AS [USER],
                                                [tblTransaction].[ReceiveAmount]
                                            FROM
                                                [dbo].[tblTransaction]
                                            WHERE
                                                [tblUnitReference].[RefId] = [tblTransaction].[RefId]
                                        ) [TRANSACTION]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                [tblReceipt].[CompanyPRNo] AS [PR_No],
                                                [tblReceipt].[CompanyORNo] AS [OR_No],
                                                [tblReceipt].[Amount]      AS [TOTAL],
                                                [tblReceipt].[BankName]    AS [BankName],
                                                [tblReceipt].[BankBranch]  AS [BankBranch],
                                                [tblReceipt].[REF]         AS [PDC_CHECK_SERIAL],
                                                [tblReceipt].[TranId]
                                            FROM
                                                [dbo].[tblReceipt]
                                            WHERE
                                                [TRANSACTION].[TranID] = [tblReceipt].[TranId]
                                        ) [RECEIPT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                IIF(@IsFullPayment = 1, 'FULL PAYMENT', 'RENTAL FOR ' + @combinedString) AS [PAYMENT_FOR]
                                        ) [PAYMENT]
                                    WHERE
                                        [TRANSACTION].[TranID] = @TranID


                    END
                IF @Mode = 'SEC'
                   AND @PaymentLevel = 'FIRST'
                    BEGIN
                        INSERT INTO [dbo].[tblRecieptReport]
                            (
                                [client_no],
                                [client_Name],
                                [client_Address],
                                [PR_No],
                                [OR_No],
                                [TIN_No],
                                [TransactionDate],
                                [AmountInWords],
                                [PaymentFor],
                                [TotalAmountInDigit],
                                [RENTAL],
                                [VAT],
                                [VATPct],
                                [TOTAL],
                                [LESSWITHHOLDING],
                                [TOTALAMOUNTDUE],
                                [BANKNAME],
                                [PDCCHECKSERIALNO],
                                [USER],
                                [EncodedDate],
                                [TRANID],
                                [Mode],
                                [PaymentLevel],
                                [UnitNo],
                                [ProjectName],
                                [BankBranch],
                                [RENTAL_LESS_VAT],
                                [RENTAL_LESS_TAX]
                            )
                                    SELECT
                                        [CLIENT].[client_no]                                                                                                        AS [client_no],
                                        [CLIENT].[client_Name]                                                                                                      AS [client_Name],
                                        [CLIENT].[client_Address]                                                                                                   AS [client_Address],
                                        [RECEIPT].[PR_No]                                                                                                           AS [PR_No],
                                        [RECEIPT].[OR_No]                                                                                                           AS [OR_No],
                                        [CLIENT].[TIN_No]                                                                                                           AS [TIN_No],
                                        [TRANSACTION].[TransactionDate]                                                                                             AS [TransactionDate],
                                        UPPER([dbo].[fnNumberToWordsWithDecimal]([tblUnitReference].[SecDeposit]))                                                  AS [AmountInWords],
                                        [PAYMENT].[PAYMENT_FOR]                                                                                                     AS [PaymentFor],
                                        [tblUnitReference].[SecDeposit]                                                                                             AS [TotalAmountInDigit],
                                        [tblUnitReference].[SecDeposit]                                                                                             AS [RENTAL],
                                        CAST(CAST(([tblUnitReference].[Unit_BaseRentalVatAmount]
                                                   + [tblUnitReference].[Unit_SecAndMainVatAmount]
                                                  )
                                                  * [dbo].[fnGetTotalSecDepositAmountCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150))   AS [VAT],
                                        CAST([tblUnitReference].[Unit_Vat] AS VARCHAR(10)) + '% VAT'                                                                AS [VATPct],
                                        [tblUnitReference].[SecDeposit]                                                                                             AS [TOTAL],
                                        CAST(CAST([tblUnitReference].[Unit_TaxAmount]
                                                  * [dbo].[fnGetTotalSecDepositAmountCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150))   AS [LESSWITHHOLDING],
                                        [tblUnitReference].[SecDeposit]                                                                                             AS [TOTALAMOUNTDUE],
                                        [RECEIPT].[BankName]                                                                                                        AS [BANKNAME],
                                        [RECEIPT].[PDC_CHECK_SERIAL]                                                                                                AS [PDCCHECKSERIALNO],
                                        [TRANSACTION].[USER]                                                                                                        AS [USER],
                                        GETDATE()                                                                                                                   AS [EncodedDate],
                                        @TranID                                                                                                                     AS [TRANID],
                                        @Mode                                                                                                                       AS [Mode],
                                        @PaymentLevel                                                                                                               AS [PaymentLevel],
                                        [tblUnitReference].[UnitNo]                                                                                                 AS [UnitNo],
                                        [dbo].[fnGetProjectNameById]([tblUnitReference].[ProjectId])                                                                AS [ProjectName],
                                        [RECEIPT].[BankBranch]                                                                                                      AS [BankBranch],
                                        CAST(CAST(IIF([tblUnitReference].[Unit_Tax] > 0,
                                                      ([tblUnitReference].[SecDeposit]
                                                       + CAST([tblUnitReference].[Unit_BaseRentalTax]
                                                              * [dbo].[fnGetTotalSecDepositAmountCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2))
                                                      ),
                                                      0) AS DECIMAL(18, 2))
                                             - CAST(([tblUnitReference].[Unit_BaseRentalVatAmount]
                                                     + [tblUnitReference].[Unit_SecAndMainVatAmount]
                                                    )
                                                    * [dbo].[fnGetTotalSecDepositAmountCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150)) AS [RENTAL_LESS_VAT],
                                        CAST(CAST([tblUnitReference].[SecDeposit] AS DECIMAL(18, 2)) AS VARCHAR(150))                                               AS [RENTAL_LESS_TAX]
                                    FROM
                                        [dbo].[tblUnitReference]
                                        CROSS APPLY
                                        (
                                            SELECT
                                                [tblClientMstr].[ClientID]      AS [client_no],
                                                [tblClientMstr].[ClientName]    AS [client_Name],
                                                [tblClientMstr].[PostalAddress] AS [client_Address],
                                                [tblClientMstr].[TIN_No]        AS [TIN_No]
                                            FROM
                                                [dbo].[tblClientMstr]
                                            WHERE
                                                [tblClientMstr].[ClientID] = [tblUnitReference].[ClientID]
                                        ) [CLIENT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                [tblTransaction].[EncodedDate]                                   AS [TransactionDate],
                                                [tblTransaction].[TranID],
                                                ISNULL([dbo].[fn_GetUserName]([tblTransaction].[EncodedBy]), '') AS [USER],
                                                [tblTransaction].[ReceiveAmount]
                                            FROM
                                                [dbo].[tblTransaction]
                                            WHERE
                                                [tblUnitReference].[RefId] = [tblTransaction].[RefId]
                                        ) [TRANSACTION]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                [tblReceipt].[CompanyPRNo] AS [PR_No],
                                                [tblReceipt].[CompanyORNo] AS [OR_No],
                                                [tblReceipt].[Amount]      AS [TOTAL],
                                                [tblReceipt].[BankName]    AS [BankName],
                                                [tblReceipt].[BankBranch]  AS [BankBranch],
                                                [tblReceipt].[REF]         AS [PDC_CHECK_SERIAL],
                                                [tblReceipt].[TranId]
                                            FROM
                                                [dbo].[tblReceipt]
                                            WHERE
                                                [TRANSACTION].[TranID] = [tblReceipt].[TranId]
                                        ) [RECEIPT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                IIF(@IsFullPayment = 1, 'FULL PAYMENT', 'RENTAL FOR ' + @combinedString) AS [PAYMENT_FOR]
                                        ) [PAYMENT]
                                    WHERE
                                        [TRANSACTION].[TranID] = @TranID


                    END



                IF @Mode = 'REN'
                   AND @PaymentLevel = 'SECOND'
                    BEGIN
                        INSERT INTO [dbo].[tblRecieptReport]
                            (
                                [client_no],
                                [client_Name],
                                [client_Address],
                                [PR_No],
                                [OR_No],
                                [TIN_No],
                                [TransactionDate],
                                [AmountInWords],
                                [PaymentFor],
                                [TotalAmountInDigit],
                                [RENTAL],
                                [VAT],
                                [VATPct],
                                [TOTAL],
                                [LESSWITHHOLDING],
                                [TOTALAMOUNTDUE],
                                [BANKNAME],
                                [PDCCHECKSERIALNO],
                                [USER],
                                [EncodedDate],
                                [TRANID],
                                [Mode],
                                [PaymentLevel],
                                [UnitNo],
                                [ProjectName],
                                [BankBranch],
                                [RENTAL_LESS_VAT],
                                [RENTAL_LESS_TAX]
                            )
                                    SELECT
                                        [CLIENT].[client_no]                                                     AS [client_no],
                                        [CLIENT].[client_Name]                                                   AS [client_Name],
                                        [CLIENT].[client_Address]                                                AS [client_Address],
                                        [RECEIPT].[PR_No]                                                        AS [PR_No],
                                        [RECEIPT].[OR_No]                                                        AS [OR_No],
                                        [CLIENT].[TIN_No]                                                        AS [TIN_No],
                                        [TRANSACTION].[TransactionDate]                                          AS [TransactionDate],
                                        UPPER([dbo].[fnNumberToWordsWithDecimal]([TRANSACTION].[ReceiveAmount])) AS [AmountInWords],
                                        [PAYMENT].[PAYMENT_FOR]                                                  AS [PaymentFor],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [TotalAmountInDigit],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [RENTAL],
                                        CAST(CAST((([tblUnitReference].[Unit_Vat] * [TRANSACTION].[ReceiveAmount])
                                                   / 100
                                                  ) AS DECIMAL(18, 2)) AS VARCHAR(30))                           AS [VAT],
                                        CAST([tblUnitReference].[Unit_Vat] AS VARCHAR(10)) + '% VAT'             AS [VATPct],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [TOTAL],
                                        IIF([tblUnitReference].[Unit_Tax] > 0,
                                            CAST(CAST((([tblUnitReference].[Unit_Tax] * [TRANSACTION].[ReceiveAmount])
                                                       / 100
                                                      ) AS DECIMAL(18, 2)) AS VARCHAR(30)),
                                            '0.00')                                                              AS [LESSWITHHOLDING],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [TOTALAMOUNTDUE],
                                        [RECEIPT].[BankName]                                                     AS [BANKNAME],
                                        [RECEIPT].[PDC_CHECK_SERIAL]                                             AS [PDCCHECKSERIALNO],
                                        [TRANSACTION].[USER]                                                     AS [USER],
                                        GETDATE()                                                                AS [EncodedDate],
                                        @TranID                                                                  AS [TRANID],
                                        @Mode                                                                    AS [Mode],
                                        @PaymentLevel                                                            AS [PaymentLevel],
                                        [tblUnitReference].[UnitNo]                                              AS [UnitNo],
                                        [dbo].[fnGetProjectNameById]([tblUnitReference].[ProjectId])             AS [ProjectName],
                                        [RECEIPT].[BankBranch]                                                   AS [BankBranch],
                                        '0'                                                                      AS [RENTAL_LESS_VAT],
                                        '0'                                                                      AS [RENTAL_LESS_TAX]
                                    FROM
                                        [dbo].[tblUnitReference]
                                        CROSS APPLY
                                        (
                                            SELECT
                                                [tblClientMstr].[ClientID]      AS [client_no],
                                                [tblClientMstr].[ClientName]    AS [client_Name],
                                                [tblClientMstr].[PostalAddress] AS [client_Address],
                                                [tblClientMstr].[TIN_No]        AS [TIN_No]
                                            FROM
                                                [dbo].[tblClientMstr]
                                            WHERE
                                                [tblClientMstr].[ClientID] = [tblUnitReference].[ClientID]
                                        ) [CLIENT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                    [tblTransaction].[EncodedDate]                                   AS [TransactionDate],
                                                    [tblTransaction].[TranID],
                                                    ISNULL([dbo].[fn_GetUserName]([tblTransaction].[EncodedBy]), '') AS [USER],
                                                    SUM([tblPayment].[Amount])                                       AS [ReceiveAmount]
                                            FROM
                                                    [dbo].[tblTransaction]
                                                INNER JOIN
                                                    [dbo].[tblPayment]
                                                        ON [tblPayment].[TranId] = [tblTransaction].[TranID]
                                            WHERE
                                                    [tblUnitReference].[RefId] = [tblTransaction].[RefId]
                                                    AND [tblPayment].[Notes] = 'RENTAL NET OF VAT'
                                            GROUP BY
                                                    [tblTransaction].[EncodedDate],
                                                    [tblTransaction].[TranID],
                                                    [tblTransaction].[EncodedBy],
                                                    [tblPayment].[Amount]
                                        ) [TRANSACTION]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                [tblReceipt].[CompanyPRNo] AS [PR_No],
                                                [tblReceipt].[CompanyORNo] AS [OR_No],
                                                [tblReceipt].[Amount]      AS [TOTAL],
                                                [tblReceipt].[Amount]      AS [TotalAmountInDigit],
                                                [tblReceipt].[BankName]    AS [BankName],
                                                [tblReceipt].[BankBranch]  AS [BankBranch],
                                                [tblReceipt].[REF]         AS [PDC_CHECK_SERIAL],
                                                [tblReceipt].[TranId]
                                            FROM
                                                [dbo].[tblReceipt]
                                            WHERE
                                                [TRANSACTION].[TranID] = [tblReceipt].[TranId]
                                        ) [RECEIPT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                IIF(@IsFullPayment = 1, 'FULL PAYMENT', 'RENTAL FOR ' + @combinedString) AS [PAYMENT_FOR]
                                        ) [PAYMENT]
                                    WHERE
                                        [TRANSACTION].[TranID] = @TranID;
                    END
                IF @Mode = 'MAIN'
                   AND @PaymentLevel = 'SECOND'
                    BEGIN
                        INSERT INTO [dbo].[tblRecieptReport]
                            (
                                [client_no],
                                [client_Name],
                                [client_Address],
                                [PR_No],
                                [OR_No],
                                [TIN_No],
                                [TransactionDate],
                                [AmountInWords],
                                [PaymentFor],
                                [TotalAmountInDigit],
                                [RENTAL],
                                [VAT],
                                [VATPct],
                                [TOTAL],
                                [LESSWITHHOLDING],
                                [TOTALAMOUNTDUE],
                                [BANKNAME],
                                [PDCCHECKSERIALNO],
                                [USER],
                                [EncodedDate],
                                [TRANID],
                                [Mode],
                                [PaymentLevel],
                                [UnitNo],
                                [ProjectName],
                                [BankBranch],
                                [RENTAL_LESS_VAT],
                                [RENTAL_LESS_TAX]
                            )
                                    SELECT
                                        [CLIENT].[client_no]                                                     AS [client_no],
                                        [CLIENT].[client_Name]                                                   AS [client_Name],
                                        [CLIENT].[client_Address]                                                AS [client_Address],
                                        [RECEIPT].[PR_No]                                                        AS [PR_No],
                                        [RECEIPT].[OR_No]                                                        AS [OR_No],
                                        [CLIENT].[TIN_No]                                                        AS [TIN_No],
                                        [TRANSACTION].[TransactionDate]                                          AS [TransactionDate],
                                        UPPER([dbo].[fnNumberToWordsWithDecimal]([TRANSACTION].[ReceiveAmount])) AS [AmountInWords],
                                        [PAYMENT].[PAYMENT_FOR]                                                  AS [PaymentFor],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [TotalAmountInDigit],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [RENTAL],
                                        CAST(CAST((([tblUnitReference].[Unit_Vat] * [TRANSACTION].[ReceiveAmount])
                                                   / 100
                                                  ) AS DECIMAL(18, 2)) AS VARCHAR(30))                           AS [VAT], --TAX WILL FOLLOW
                                        CAST([tblUnitReference].[GenVat] AS VARCHAR(10)) + '% VAT'               AS [VATPct],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [TOTAL],
                                        IIF([tblUnitReference].[Unit_Tax] > 0,
                                            CAST(CAST((([tblUnitReference].[Unit_Tax] * [TRANSACTION].[ReceiveAmount])
                                                       / 100
                                                      ) AS DECIMAL(18, 2)) AS VARCHAR(30)),
                                            '0.00')                                                              AS [LESSWITHHOLDING],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [TOTALAMOUNTDUE],
                                        [RECEIPT].[BankName]                                                     AS [BANKNAME],
                                        [RECEIPT].[PDC_CHECK_SERIAL]                                             AS [PDCCHECKSERIALNO],
                                        [TRANSACTION].[USER]                                                     AS [USER],
                                        GETDATE()                                                                AS [EncodedDate],
                                        @TranID                                                                  AS [TRANID],
                                        @Mode                                                                    AS [Mode],
                                        @PaymentLevel                                                            AS [PaymentLevel],
                                        [tblUnitReference].[UnitNo]                                              AS [UnitNo],
                                        [dbo].[fnGetProjectNameById]([tblUnitReference].[ProjectId])             AS [ProjectName],
                                        [RECEIPT].[BankBranch]                                                   AS [BankBranch],
                                        '0'                                                                      AS [RENTAL_LESS_VAT],
                                        '0'                                                                      AS [RENTAL_LESS_TAX]
                                    FROM
                                        [dbo].[tblUnitReference]
                                        CROSS APPLY
                                        (
                                            SELECT
                                                [tblClientMstr].[ClientID]      AS [client_no],
                                                [tblClientMstr].[ClientName]    AS [client_Name],
                                                [tblClientMstr].[PostalAddress] AS [client_Address],
                                                [tblClientMstr].[TIN_No]        AS [TIN_No]
                                            FROM
                                                [dbo].[tblClientMstr]
                                            WHERE
                                                [tblClientMstr].[ClientID] = [tblUnitReference].[ClientID]
                                        ) [CLIENT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                    [tblTransaction].[EncodedDate]                                   AS [TransactionDate],
                                                    [tblTransaction].[TranID],
                                                    ISNULL([dbo].[fn_GetUserName]([tblTransaction].[EncodedBy]), '') AS [USER],
                                                    SUM([tblPayment].[Amount])                                       AS [ReceiveAmount]
                                            FROM
                                                    [dbo].[tblTransaction]
                                                INNER JOIN
                                                    [dbo].[tblPayment]
                                                        ON [tblPayment].[TranId] = [tblTransaction].[TranID]
                                            WHERE
                                                    [tblUnitReference].[RefId] = [tblTransaction].[RefId]
                                                    AND [tblPayment].[Notes] = 'SECURITY AND MAINTENANCE NET OF VAT'
                                            GROUP BY
                                                    [tblTransaction].[EncodedDate],
                                                    [tblTransaction].[TranID],
                                                    [tblTransaction].[EncodedBy],
                                                    [tblPayment].[Amount]
                                        ) [TRANSACTION]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                [tblReceipt].[CompanyPRNo] AS [PR_No],
                                                [tblReceipt].[CompanyORNo] AS [OR_No],
                                                [tblReceipt].[Amount]      AS [TOTAL],
                                                [tblReceipt].[Amount]      AS [TotalAmountInDigit],
                                                [tblReceipt].[BankName]    AS [BankName],
                                                [tblReceipt].[BankBranch]  AS [BankBranch],
                                                [tblReceipt].[REF]         AS [PDC_CHECK_SERIAL],
                                                [tblReceipt].[TranId]
                                            FROM
                                                [dbo].[tblReceipt]
                                            WHERE
                                                [TRANSACTION].[TranID] = [tblReceipt].[TranId]
                                        ) [RECEIPT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                IIF(@IsFullPayment = 1, 'FULL PAYMENT', 'RENTAL FOR ' + @combinedString) AS [PAYMENT_FOR]
                                        ) [PAYMENT]
                                    WHERE
                                        [TRANSACTION].[TranID] = @TranID;
                    END





            END


        SELECT TOP 1
               [tblRecieptReport].[client_no],
               [tblRecieptReport].[client_Name],
               [tblRecieptReport].[client_Address],
               [tblRecieptReport].[PR_No],
               [tblRecieptReport].[OR_No],
               [tblRecieptReport].[TIN_No],
               [tblRecieptReport].[TransactionDate],
               [tblRecieptReport].[AmountInWords],
               [tblRecieptReport].[PaymentFor],
               --FORMAT(CAST([#TMP].[TotalAmountInDigit] AS DECIMAL(18, 2)), 'C', 'en-PH') AS [TotalAmountInDigit],
               FORMAT(CAST([tblRecieptReport].[TotalAmountInDigit] AS DECIMAL(18, 2)), 'N')      AS [TotalAmountInDigit],
               --FORMAT(CAST([#TMP].[RENTAL] AS DECIMAL(18, 2)), 'C', 'en-PH') AS [RENTAL],
               FORMAT(CAST([tblRecieptReport].[RENTAL] AS DECIMAL(18, 2)), 'C', 'en-PH')         AS [RENTAL],
               FORMAT(CAST([tblRecieptReport].[VAT] AS DECIMAL(18, 2)), 'C', 'en-PH')            AS [VAT],
               [tblRecieptReport].[VATPct],
               FORMAT(CAST([tblRecieptReport].[RENTAL] AS DECIMAL(18, 2)), 'C', 'en-PH')         AS [TOTAL],
               --FORMAT(CAST([tblRecieptReport].[LESSWITHHOLDING] AS DECIMAL(18, 2)), 'C', 'en-PH') AS [LESSWITHHOLDING],
               CAST(CAST('0.00' AS DECIMAL(18, 2)) AS VARCHAR(50)) + ' %'                        AS [LESSWITHHOLDING],
               --[#TMP].[LESSWITHHOLDING] AS [LESSWITHHOLDING],
               FORMAT(CAST([tblRecieptReport].[TOTALAMOUNTDUE] AS DECIMAL(18, 2)), 'C', 'en-PH') AS [TOTALAMOUNTDUE],
               [tblRecieptReport].[BANKNAME],
               [tblRecieptReport].[PDCCHECKSERIALNO],
               [tblRecieptReport].[USER],
               [tblRecieptReport].[Mode],
               [tblRecieptReport].[UnitNo],
               [tblRecieptReport].[ProjectName],
               [tblRecieptReport].[BankBranch],
               ''                                                                                AS [BankCheckDate],
               ''                                                                                AS [BankCheckAmount],
               [tblRecieptReport].[RENTAL_LESS_VAT],
               [tblRecieptReport].[RENTAL_LESS_TAX]
        FROM
               [dbo].[tblRecieptReport]
        WHERE
               [tblRecieptReport].[TRANID] = @TranID
               AND [tblRecieptReport].[Mode] = @Mode
               AND [tblRecieptReport].[PaymentLevel] = @PaymentLevel
        ORDER BY
               [tblRecieptReport].[EncodedDate]

    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Nature_PR_Report]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_Nature_PR_Report]
    @TranID VARCHAR(20) = NULL,
    @Mode VARCHAR(50) = NULL,
    @PaymentLevel VARCHAR(50) = NULL
AS
BEGIN
        SET NOCOUNT ON;


        DECLARE @combinedString VARCHAR(MAX);
        DECLARE @IsFullPayment BIT = 0;
        DECLARE @RefId VARCHAR(100) = '';


        IF NOT EXISTS
            (
                SELECT
                    1
                FROM
                    [dbo].[tblRecieptReport]
                WHERE
                    [tblRecieptReport].[TRANID] = @TranID
                    AND [tblRecieptReport].[Mode] = @Mode
                    AND [tblRecieptReport].[PaymentLevel] = @PaymentLevel
            )
            BEGIN
                SELECT
                    @IsFullPayment = ISNULL([tblUnitReference].[IsFullPayment], 0),
                    @RefId         = [tblUnitReference].[RefId]
                FROM
                    [dbo].[tblUnitReference]
                WHERE
                    [tblUnitReference].[RefId] =
                    (
                        SELECT TOP 1
                               [tblTransaction].[RefId]
                        FROM
                               [dbo].[tblTransaction]
                        WHERE
                               [tblTransaction].[TranID] = @TranID
                    );

                IF @IsFullPayment = 0
                    BEGIN
                        IF
                            (
                                SELECT
                                    COUNT(*)
                                FROM
                                    [dbo].[tblPayment]
                                WHERE
                                    [tblPayment].[TranId] = @TranID
                                    AND [tblPayment].[Remarks] NOT IN (
                                                                          'SECURITY DEPOSIT'
                                                                      )
                            ) > 5
                            BEGIN
                                IF @Mode = 'REN'
                                   AND @PaymentLevel = 'SECOND'
                                    BEGIN
                                        SELECT
                                            @combinedString
                                            =
                                            (
                                                SELECT  TOP 1
                                                        UPPER(DATENAME(MONTH, MIN([tblPayment].[ForMonth]))) + ' '
                                                        + CAST(YEAR(MIN([tblPayment].[ForMonth])) AS VARCHAR(4))
                                                FROM
                                                        [dbo].[tblPayment]
                                                    INNER JOIN
                                                        [dbo].[tblMonthLedger]
                                                            ON [tblMonthLedger].[LedgMonth] = [tblPayment].[ForMonth]
                                                               AND [tblMonthLedger].[Remarks] = [tblPayment].[Notes]
                                                               AND [tblMonthLedger].[TransactionID] = [tblPayment].[TranId]
                                                WHERE
                                                        [tblPayment].[TranId] = @TranID
                                                        AND [tblPayment].[Remarks] NOT IN (
                                                                                              'SECURITY DEPOSIT'
                                                                                          )
                                                        AND [tblPayment].[Notes] = 'RENTAL NET OF VAT'
                                                        AND ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                                            ) + ' TO '
                                            +
                                            (
                                                SELECT  TOP 1
                                                        UPPER(DATENAME(MONTH, MAX([tblPayment].[ForMonth]))) + ' '
                                                        + CAST(YEAR(MAX([tblPayment].[ForMonth])) AS VARCHAR(4))
                                                FROM
                                                        [dbo].[tblPayment]
                                                    INNER JOIN
                                                        [dbo].[tblMonthLedger]
                                                            ON [tblMonthLedger].[LedgMonth] = [tblPayment].[ForMonth]
                                                               AND [tblMonthLedger].[Remarks] = [tblPayment].[Notes]
                                                               AND [tblMonthLedger].[TransactionID] = [tblPayment].[TranId]
                                                WHERE
                                                        [tblPayment].[TranId] = @TranID
                                                        AND [tblPayment].[Remarks] NOT IN (
                                                                                              'SECURITY DEPOSIT'
                                                                                          )
                                                        AND [tblPayment].[Notes] = 'RENTAL NET OF VAT'
                                                        AND ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                                            )
                                    END

                                IF @Mode = 'MAIN'
                                   AND @PaymentLevel = 'SECOND'
                                    BEGIN

                                        SELECT
                                            @combinedString
                                            =
                                            (
                                                SELECT  TOP 1
                                                        UPPER(DATENAME(MONTH, MIN([tblPayment].[ForMonth]))) + ' '
                                                        + CAST(YEAR(MIN([tblPayment].[ForMonth])) AS VARCHAR(4))
                                                FROM
                                                        [dbo].[tblPayment]
                                                    INNER JOIN
                                                        [dbo].[tblMonthLedger]
                                                            ON [tblMonthLedger].[LedgMonth] = [tblPayment].[ForMonth]
                                                               AND [tblMonthLedger].[Remarks] = [tblPayment].[Notes]
                                                               AND [tblMonthLedger].[TransactionID] = [tblPayment].[TranId]
                                                WHERE
                                                        [tblPayment].[TranId] = @TranID
                                                        AND [tblPayment].[Remarks] NOT IN (
                                                                                              'SECURITY DEPOSIT'
                                                                                          )
                                                        AND [tblPayment].[Notes] = 'SECURITY AND MAINTENANCE NET OF VAT'
                                                        AND ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                                            ) + ' TO '
                                            +
                                            (
                                                SELECT  TOP 1
                                                        UPPER(DATENAME(MONTH, MAX([tblPayment].[ForMonth]))) + ' '
                                                        + CAST(YEAR(MAX([tblPayment].[ForMonth])) AS VARCHAR(4))
                                                FROM
                                                        [dbo].[tblPayment]
                                                    INNER JOIN
                                                        [dbo].[tblMonthLedger]
                                                            ON [tblMonthLedger].[LedgMonth] = [tblPayment].[ForMonth]
                                                               AND [tblMonthLedger].[Remarks] = [tblPayment].[Notes]
                                                               AND [tblMonthLedger].[TransactionID] = [tblPayment].[TranId]
                                                WHERE
                                                        [tblPayment].[TranId] = @TranID
                                                        AND [tblPayment].[Remarks] NOT IN (
                                                                                              'SECURITY DEPOSIT'
                                                                                          )
                                                        AND [tblPayment].[Notes] = 'SECURITY AND MAINTENANCE NET OF VAT'
                                                        AND ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                                            )
                                    END

                            END
                        ELSE
                            BEGIN
                                IF @Mode = 'SEC'
                                   AND @PaymentLevel = 'FIRST'
                                    BEGIN
                                        SELECT
                                            @combinedString
                                            = '('
                                              + CAST(CAST([dbo].[fnGetTotalSecDepositAmountCount](@RefId) AS INT) AS VARCHAR(50))
                                              + ')MONTH-SECURITY DEPOSIT'

                                    END
                                ELSE IF @Mode = 'ADV'
                                        AND @PaymentLevel = 'FIRST'
                                    BEGIN
                                        --SELECT @combinedString = 'ADVANCE PAYMENT'
                                        BEGIN
                                            SELECT
                                                @combinedString
                                                = COALESCE(@combinedString + '-', '')
                                                  + UPPER(DATENAME(MONTH, [tblPayment].[ForMonth])) + ' '
                                                  + CAST(YEAR([tblPayment].[ForMonth]) AS VARCHAR(4))
                                            FROM
                                                [dbo].[tblPayment]
                                            WHERE
                                                [tblPayment].[TranId] = @TranID
                                                AND [tblPayment].[Remarks] = 'MONTHS ADVANCE'
                                                AND ISNULL([tblPayment].[Notes], '') = ''


                                        END
                                    END
                                ELSE
                                    BEGIN

                                        IF @Mode = 'REN'
                                           AND @PaymentLevel = 'SECOND'
                                            BEGIN
                                                SELECT
                                                        @combinedString
                                                    = COALESCE(@combinedString + '-', '')
                                                      + UPPER(DATENAME(MONTH, [tblPayment].[ForMonth])) + ' '
                                                      + CAST(YEAR([tblPayment].[ForMonth]) AS VARCHAR(4))
                                                      + IIF(ISNULL([tblMonthLedger].[IsHold], 0) = 1, '(PARTIAL)', '')
                                                FROM
                                                        [dbo].[tblPayment]
                                                    INNER JOIN
                                                        [dbo].[tblMonthLedger]
                                                            ON [tblMonthLedger].[LedgMonth] = [tblPayment].[ForMonth]
                                                               AND [tblMonthLedger].[Remarks] = [tblPayment].[Notes]
                                                               AND [tblMonthLedger].[TransactionID] = [tblPayment].[TranId]
                                                WHERE
                                                        [tblPayment].[TranId] = @TranID
                                                        AND [tblPayment].[Remarks] NOT IN (
                                                                                              'SECURITY DEPOSIT'
                                                                                          )
                                                        AND [tblPayment].[Notes] = 'RENTAL NET OF VAT'
                                                        AND ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                                            END
                                        IF @Mode = 'MAIN'
                                           AND @PaymentLevel = 'SECOND'
                                            BEGIN
                                                SELECT
                                                        @combinedString
                                                    = COALESCE(@combinedString + '-', '')
                                                      + UPPER(DATENAME(MONTH, [tblPayment].[ForMonth])) + ' '
                                                      + CAST(YEAR([tblPayment].[ForMonth]) AS VARCHAR(4))
                                                      + IIF(ISNULL([tblMonthLedger].[IsHold], 0) = 1, '(PARTIAL)', '')
                                                FROM
                                                        [dbo].[tblPayment]
                                                    INNER JOIN
                                                        [dbo].[tblMonthLedger]
                                                            ON [tblMonthLedger].[LedgMonth] = [tblPayment].[ForMonth]
                                                               AND [tblMonthLedger].[Remarks] = [tblPayment].[Notes]
                                                               AND [tblMonthLedger].[TransactionID] = [tblPayment].[TranId]
                                                WHERE
                                                        [tblPayment].[TranId] = @TranID
                                                        AND [tblPayment].[Remarks] NOT IN (
                                                                                              'SECURITY DEPOSIT'
                                                                                          )
                                                        AND [tblPayment].[Notes] = 'SECURITY AND MAINTENANCE NET OF VAT'
                                                        AND ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                                            END


                                    END
                            END
                    END;


                IF @Mode = 'ADV'
                   AND @PaymentLevel = 'FIRST'
                    BEGIN
                        INSERT INTO [dbo].[tblRecieptReport]
                            (
                                [client_no],
                                [client_Name],
                                [client_Address],
                                [PR_No],
                                [OR_No],
                                [TIN_No],
                                [TransactionDate],
                                [AmountInWords],
                                [PaymentFor],      --PAYMENT DESCRIPTION
                                [TotalAmountInDigit],
                                [RENTAL],
                                [VAT],             --VAT AMOUNT
                                [VATPct],
                                [TOTAL],
                                [LESSWITHHOLDING], --TAX AMOUNT
                                [TOTALAMOUNTDUE],
                                [BANKNAME],
                                [PDCCHECKSERIALNO],
                                [USER],
                                [EncodedDate],
                                [TRANID],
                                [Mode],
                                [PaymentLevel],
                                [UnitNo],
                                [ProjectName],
                                [BankBranch],
                                [RENTAL_LESS_VAT],
                                [RENTAL_LESS_TAX]
                            )
                                    SELECT
                                        [CLIENT].[client_no]                                                                                               AS [client_no],
                                        [CLIENT].[client_Name]                                                                                             AS [client_Name],
                                        [CLIENT].[client_Address]                                                                                          AS [client_Address],
                                        [RECEIPT].[PR_No]                                                                                                  AS [PR_No],
                                        [RECEIPT].[OR_No]                                                                                                  AS [OR_No],
                                        [CLIENT].[TIN_No]                                                                                                  AS [TIN_No],
                                        [TRANSACTION].[TransactionDate]                                                                                    AS [TransactionDate],
                                        UPPER([dbo].[fnNumberToWordsWithDecimal](IIF(@IsFullPayment = 0,
                                                                                     [tblUnitReference].[AdvancePaymentAmount],
                                                                                     [tblUnitReference].[Total])
                                                                                )
                                             )                                                                                                             AS [AmountInWords],
                                        [PAYMENT].[PAYMENT_FOR]                                                                                            AS [PaymentFor],
                                        IIF(@IsFullPayment = 0,
                                            [tblUnitReference].[AdvancePaymentAmount],
                                            [tblUnitReference].[Total])                                                                                    AS [TotalAmountInDigit],
                                        IIF(@IsFullPayment = 0,
                                            [tblUnitReference].[AdvancePaymentAmount],
                                            [tblUnitReference].[Total])                                                                                    AS [RENTAL],
                                        CAST(([tblUnitReference].[Unit_BaseRentalVatAmount]
                                              + [tblUnitReference].[Unit_SecAndMainVatAmount]
                                             )
                                             * CAST([dbo].[fnGetAdvanceMonthCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150))   AS [VAT_AMOUNT],
                                        CAST([tblUnitReference].[Unit_Vat] AS VARCHAR(10)) + '% VAT'                                                       AS [VATPct],
                                        IIF(@IsFullPayment = 0,
                                            [tblUnitReference].[AdvancePaymentAmount],
                                            [tblUnitReference].[Total])                                                                                    AS [TOTAL],
                                        CAST([tblUnitReference].[Unit_BaseRentalTax]
                                             * CAST([dbo].[fnGetAdvanceMonthCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150))   AS [LESSWITHHOLDING],
                                        [tblUnitReference].[AdvancePaymentAmount]                                                                          AS [TOTALAMOUNTDUE],
                                        [RECEIPT].[BankName]                                                                                               AS [BANKNAME],
                                        [RECEIPT].[PDC_CHECK_SERIAL]                                                                                       AS [PDCCHECKSERIALNO],
                                        [TRANSACTION].[USER]                                                                                               AS [USER],
                                        GETDATE()                                                                                                          AS [EncodedDate],
                                        @TranID                                                                                                            AS [TRANID],
                                        @Mode                                                                                                              AS [Mode],
                                        @PaymentLevel                                                                                                      AS [PaymentLevel],
                                        [tblUnitReference].[UnitNo]                                                                                        AS [UnitNo],
                                        [dbo].[fnGetProjectNameById]([tblUnitReference].[ProjectId])                                                       AS [ProjectName],
                                        [RECEIPT].[BankBranch]                                                                                             AS [BankBranch],
                                        CAST(CAST(IIF(@IsFullPayment = 0,
                                                      IIF([tblUnitReference].[Unit_Tax] > 0,
                                                          ([tblUnitReference].[AdvancePaymentAmount]
                                                           + CAST([tblUnitReference].[Unit_BaseRentalTax]
                                                                  * [dbo].[fnGetAdvanceMonthCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2))
                                                          ),
                                                          [tblUnitReference].[AdvancePaymentAmount]),
                                                      [tblUnitReference].[Total]) AS DECIMAL(18, 2))
                                             - CAST(([dbo].[tblUnitReference].[Unit_BaseRentalVatAmount]
                                                     + [tblUnitReference].[Unit_SecAndMainVatAmount]
                                                    )
                                                    * [dbo].[fnGetAdvanceMonthCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150)) AS [RENTAL_LESS_VAT],
                                        CAST(IIF(@IsFullPayment = 0,
                                                 [tblUnitReference].[AdvancePaymentAmount],
                                                 [tblUnitReference].[Total]) AS VARCHAR(150))                                                              AS [RENTAL_LESS_TAX]
                                    FROM
                                        [dbo].[tblUnitReference]
                                        CROSS APPLY
                                        (
                                            SELECT
                                                [tblClientMstr].[ClientID]      AS [client_no],
                                                [tblClientMstr].[ClientName]    AS [client_Name],
                                                [tblClientMstr].[PostalAddress] AS [client_Address],
                                                [tblClientMstr].[TIN_No]        AS [TIN_No]
                                            FROM
                                                [dbo].[tblClientMstr]
                                            WHERE
                                                [tblClientMstr].[ClientID] = [tblUnitReference].[ClientID]
                                        ) [CLIENT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                [tblTransaction].[EncodedDate]                                   AS [TransactionDate],
                                                [tblTransaction].[TranID],
                                                ISNULL([dbo].[fn_GetUserName]([tblTransaction].[EncodedBy]), '') AS [USER],
                                                [tblTransaction].[ReceiveAmount]
                                            FROM
                                                [dbo].[tblTransaction]
                                            WHERE
                                                [tblUnitReference].[RefId] = [tblTransaction].[RefId]
                                        ) [TRANSACTION]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                [tblReceipt].[CompanyPRNo] AS [PR_No],
                                                [tblReceipt].[CompanyORNo] AS [OR_No],
                                                [tblReceipt].[Amount]      AS [TOTAL],
                                                [tblReceipt].[BankName]    AS [BankName],
                                                [tblReceipt].[BankBranch]  AS [BankBranch],
                                                [tblReceipt].[REF]         AS [PDC_CHECK_SERIAL],
                                                [tblReceipt].[TranId]
                                            FROM
                                                [dbo].[tblReceipt]
                                            WHERE
                                                [TRANSACTION].[TranID] = [tblReceipt].[TranId]
                                        ) [RECEIPT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                IIF(@IsFullPayment = 1, 'FULL PAYMENT', 'RENTAL FOR ' + @combinedString) AS [PAYMENT_FOR]
                                        ) [PAYMENT]
                                    WHERE
                                        [TRANSACTION].[TranID] = @TranID


                    END
                IF @Mode = 'SEC'
                   AND @PaymentLevel = 'FIRST'
                    BEGIN
                        INSERT INTO [dbo].[tblRecieptReport]
                            (
                                [client_no],
                                [client_Name],
                                [client_Address],
                                [PR_No],
                                [OR_No],
                                [TIN_No],
                                [TransactionDate],
                                [AmountInWords],
                                [PaymentFor],
                                [TotalAmountInDigit],
                                [RENTAL],
                                [VAT],
                                [VATPct],
                                [TOTAL],
                                [LESSWITHHOLDING],
                                [TOTALAMOUNTDUE],
                                [BANKNAME],
                                [PDCCHECKSERIALNO],
                                [USER],
                                [EncodedDate],
                                [TRANID],
                                [Mode],
                                [PaymentLevel],
                                [UnitNo],
                                [ProjectName],
                                [BankBranch],
                                [RENTAL_LESS_VAT],
                                [RENTAL_LESS_TAX]
                            )
                                    SELECT
                                        [CLIENT].[client_no]                                                                                                        AS [client_no],
                                        [CLIENT].[client_Name]                                                                                                      AS [client_Name],
                                        [CLIENT].[client_Address]                                                                                                   AS [client_Address],
                                        [RECEIPT].[PR_No]                                                                                                           AS [PR_No],
                                        [RECEIPT].[OR_No]                                                                                                           AS [OR_No],
                                        [CLIENT].[TIN_No]                                                                                                           AS [TIN_No],
                                        [TRANSACTION].[TransactionDate]                                                                                             AS [TransactionDate],
                                        UPPER([dbo].[fnNumberToWordsWithDecimal]([tblUnitReference].[SecDeposit]))                                                  AS [AmountInWords],
                                        [PAYMENT].[PAYMENT_FOR]                                                                                                     AS [PaymentFor],
                                        [tblUnitReference].[SecDeposit]                                                                                             AS [TotalAmountInDigit],
                                        [tblUnitReference].[SecDeposit]                                                                                             AS [RENTAL],
                                        CAST(CAST(([tblUnitReference].[Unit_BaseRentalVatAmount]
                                                   + [tblUnitReference].[Unit_SecAndMainVatAmount]
                                                  )
                                                  * [dbo].[fnGetTotalSecDepositAmountCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150))   AS [VAT],
                                        CAST([tblUnitReference].[Unit_Vat] AS VARCHAR(10)) + '% VAT'                                                                AS [VATPct],
                                        [tblUnitReference].[SecDeposit]                                                                                             AS [TOTAL],
                                        CAST(CAST([tblUnitReference].[Unit_TaxAmount]
                                                  * [dbo].[fnGetTotalSecDepositAmountCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150))   AS [LESSWITHHOLDING],
                                        [tblUnitReference].[SecDeposit]                                                                                             AS [TOTALAMOUNTDUE],
                                        [RECEIPT].[BankName]                                                                                                        AS [BANKNAME],
                                        [RECEIPT].[PDC_CHECK_SERIAL]                                                                                                AS [PDCCHECKSERIALNO],
                                        [TRANSACTION].[USER]                                                                                                        AS [USER],
                                        GETDATE()                                                                                                                   AS [EncodedDate],
                                        @TranID                                                                                                                     AS [TRANID],
                                        @Mode                                                                                                                       AS [Mode],
                                        @PaymentLevel                                                                                                               AS [PaymentLevel],
                                        [tblUnitReference].[UnitNo]                                                                                                 AS [UnitNo],
                                        [dbo].[fnGetProjectNameById]([tblUnitReference].[ProjectId])                                                                AS [ProjectName],
                                        [RECEIPT].[BankBranch]                                                                                                      AS [BankBranch],
                                        CAST(CAST(IIF([tblUnitReference].[Unit_Tax] > 0,
                                                      ([tblUnitReference].[SecDeposit]
                                                       + CAST([tblUnitReference].[Unit_BaseRentalTax]
                                                              * [dbo].[fnGetTotalSecDepositAmountCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2))
                                                      ),
                                                      0) AS DECIMAL(18, 2))
                                             - CAST(([tblUnitReference].[Unit_BaseRentalVatAmount]
                                                     + [tblUnitReference].[Unit_SecAndMainVatAmount]
                                                    )
                                                    * [dbo].[fnGetTotalSecDepositAmountCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150)) AS [RENTAL_LESS_VAT],
                                        CAST(CAST([tblUnitReference].[SecDeposit] AS DECIMAL(18, 2)) AS VARCHAR(150))                                               AS [RENTAL_LESS_TAX]
                                    FROM
                                        [dbo].[tblUnitReference]
                                        CROSS APPLY
                                        (
                                            SELECT
                                                [tblClientMstr].[ClientID]      AS [client_no],
                                                [tblClientMstr].[ClientName]    AS [client_Name],
                                                [tblClientMstr].[PostalAddress] AS [client_Address],
                                                [tblClientMstr].[TIN_No]        AS [TIN_No]
                                            FROM
                                                [dbo].[tblClientMstr]
                                            WHERE
                                                [tblClientMstr].[ClientID] = [tblUnitReference].[ClientID]
                                        ) [CLIENT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                [tblTransaction].[EncodedDate]                                   AS [TransactionDate],
                                                [tblTransaction].[TranID],
                                                ISNULL([dbo].[fn_GetUserName]([tblTransaction].[EncodedBy]), '') AS [USER],
                                                [tblTransaction].[ReceiveAmount]
                                            FROM
                                                [dbo].[tblTransaction]
                                            WHERE
                                                [tblUnitReference].[RefId] = [tblTransaction].[RefId]
                                        ) [TRANSACTION]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                [tblReceipt].[CompanyPRNo] AS [PR_No],
                                                [tblReceipt].[CompanyORNo] AS [OR_No],
                                                [tblReceipt].[Amount]      AS [TOTAL],
                                                [tblReceipt].[BankName]    AS [BankName],
                                                [tblReceipt].[BankBranch]  AS [BankBranch],
                                                [tblReceipt].[REF]         AS [PDC_CHECK_SERIAL],
                                                [tblReceipt].[TranId]
                                            FROM
                                                [dbo].[tblReceipt]
                                            WHERE
                                                [TRANSACTION].[TranID] = [tblReceipt].[TranId]
                                        ) [RECEIPT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                IIF(@IsFullPayment = 1, 'FULL PAYMENT', 'RENTAL FOR ' + @combinedString) AS [PAYMENT_FOR]
                                        ) [PAYMENT]
                                    WHERE
                                        [TRANSACTION].[TranID] = @TranID


                    END



                IF @Mode = 'REN'
                   AND @PaymentLevel = 'SECOND'
                    BEGIN
                        INSERT INTO [dbo].[tblRecieptReport]
                            (
                                [client_no],
                                [client_Name],
                                [client_Address],
                                [PR_No],
                                [OR_No],
                                [TIN_No],
                                [TransactionDate],
                                [AmountInWords],
                                [PaymentFor],
                                [TotalAmountInDigit],
                                [RENTAL],
                                [VAT],
                                [VATPct],
                                [TOTAL],
                                [LESSWITHHOLDING],
                                [TOTALAMOUNTDUE],
                                [BANKNAME],
                                [PDCCHECKSERIALNO],
                                [USER],
                                [EncodedDate],
                                [TRANID],
                                [Mode],
                                [PaymentLevel],
                                [UnitNo],
                                [ProjectName],
                                [BankBranch],
                                [RENTAL_LESS_VAT],
                                [RENTAL_LESS_TAX]
                            )
                                    SELECT
                                        [CLIENT].[client_no]                                                     AS [client_no],
                                        [CLIENT].[client_Name]                                                   AS [client_Name],
                                        [CLIENT].[client_Address]                                                AS [client_Address],
                                        [RECEIPT].[PR_No]                                                        AS [PR_No],
                                        [RECEIPT].[OR_No]                                                        AS [OR_No],
                                        [CLIENT].[TIN_No]                                                        AS [TIN_No],
                                        [TRANSACTION].[TransactionDate]                                          AS [TransactionDate],
                                        UPPER([dbo].[fnNumberToWordsWithDecimal]([TRANSACTION].[ReceiveAmount])) AS [AmountInWords],
                                        [PAYMENT].[PAYMENT_FOR]                                                  AS [PaymentFor],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [TotalAmountInDigit],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [RENTAL],
                                        CAST(CAST((([tblUnitReference].[Unit_Vat] * [TRANSACTION].[ReceiveAmount])
                                                   / 100
                                                  ) AS DECIMAL(18, 2)) AS VARCHAR(30))                           AS [VAT],
                                        CAST([tblUnitReference].[Unit_Vat] AS VARCHAR(10)) + '% VAT'             AS [VATPct],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [TOTAL],
                                        IIF([tblUnitReference].[Unit_Tax] > 0,
                                            CAST(CAST((([tblUnitReference].[Unit_Tax] * [TRANSACTION].[ReceiveAmount])
                                                       / 100
                                                      ) AS DECIMAL(18, 2)) AS VARCHAR(30)),
                                            '0.00')                                                              AS [LESSWITHHOLDING],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [TOTALAMOUNTDUE],
                                        [RECEIPT].[BankName]                                                     AS [BANKNAME],
                                        [RECEIPT].[PDC_CHECK_SERIAL]                                             AS [PDCCHECKSERIALNO],
                                        [TRANSACTION].[USER]                                                     AS [USER],
                                        GETDATE()                                                                AS [EncodedDate],
                                        @TranID                                                                  AS [TRANID],
                                        @Mode                                                                    AS [Mode],
                                        @PaymentLevel                                                            AS [PaymentLevel],
                                        [tblUnitReference].[UnitNo]                                              AS [UnitNo],
                                        [dbo].[fnGetProjectNameById]([tblUnitReference].[ProjectId])             AS [ProjectName],
                                        [RECEIPT].[BankBranch]                                                   AS [BankBranch],
                                        '0'                                                                      AS [RENTAL_LESS_VAT],
                                        '0'                                                                      AS [RENTAL_LESS_TAX]
                                    FROM
                                        [dbo].[tblUnitReference]
                                        CROSS APPLY
                                        (
                                            SELECT
                                                [tblClientMstr].[ClientID]      AS [client_no],
                                                [tblClientMstr].[ClientName]    AS [client_Name],
                                                [tblClientMstr].[PostalAddress] AS [client_Address],
                                                [tblClientMstr].[TIN_No]        AS [TIN_No]
                                            FROM
                                                [dbo].[tblClientMstr]
                                            WHERE
                                                [tblClientMstr].[ClientID] = [tblUnitReference].[ClientID]
                                        ) [CLIENT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                    [tblTransaction].[EncodedDate]                                   AS [TransactionDate],
                                                    [tblTransaction].[TranID],
                                                    ISNULL([dbo].[fn_GetUserName]([tblTransaction].[EncodedBy]), '') AS [USER],
                                                    SUM([tblPayment].[Amount])                                       AS [ReceiveAmount]
                                            FROM
                                                    [dbo].[tblTransaction]
                                                INNER JOIN
                                                    [dbo].[tblPayment]
                                                        ON [tblPayment].[TranId] = [tblTransaction].[TranID]
                                            WHERE
                                                    [tblUnitReference].[RefId] = [tblTransaction].[RefId]
                                                    AND [tblPayment].[Notes] = 'RENTAL NET OF VAT'
                                            GROUP BY
                                                    [tblTransaction].[EncodedDate],
                                                    [tblTransaction].[TranID],
                                                    [tblTransaction].[EncodedBy],
                                                    [tblPayment].[Amount]
                                        ) [TRANSACTION]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                [tblReceipt].[CompanyPRNo] AS [PR_No],
                                                [tblReceipt].[CompanyORNo] AS [OR_No],
                                                [tblReceipt].[Amount]      AS [TOTAL],
                                                [tblReceipt].[Amount]      AS [TotalAmountInDigit],
                                                [tblReceipt].[BankName]    AS [BankName],
                                                [tblReceipt].[BankBranch]  AS [BankBranch],
                                                [tblReceipt].[REF]         AS [PDC_CHECK_SERIAL],
                                                [tblReceipt].[TranId]
                                            FROM
                                                [dbo].[tblReceipt]
                                            WHERE
                                                [TRANSACTION].[TranID] = [tblReceipt].[TranId]
                                        ) [RECEIPT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                IIF(@IsFullPayment = 1, 'FULL PAYMENT', 'RENTAL FOR ' + @combinedString) AS [PAYMENT_FOR]
                                        ) [PAYMENT]
                                    WHERE
                                        [TRANSACTION].[TranID] = @TranID;
                    END
                IF @Mode = 'MAIN'
                   AND @PaymentLevel = 'SECOND'
                    BEGIN
                        INSERT INTO [dbo].[tblRecieptReport]
                            (
                                [client_no],
                                [client_Name],
                                [client_Address],
                                [PR_No],
                                [OR_No],
                                [TIN_No],
                                [TransactionDate],
                                [AmountInWords],
                                [PaymentFor],
                                [TotalAmountInDigit],
                                [RENTAL],
                                [VAT],
                                [VATPct],
                                [TOTAL],
                                [LESSWITHHOLDING],
                                [TOTALAMOUNTDUE],
                                [BANKNAME],
                                [PDCCHECKSERIALNO],
                                [USER],
                                [EncodedDate],
                                [TRANID],
                                [Mode],
                                [PaymentLevel],
                                [UnitNo],
                                [ProjectName],
                                [BankBranch],
                                [RENTAL_LESS_VAT],
                                [RENTAL_LESS_TAX]
                            )
                                    SELECT
                                        [CLIENT].[client_no]                                                     AS [client_no],
                                        [CLIENT].[client_Name]                                                   AS [client_Name],
                                        [CLIENT].[client_Address]                                                AS [client_Address],
                                        [RECEIPT].[PR_No]                                                        AS [PR_No],
                                        [RECEIPT].[OR_No]                                                        AS [OR_No],
                                        [CLIENT].[TIN_No]                                                        AS [TIN_No],
                                        [TRANSACTION].[TransactionDate]                                          AS [TransactionDate],
                                        UPPER([dbo].[fnNumberToWordsWithDecimal]([TRANSACTION].[ReceiveAmount])) AS [AmountInWords],
                                        [PAYMENT].[PAYMENT_FOR]                                                  AS [PaymentFor],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [TotalAmountInDigit],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [RENTAL],
                                        CAST(CAST((([tblUnitReference].[Unit_Vat] * [TRANSACTION].[ReceiveAmount])
                                                   / 100
                                                  ) AS DECIMAL(18, 2)) AS VARCHAR(30))                           AS [VAT], --TAX WILL FOLLOW
                                        CAST([tblUnitReference].[GenVat] AS VARCHAR(10)) + '% VAT'               AS [VATPct],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [TOTAL],
                                        IIF([tblUnitReference].[Unit_Tax] > 0,
                                            CAST(CAST((([tblUnitReference].[Unit_Tax] * [TRANSACTION].[ReceiveAmount])
                                                       / 100
                                                      ) AS DECIMAL(18, 2)) AS VARCHAR(30)),
                                            '0.00')                                                              AS [LESSWITHHOLDING],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [TOTALAMOUNTDUE],
                                        [RECEIPT].[BankName]                                                     AS [BANKNAME],
                                        [RECEIPT].[PDC_CHECK_SERIAL]                                             AS [PDCCHECKSERIALNO],
                                        [TRANSACTION].[USER]                                                     AS [USER],
                                        GETDATE()                                                                AS [EncodedDate],
                                        @TranID                                                                  AS [TRANID],
                                        @Mode                                                                    AS [Mode],
                                        @PaymentLevel                                                            AS [PaymentLevel],
                                        [tblUnitReference].[UnitNo]                                              AS [UnitNo],
                                        [dbo].[fnGetProjectNameById]([tblUnitReference].[ProjectId])             AS [ProjectName],
                                        [RECEIPT].[BankBranch]                                                   AS [BankBranch],
                                        '0'                                                                      AS [RENTAL_LESS_VAT],
                                        '0'                                                                      AS [RENTAL_LESS_TAX]
                                    FROM
                                        [dbo].[tblUnitReference]
                                        CROSS APPLY
                                        (
                                            SELECT
                                                [tblClientMstr].[ClientID]      AS [client_no],
                                                [tblClientMstr].[ClientName]    AS [client_Name],
                                                [tblClientMstr].[PostalAddress] AS [client_Address],
                                                [tblClientMstr].[TIN_No]        AS [TIN_No]
                                            FROM
                                                [dbo].[tblClientMstr]
                                            WHERE
                                                [tblClientMstr].[ClientID] = [tblUnitReference].[ClientID]
                                        ) [CLIENT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                    [tblTransaction].[EncodedDate]                                   AS [TransactionDate],
                                                    [tblTransaction].[TranID],
                                                    ISNULL([dbo].[fn_GetUserName]([tblTransaction].[EncodedBy]), '') AS [USER],
                                                    SUM([tblPayment].[Amount])                                       AS [ReceiveAmount]
                                            FROM
                                                    [dbo].[tblTransaction]
                                                INNER JOIN
                                                    [dbo].[tblPayment]
                                                        ON [tblPayment].[TranId] = [tblTransaction].[TranID]
                                            WHERE
                                                    [tblUnitReference].[RefId] = [tblTransaction].[RefId]
                                                    AND [tblPayment].[Notes] = 'SECURITY AND MAINTENANCE NET OF VAT'
                                            GROUP BY
                                                    [tblTransaction].[EncodedDate],
                                                    [tblTransaction].[TranID],
                                                    [tblTransaction].[EncodedBy],
                                                    [tblPayment].[Amount]
                                        ) [TRANSACTION]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                [tblReceipt].[CompanyPRNo] AS [PR_No],
                                                [tblReceipt].[CompanyORNo] AS [OR_No],
                                                [tblReceipt].[Amount]      AS [TOTAL],
                                                [tblReceipt].[Amount]      AS [TotalAmountInDigit],
                                                [tblReceipt].[BankName]    AS [BankName],
                                                [tblReceipt].[BankBranch]  AS [BankBranch],
                                                [tblReceipt].[REF]         AS [PDC_CHECK_SERIAL],
                                                [tblReceipt].[TranId]
                                            FROM
                                                [dbo].[tblReceipt]
                                            WHERE
                                                [TRANSACTION].[TranID] = [tblReceipt].[TranId]
                                        ) [RECEIPT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                IIF(@IsFullPayment = 1, 'FULL PAYMENT', 'RENTAL FOR ' + @combinedString) AS [PAYMENT_FOR]
                                        ) [PAYMENT]
                                    WHERE
                                        [TRANSACTION].[TranID] = @TranID;
                    END





            END


        SELECT TOP 1
               [tblRecieptReport].[client_no],
               [tblRecieptReport].[client_Name],
               [tblRecieptReport].[client_Address],
               [tblRecieptReport].[PR_No],
               [tblRecieptReport].[OR_No],
               [tblRecieptReport].[TIN_No],
               [tblRecieptReport].[TransactionDate],
               [tblRecieptReport].[AmountInWords],
               [tblRecieptReport].[PaymentFor],
               --FORMAT(CAST([#TMP].[TotalAmountInDigit] AS DECIMAL(18, 2)), 'C', 'en-PH') AS [TotalAmountInDigit],
               FORMAT(CAST([tblRecieptReport].[TotalAmountInDigit] AS DECIMAL(18, 2)), 'N')      AS [TotalAmountInDigit],
               --FORMAT(CAST([#TMP].[RENTAL] AS DECIMAL(18, 2)), 'C', 'en-PH') AS [RENTAL],
               FORMAT(CAST([tblRecieptReport].[RENTAL] AS DECIMAL(18, 2)), 'C', 'en-PH')         AS [RENTAL],
               FORMAT(CAST([tblRecieptReport].[VAT] AS DECIMAL(18, 2)), 'C', 'en-PH')            AS [VAT],
               [tblRecieptReport].[VATPct],
               FORMAT(CAST([tblRecieptReport].[RENTAL] AS DECIMAL(18, 2)), 'C', 'en-PH')         AS [TOTAL],
               --FORMAT(CAST([tblRecieptReport].[LESSWITHHOLDING] AS DECIMAL(18, 2)), 'C', 'en-PH') AS [LESSWITHHOLDING],
               CAST(CAST('0.00' AS DECIMAL(18, 2)) AS VARCHAR(50)) + ' %'                        AS [LESSWITHHOLDING],
               --[#TMP].[LESSWITHHOLDING] AS [LESSWITHHOLDING],
               FORMAT(CAST([tblRecieptReport].[TOTALAMOUNTDUE] AS DECIMAL(18, 2)), 'C', 'en-PH') AS [TOTALAMOUNTDUE],
               [tblRecieptReport].[BANKNAME],
               [tblRecieptReport].[PDCCHECKSERIALNO],
               [tblRecieptReport].[USER],
               [tblRecieptReport].[Mode],
               [tblRecieptReport].[UnitNo],
               [tblRecieptReport].[ProjectName],
               [tblRecieptReport].[BankBranch],
               ''                                                                                AS [BankCheckDate],
               ''                                                                                AS [BankCheckAmount],
               [tblRecieptReport].[RENTAL_LESS_VAT],
               [tblRecieptReport].[RENTAL_LESS_TAX]
        FROM
               [dbo].[tblRecieptReport]
        WHERE
               [tblRecieptReport].[TRANID] = @TranID
               AND [tblRecieptReport].[Mode] = @Mode
               AND [tblRecieptReport].[PaymentLevel] = @PaymentLevel
        ORDER BY
               [tblRecieptReport].[EncodedDate]

    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Ongching_OR_Report]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_Ongching_OR_Report]
    @TranID VARCHAR(20) = NULL,
    @Mode VARCHAR(50) = NULL,
    @PaymentLevel VARCHAR(50) = NULL
AS
  BEGIN
        SET NOCOUNT ON;


        DECLARE @combinedString VARCHAR(MAX);
        DECLARE @IsFullPayment BIT = 0;
        DECLARE @RefId VARCHAR(100) = '';


        IF NOT EXISTS
            (
                SELECT
                    1
                FROM
                    [dbo].[tblRecieptReport]
                WHERE
                    [tblRecieptReport].[TRANID] = @TranID
                    AND [tblRecieptReport].[Mode] = @Mode
                    AND [tblRecieptReport].[PaymentLevel] = @PaymentLevel
            )
            BEGIN
                SELECT
                    @IsFullPayment = ISNULL([tblUnitReference].[IsFullPayment], 0),
                    @RefId         = [tblUnitReference].[RefId]
                FROM
                    [dbo].[tblUnitReference]
                WHERE
                    [tblUnitReference].[RefId] =
                    (
                        SELECT TOP 1
                               [tblTransaction].[RefId]
                        FROM
                               [dbo].[tblTransaction]
                        WHERE
                               [tblTransaction].[TranID] = @TranID
                    );

                IF @IsFullPayment = 0
                    BEGIN
                        IF
                            (
                                SELECT
                                    COUNT(*)
                                FROM
                                    [dbo].[tblPayment]
                                WHERE
                                    [tblPayment].[TranId] = @TranID
                                    AND [tblPayment].[Remarks] NOT IN (
                                                                          'SECURITY DEPOSIT'
                                                                      )
                            ) > 5
                            BEGIN
                                IF @Mode = 'REN'
                                   AND @PaymentLevel = 'SECOND'
                                    BEGIN
                                        SELECT
                                            @combinedString
                                            =
                                            (
                                                SELECT  TOP 1
                                                        UPPER(DATENAME(MONTH, MIN([tblPayment].[ForMonth]))) + ' '
                                                        + CAST(YEAR(MIN([tblPayment].[ForMonth])) AS VARCHAR(4))
                                                FROM
                                                        [dbo].[tblPayment]
                                                    INNER JOIN
                                                        [dbo].[tblMonthLedger]
                                                            ON [tblMonthLedger].[LedgMonth] = [tblPayment].[ForMonth]
                                                               AND [tblMonthLedger].[Remarks] = [tblPayment].[Notes]
                                                               AND [tblMonthLedger].[TransactionID] = [tblPayment].[TranId]
                                                WHERE
                                                        [tblPayment].[TranId] = @TranID
                                                        AND [tblPayment].[Remarks] NOT IN (
                                                                                              'SECURITY DEPOSIT'
                                                                                          )
                                                        AND [tblPayment].[Notes] = 'RENTAL NET OF VAT'
                                                        AND ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                                            ) + ' TO '
                                            +
                                            (
                                                SELECT  TOP 1
                                                        UPPER(DATENAME(MONTH, MAX([tblPayment].[ForMonth]))) + ' '
                                                        + CAST(YEAR(MAX([tblPayment].[ForMonth])) AS VARCHAR(4))
                                                FROM
                                                        [dbo].[tblPayment]
                                                    INNER JOIN
                                                        [dbo].[tblMonthLedger]
                                                            ON [tblMonthLedger].[LedgMonth] = [tblPayment].[ForMonth]
                                                               AND [tblMonthLedger].[Remarks] = [tblPayment].[Notes]
                                                               AND [tblMonthLedger].[TransactionID] = [tblPayment].[TranId]
                                                WHERE
                                                        [tblPayment].[TranId] = @TranID
                                                        AND [tblPayment].[Remarks] NOT IN (
                                                                                              'SECURITY DEPOSIT'
                                                                                          )
                                                        AND [tblPayment].[Notes] = 'RENTAL NET OF VAT'
                                                        AND ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                                            )
                                    END

                                IF @Mode = 'MAIN'
                                   AND @PaymentLevel = 'SECOND'
                                    BEGIN

                                        SELECT
                                            @combinedString
                                            =
                                            (
                                                SELECT  TOP 1
                                                        UPPER(DATENAME(MONTH, MIN([tblPayment].[ForMonth]))) + ' '
                                                        + CAST(YEAR(MIN([tblPayment].[ForMonth])) AS VARCHAR(4))
                                                FROM
                                                        [dbo].[tblPayment]
                                                    INNER JOIN
                                                        [dbo].[tblMonthLedger]
                                                            ON [tblMonthLedger].[LedgMonth] = [tblPayment].[ForMonth]
                                                               AND [tblMonthLedger].[Remarks] = [tblPayment].[Notes]
                                                               AND [tblMonthLedger].[TransactionID] = [tblPayment].[TranId]
                                                WHERE
                                                        [tblPayment].[TranId] = @TranID
                                                        AND [tblPayment].[Remarks] NOT IN (
                                                                                              'SECURITY DEPOSIT'
                                                                                          )
                                                        AND [tblPayment].[Notes] = 'SECURITY AND MAINTENANCE NET OF VAT'
                                                        AND ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                                            ) + ' TO '
                                            +
                                            (
                                                SELECT  TOP 1
                                                        UPPER(DATENAME(MONTH, MAX([tblPayment].[ForMonth]))) + ' '
                                                        + CAST(YEAR(MAX([tblPayment].[ForMonth])) AS VARCHAR(4))
                                                FROM
                                                        [dbo].[tblPayment]
                                                    INNER JOIN
                                                        [dbo].[tblMonthLedger]
                                                            ON [tblMonthLedger].[LedgMonth] = [tblPayment].[ForMonth]
                                                               AND [tblMonthLedger].[Remarks] = [tblPayment].[Notes]
                                                               AND [tblMonthLedger].[TransactionID] = [tblPayment].[TranId]
                                                WHERE
                                                        [tblPayment].[TranId] = @TranID
                                                        AND [tblPayment].[Remarks] NOT IN (
                                                                                              'SECURITY DEPOSIT'
                                                                                          )
                                                        AND [tblPayment].[Notes] = 'SECURITY AND MAINTENANCE NET OF VAT'
                                                        AND ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                                            )
                                    END

                            END
                        ELSE
                            BEGIN
                                IF @Mode = 'SEC'
                                   AND @PaymentLevel = 'FIRST'
                                    BEGIN
                                        SELECT
                                            @combinedString
                                            = '('
                                              + CAST(CAST([dbo].[fnGetTotalSecDepositAmountCount](@RefId) AS INT) AS VARCHAR(50))
                                              + ')MONTH-SECURITY DEPOSIT'

                                    END
                                ELSE IF @Mode = 'ADV'
                                        AND @PaymentLevel = 'FIRST'
                                    BEGIN
                                        --SELECT @combinedString = 'ADVANCE PAYMENT'
                                        BEGIN
                                            SELECT
                                                @combinedString
                                                = COALESCE(@combinedString + '-', '')
                                                  + UPPER(DATENAME(MONTH, [tblPayment].[ForMonth])) + ' '
                                                  + CAST(YEAR([tblPayment].[ForMonth]) AS VARCHAR(4))
                                            FROM
                                                [dbo].[tblPayment]
                                            WHERE
                                                [tblPayment].[TranId] = @TranID
                                                AND [tblPayment].[Remarks] = 'MONTHS ADVANCE'
                                                AND ISNULL([tblPayment].[Notes], '') = ''


                                        END
                                    END
                                ELSE
                                    BEGIN

                                        IF @Mode = 'REN'
                                           AND @PaymentLevel = 'SECOND'
                                            BEGIN
                                                SELECT
                                                        @combinedString
                                                    = COALESCE(@combinedString + '-', '')
                                                      + UPPER(DATENAME(MONTH, [tblPayment].[ForMonth])) + ' '
                                                      + CAST(YEAR([tblPayment].[ForMonth]) AS VARCHAR(4))
                                                      + IIF(ISNULL([tblMonthLedger].[IsHold], 0) = 1, '(PARTIAL)', '')
                                                FROM
                                                        [dbo].[tblPayment]
                                                    INNER JOIN
                                                        [dbo].[tblMonthLedger]
                                                            ON [tblMonthLedger].[LedgMonth] = [tblPayment].[ForMonth]
                                                               AND [tblMonthLedger].[Remarks] = [tblPayment].[Notes]
                                                               AND [tblMonthLedger].[TransactionID] = [tblPayment].[TranId]
                                                WHERE
                                                        [tblPayment].[TranId] = @TranID
                                                        AND [tblPayment].[Remarks] NOT IN (
                                                                                              'SECURITY DEPOSIT'
                                                                                          )
                                                        AND [tblPayment].[Notes] = 'RENTAL NET OF VAT'
                                                        AND ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                                            END
                                        IF @Mode = 'MAIN'
                                           AND @PaymentLevel = 'SECOND'
                                            BEGIN
                                                SELECT
                                                        @combinedString
                                                    = COALESCE(@combinedString + '-', '')
                                                      + UPPER(DATENAME(MONTH, [tblPayment].[ForMonth])) + ' '
                                                      + CAST(YEAR([tblPayment].[ForMonth]) AS VARCHAR(4))
                                                      + IIF(ISNULL([tblMonthLedger].[IsHold], 0) = 1, '(PARTIAL)', '')
                                                FROM
                                                        [dbo].[tblPayment]
                                                    INNER JOIN
                                                        [dbo].[tblMonthLedger]
                                                            ON [tblMonthLedger].[LedgMonth] = [tblPayment].[ForMonth]
                                                               AND [tblMonthLedger].[Remarks] = [tblPayment].[Notes]
                                                               AND [tblMonthLedger].[TransactionID] = [tblPayment].[TranId]
                                                WHERE
                                                        [tblPayment].[TranId] = @TranID
                                                        AND [tblPayment].[Remarks] NOT IN (
                                                                                              'SECURITY DEPOSIT'
                                                                                          )
                                                        AND [tblPayment].[Notes] = 'SECURITY AND MAINTENANCE NET OF VAT'
                                                        AND ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                                            END


                                    END
                            END
                    END;


                IF @Mode = 'ADV'
                   AND @PaymentLevel = 'FIRST'
                    BEGIN
                        INSERT INTO [dbo].[tblRecieptReport]
                            (
                                [client_no],
                                [client_Name],
                                [client_Address],
                                [PR_No],
                                [OR_No],
                                [TIN_No],
                                [TransactionDate],
                                [AmountInWords],
                                [PaymentFor],      --PAYMENT DESCRIPTION
                                [TotalAmountInDigit],
                                [RENTAL],
                                [VAT],             --VAT AMOUNT
                                [VATPct],
                                [TOTAL],
                                [LESSWITHHOLDING], --TAX AMOUNT
                                [TOTALAMOUNTDUE],
                                [BANKNAME],
                                [PDCCHECKSERIALNO],
                                [USER],
                                [EncodedDate],
                                [TRANID],
                                [Mode],
                                [PaymentLevel],
                                [UnitNo],
                                [ProjectName],
                                [BankBranch],
                                [RENTAL_LESS_VAT],
                                [RENTAL_LESS_TAX]
                            )
                                    SELECT
                                        [CLIENT].[client_no]                                                                                               AS [client_no],
                                        [CLIENT].[client_Name]                                                                                             AS [client_Name],
                                        [CLIENT].[client_Address]                                                                                          AS [client_Address],
                                        [RECEIPT].[PR_No]                                                                                                  AS [PR_No],
                                        [RECEIPT].[OR_No]                                                                                                  AS [OR_No],
                                        [CLIENT].[TIN_No]                                                                                                  AS [TIN_No],
                                        [TRANSACTION].[TransactionDate]                                                                                    AS [TransactionDate],
                                        UPPER([dbo].[fnNumberToWordsWithDecimal](IIF(@IsFullPayment = 0,
                                                                                     [tblUnitReference].[AdvancePaymentAmount],
                                                                                     [tblUnitReference].[Total])
                                                                                )
                                             )                                                                                                             AS [AmountInWords],
                                        [PAYMENT].[PAYMENT_FOR]                                                                                            AS [PaymentFor],
                                        IIF(@IsFullPayment = 0,
                                            [tblUnitReference].[AdvancePaymentAmount],
                                            [tblUnitReference].[Total])                                                                                    AS [TotalAmountInDigit],
                                        IIF(@IsFullPayment = 0,
                                            [tblUnitReference].[AdvancePaymentAmount],
                                            [tblUnitReference].[Total])                                                                                    AS [RENTAL],
                                        CAST(([tblUnitReference].[Unit_BaseRentalVatAmount]
                                              + [tblUnitReference].[Unit_SecAndMainVatAmount]
                                             )
                                             * CAST([dbo].[fnGetAdvanceMonthCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150))   AS [VAT_AMOUNT],
                                        CAST([tblUnitReference].[Unit_Vat] AS VARCHAR(10)) + '% VAT'                                                       AS [VATPct],
                                        IIF(@IsFullPayment = 0,
                                            [tblUnitReference].[AdvancePaymentAmount],
                                            [tblUnitReference].[Total])                                                                                    AS [TOTAL],
                                        CAST([tblUnitReference].[Unit_BaseRentalTax]
                                             * CAST([dbo].[fnGetAdvanceMonthCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150))   AS [LESSWITHHOLDING],
                                        [tblUnitReference].[AdvancePaymentAmount]                                                                          AS [TOTALAMOUNTDUE],
                                        [RECEIPT].[BankName]                                                                                               AS [BANKNAME],
                                        [RECEIPT].[PDC_CHECK_SERIAL]                                                                                       AS [PDCCHECKSERIALNO],
                                        [TRANSACTION].[USER]                                                                                               AS [USER],
                                        GETDATE()                                                                                                          AS [EncodedDate],
                                        @TranID                                                                                                            AS [TRANID],
                                        @Mode                                                                                                              AS [Mode],
                                        @PaymentLevel                                                                                                      AS [PaymentLevel],
                                        [tblUnitReference].[UnitNo]                                                                                        AS [UnitNo],
                                        [dbo].[fnGetProjectNameById]([tblUnitReference].[ProjectId])                                                       AS [ProjectName],
                                        [RECEIPT].[BankBranch]                                                                                             AS [BankBranch],
                                        CAST(CAST(IIF(@IsFullPayment = 0,
                                                      IIF([tblUnitReference].[Unit_Tax] > 0,
                                                          ([tblUnitReference].[AdvancePaymentAmount]
                                                           + CAST([tblUnitReference].[Unit_BaseRentalTax]
                                                                  * [dbo].[fnGetAdvanceMonthCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2))
                                                          ),
                                                          [tblUnitReference].[AdvancePaymentAmount]),
                                                      [tblUnitReference].[Total]) AS DECIMAL(18, 2))
                                             - CAST(([dbo].[tblUnitReference].[Unit_BaseRentalVatAmount]
                                                     + [tblUnitReference].[Unit_SecAndMainVatAmount]
                                                    )
                                                    * [dbo].[fnGetAdvanceMonthCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150)) AS [RENTAL_LESS_VAT],
                                        CAST(IIF(@IsFullPayment = 0,
                                                 [tblUnitReference].[AdvancePaymentAmount],
                                                 [tblUnitReference].[Total]) AS VARCHAR(150))                                                              AS [RENTAL_LESS_TAX]
                                    FROM
                                        [dbo].[tblUnitReference]
                                        CROSS APPLY
                                        (
                                            SELECT
                                                [tblClientMstr].[ClientID]      AS [client_no],
                                                [tblClientMstr].[ClientName]    AS [client_Name],
                                                [tblClientMstr].[PostalAddress] AS [client_Address],
                                                [tblClientMstr].[TIN_No]        AS [TIN_No]
                                            FROM
                                                [dbo].[tblClientMstr]
                                            WHERE
                                                [tblClientMstr].[ClientID] = [tblUnitReference].[ClientID]
                                        ) [CLIENT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                [tblTransaction].[EncodedDate]                                   AS [TransactionDate],
                                                [tblTransaction].[TranID],
                                                ISNULL([dbo].[fn_GetUserName]([tblTransaction].[EncodedBy]), '') AS [USER],
                                                [tblTransaction].[ReceiveAmount]
                                            FROM
                                                [dbo].[tblTransaction]
                                            WHERE
                                                [tblUnitReference].[RefId] = [tblTransaction].[RefId]
                                        ) [TRANSACTION]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                [tblReceipt].[CompanyPRNo] AS [PR_No],
                                                [tblReceipt].[CompanyORNo] AS [OR_No],
                                                [tblReceipt].[Amount]      AS [TOTAL],
                                                [tblReceipt].[BankName]    AS [BankName],
                                                [tblReceipt].[BankBranch]  AS [BankBranch],
                                                [tblReceipt].[REF]         AS [PDC_CHECK_SERIAL],
                                                [tblReceipt].[TranId]
                                            FROM
                                                [dbo].[tblReceipt]
                                            WHERE
                                                [TRANSACTION].[TranID] = [tblReceipt].[TranId]
                                        ) [RECEIPT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                IIF(@IsFullPayment = 1, 'FULL PAYMENT', 'RENTAL FOR ' + @combinedString) AS [PAYMENT_FOR]
                                        ) [PAYMENT]
                                    WHERE
                                        [TRANSACTION].[TranID] = @TranID


                    END
                IF @Mode = 'SEC'
                   AND @PaymentLevel = 'FIRST'
                    BEGIN
                        INSERT INTO [dbo].[tblRecieptReport]
                            (
                                [client_no],
                                [client_Name],
                                [client_Address],
                                [PR_No],
                                [OR_No],
                                [TIN_No],
                                [TransactionDate],
                                [AmountInWords],
                                [PaymentFor],
                                [TotalAmountInDigit],
                                [RENTAL],
                                [VAT],
                                [VATPct],
                                [TOTAL],
                                [LESSWITHHOLDING],
                                [TOTALAMOUNTDUE],
                                [BANKNAME],
                                [PDCCHECKSERIALNO],
                                [USER],
                                [EncodedDate],
                                [TRANID],
                                [Mode],
                                [PaymentLevel],
                                [UnitNo],
                                [ProjectName],
                                [BankBranch],
                                [RENTAL_LESS_VAT],
                                [RENTAL_LESS_TAX]
                            )
                                    SELECT
                                        [CLIENT].[client_no]                                                                                                        AS [client_no],
                                        [CLIENT].[client_Name]                                                                                                      AS [client_Name],
                                        [CLIENT].[client_Address]                                                                                                   AS [client_Address],
                                        [RECEIPT].[PR_No]                                                                                                           AS [PR_No],
                                        [RECEIPT].[OR_No]                                                                                                           AS [OR_No],
                                        [CLIENT].[TIN_No]                                                                                                           AS [TIN_No],
                                        [TRANSACTION].[TransactionDate]                                                                                             AS [TransactionDate],
                                        UPPER([dbo].[fnNumberToWordsWithDecimal]([tblUnitReference].[SecDeposit]))                                                  AS [AmountInWords],
                                        [PAYMENT].[PAYMENT_FOR]                                                                                                     AS [PaymentFor],
                                        [tblUnitReference].[SecDeposit]                                                                                             AS [TotalAmountInDigit],
                                        [tblUnitReference].[SecDeposit]                                                                                             AS [RENTAL],
                                        CAST(CAST(([tblUnitReference].[Unit_BaseRentalVatAmount]
                                                   + [tblUnitReference].[Unit_SecAndMainVatAmount]
                                                  )
                                                  * [dbo].[fnGetTotalSecDepositAmountCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150))   AS [VAT],
                                        CAST([tblUnitReference].[Unit_Vat] AS VARCHAR(10)) + '% VAT'                                                                AS [VATPct],
                                        [tblUnitReference].[SecDeposit]                                                                                             AS [TOTAL],
                                        CAST(CAST([tblUnitReference].[Unit_TaxAmount]
                                                  * [dbo].[fnGetTotalSecDepositAmountCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150))   AS [LESSWITHHOLDING],
                                        [tblUnitReference].[SecDeposit]                                                                                             AS [TOTALAMOUNTDUE],
                                        [RECEIPT].[BankName]                                                                                                        AS [BANKNAME],
                                        [RECEIPT].[PDC_CHECK_SERIAL]                                                                                                AS [PDCCHECKSERIALNO],
                                        [TRANSACTION].[USER]                                                                                                        AS [USER],
                                        GETDATE()                                                                                                                   AS [EncodedDate],
                                        @TranID                                                                                                                     AS [TRANID],
                                        @Mode                                                                                                                       AS [Mode],
                                        @PaymentLevel                                                                                                               AS [PaymentLevel],
                                        [tblUnitReference].[UnitNo]                                                                                                 AS [UnitNo],
                                        [dbo].[fnGetProjectNameById]([tblUnitReference].[ProjectId])                                                                AS [ProjectName],
                                        [RECEIPT].[BankBranch]                                                                                                      AS [BankBranch],
                                        CAST(CAST(IIF([tblUnitReference].[Unit_Tax] > 0,
                                                      ([tblUnitReference].[SecDeposit]
                                                       + CAST([tblUnitReference].[Unit_BaseRentalTax]
                                                              * [dbo].[fnGetTotalSecDepositAmountCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2))
                                                      ),
                                                      0) AS DECIMAL(18, 2))
                                             - CAST(([tblUnitReference].[Unit_BaseRentalVatAmount]
                                                     + [tblUnitReference].[Unit_SecAndMainVatAmount]
                                                    )
                                                    * [dbo].[fnGetTotalSecDepositAmountCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150)) AS [RENTAL_LESS_VAT],
                                        CAST(CAST([tblUnitReference].[SecDeposit] AS DECIMAL(18, 2)) AS VARCHAR(150))                                               AS [RENTAL_LESS_TAX]
                                    FROM
                                        [dbo].[tblUnitReference]
                                        CROSS APPLY
                                        (
                                            SELECT
                                                [tblClientMstr].[ClientID]      AS [client_no],
                                                [tblClientMstr].[ClientName]    AS [client_Name],
                                                [tblClientMstr].[PostalAddress] AS [client_Address],
                                                [tblClientMstr].[TIN_No]        AS [TIN_No]
                                            FROM
                                                [dbo].[tblClientMstr]
                                            WHERE
                                                [tblClientMstr].[ClientID] = [tblUnitReference].[ClientID]
                                        ) [CLIENT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                [tblTransaction].[EncodedDate]                                   AS [TransactionDate],
                                                [tblTransaction].[TranID],
                                                ISNULL([dbo].[fn_GetUserName]([tblTransaction].[EncodedBy]), '') AS [USER],
                                                [tblTransaction].[ReceiveAmount]
                                            FROM
                                                [dbo].[tblTransaction]
                                            WHERE
                                                [tblUnitReference].[RefId] = [tblTransaction].[RefId]
                                        ) [TRANSACTION]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                [tblReceipt].[CompanyPRNo] AS [PR_No],
                                                [tblReceipt].[CompanyORNo] AS [OR_No],
                                                [tblReceipt].[Amount]      AS [TOTAL],
                                                [tblReceipt].[BankName]    AS [BankName],
                                                [tblReceipt].[BankBranch]  AS [BankBranch],
                                                [tblReceipt].[REF]         AS [PDC_CHECK_SERIAL],
                                                [tblReceipt].[TranId]
                                            FROM
                                                [dbo].[tblReceipt]
                                            WHERE
                                                [TRANSACTION].[TranID] = [tblReceipt].[TranId]
                                        ) [RECEIPT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                IIF(@IsFullPayment = 1, 'FULL PAYMENT', 'RENTAL FOR ' + @combinedString) AS [PAYMENT_FOR]
                                        ) [PAYMENT]
                                    WHERE
                                        [TRANSACTION].[TranID] = @TranID


                    END



                IF @Mode = 'REN'
                   AND @PaymentLevel = 'SECOND'
                    BEGIN
                        INSERT INTO [dbo].[tblRecieptReport]
                            (
                                [client_no],
                                [client_Name],
                                [client_Address],
                                [PR_No],
                                [OR_No],
                                [TIN_No],
                                [TransactionDate],
                                [AmountInWords],
                                [PaymentFor],
                                [TotalAmountInDigit],
                                [RENTAL],
                                [VAT],
                                [VATPct],
                                [TOTAL],
                                [LESSWITHHOLDING],
                                [TOTALAMOUNTDUE],
                                [BANKNAME],
                                [PDCCHECKSERIALNO],
                                [USER],
                                [EncodedDate],
                                [TRANID],
                                [Mode],
                                [PaymentLevel],
                                [UnitNo],
                                [ProjectName],
                                [BankBranch],
                                [RENTAL_LESS_VAT],
                                [RENTAL_LESS_TAX]
                            )
                                    SELECT
                                        [CLIENT].[client_no]                                                     AS [client_no],
                                        [CLIENT].[client_Name]                                                   AS [client_Name],
                                        [CLIENT].[client_Address]                                                AS [client_Address],
                                        [RECEIPT].[PR_No]                                                        AS [PR_No],
                                        [RECEIPT].[OR_No]                                                        AS [OR_No],
                                        [CLIENT].[TIN_No]                                                        AS [TIN_No],
                                        [TRANSACTION].[TransactionDate]                                          AS [TransactionDate],
                                        UPPER([dbo].[fnNumberToWordsWithDecimal]([TRANSACTION].[ReceiveAmount])) AS [AmountInWords],
                                        [PAYMENT].[PAYMENT_FOR]                                                  AS [PaymentFor],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [TotalAmountInDigit],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [RENTAL],
                                        CAST(CAST((([tblUnitReference].[Unit_Vat] * [TRANSACTION].[ReceiveAmount])
                                                   / 100
                                                  ) AS DECIMAL(18, 2)) AS VARCHAR(30))                           AS [VAT],
                                        CAST([tblUnitReference].[Unit_Vat] AS VARCHAR(10)) + '% VAT'             AS [VATPct],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [TOTAL],
                                        IIF([tblUnitReference].[Unit_Tax] > 0,
                                            CAST(CAST((([tblUnitReference].[Unit_Tax] * [TRANSACTION].[ReceiveAmount])
                                                       / 100
                                                      ) AS DECIMAL(18, 2)) AS VARCHAR(30)),
                                            '0.00')                                                              AS [LESSWITHHOLDING],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [TOTALAMOUNTDUE],
                                        [RECEIPT].[BankName]                                                     AS [BANKNAME],
                                        [RECEIPT].[PDC_CHECK_SERIAL]                                             AS [PDCCHECKSERIALNO],
                                        [TRANSACTION].[USER]                                                     AS [USER],
                                        GETDATE()                                                                AS [EncodedDate],
                                        @TranID                                                                  AS [TRANID],
                                        @Mode                                                                    AS [Mode],
                                        @PaymentLevel                                                            AS [PaymentLevel],
                                        [tblUnitReference].[UnitNo]                                              AS [UnitNo],
                                        [dbo].[fnGetProjectNameById]([tblUnitReference].[ProjectId])             AS [ProjectName],
                                        [RECEIPT].[BankBranch]                                                   AS [BankBranch],
                                        '0'                                                                      AS [RENTAL_LESS_VAT],
                                        '0'                                                                      AS [RENTAL_LESS_TAX]
                                    FROM
                                        [dbo].[tblUnitReference]
                                        CROSS APPLY
                                        (
                                            SELECT
                                                [tblClientMstr].[ClientID]      AS [client_no],
                                                [tblClientMstr].[ClientName]    AS [client_Name],
                                                [tblClientMstr].[PostalAddress] AS [client_Address],
                                                [tblClientMstr].[TIN_No]        AS [TIN_No]
                                            FROM
                                                [dbo].[tblClientMstr]
                                            WHERE
                                                [tblClientMstr].[ClientID] = [tblUnitReference].[ClientID]
                                        ) [CLIENT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                    [tblTransaction].[EncodedDate]                                   AS [TransactionDate],
                                                    [tblTransaction].[TranID],
                                                    ISNULL([dbo].[fn_GetUserName]([tblTransaction].[EncodedBy]), '') AS [USER],
                                                    SUM([tblPayment].[Amount])                                       AS [ReceiveAmount]
                                            FROM
                                                    [dbo].[tblTransaction]
                                                INNER JOIN
                                                    [dbo].[tblPayment]
                                                        ON [tblPayment].[TranId] = [tblTransaction].[TranID]
                                            WHERE
                                                    [tblUnitReference].[RefId] = [tblTransaction].[RefId]
                                                    AND [tblPayment].[Notes] = 'RENTAL NET OF VAT'
                                            GROUP BY
                                                    [tblTransaction].[EncodedDate],
                                                    [tblTransaction].[TranID],
                                                    [tblTransaction].[EncodedBy],
                                                    [tblPayment].[Amount]
                                        ) [TRANSACTION]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                [tblReceipt].[CompanyPRNo] AS [PR_No],
                                                [tblReceipt].[CompanyORNo] AS [OR_No],
                                                [tblReceipt].[Amount]      AS [TOTAL],
                                                [tblReceipt].[Amount]      AS [TotalAmountInDigit],
                                                [tblReceipt].[BankName]    AS [BankName],
                                                [tblReceipt].[BankBranch]  AS [BankBranch],
                                                [tblReceipt].[REF]         AS [PDC_CHECK_SERIAL],
                                                [tblReceipt].[TranId]
                                            FROM
                                                [dbo].[tblReceipt]
                                            WHERE
                                                [TRANSACTION].[TranID] = [tblReceipt].[TranId]
                                        ) [RECEIPT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                IIF(@IsFullPayment = 1, 'FULL PAYMENT', 'RENTAL FOR ' + @combinedString) AS [PAYMENT_FOR]
                                        ) [PAYMENT]
                                    WHERE
                                        [TRANSACTION].[TranID] = @TranID;
                    END
                IF @Mode = 'MAIN'
                   AND @PaymentLevel = 'SECOND'
                    BEGIN
                        INSERT INTO [dbo].[tblRecieptReport]
                            (
                                [client_no],
                                [client_Name],
                                [client_Address],
                                [PR_No],
                                [OR_No],
                                [TIN_No],
                                [TransactionDate],
                                [AmountInWords],
                                [PaymentFor],
                                [TotalAmountInDigit],
                                [RENTAL],
                                [VAT],
                                [VATPct],
                                [TOTAL],
                                [LESSWITHHOLDING],
                                [TOTALAMOUNTDUE],
                                [BANKNAME],
                                [PDCCHECKSERIALNO],
                                [USER],
                                [EncodedDate],
                                [TRANID],
                                [Mode],
                                [PaymentLevel],
                                [UnitNo],
                                [ProjectName],
                                [BankBranch],
                                [RENTAL_LESS_VAT],
                                [RENTAL_LESS_TAX]
                            )
                                    SELECT
                                        [CLIENT].[client_no]                                                     AS [client_no],
                                        [CLIENT].[client_Name]                                                   AS [client_Name],
                                        [CLIENT].[client_Address]                                                AS [client_Address],
                                        [RECEIPT].[PR_No]                                                        AS [PR_No],
                                        [RECEIPT].[OR_No]                                                        AS [OR_No],
                                        [CLIENT].[TIN_No]                                                        AS [TIN_No],
                                        [TRANSACTION].[TransactionDate]                                          AS [TransactionDate],
                                        UPPER([dbo].[fnNumberToWordsWithDecimal]([TRANSACTION].[ReceiveAmount])) AS [AmountInWords],
                                        [PAYMENT].[PAYMENT_FOR]                                                  AS [PaymentFor],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [TotalAmountInDigit],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [RENTAL],
                                        CAST(CAST((([tblUnitReference].[Unit_Vat] * [TRANSACTION].[ReceiveAmount])
                                                   / 100
                                                  ) AS DECIMAL(18, 2)) AS VARCHAR(30))                           AS [VAT], --TAX WILL FOLLOW
                                        CAST([tblUnitReference].[GenVat] AS VARCHAR(10)) + '% VAT'               AS [VATPct],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [TOTAL],
                                        IIF([tblUnitReference].[Unit_Tax] > 0,
                                            CAST(CAST((([tblUnitReference].[Unit_Tax] * [TRANSACTION].[ReceiveAmount])
                                                       / 100
                                                      ) AS DECIMAL(18, 2)) AS VARCHAR(30)),
                                            '0.00')                                                              AS [LESSWITHHOLDING],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [TOTALAMOUNTDUE],
                                        [RECEIPT].[BankName]                                                     AS [BANKNAME],
                                        [RECEIPT].[PDC_CHECK_SERIAL]                                             AS [PDCCHECKSERIALNO],
                                        [TRANSACTION].[USER]                                                     AS [USER],
                                        GETDATE()                                                                AS [EncodedDate],
                                        @TranID                                                                  AS [TRANID],
                                        @Mode                                                                    AS [Mode],
                                        @PaymentLevel                                                            AS [PaymentLevel],
                                        [tblUnitReference].[UnitNo]                                              AS [UnitNo],
                                        [dbo].[fnGetProjectNameById]([tblUnitReference].[ProjectId])             AS [ProjectName],
                                        [RECEIPT].[BankBranch]                                                   AS [BankBranch],
                                        '0'                                                                      AS [RENTAL_LESS_VAT],
                                        '0'                                                                      AS [RENTAL_LESS_TAX]
                                    FROM
                                        [dbo].[tblUnitReference]
                                        CROSS APPLY
                                        (
                                            SELECT
                                                [tblClientMstr].[ClientID]      AS [client_no],
                                                [tblClientMstr].[ClientName]    AS [client_Name],
                                                [tblClientMstr].[PostalAddress] AS [client_Address],
                                                [tblClientMstr].[TIN_No]        AS [TIN_No]
                                            FROM
                                                [dbo].[tblClientMstr]
                                            WHERE
                                                [tblClientMstr].[ClientID] = [tblUnitReference].[ClientID]
                                        ) [CLIENT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                    [tblTransaction].[EncodedDate]                                   AS [TransactionDate],
                                                    [tblTransaction].[TranID],
                                                    ISNULL([dbo].[fn_GetUserName]([tblTransaction].[EncodedBy]), '') AS [USER],
                                                    SUM([tblPayment].[Amount])                                       AS [ReceiveAmount]
                                            FROM
                                                    [dbo].[tblTransaction]
                                                INNER JOIN
                                                    [dbo].[tblPayment]
                                                        ON [tblPayment].[TranId] = [tblTransaction].[TranID]
                                            WHERE
                                                    [tblUnitReference].[RefId] = [tblTransaction].[RefId]
                                                    AND [tblPayment].[Notes] = 'SECURITY AND MAINTENANCE NET OF VAT'
                                            GROUP BY
                                                    [tblTransaction].[EncodedDate],
                                                    [tblTransaction].[TranID],
                                                    [tblTransaction].[EncodedBy],
                                                    [tblPayment].[Amount]
                                        ) [TRANSACTION]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                [tblReceipt].[CompanyPRNo] AS [PR_No],
                                                [tblReceipt].[CompanyORNo] AS [OR_No],
                                                [tblReceipt].[Amount]      AS [TOTAL],
                                                [tblReceipt].[Amount]      AS [TotalAmountInDigit],
                                                [tblReceipt].[BankName]    AS [BankName],
                                                [tblReceipt].[BankBranch]  AS [BankBranch],
                                                [tblReceipt].[REF]         AS [PDC_CHECK_SERIAL],
                                                [tblReceipt].[TranId]
                                            FROM
                                                [dbo].[tblReceipt]
                                            WHERE
                                                [TRANSACTION].[TranID] = [tblReceipt].[TranId]
                                        ) [RECEIPT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                IIF(@IsFullPayment = 1, 'FULL PAYMENT', 'RENTAL FOR ' + @combinedString) AS [PAYMENT_FOR]
                                        ) [PAYMENT]
                                    WHERE
                                        [TRANSACTION].[TranID] = @TranID;
                    END





            END


        SELECT TOP 1
               [tblRecieptReport].[client_no],
               [tblRecieptReport].[client_Name],
               [tblRecieptReport].[client_Address],
               [tblRecieptReport].[PR_No],
               [tblRecieptReport].[OR_No],
               [tblRecieptReport].[TIN_No],
               [tblRecieptReport].[TransactionDate],
               [tblRecieptReport].[AmountInWords],
               [tblRecieptReport].[PaymentFor],
               --FORMAT(CAST([#TMP].[TotalAmountInDigit] AS DECIMAL(18, 2)), 'C', 'en-PH') AS [TotalAmountInDigit],
               FORMAT(CAST([tblRecieptReport].[TotalAmountInDigit] AS DECIMAL(18, 2)), 'N')      AS [TotalAmountInDigit],
               --FORMAT(CAST([#TMP].[RENTAL] AS DECIMAL(18, 2)), 'C', 'en-PH') AS [RENTAL],
               FORMAT(CAST([tblRecieptReport].[RENTAL] AS DECIMAL(18, 2)), 'C', 'en-PH')         AS [RENTAL],
               FORMAT(CAST([tblRecieptReport].[VAT] AS DECIMAL(18, 2)), 'C', 'en-PH')            AS [VAT],
               [tblRecieptReport].[VATPct],
               FORMAT(CAST([tblRecieptReport].[RENTAL] AS DECIMAL(18, 2)), 'C', 'en-PH')         AS [TOTAL],
               --FORMAT(CAST([tblRecieptReport].[LESSWITHHOLDING] AS DECIMAL(18, 2)), 'C', 'en-PH') AS [LESSWITHHOLDING],
               CAST(CAST('0.00' AS DECIMAL(18, 2)) AS VARCHAR(50)) + ' %'                        AS [LESSWITHHOLDING],
               --[#TMP].[LESSWITHHOLDING] AS [LESSWITHHOLDING],
               FORMAT(CAST([tblRecieptReport].[TOTALAMOUNTDUE] AS DECIMAL(18, 2)), 'C', 'en-PH') AS [TOTALAMOUNTDUE],
               [tblRecieptReport].[BANKNAME],
               [tblRecieptReport].[PDCCHECKSERIALNO],
               [tblRecieptReport].[USER],
               [tblRecieptReport].[Mode],
               [tblRecieptReport].[UnitNo],
               [tblRecieptReport].[ProjectName],
               [tblRecieptReport].[BankBranch],
               ''                                                                                AS [BankCheckDate],
               ''                                                                                AS [BankCheckAmount],
               [tblRecieptReport].[RENTAL_LESS_VAT],
               [tblRecieptReport].[RENTAL_LESS_TAX]
        FROM
               [dbo].[tblRecieptReport]
        WHERE
               [tblRecieptReport].[TRANID] = @TranID
               AND [tblRecieptReport].[Mode] = @Mode
               AND [tblRecieptReport].[PaymentLevel] = @PaymentLevel
        ORDER BY
               [tblRecieptReport].[EncodedDate]

    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Ongching_PR_Report]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_Ongching_PR_Report]
    @TranID VARCHAR(20) = NULL,
    @Mode VARCHAR(50) = NULL,
    @PaymentLevel VARCHAR(50) = NULL
AS
    BEGIN
        SET NOCOUNT ON;


        DECLARE @combinedString VARCHAR(MAX);
        DECLARE @IsFullPayment BIT = 0;
        DECLARE @RefId VARCHAR(100) = '';


        IF NOT EXISTS
            (
                SELECT
                    1
                FROM
                    [dbo].[tblRecieptReport]
                WHERE
                    [tblRecieptReport].[TRANID] = @TranID
                    AND [tblRecieptReport].[Mode] = @Mode
                    AND [tblRecieptReport].[PaymentLevel] = @PaymentLevel
            )
            BEGIN
                SELECT
                    @IsFullPayment = ISNULL([tblUnitReference].[IsFullPayment], 0),
                    @RefId         = [tblUnitReference].[RefId]
                FROM
                    [dbo].[tblUnitReference]
                WHERE
                    [tblUnitReference].[RefId] =
                    (
                        SELECT TOP 1
                               [tblTransaction].[RefId]
                        FROM
                               [dbo].[tblTransaction]
                        WHERE
                               [tblTransaction].[TranID] = @TranID
                    );

                IF @IsFullPayment = 0
                    BEGIN
                        IF
                            (
                                SELECT
                                    COUNT(*)
                                FROM
                                    [dbo].[tblPayment]
                                WHERE
                                    [tblPayment].[TranId] = @TranID
                                    AND [tblPayment].[Remarks] NOT IN (
                                                                          'SECURITY DEPOSIT'
                                                                      )
                            ) > 5
                            BEGIN
                                IF @Mode = 'REN'
                                   AND @PaymentLevel = 'SECOND'
                                    BEGIN
                                        SELECT
                                            @combinedString
                                            =
                                            (
                                                SELECT  TOP 1
                                                        UPPER(DATENAME(MONTH, MIN([tblPayment].[ForMonth]))) + ' '
                                                        + CAST(YEAR(MIN([tblPayment].[ForMonth])) AS VARCHAR(4))
                                                FROM
                                                        [dbo].[tblPayment]
                                                    INNER JOIN
                                                        [dbo].[tblMonthLedger]
                                                            ON [tblMonthLedger].[LedgMonth] = [tblPayment].[ForMonth]
                                                               AND [tblMonthLedger].[Remarks] = [tblPayment].[Notes]
                                                               AND [tblMonthLedger].[TransactionID] = [tblPayment].[TranId]
                                                WHERE
                                                        [tblPayment].[TranId] = @TranID
                                                        AND [tblPayment].[Remarks] NOT IN (
                                                                                              'SECURITY DEPOSIT'
                                                                                          )
                                                        AND [tblPayment].[Notes] = 'RENTAL NET OF VAT'
                                                        AND ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                                            ) + ' TO '
                                            +
                                            (
                                                SELECT  TOP 1
                                                        UPPER(DATENAME(MONTH, MAX([tblPayment].[ForMonth]))) + ' '
                                                        + CAST(YEAR(MAX([tblPayment].[ForMonth])) AS VARCHAR(4))
                                                FROM
                                                        [dbo].[tblPayment]
                                                    INNER JOIN
                                                        [dbo].[tblMonthLedger]
                                                            ON [tblMonthLedger].[LedgMonth] = [tblPayment].[ForMonth]
                                                               AND [tblMonthLedger].[Remarks] = [tblPayment].[Notes]
                                                               AND [tblMonthLedger].[TransactionID] = [tblPayment].[TranId]
                                                WHERE
                                                        [tblPayment].[TranId] = @TranID
                                                        AND [tblPayment].[Remarks] NOT IN (
                                                                                              'SECURITY DEPOSIT'
                                                                                          )
                                                        AND [tblPayment].[Notes] = 'RENTAL NET OF VAT'
                                                        AND ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                                            )
                                    END

                                IF @Mode = 'MAIN'
                                   AND @PaymentLevel = 'SECOND'
                                    BEGIN

                                        SELECT
                                            @combinedString
                                            =
                                            (
                                                SELECT  TOP 1
                                                        UPPER(DATENAME(MONTH, MIN([tblPayment].[ForMonth]))) + ' '
                                                        + CAST(YEAR(MIN([tblPayment].[ForMonth])) AS VARCHAR(4))
                                                FROM
                                                        [dbo].[tblPayment]
                                                    INNER JOIN
                                                        [dbo].[tblMonthLedger]
                                                            ON [tblMonthLedger].[LedgMonth] = [tblPayment].[ForMonth]
                                                               AND [tblMonthLedger].[Remarks] = [tblPayment].[Notes]
                                                               AND [tblMonthLedger].[TransactionID] = [tblPayment].[TranId]
                                                WHERE
                                                        [tblPayment].[TranId] = @TranID
                                                        AND [tblPayment].[Remarks] NOT IN (
                                                                                              'SECURITY DEPOSIT'
                                                                                          )
                                                        AND [tblPayment].[Notes] = 'SECURITY AND MAINTENANCE NET OF VAT'
                                                        AND ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                                            ) + ' TO '
                                            +
                                            (
                                                SELECT  TOP 1
                                                        UPPER(DATENAME(MONTH, MAX([tblPayment].[ForMonth]))) + ' '
                                                        + CAST(YEAR(MAX([tblPayment].[ForMonth])) AS VARCHAR(4))
                                                FROM
                                                        [dbo].[tblPayment]
                                                    INNER JOIN
                                                        [dbo].[tblMonthLedger]
                                                            ON [tblMonthLedger].[LedgMonth] = [tblPayment].[ForMonth]
                                                               AND [tblMonthLedger].[Remarks] = [tblPayment].[Notes]
                                                               AND [tblMonthLedger].[TransactionID] = [tblPayment].[TranId]
                                                WHERE
                                                        [tblPayment].[TranId] = @TranID
                                                        AND [tblPayment].[Remarks] NOT IN (
                                                                                              'SECURITY DEPOSIT'
                                                                                          )
                                                        AND [tblPayment].[Notes] = 'SECURITY AND MAINTENANCE NET OF VAT'
                                                        AND ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                                            )
                                    END

                            END
                        ELSE
                            BEGIN
                                IF @Mode = 'SEC'
                                   AND @PaymentLevel = 'FIRST'
                                    BEGIN
                                        SELECT
                                            @combinedString
                                            = '('
                                              + CAST(CAST([dbo].[fnGetTotalSecDepositAmountCount](@RefId) AS INT) AS VARCHAR(50))
                                              + ')MONTH-SECURITY DEPOSIT'

                                    END
                                ELSE IF @Mode = 'ADV'
                                        AND @PaymentLevel = 'FIRST'
                                    BEGIN
                                        --SELECT @combinedString = 'ADVANCE PAYMENT'
                                        BEGIN
                                            SELECT
                                                @combinedString
                                                = COALESCE(@combinedString + '-', '')
                                                  + UPPER(DATENAME(MONTH, [tblPayment].[ForMonth])) + ' '
                                                  + CAST(YEAR([tblPayment].[ForMonth]) AS VARCHAR(4))
                                            FROM
                                                [dbo].[tblPayment]
                                            WHERE
                                                [tblPayment].[TranId] = @TranID
                                                AND [tblPayment].[Remarks] = 'MONTHS ADVANCE'
                                                AND ISNULL([tblPayment].[Notes], '') = ''


                                        END
                                    END
                                ELSE
                                    BEGIN

                                        IF @Mode = 'REN'
                                           AND @PaymentLevel = 'SECOND'
                                            BEGIN
                                                SELECT
                                                        @combinedString
                                                    = COALESCE(@combinedString + '-', '')
                                                      + UPPER(DATENAME(MONTH, [tblPayment].[ForMonth])) + ' '
                                                      + CAST(YEAR([tblPayment].[ForMonth]) AS VARCHAR(4))
                                                      + IIF(ISNULL([tblMonthLedger].[IsHold], 0) = 1, '(PARTIAL)', '')
                                                FROM
                                                        [dbo].[tblPayment]
                                                    INNER JOIN
                                                        [dbo].[tblMonthLedger]
                                                            ON [tblMonthLedger].[LedgMonth] = [tblPayment].[ForMonth]
                                                               AND [tblMonthLedger].[Remarks] = [tblPayment].[Notes]
                                                               AND [tblMonthLedger].[TransactionID] = [tblPayment].[TranId]
                                                WHERE
                                                        [tblPayment].[TranId] = @TranID
                                                        AND [tblPayment].[Remarks] NOT IN (
                                                                                              'SECURITY DEPOSIT'
                                                                                          )
                                                        AND [tblPayment].[Notes] = 'RENTAL NET OF VAT'
                                                        AND ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                                            END
                                        IF @Mode = 'MAIN'
                                           AND @PaymentLevel = 'SECOND'
                                            BEGIN
                                                SELECT
                                                        @combinedString
                                                    = COALESCE(@combinedString + '-', '')
                                                      + UPPER(DATENAME(MONTH, [tblPayment].[ForMonth])) + ' '
                                                      + CAST(YEAR([tblPayment].[ForMonth]) AS VARCHAR(4))
                                                      + IIF(ISNULL([tblMonthLedger].[IsHold], 0) = 1, '(PARTIAL)', '')
                                                FROM
                                                        [dbo].[tblPayment]
                                                    INNER JOIN
                                                        [dbo].[tblMonthLedger]
                                                            ON [tblMonthLedger].[LedgMonth] = [tblPayment].[ForMonth]
                                                               AND [tblMonthLedger].[Remarks] = [tblPayment].[Notes]
                                                               AND [tblMonthLedger].[TransactionID] = [tblPayment].[TranId]
                                                WHERE
                                                        [tblPayment].[TranId] = @TranID
                                                        AND [tblPayment].[Remarks] NOT IN (
                                                                                              'SECURITY DEPOSIT'
                                                                                          )
                                                        AND [tblPayment].[Notes] = 'SECURITY AND MAINTENANCE NET OF VAT'
                                                        AND ISNULL([tblMonthLedger].[IsPaid], 0) = 1
                                            END


                                    END
                            END
                    END;


                IF @Mode = 'ADV'
                   AND @PaymentLevel = 'FIRST'
                    BEGIN
                        INSERT INTO [dbo].[tblRecieptReport]
                            (
                                [client_no],
                                [client_Name],
                                [client_Address],
                                [PR_No],
                                [OR_No],
                                [TIN_No],
                                [TransactionDate],
                                [AmountInWords],
                                [PaymentFor],      --PAYMENT DESCRIPTION
                                [TotalAmountInDigit],
                                [RENTAL],
                                [VAT],             --VAT AMOUNT
                                [VATPct],
                                [TOTAL],
                                [LESSWITHHOLDING], --TAX AMOUNT
                                [TOTALAMOUNTDUE],
                                [BANKNAME],
                                [PDCCHECKSERIALNO],
                                [USER],
                                [EncodedDate],
                                [TRANID],
                                [Mode],
                                [PaymentLevel],
                                [UnitNo],
                                [ProjectName],
                                [BankBranch],
                                [RENTAL_LESS_VAT],
                                [RENTAL_LESS_TAX]
                            )
                                    SELECT
                                        [CLIENT].[client_no]                                                                                               AS [client_no],
                                        [CLIENT].[client_Name]                                                                                             AS [client_Name],
                                        [CLIENT].[client_Address]                                                                                          AS [client_Address],
                                        [RECEIPT].[PR_No]                                                                                                  AS [PR_No],
                                        [RECEIPT].[OR_No]                                                                                                  AS [OR_No],
                                        [CLIENT].[TIN_No]                                                                                                  AS [TIN_No],
                                        [TRANSACTION].[TransactionDate]                                                                                    AS [TransactionDate],
                                        UPPER([dbo].[fnNumberToWordsWithDecimal](IIF(@IsFullPayment = 0,
                                                                                     [tblUnitReference].[AdvancePaymentAmount],
                                                                                     [tblUnitReference].[Total])
                                                                                )
                                             )                                                                                                             AS [AmountInWords],
                                        [PAYMENT].[PAYMENT_FOR]                                                                                            AS [PaymentFor],
                                        IIF(@IsFullPayment = 0,
                                            [tblUnitReference].[AdvancePaymentAmount],
                                            [tblUnitReference].[Total])                                                                                    AS [TotalAmountInDigit],
                                        IIF(@IsFullPayment = 0,
                                            [tblUnitReference].[AdvancePaymentAmount],
                                            [tblUnitReference].[Total])                                                                                    AS [RENTAL],
                                        CAST(([tblUnitReference].[Unit_BaseRentalVatAmount]
                                              + [tblUnitReference].[Unit_SecAndMainVatAmount]
                                             )
                                             * CAST([dbo].[fnGetAdvanceMonthCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150))   AS [VAT_AMOUNT],
                                        CAST([tblUnitReference].[Unit_Vat] AS VARCHAR(10)) + '% VAT'                                                       AS [VATPct],
                                        IIF(@IsFullPayment = 0,
                                            [tblUnitReference].[AdvancePaymentAmount],
                                            [tblUnitReference].[Total])                                                                                    AS [TOTAL],
                                        CAST([tblUnitReference].[Unit_BaseRentalTax]
                                             * CAST([dbo].[fnGetAdvanceMonthCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150))   AS [LESSWITHHOLDING],
                                        [tblUnitReference].[AdvancePaymentAmount]                                                                          AS [TOTALAMOUNTDUE],
                                        [RECEIPT].[BankName]                                                                                               AS [BANKNAME],
                                        [RECEIPT].[PDC_CHECK_SERIAL]                                                                                       AS [PDCCHECKSERIALNO],
                                        [TRANSACTION].[USER]                                                                                               AS [USER],
                                        GETDATE()                                                                                                          AS [EncodedDate],
                                        @TranID                                                                                                            AS [TRANID],
                                        @Mode                                                                                                              AS [Mode],
                                        @PaymentLevel                                                                                                      AS [PaymentLevel],
                                        [tblUnitReference].[UnitNo]                                                                                        AS [UnitNo],
                                        [dbo].[fnGetProjectNameById]([tblUnitReference].[ProjectId])                                                       AS [ProjectName],
                                        [RECEIPT].[BankBranch]                                                                                             AS [BankBranch],
                                        CAST(CAST(IIF(@IsFullPayment = 0,
                                                      IIF([tblUnitReference].[Unit_Tax] > 0,
                                                          ([tblUnitReference].[AdvancePaymentAmount]
                                                           + CAST([tblUnitReference].[Unit_BaseRentalTax]
                                                                  * [dbo].[fnGetAdvanceMonthCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2))
                                                          ),
                                                          [tblUnitReference].[AdvancePaymentAmount]),
                                                      [tblUnitReference].[Total]) AS DECIMAL(18, 2))
                                             - CAST(([dbo].[tblUnitReference].[Unit_BaseRentalVatAmount]
                                                     + [tblUnitReference].[Unit_SecAndMainVatAmount]
                                                    )
                                                    * [dbo].[fnGetAdvanceMonthCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150)) AS [RENTAL_LESS_VAT],
                                        CAST(IIF(@IsFullPayment = 0,
                                                 [tblUnitReference].[AdvancePaymentAmount],
                                                 [tblUnitReference].[Total]) AS VARCHAR(150))                                                              AS [RENTAL_LESS_TAX]
                                    FROM
                                        [dbo].[tblUnitReference]
                                        CROSS APPLY
                                        (
                                            SELECT
                                                [tblClientMstr].[ClientID]      AS [client_no],
                                                [tblClientMstr].[ClientName]    AS [client_Name],
                                                [tblClientMstr].[PostalAddress] AS [client_Address],
                                                [tblClientMstr].[TIN_No]        AS [TIN_No]
                                            FROM
                                                [dbo].[tblClientMstr]
                                            WHERE
                                                [tblClientMstr].[ClientID] = [tblUnitReference].[ClientID]
                                        ) [CLIENT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                [tblTransaction].[EncodedDate]                                   AS [TransactionDate],
                                                [tblTransaction].[TranID],
                                                ISNULL([dbo].[fn_GetUserName]([tblTransaction].[EncodedBy]), '') AS [USER],
                                                [tblTransaction].[ReceiveAmount]
                                            FROM
                                                [dbo].[tblTransaction]
                                            WHERE
                                                [tblUnitReference].[RefId] = [tblTransaction].[RefId]
                                        ) [TRANSACTION]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                [tblReceipt].[CompanyPRNo] AS [PR_No],
                                                [tblReceipt].[CompanyORNo] AS [OR_No],
                                                [tblReceipt].[Amount]      AS [TOTAL],
                                                [tblReceipt].[BankName]    AS [BankName],
                                                [tblReceipt].[BankBranch]  AS [BankBranch],
                                                [tblReceipt].[REF]         AS [PDC_CHECK_SERIAL],
                                                [tblReceipt].[TranId]
                                            FROM
                                                [dbo].[tblReceipt]
                                            WHERE
                                                [TRANSACTION].[TranID] = [tblReceipt].[TranId]
                                        ) [RECEIPT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                IIF(@IsFullPayment = 1, 'FULL PAYMENT', 'RENTAL FOR ' + @combinedString) AS [PAYMENT_FOR]
                                        ) [PAYMENT]
                                    WHERE
                                        [TRANSACTION].[TranID] = @TranID


                    END
                IF @Mode = 'SEC'
                   AND @PaymentLevel = 'FIRST'
                    BEGIN
                        INSERT INTO [dbo].[tblRecieptReport]
                            (
                                [client_no],
                                [client_Name],
                                [client_Address],
                                [PR_No],
                                [OR_No],
                                [TIN_No],
                                [TransactionDate],
                                [AmountInWords],
                                [PaymentFor],
                                [TotalAmountInDigit],
                                [RENTAL],
                                [VAT],
                                [VATPct],
                                [TOTAL],
                                [LESSWITHHOLDING],
                                [TOTALAMOUNTDUE],
                                [BANKNAME],
                                [PDCCHECKSERIALNO],
                                [USER],
                                [EncodedDate],
                                [TRANID],
                                [Mode],
                                [PaymentLevel],
                                [UnitNo],
                                [ProjectName],
                                [BankBranch],
                                [RENTAL_LESS_VAT],
                                [RENTAL_LESS_TAX]
                            )
                                    SELECT
                                        [CLIENT].[client_no]                                                                                                        AS [client_no],
                                        [CLIENT].[client_Name]                                                                                                      AS [client_Name],
                                        [CLIENT].[client_Address]                                                                                                   AS [client_Address],
                                        [RECEIPT].[PR_No]                                                                                                           AS [PR_No],
                                        [RECEIPT].[OR_No]                                                                                                           AS [OR_No],
                                        [CLIENT].[TIN_No]                                                                                                           AS [TIN_No],
                                        [TRANSACTION].[TransactionDate]                                                                                             AS [TransactionDate],
                                        UPPER([dbo].[fnNumberToWordsWithDecimal]([tblUnitReference].[SecDeposit]))                                                  AS [AmountInWords],
                                        [PAYMENT].[PAYMENT_FOR]                                                                                                     AS [PaymentFor],
                                        [tblUnitReference].[SecDeposit]                                                                                             AS [TotalAmountInDigit],
                                        [tblUnitReference].[SecDeposit]                                                                                             AS [RENTAL],
                                        CAST(CAST(([tblUnitReference].[Unit_BaseRentalVatAmount]
                                                   + [tblUnitReference].[Unit_SecAndMainVatAmount]
                                                  )
                                                  * [dbo].[fnGetTotalSecDepositAmountCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150))   AS [VAT],
                                        CAST([tblUnitReference].[Unit_Vat] AS VARCHAR(10)) + '% VAT'                                                                AS [VATPct],
                                        [tblUnitReference].[SecDeposit]                                                                                             AS [TOTAL],
                                        CAST(CAST([tblUnitReference].[Unit_TaxAmount]
                                                  * [dbo].[fnGetTotalSecDepositAmountCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150))   AS [LESSWITHHOLDING],
                                        [tblUnitReference].[SecDeposit]                                                                                             AS [TOTALAMOUNTDUE],
                                        [RECEIPT].[BankName]                                                                                                        AS [BANKNAME],
                                        [RECEIPT].[PDC_CHECK_SERIAL]                                                                                                AS [PDCCHECKSERIALNO],
                                        [TRANSACTION].[USER]                                                                                                        AS [USER],
                                        GETDATE()                                                                                                                   AS [EncodedDate],
                                        @TranID                                                                                                                     AS [TRANID],
                                        @Mode                                                                                                                       AS [Mode],
                                        @PaymentLevel                                                                                                               AS [PaymentLevel],
                                        [tblUnitReference].[UnitNo]                                                                                                 AS [UnitNo],
                                        [dbo].[fnGetProjectNameById]([tblUnitReference].[ProjectId])                                                                AS [ProjectName],
                                        [RECEIPT].[BankBranch]                                                                                                      AS [BankBranch],
                                        CAST(CAST(IIF([tblUnitReference].[Unit_Tax] > 0,
                                                      ([tblUnitReference].[SecDeposit]
                                                       + CAST([tblUnitReference].[Unit_BaseRentalTax]
                                                              * [dbo].[fnGetTotalSecDepositAmountCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2))
                                                      ),
                                                      0) AS DECIMAL(18, 2))
                                             - CAST(([tblUnitReference].[Unit_BaseRentalVatAmount]
                                                     + [tblUnitReference].[Unit_SecAndMainVatAmount]
                                                    )
                                                    * [dbo].[fnGetTotalSecDepositAmountCount]([dbo].[tblUnitReference].[RefId]) AS DECIMAL(18, 2)) AS VARCHAR(150)) AS [RENTAL_LESS_VAT],
                                        CAST(CAST([tblUnitReference].[SecDeposit] AS DECIMAL(18, 2)) AS VARCHAR(150))                                               AS [RENTAL_LESS_TAX]
                                    FROM
                                        [dbo].[tblUnitReference]
                                        CROSS APPLY
                                        (
                                            SELECT
                                                [tblClientMstr].[ClientID]      AS [client_no],
                                                [tblClientMstr].[ClientName]    AS [client_Name],
                                                [tblClientMstr].[PostalAddress] AS [client_Address],
                                                [tblClientMstr].[TIN_No]        AS [TIN_No]
                                            FROM
                                                [dbo].[tblClientMstr]
                                            WHERE
                                                [tblClientMstr].[ClientID] = [tblUnitReference].[ClientID]
                                        ) [CLIENT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                [tblTransaction].[EncodedDate]                                   AS [TransactionDate],
                                                [tblTransaction].[TranID],
                                                ISNULL([dbo].[fn_GetUserName]([tblTransaction].[EncodedBy]), '') AS [USER],
                                                [tblTransaction].[ReceiveAmount]
                                            FROM
                                                [dbo].[tblTransaction]
                                            WHERE
                                                [tblUnitReference].[RefId] = [tblTransaction].[RefId]
                                        ) [TRANSACTION]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                [tblReceipt].[CompanyPRNo] AS [PR_No],
                                                [tblReceipt].[CompanyORNo] AS [OR_No],
                                                [tblReceipt].[Amount]      AS [TOTAL],
                                                [tblReceipt].[BankName]    AS [BankName],
                                                [tblReceipt].[BankBranch]  AS [BankBranch],
                                                [tblReceipt].[REF]         AS [PDC_CHECK_SERIAL],
                                                [tblReceipt].[TranId]
                                            FROM
                                                [dbo].[tblReceipt]
                                            WHERE
                                                [TRANSACTION].[TranID] = [tblReceipt].[TranId]
                                        ) [RECEIPT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                IIF(@IsFullPayment = 1, 'FULL PAYMENT', 'RENTAL FOR ' + @combinedString) AS [PAYMENT_FOR]
                                        ) [PAYMENT]
                                    WHERE
                                        [TRANSACTION].[TranID] = @TranID


                    END



                IF @Mode = 'REN'
                   AND @PaymentLevel = 'SECOND'
                    BEGIN
                        INSERT INTO [dbo].[tblRecieptReport]
                            (
                                [client_no],
                                [client_Name],
                                [client_Address],
                                [PR_No],
                                [OR_No],
                                [TIN_No],
                                [TransactionDate],
                                [AmountInWords],
                                [PaymentFor],
                                [TotalAmountInDigit],
                                [RENTAL],
                                [VAT],
                                [VATPct],
                                [TOTAL],
                                [LESSWITHHOLDING],
                                [TOTALAMOUNTDUE],
                                [BANKNAME],
                                [PDCCHECKSERIALNO],
                                [USER],
                                [EncodedDate],
                                [TRANID],
                                [Mode],
                                [PaymentLevel],
                                [UnitNo],
                                [ProjectName],
                                [BankBranch],
                                [RENTAL_LESS_VAT],
                                [RENTAL_LESS_TAX]
                            )
                                    SELECT
                                        [CLIENT].[client_no]                                                     AS [client_no],
                                        [CLIENT].[client_Name]                                                   AS [client_Name],
                                        [CLIENT].[client_Address]                                                AS [client_Address],
                                        [RECEIPT].[PR_No]                                                        AS [PR_No],
                                        [RECEIPT].[OR_No]                                                        AS [OR_No],
                                        [CLIENT].[TIN_No]                                                        AS [TIN_No],
                                        [TRANSACTION].[TransactionDate]                                          AS [TransactionDate],
                                        UPPER([dbo].[fnNumberToWordsWithDecimal]([TRANSACTION].[ReceiveAmount])) AS [AmountInWords],
                                        [PAYMENT].[PAYMENT_FOR]                                                  AS [PaymentFor],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [TotalAmountInDigit],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [RENTAL],
                                        CAST(CAST((([tblUnitReference].[Unit_Vat] * [TRANSACTION].[ReceiveAmount])
                                                   / 100
                                                  ) AS DECIMAL(18, 2)) AS VARCHAR(30))                           AS [VAT],
                                        CAST([tblUnitReference].[Unit_Vat] AS VARCHAR(10)) + '% VAT'             AS [VATPct],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [TOTAL],
                                        IIF([tblUnitReference].[Unit_Tax] > 0,
                                            CAST(CAST((([tblUnitReference].[Unit_Tax] * [TRANSACTION].[ReceiveAmount])
                                                       / 100
                                                      ) AS DECIMAL(18, 2)) AS VARCHAR(30)),
                                            '0.00')                                                              AS [LESSWITHHOLDING],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [TOTALAMOUNTDUE],
                                        [RECEIPT].[BankName]                                                     AS [BANKNAME],
                                        [RECEIPT].[PDC_CHECK_SERIAL]                                             AS [PDCCHECKSERIALNO],
                                        [TRANSACTION].[USER]                                                     AS [USER],
                                        GETDATE()                                                                AS [EncodedDate],
                                        @TranID                                                                  AS [TRANID],
                                        @Mode                                                                    AS [Mode],
                                        @PaymentLevel                                                            AS [PaymentLevel],
                                        [tblUnitReference].[UnitNo]                                              AS [UnitNo],
                                        [dbo].[fnGetProjectNameById]([tblUnitReference].[ProjectId])             AS [ProjectName],
                                        [RECEIPT].[BankBranch]                                                   AS [BankBranch],
                                        '0'                                                                      AS [RENTAL_LESS_VAT],
                                        '0'                                                                      AS [RENTAL_LESS_TAX]
                                    FROM
                                        [dbo].[tblUnitReference]
                                        CROSS APPLY
                                        (
                                            SELECT
                                                [tblClientMstr].[ClientID]      AS [client_no],
                                                [tblClientMstr].[ClientName]    AS [client_Name],
                                                [tblClientMstr].[PostalAddress] AS [client_Address],
                                                [tblClientMstr].[TIN_No]        AS [TIN_No]
                                            FROM
                                                [dbo].[tblClientMstr]
                                            WHERE
                                                [tblClientMstr].[ClientID] = [tblUnitReference].[ClientID]
                                        ) [CLIENT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                    [tblTransaction].[EncodedDate]                                   AS [TransactionDate],
                                                    [tblTransaction].[TranID],
                                                    ISNULL([dbo].[fn_GetUserName]([tblTransaction].[EncodedBy]), '') AS [USER],
                                                    SUM([tblPayment].[Amount])                                       AS [ReceiveAmount]
                                            FROM
                                                    [dbo].[tblTransaction]
                                                INNER JOIN
                                                    [dbo].[tblPayment]
                                                        ON [tblPayment].[TranId] = [tblTransaction].[TranID]
                                            WHERE
                                                    [tblUnitReference].[RefId] = [tblTransaction].[RefId]
                                                    AND [tblPayment].[Notes] = 'RENTAL NET OF VAT'
                                            GROUP BY
                                                    [tblTransaction].[EncodedDate],
                                                    [tblTransaction].[TranID],
                                                    [tblTransaction].[EncodedBy],
                                                    [tblPayment].[Amount]
                                        ) [TRANSACTION]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                [tblReceipt].[CompanyPRNo] AS [PR_No],
                                                [tblReceipt].[CompanyORNo] AS [OR_No],
                                                [tblReceipt].[Amount]      AS [TOTAL],
                                                [tblReceipt].[Amount]      AS [TotalAmountInDigit],
                                                [tblReceipt].[BankName]    AS [BankName],
                                                [tblReceipt].[BankBranch]  AS [BankBranch],
                                                [tblReceipt].[REF]         AS [PDC_CHECK_SERIAL],
                                                [tblReceipt].[TranId]
                                            FROM
                                                [dbo].[tblReceipt]
                                            WHERE
                                                [TRANSACTION].[TranID] = [tblReceipt].[TranId]
                                        ) [RECEIPT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                IIF(@IsFullPayment = 1, 'FULL PAYMENT', 'RENTAL FOR ' + @combinedString) AS [PAYMENT_FOR]
                                        ) [PAYMENT]
                                    WHERE
                                        [TRANSACTION].[TranID] = @TranID;
                    END
                IF @Mode = 'MAIN'
                   AND @PaymentLevel = 'SECOND'
                    BEGIN
                        INSERT INTO [dbo].[tblRecieptReport]
                            (
                                [client_no],
                                [client_Name],
                                [client_Address],
                                [PR_No],
                                [OR_No],
                                [TIN_No],
                                [TransactionDate],
                                [AmountInWords],
                                [PaymentFor],
                                [TotalAmountInDigit],
                                [RENTAL],
                                [VAT],
                                [VATPct],
                                [TOTAL],
                                [LESSWITHHOLDING],
                                [TOTALAMOUNTDUE],
                                [BANKNAME],
                                [PDCCHECKSERIALNO],
                                [USER],
                                [EncodedDate],
                                [TRANID],
                                [Mode],
                                [PaymentLevel],
                                [UnitNo],
                                [ProjectName],
                                [BankBranch],
                                [RENTAL_LESS_VAT],
                                [RENTAL_LESS_TAX]
                            )
                                    SELECT
                                        [CLIENT].[client_no]                                                     AS [client_no],
                                        [CLIENT].[client_Name]                                                   AS [client_Name],
                                        [CLIENT].[client_Address]                                                AS [client_Address],
                                        [RECEIPT].[PR_No]                                                        AS [PR_No],
                                        [RECEIPT].[OR_No]                                                        AS [OR_No],
                                        [CLIENT].[TIN_No]                                                        AS [TIN_No],
                                        [TRANSACTION].[TransactionDate]                                          AS [TransactionDate],
                                        UPPER([dbo].[fnNumberToWordsWithDecimal]([TRANSACTION].[ReceiveAmount])) AS [AmountInWords],
                                        [PAYMENT].[PAYMENT_FOR]                                                  AS [PaymentFor],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [TotalAmountInDigit],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [RENTAL],
                                        CAST(CAST((([tblUnitReference].[Unit_Vat] * [TRANSACTION].[ReceiveAmount])
                                                   / 100
                                                  ) AS DECIMAL(18, 2)) AS VARCHAR(30))                           AS [VAT], --TAX WILL FOLLOW
                                        CAST([tblUnitReference].[GenVat] AS VARCHAR(10)) + '% VAT'               AS [VATPct],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [TOTAL],
                                        IIF([tblUnitReference].[Unit_Tax] > 0,
                                            CAST(CAST((([tblUnitReference].[Unit_Tax] * [TRANSACTION].[ReceiveAmount])
                                                       / 100
                                                      ) AS DECIMAL(18, 2)) AS VARCHAR(30)),
                                            '0.00')                                                              AS [LESSWITHHOLDING],
                                        [TRANSACTION].[ReceiveAmount]                                            AS [TOTALAMOUNTDUE],
                                        [RECEIPT].[BankName]                                                     AS [BANKNAME],
                                        [RECEIPT].[PDC_CHECK_SERIAL]                                             AS [PDCCHECKSERIALNO],
                                        [TRANSACTION].[USER]                                                     AS [USER],
                                        GETDATE()                                                                AS [EncodedDate],
                                        @TranID                                                                  AS [TRANID],
                                        @Mode                                                                    AS [Mode],
                                        @PaymentLevel                                                            AS [PaymentLevel],
                                        [tblUnitReference].[UnitNo]                                              AS [UnitNo],
                                        [dbo].[fnGetProjectNameById]([tblUnitReference].[ProjectId])             AS [ProjectName],
                                        [RECEIPT].[BankBranch]                                                   AS [BankBranch],
                                        '0'                                                                      AS [RENTAL_LESS_VAT],
                                        '0'                                                                      AS [RENTAL_LESS_TAX]
                                    FROM
                                        [dbo].[tblUnitReference]
                                        CROSS APPLY
                                        (
                                            SELECT
                                                [tblClientMstr].[ClientID]      AS [client_no],
                                                [tblClientMstr].[ClientName]    AS [client_Name],
                                                [tblClientMstr].[PostalAddress] AS [client_Address],
                                                [tblClientMstr].[TIN_No]        AS [TIN_No]
                                            FROM
                                                [dbo].[tblClientMstr]
                                            WHERE
                                                [tblClientMstr].[ClientID] = [tblUnitReference].[ClientID]
                                        ) [CLIENT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                    [tblTransaction].[EncodedDate]                                   AS [TransactionDate],
                                                    [tblTransaction].[TranID],
                                                    ISNULL([dbo].[fn_GetUserName]([tblTransaction].[EncodedBy]), '') AS [USER],
                                                    SUM([tblPayment].[Amount])                                       AS [ReceiveAmount]
                                            FROM
                                                    [dbo].[tblTransaction]
                                                INNER JOIN
                                                    [dbo].[tblPayment]
                                                        ON [tblPayment].[TranId] = [tblTransaction].[TranID]
                                            WHERE
                                                    [tblUnitReference].[RefId] = [tblTransaction].[RefId]
                                                    AND [tblPayment].[Notes] = 'SECURITY AND MAINTENANCE NET OF VAT'
                                            GROUP BY
                                                    [tblTransaction].[EncodedDate],
                                                    [tblTransaction].[TranID],
                                                    [tblTransaction].[EncodedBy],
                                                    [tblPayment].[Amount]
                                        ) [TRANSACTION]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                [tblReceipt].[CompanyPRNo] AS [PR_No],
                                                [tblReceipt].[CompanyORNo] AS [OR_No],
                                                [tblReceipt].[Amount]      AS [TOTAL],
                                                [tblReceipt].[Amount]      AS [TotalAmountInDigit],
                                                [tblReceipt].[BankName]    AS [BankName],
                                                [tblReceipt].[BankBranch]  AS [BankBranch],
                                                [tblReceipt].[REF]         AS [PDC_CHECK_SERIAL],
                                                [tblReceipt].[TranId]
                                            FROM
                                                [dbo].[tblReceipt]
                                            WHERE
                                                [TRANSACTION].[TranID] = [tblReceipt].[TranId]
                                        ) [RECEIPT]
                                        OUTER APPLY
                                        (
                                            SELECT
                                                IIF(@IsFullPayment = 1, 'FULL PAYMENT', 'RENTAL FOR ' + @combinedString) AS [PAYMENT_FOR]
                                        ) [PAYMENT]
                                    WHERE
                                        [TRANSACTION].[TranID] = @TranID;
                    END





            END


        SELECT TOP 1
               [tblRecieptReport].[client_no],
               [tblRecieptReport].[client_Name],
               [tblRecieptReport].[client_Address],
               [tblRecieptReport].[PR_No],
               [tblRecieptReport].[OR_No],
               [tblRecieptReport].[TIN_No],
               [tblRecieptReport].[TransactionDate],
               [tblRecieptReport].[AmountInWords],
               [tblRecieptReport].[PaymentFor],
               --FORMAT(CAST([#TMP].[TotalAmountInDigit] AS DECIMAL(18, 2)), 'C', 'en-PH') AS [TotalAmountInDigit],
               FORMAT(CAST([tblRecieptReport].[TotalAmountInDigit] AS DECIMAL(18, 2)), 'N')      AS [TotalAmountInDigit],
               --FORMAT(CAST([#TMP].[RENTAL] AS DECIMAL(18, 2)), 'C', 'en-PH') AS [RENTAL],
               FORMAT(CAST([tblRecieptReport].[RENTAL] AS DECIMAL(18, 2)), 'C', 'en-PH')         AS [RENTAL],
               FORMAT(CAST([tblRecieptReport].[VAT] AS DECIMAL(18, 2)), 'C', 'en-PH')            AS [VAT],
               [tblRecieptReport].[VATPct],
               FORMAT(CAST([tblRecieptReport].[RENTAL] AS DECIMAL(18, 2)), 'C', 'en-PH')         AS [TOTAL],
               --FORMAT(CAST([tblRecieptReport].[LESSWITHHOLDING] AS DECIMAL(18, 2)), 'C', 'en-PH') AS [LESSWITHHOLDING],
               CAST(CAST('0.00' AS DECIMAL(18, 2)) AS VARCHAR(50)) + ' %'                        AS [LESSWITHHOLDING],
               --[#TMP].[LESSWITHHOLDING] AS [LESSWITHHOLDING],
               FORMAT(CAST([tblRecieptReport].[TOTALAMOUNTDUE] AS DECIMAL(18, 2)), 'C', 'en-PH') AS [TOTALAMOUNTDUE],
               [tblRecieptReport].[BANKNAME],
               [tblRecieptReport].[PDCCHECKSERIALNO],
               [tblRecieptReport].[USER],
               [tblRecieptReport].[Mode],
               [tblRecieptReport].[UnitNo],
               [tblRecieptReport].[ProjectName],
               [tblRecieptReport].[BankBranch],
               ''                                                                                AS [BankCheckDate],
               ''                                                                                AS [BankCheckAmount],
               [tblRecieptReport].[RENTAL_LESS_VAT],
               [tblRecieptReport].[RENTAL_LESS_TAX]
        FROM
               [dbo].[tblRecieptReport]
        WHERE
               [tblRecieptReport].[TRANID] = @TranID
               AND [tblRecieptReport].[Mode] = @Mode
               AND [tblRecieptReport].[PaymentLevel] = @PaymentLevel
        ORDER BY
               [tblRecieptReport].[EncodedDate]

    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_ProjectAddress]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_ProjectAddress] @projectId INT
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        -- Insert statements for procedure here


        SELECT
            [tblProjectMstr].[ProjectAddress],
            [tblProjectMstr].[ProjectType]
        FROM
            [dbo].[tblProjectMstr]
        WHERE
            ISNULL([tblProjectMstr].[IsActive], 0) = 1
            AND [tblProjectMstr].[RecId] = @projectId;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_RefreshUpdatesGroupControls]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_RefreshUpdatesGroupControls]
AS
BEGIN

    SET NOCOUNT ON;
    MERGE INTO [dbo].[tblGroupFormControls] AS [target]
    USING
    (
        SELECT [tblFormControlsMaster].[FormId],
               [tblFormControlsMaster].[ControlId],
               [tblGroup].[GroupId],
               1 AS [IsVisible],
               0 AS [IsDelete]
        FROM [dbo].[tblFormControlsMaster]
            CROSS JOIN [dbo].[tblGroup]
    ) AS [source]
    ON [target].[FormId] = [source].[FormId]
       AND [target].[ControlId] = [source].[ControlId]
       AND [target].[GroupId] = [source].[GroupId]
    WHEN NOT MATCHED THEN
        INSERT
        (
            [FormId],
            [ControlId],
            [GroupId],
            [IsVisible],
            [IsDelete]
        )
        VALUES
        ([source].[FormId], [source].[ControlId], [source].[GroupId], [source].[IsVisible], [source].[IsDelete]);
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveBankName]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SaveBankName] @BankName VARCHAR(50) = NULL
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;
        DECLARE @Message_Code VARCHAR(MAX) = '';
        -- Insert statements for procedure here
        IF NOT EXISTS
            (
                SELECT
                    [tblBankName].[BankName]
                FROM
                    [dbo].[tblBankName]
                WHERE
                    [tblBankName].[BankName] = @BankName
            )
            BEGIN
                INSERT INTO [dbo].[tblBankName]
                    (
                        [BankName]
                    )
                VALUES
                    (
                        UPPER(@BankName)
                    );
                IF (@@ROWCOUNT > 0)
                    BEGIN
                        SET @Message_Code = 'SUCCESS';
                    END;
            END;
        ELSE
            BEGIN

                SET @Message_Code = 'THIS BANK IS ALREADy EXISTST!';

            END;

        SELECT
            @Message_Code AS [Message_Code];
    END;

GO
/****** Object:  StoredProcedure [dbo].[sp_SaveClient]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SaveClient]
    @ClientType        VARCHAR(50),
    @ClientName        VARCHAR(100),
    @Age               INT            = 0,
    @PostalAddress     VARCHAR(100)   = NULL,
    @DateOfBirth       DATE           = NULL,
    @TelNumber         VARCHAR(20)    = NULL,
    @Gender            BIT            = NULL,
    @Nationality       VARCHAR(50)    = NULL,
    @Occupation        VARCHAR(100)   = NULL,
    @AnnualIncome      DECIMAL(18, 2) = 0,
    @EmployerName      VARCHAR(100)   = NULL,
    @EmployerAddress   VARCHAR(200)   = NULL,
    @SpouseName        VARCHAR(100)   = NULL,
    @ChildrenNames     VARCHAR(500)   = NULL,
    @TotalPersons      INT            = 0,
    @MaidName          VARCHAR(100)   = NULL,
    @DriverName        VARCHAR(100)   = NULL,
    @VisitorsPerDay    INT            = 0,
    @BuildingSecretary INT            = 0,
    @EncodedBy         INT            = 0,
    @ComputerName      VARCHAR(50)    = NULL,
	@TIN_No      VARCHAR(50)    = NULL
AS
    BEGIN
        SET NOCOUNT ON;



        INSERT INTO [dbo].[tblClientMstr]
            (
                [ClientType],
                [ClientName],
                [Age],
                [PostalAddress],
                [DateOfBirth],
                [TelNumber],
                [Gender],
                [Nationality],
                [Occupation],
                [AnnualIncome],
                [EmployerName],
                [EmployerAddress],
                [SpouseName],
                [ChildrenNames],
                [TotalPersons],
                [MaidName],
                [DriverName],
                [VisitorsPerDay],
                [BuildingSecretary],
                [EncodedDate],
                [EncodedBy],
                [IsActive],
                [ComputerName],
				[TIN_No]
            )
        VALUES
            (
                @ClientType, @ClientName, @Age, @PostalAddress, @DateOfBirth, @TelNumber, @Gender, @Nationality,
                @Occupation, @AnnualIncome, @EmployerName, @EmployerAddress, @SpouseName, @ChildrenNames,
                @TotalPersons, @MaidName, @DriverName, @VisitorsPerDay, @BuildingSecretary, GETDATE(), @EncodedBy, 1,
                @ComputerName,@TIN_No
            );

        IF (@@ROWCOUNT > 0)
            BEGIN
                SELECT
                    'SUCCESS' AS [Message_Code];
            END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveCompany]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_SaveCompany]
    @CompanyName VARCHAR(200) = NULL,
    @CompanyAddress VARCHAR(500) = NULL,
    @CompanyTIN VARCHAR(20) = NULL,
    @CompanyOwnerName VARCHAR(100) = NULL,
    @ComputerName VARCHAR(100) = NULL,
    @EncodedBy INT = NULL
AS
BEGIN
    DECLARE @Message_Code VARCHAR(MAX) = ''

    IF NOT EXISTS
    (
        SELECT 1
        FROM [dbo].[tblCompany]
        WHERE [tblCompany].[CompanyName] = UPPER(@CompanyName)
    )
    BEGIN

        INSERT INTO [dbo].[tblCompany]
        (
            [CompanyName],
            [CompanyAddress],
            [CompanyTIN],
            [CompanyOwnerName],
            [EncodedBy],
            [EncodedDate],
            [ComputerName],
            [Status]
        )
        VALUES
        (   UPPER(@CompanyName),      -- CompanyName - varchar(200)
            @CompanyAddress,          -- CompanyAddress - varchar(500)
            @CompanyTIN,              -- CompanyTIN - varchar(20)
            UPPER(@CompanyOwnerName), -- CompanyOwnerName - varchar(100)
            @EncodedBy,               -- EncodedBy - int
            GETDATE(),                -- EncodedDate - datetime      
            @ComputerName,            -- ComputerName - varchar(20),
            1)

        IF @@ROWCOUNT > 0
        BEGIN
            SET @Message_Code = 'SUCCESS'
        END
        ELSE
        BEGIN
            SET @Message_Code = ERROR_MESSAGE();
        END
    END
    ELSE
    BEGIN
        SET @Message_Code = 'COMPANY ALREADY EXIST';
    END

    SELECT @Message_Code AS [Message_Code]
END
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveComputation]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SaveComputation]
    @ProjectId INT,
    @InquiringClient VARCHAR(500),
    @ClientMobile VARCHAR(50),
    @UnitId INT,
    @UnitNo VARCHAR(50),
    @StatDate VARCHAR(10),
    @FinishDate VARCHAR(10),
    @Rental DECIMAL(18, 2) NULL,
    @SecAndMaintenance DECIMAL(18, 2),
    @TotalRent DECIMAL(18, 2),
    @SecDeposit DECIMAL(18, 2),
    @Total DECIMAL(18, 2),
    @EncodedBy INT,
    @ComputerName VARCHAR(30),
    @ClientID VARCHAR(50),
    @XML XML,
    @AdvancePaymentAmount DECIMAL(18, 2),
    @IsFullPayment BIT = 0,
    @IsRenewal BIT = 0
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @ComputationID AS INT = 0;
    DECLARE @ProjectType AS VARCHAR(20) = '';
    DECLARE @GenVat AS DECIMAL(18, 2) = 0;
    DECLARE @WithHoldingTax AS DECIMAL(18, 2) = 0;
    DECLARE @PenaltyPct AS DECIMAL(18, 2) = 0;
    DECLARE @RefId AS VARCHAR(30) = '';

    DECLARE @Unit_IsParking AS BIT = 0;
    DECLARE @Unit_IsNonVat AS BIT = 0;
    DECLARE @Unit_AreaSqm AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_AreaRateSqm AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_AreaTotalAmount AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_BaseRentalVatAmount AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_BaseRentalWithVatAmount AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_BaseRentalTax AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_TotalRental AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_SecAndMainAmount AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_SecAndMainVatAmount AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_SecAndMainWithVatAmount AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_Vat AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_Tax AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_TaxAmount AS DECIMAL(18, 2) = 0;

    DECLARE @Message_Code AS VARCHAR(MAX) = '';
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
        SELECT [ParaValues].[data].[value]('c1[1]', 'VARCHAR(10)')
        FROM @XML.[nodes]('/Table1') AS [ParaValues]([data]);
    END;

    SELECT @ProjectType = [tblProjectMstr].[ProjectType],
           @Unit_IsParking = [tblUnitMstr].[IsParking],
           @Unit_IsNonVat = [tblUnitMstr].[IsNonVat],
           @Unit_AreaSqm = [tblUnitMstr].[AreaSqm],
           @Unit_AreaRateSqm = [tblUnitMstr].[AreaRateSqm],
           @Unit_AreaTotalAmount = [tblUnitMstr].[AreaTotalAmount],
           @Unit_BaseRentalVatAmount = [tblUnitMstr].[BaseRentalVatAmount],
           @Unit_BaseRentalWithVatAmount = [tblUnitMstr].[BaseRentalWithVatAmount],
           @Unit_BaseRentalTax = [tblUnitMstr].[BaseRentalTax],
           @Unit_TotalRental = [tblUnitMstr].[TotalRental],
           @Unit_SecAndMainAmount = [tblUnitMstr].[SecAndMainAmount],
           @Unit_SecAndMainVatAmount = [tblUnitMstr].[SecAndMainVatAmount],
           @Unit_SecAndMainWithVatAmount = [tblUnitMstr].[SecAndMainWithVatAmount],
           @Unit_Vat = [tblUnitMstr].[Vat],
           @Unit_Tax = [tblUnitMstr].[Tax],
           @Unit_TaxAmount = [tblUnitMstr].[TaxAmount]
    FROM [dbo].[tblUnitMstr] WITH (NOLOCK)
        INNER JOIN [dbo].[tblProjectMstr] WITH (NOLOCK)
            ON [tblUnitMstr].[ProjectId] = [tblProjectMstr].[RecId]
    WHERE [tblUnitMstr].[RecId] = @UnitId;


    SELECT @GenVat = [tblRatesSettings].[GenVat],
           @WithHoldingTax = [tblRatesSettings].[WithHoldingTax],
           @PenaltyPct = [tblRatesSettings].[PenaltyPct]
    FROM [dbo].[tblRatesSettings] WITH (NOLOCK)
    WHERE [tblRatesSettings].[ProjectType] = @ProjectType;


    UPDATE [dbo].[tblUnitMstr]
    SET [tblUnitMstr].[UnitStatus] = 'RESERVED'
    WHERE [tblUnitMstr].[RecId] = @UnitId;

    -- Insert the record into tblClientMstr
    INSERT INTO [dbo].[tblUnitReference]
    (
        [ProjectId],
        [InquiringClient],
        [ClientMobile],
        [UnitId],
        [UnitNo],
        [StatDate],
        [FinishDate],
        [TransactionDate],
        [Rental],
        [SecAndMaintenance],
        [TotalRent],
        [SecDeposit],
        [Total],
        [EncodedBy],
        [EncodedDate],
        [IsActive],
        [ComputerName],
        [ClientID],
        [GenVat],
        [WithHoldingTax],
        [PenaltyPct],
        [AdvancePaymentAmount],
        [IsFullPayment],
        [Unit_IsNonVat],
        [Unit_AreaSqm],
        [Unit_AreaRateSqm],
        [Unit_AreaTotalAmount],
        [Unit_BaseRentalVatAmount],
        [Unit_BaseRentalWithVatAmount],
        [Unit_BaseRentalTax],
        [Unit_TotalRental],
        [Unit_SecAndMainAmount],
        [Unit_SecAndMainVatAmount],
        [Unit_SecAndMainWithVatAmount],
        [Unit_Vat],
        [Unit_Tax],
        [Unit_TaxAmount],
        [Unit_IsParking],
        [Unit_ProjectType],
        [IsRenewal]
    )
    VALUES
    (@ProjectId, @InquiringClient, @ClientMobile, @UnitId, @UnitNo, @StatDate, @FinishDate, GETDATE(), @Rental,
     @SecAndMaintenance, @TotalRent, @SecDeposit, @Total, @EncodedBy, GETDATE(), 1, @ComputerName, @ClientID, @GenVat,
     @WithHoldingTax, @PenaltyPct, @AdvancePaymentAmount, @IsFullPayment, @Unit_IsNonVat, @Unit_AreaSqm,
     @Unit_AreaRateSqm, @Unit_AreaTotalAmount, @Unit_BaseRentalVatAmount, @Unit_BaseRentalWithVatAmount,
     @Unit_BaseRentalTax, @Unit_TotalRental, @Unit_SecAndMainAmount, @Unit_SecAndMainVatAmount,
     @Unit_SecAndMainWithVatAmount, @Unit_Vat, @Unit_Tax, @Unit_TaxAmount, @Unit_IsParking, @ProjectType, @IsRenewal);
    SET @ComputationID = SCOPE_IDENTITY();

    IF (@@ROWCOUNT > 0)
    BEGIN
        SELECT @RefId = [tblUnitReference].[RefId]
        FROM [dbo].[tblUnitReference]
        WHERE [tblUnitReference].[RecId] = @ComputationID;
        INSERT INTO [dbo].[tblAdvancePayment]
        (
            [Months],
            [RefId],
            [Amount]
        )
        SELECT CONVERT(DATE, [#tblAdvancePayment].[Months]),
               @RefId,
               @TotalRent
        FROM [#tblAdvancePayment];

        EXEC [dbo].[sp_GenerateLedger] @FromDate = @StatDate,
                                       @EndDate = @FinishDate,
                                       @LedgAmount = @TotalRent,
                                       @Rental = @Rental,
                                       @SecAndMaintenance = @SecAndMaintenance,
                                       @ComputationID = @ComputationID,
                                       @ClientID = @ClientID,
                                       @EncodedBy = @EncodedBy,
                                       @ComputerName = @ComputerName,
                                       @UnitId = @UnitId,
									   @IsRenewal = @IsRenewal;

        SET @Message_Code = 'SUCCESS';

    END;

    SELECT @Message_Code AS [Message_Code];
    DROP TABLE [#tblAdvancePayment];
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveComputationParking]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SaveComputationParking]
    @ProjectId INT,
    @InquiringClient VARCHAR(500),
    @ClientMobile VARCHAR(50),
    @UnitId INT,
    @UnitNo VARCHAR(50),
    @StatDate VARCHAR(10),
    @FinishDate VARCHAR(10),
    @Rental DECIMAL(18, 2) NULL,
    @TotalRent DECIMAL(18, 2),
    @Total DECIMAL(18, 2),
    @EncodedBy INT,
    @ComputerName VARCHAR(30),
    @ClientID VARCHAR(50),
    @XML XML,
    @AdvancePaymentAmount DECIMAL(18, 2),
    @IsFullPayment BIT = 0,
	 @IsRenewal BIT = 0
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ComputationID AS INT = 0;
    DECLARE @ProjectType AS VARCHAR(20) = '';
    DECLARE @GenVat AS DECIMAL(18, 2) = 0;
    DECLARE @WithHoldingTax AS DECIMAL(18, 2) = 0;
    DECLARE @PenaltyPct AS DECIMAL(18, 2) = 0;
    DECLARE @RefId AS VARCHAR(30) = '';

    DECLARE @Unit_IsParking AS BIT = 0;
    DECLARE @Unit_IsNonVat AS BIT = 0;
    DECLARE @Unit_AreaSqm AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_AreaRateSqm AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_AreaTotalAmount AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_BaseRentalVatAmount AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_BaseRentalWithVatAmount AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_BaseRentalTax AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_TotalRental AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_SecAndMainAmount AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_SecAndMainVatAmount AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_SecAndMainWithVatAmount AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_Vat AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_Tax AS DECIMAL(18, 2) = 0;
    DECLARE @Unit_TaxAmount AS DECIMAL(18, 2) = 0;

    DECLARE @Message_Code AS VARCHAR(MAX) = '';
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
        SELECT [ParaValues].[data].[value]('c1[1]', 'VARCHAR(10)')
        FROM @XML.[nodes]('/Table1') AS [ParaValues]([data]);
    END;

    SELECT @ProjectType = [tblProjectMstr].[ProjectType],
           @Unit_IsParking = [tblUnitMstr].[IsParking],
           @Unit_IsNonVat = [tblUnitMstr].[IsNonVat],
           @Unit_AreaSqm = [tblUnitMstr].[AreaSqm],
           @Unit_AreaRateSqm = [tblUnitMstr].[AreaRateSqm],
           @Unit_AreaTotalAmount = [tblUnitMstr].[AreaTotalAmount],
           @Unit_BaseRentalVatAmount = [tblUnitMstr].[BaseRentalVatAmount],
           @Unit_BaseRentalWithVatAmount = [tblUnitMstr].[BaseRentalWithVatAmount],
           @Unit_BaseRentalTax = [tblUnitMstr].[BaseRentalTax],
           @Unit_TotalRental = [tblUnitMstr].[TotalRental],
           @Unit_SecAndMainAmount = [tblUnitMstr].[SecAndMainAmount],
           @Unit_SecAndMainVatAmount = [tblUnitMstr].[SecAndMainVatAmount],
           @Unit_SecAndMainWithVatAmount = [tblUnitMstr].[SecAndMainWithVatAmount],
           @Unit_Vat = [tblUnitMstr].[Vat],
           @Unit_Tax = [tblUnitMstr].[Tax],
           @Unit_TaxAmount = [tblUnitMstr].[TaxAmount]
    FROM [dbo].[tblUnitMstr] WITH (NOLOCK)
        INNER JOIN [dbo].[tblProjectMstr] WITH (NOLOCK)
            ON [tblUnitMstr].[ProjectId] = [tblProjectMstr].[RecId]
    WHERE [tblUnitMstr].[RecId] = @UnitId;


    SELECT @GenVat = [tblRatesSettings].[GenVat],
           @WithHoldingTax = [tblRatesSettings].[WithHoldingTax],
           @PenaltyPct = [tblRatesSettings].[PenaltyPct]
    FROM [dbo].[tblRatesSettings] WITH (NOLOCK)
    WHERE [tblRatesSettings].[ProjectType] = @ProjectType;

    UPDATE [dbo].[tblUnitMstr]
    SET [tblUnitMstr].[UnitStatus] = 'RESERVED'
    WHERE [tblUnitMstr].[RecId] = @UnitId;

    -- Insert the record into tblClientMstr
    INSERT INTO [dbo].[tblUnitReference]
    (
        [ProjectId],
        [InquiringClient],
        [ClientMobile],
        [UnitId],
        [UnitNo],
        [StatDate],
        [FinishDate],
        [TransactionDate],
        [Rental],
        [TotalRent],
        [Total],
        [EncodedBy],
        [EncodedDate],
        [IsActive],
        [ComputerName],
        [ClientID],
        [GenVat],
        [WithHoldingTax],
        [PenaltyPct],
        [AdvancePaymentAmount],
        [IsFullPayment],
        [Unit_IsNonVat],
        [Unit_AreaSqm],
        [Unit_AreaRateSqm],
        [Unit_AreaTotalAmount],
        [Unit_BaseRentalVatAmount],
        [Unit_BaseRentalWithVatAmount],
        [Unit_BaseRentalTax],
        [Unit_TotalRental],
        [Unit_SecAndMainAmount],
        [Unit_SecAndMainVatAmount],
        [Unit_SecAndMainWithVatAmount],
        [Unit_Vat],
        [Unit_Tax],
        [Unit_TaxAmount],
        [Unit_IsParking],
        [Unit_ProjectType],
		 [IsRenewal]
    )
    VALUES
    (@ProjectId, @InquiringClient, @ClientMobile, @UnitId, @UnitNo, @StatDate, @FinishDate, GETDATE(), @Rental,
     @TotalRent, @Total, @EncodedBy, GETDATE(), 1, @ComputerName, @ClientID, @GenVat, @WithHoldingTax, @PenaltyPct,
     @AdvancePaymentAmount, @IsFullPayment, @Unit_IsNonVat, @Unit_AreaSqm, @Unit_AreaRateSqm, @Unit_AreaTotalAmount,
     @Unit_BaseRentalVatAmount, @Unit_BaseRentalWithVatAmount, @Unit_BaseRentalTax, @Unit_TotalRental,
     @Unit_SecAndMainAmount, @Unit_SecAndMainVatAmount, @Unit_SecAndMainWithVatAmount, @Unit_Vat, @Unit_Tax,
     @Unit_TaxAmount, @Unit_IsParking, @ProjectType,@IsRenewal);
    SET @ComputationID = SCOPE_IDENTITY();
    IF (@@ROWCOUNT > 0)
    BEGIN

        SELECT @RefId = [tblUnitReference].[RefId]
        FROM [dbo].[tblUnitReference]
        WHERE [tblUnitReference].[RecId] = @ComputationID;
        INSERT INTO [dbo].[tblAdvancePayment]
        (
            [Months],
            [RefId],
            [Amount]
        )
        SELECT CONVERT(DATE, [#tblAdvancePayment].[Months]),
               @RefId,
               @TotalRent
        FROM [#tblAdvancePayment];

        EXEC [dbo].[sp_GenerateLedger] @FromDate = @StatDate,
                                       @EndDate = @FinishDate,
                                       @LedgAmount = @TotalRent,
                                       @Rental = @Rental,
                                       @ComputationID = @ComputationID,
                                       @ClientID = @ClientID,
                                       @EncodedBy = @EncodedBy,
                                       @ComputerName = @ComputerName,
                                       @UnitId = @UnitId,
									    @IsRenewal = @IsRenewal;

        SET @Message_Code = 'SUCCESS';
    END;

    SELECT @Message_Code AS [Message_Code];
    DROP TABLE [#tblAdvancePayment];
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveFile]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SaveFile]
    @FilePath         NVARCHAR(MAX),
    @FileData         VARBINARY(MAX),
    @ClientName       VARCHAR(100),
    @FileNames        VARCHAR(100),
    @Files            VARCHAR(200),
    @Notes            VARCHAR(500) = NULL,
    @ReferenceId      VARCHAR(500) = NULL,
    @IsSignedContract BIT          = 0
AS
    BEGIN
        INSERT INTO [dbo].[Files]
            (
                [ClientName],
                [FilePath],
                [FileData],
                [FileNames],
                [Notes],
                [Files],
                [RefId]
            )
        VALUES
            (
                @ClientName, @FilePath, @FileData, @FileNames, @Notes, @Files, @ReferenceId
            );

        -- Log a success event    
        IF (@@ROWCOUNT > 0)
            BEGIN
                -- Log a success event
                INSERT INTO [dbo].[LoggingEvent]
                    (
                        [EventType],
                        [EventMessage]
                    )
                VALUES
                    (
                        'SUCCESS', 'Result From : sp_SaveFile -(' + @FilePath + ') File saved successfully'
                    );

                SELECT
                    'SUCCESS' AS [Message_Code];
            END;
        ELSE
            BEGIN
                -- Log an error event
                INSERT INTO [dbo].[LoggingEvent]
                    (
                        [EventType],
                        [EventMessage]
                    )
                VALUES
                    (
                        'ERROR', 'Result From : sp_SaveFile -' + 'No rows affected in Files table'
                    );

            END;
        -- Update the flag in tblUnitReference
        IF (@IsSignedContract = 1)
            BEGIN
                UPDATE
                    [dbo].[tblUnitReference]
                SET
                    [tblUnitReference].[IsSignedContract] = 1,
                    [tblUnitReference].[SignedContractDate] = GETDATE()
                WHERE
                    [tblUnitReference].[RefId] = @ReferenceId;

                IF (@@ROWCOUNT > 0)
                    BEGIN
                        -- Log a success event
                        INSERT INTO [dbo].[LoggingEvent]
                            (
                                [EventType],
                                [EventMessage]
                            )
                        VALUES
                            (
                                'SUCCESS',
                                'Result From : sp_SaveFile -' + '(' + @ReferenceId
                                + ': IsSignedContract = 1 ) UnitReference updated successfully'
                            );

                        SELECT
                            'SUCCESS' AS [Message_Code];
                    END;
                ELSE
                    BEGIN

                        -- Log an error event
                        INSERT INTO [dbo].[LoggingEvent]
                            (
                                [EventType],
                                [EventMessage]
                            )
                        VALUES
                            (
                                'ERROR', 'Result From : sp_SaveFile -' + 'No rows affected in UnitReference table'
                            );
                    END;
            END;
        -- Log the error message
        DECLARE @ErrorMessage NVARCHAR(MAX);
        SET @ErrorMessage = ERROR_MESSAGE();


        IF @ErrorMessage <> ''
            BEGIN
                -- Log an error event
                INSERT INTO [dbo].[LoggingEvent]
                    (
                        [EventType],
                        [EventMessage]
                    )
                VALUES
                    (
                        'ERROR', 'From : sp_SaveFile -' + @ErrorMessage
                    );

                -- Insert into a logging table
                INSERT INTO [dbo].[ErrorLog]
                    (
                        [ProcedureName],
                        [ErrorMessage],
                        [LogDateTime]
                    )
                VALUES
                    (
                        'sp_SaveFile', @ErrorMessage, GETDATE()
                    );

                -- Return an error message
                SELECT
                    'ERROR'       AS [Message_Code],
                    @ErrorMessage AS [ErrorMessage];
            END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveFormControls]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SaveFormControls]
    @FormId             INT         = NULL,
    @MenuId             INT         = NULL,
    @ControlName        VARCHAR(50) = NULL,
    @ControlDescription VARCHAR(50) = NULL,
    @IsBackRoundControl BIT         = 0,
    @IsHeaderControl    BIT         = 0
AS
    BEGIN

        SET NOCOUNT ON;
        DECLARE @Message_Code NVARCHAR(MAX) = N'';

        IF NOT EXISTS
            (
                SELECT
                    [tblFormControlsMaster].[ControlName]
                FROM
                    [dbo].[tblFormControlsMaster] WITH (NOLOCK)
                WHERE
                    [tblFormControlsMaster].[ControlName] = @ControlName
                    AND [tblFormControlsMaster].[FormId] = @FormId
                    AND [tblFormControlsMaster].[MenuId] = @MenuId
            )
            BEGIN
                INSERT INTO [dbo].[tblFormControlsMaster]
                    (
                        [FormId],
                        [MenuId],
                        [ControlName],
                        [ControlDescription],
                        [IsBackRoundControl],
                        [IsHeaderControl],
                        [IsDelete]
                    )
                VALUES
                    (
                        @FormId, @MenuId, @ControlName, @ControlDescription, @IsBackRoundControl, @IsHeaderControl, 0
                    );
                IF (@@ROWCOUNT > 0)
                    BEGIN
                        SET @Message_Code = N'SUCCESS';
                    END;
            END;
        ELSE
            BEGIN
                SET @Message_Code = N'CONTROL NAME ALREADY EXISTS';
            END;

        SELECT
            @Message_Code AS [Message_Code];

    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveLocation]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SaveLocation]
    @Description VARCHAR(50)  = NULL,
    @LocAddress  VARCHAR(500) = NULL
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        -- Insert statements for procedure here
        INSERT INTO [dbo].[tblLocationMstr]
            (
                [Descriptions],
                [LocAddress],
                [IsActive]
            )
        VALUES
            (
                @Description, @LocAddress, 1
            );

        IF (@@ROWCOUNT > 0)
            BEGIN
                SELECT
                    'SUCCESS' AS [Message_Code];
            END;
        ELSE
            BEGIN
                SELECT
                    'FAIL' AS [Message_Code];
            END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveNewtUnit]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SaveNewtUnit]
    @ProjectId INT = NULL,
    @IsParking BIT = NULL,
    @FloorNo INT = NULL,
    @AreaSqm DECIMAL(18, 2) = NULL,
    @AreaRateSqm DECIMAL(18, 2) = NULL,
    @AreaTotalAmount DECIMAL(18, 2) = NULL,
    @FloorType VARCHAR(50) = NULL,
    @BaseRental DECIMAL(18, 2) = NULL,
    @DetailsofProperty VARCHAR(300) = NULL,
    @UnitNo VARCHAR(20) = NULL,
    @UnitSequence INT = NULL,
    @BaseRentalVatAmount DECIMAL(18, 2) = NULL,
    @BaseRentalWithVatAmount DECIMAL(18, 2) = NULL,
    @BaseRentalTax DECIMAL(18, 2) = NULL,
    @IsNonVat BIT = NULL,
    @TotalRental DECIMAL(18, 2) = NULL,
    @SecAndMainAmount DECIMAL(18, 2) = NULL,
    @SecAndMainVatAmount DECIMAL(18, 2) = NULL,
    @SecAndMainWithVatAmount DECIMAL(18, 2) = NULL,
    @Vat DECIMAL(18, 2) = NULL,
    @Tax DECIMAL(18, 2) = NULL,
    @TaxAmount DECIMAL(18, 2) = NULL,
    @EndodedBy INT = NULL,
    @ComputerName VARCHAR(20) = NULL
AS
BEGIN
    DECLARE @Message_Code VARCHAR(100) = '';
    IF NOT EXISTS
    (
        SELECT 1
        FROM [dbo].[tblUnitMstr]
        WHERE [tblUnitMstr].[ProjectId] = @ProjectId
              AND [tblUnitMstr].[UnitNo] = @UnitNo
              AND [tblUnitMstr].[FloorType] = @FloorType
              AND [tblUnitMstr].[IsParking] = @IsParking
    )
    BEGIN
        INSERT INTO [dbo].[tblUnitMstr]
        (
            [ProjectId],
            [IsParking],
            [FloorNo],
            [AreaSqm],
            [AreaRateSqm],
            [AreaTotalAmount],
            [FloorType],
            [BaseRental],
            [UnitStatus],
            [DetailsofProperty],
            [UnitNo],
            [UnitSequence],
            [EndodedBy],
            [EndodedDate],
            [IsActive],
            [ComputerName],
            [BaseRentalVatAmount],
            [BaseRentalWithVatAmount],
            [BaseRentalTax],
            [IsNonVat],
            [TotalRental],
            [SecAndMainAmount],
            [SecAndMainVatAmount],
            [SecAndMainWithVatAmount],
            [Vat],
            [Tax],
            [TaxAmount]
        )
        VALUES
        (@ProjectId, @IsParking, @FloorNo, @AreaSqm, @AreaRateSqm, @AreaTotalAmount, @FloorType, @BaseRental, 'VACANT',
         @DetailsofProperty, @UnitNo, @UnitSequence, @EndodedBy, GETDATE(), 1, @ComputerName, @BaseRentalVatAmount,
         @BaseRentalWithVatAmount, @BaseRentalTax, @IsNonVat, @TotalRental, @SecAndMainAmount, @SecAndMainVatAmount,
         @SecAndMainWithVatAmount, @Vat, @Tax, @TaxAmount);

        IF (@@ROWCOUNT > 0)
        BEGIN
            SET @Message_Code = 'SUCCESS';
        END;
    END;
    ELSE
    BEGIN
        SET @Message_Code = 'UNIT NUMBER ALREADY TAKEN.';
    END;


    SELECT @Message_Code AS [Message_Code];
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveProject]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SaveProject]
    @ProjectType VARCHAR(50) = NULL,
    @LocId INT = NULL,
    @ProjectName VARCHAR(50) = NULL,
    @Descriptions VARCHAR(50) = NULL,
    @ProjectAddress VARCHAR(500) = NULL,
    @CompanyId INT = NULL
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here

    IF NOT EXISTS
    (
        SELECT [tblProjectMstr].[ProjectName]
        FROM [dbo].[tblProjectMstr]
        WHERE [tblProjectMstr].[ProjectName] = @ProjectName
    )
    BEGIN
        INSERT INTO [dbo].[tblProjectMstr]
        (
            [ProjectType],
            [LocId],
            [ProjectName],
            [Descriptions],
            [ProjectAddress],
            [IsActive],
            [CompanyId]
        )
        VALUES
        (@ProjectType, @LocId, @ProjectName, @Descriptions, @ProjectAddress, 1, @CompanyId);

        IF (@@ROWCOUNT > 0)
        BEGIN
            SELECT 'SUCCESS' AS [Message_Code];
        END;
    END;
    ELSE
    BEGIN
        SELECT 'PROJECT NAME ALREADY EXISTS' AS [Message_Code];
    END;
END;


GO
/****** Object:  StoredProcedure [dbo].[sp_SavePurchaseItem]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SavePurchaseItem]
    @ProjectId    INT            = NULL,
    @Descriptions VARCHAR(200)   = NULL,
    @DatePurchase DATETIME       = NULL,
    @UnitAmount   INT            = NULL,
    @Amount       DECIMAL(18, 2) = NULL,
    @TotalAmount  DECIMAL(18, 2) = NULL,
    @Remarks      VARCHAR(200)   = NULL,
    @UnitNumber   VARCHAR(50)    = NULL,
    @UnitID       INT            = NULL,
    @EncodedBy    INT            = NULL,
    @ComputerName VARCHAR(50)    = NULL
AS
    BEGIN

        SET NOCOUNT ON;

        IF NOT EXISTS
            (
                SELECT
                    *
                FROM
                    [dbo].[tblProjPurchItem]
                WHERE
                    [tblProjPurchItem].[Descriptions] = @Descriptions
                    AND [tblProjPurchItem].[ProjectId] = @ProjectId
            )
            BEGIN
                INSERT INTO [dbo].[tblProjPurchItem]
                    (
                        [ProjectId],
                        [Descriptions],
                        [DatePurchase],
                        [UnitAmount],
                        [Amount],
                        [TotalAmount],
                        [Remarks],
                        [UnitNumber],
                        [UnitID],
                        [EncodedBy],
                        [EncodedDate],
                        [ComputerName],
                        [IsActive]
                    )
                VALUES
                    (
                        @ProjectId, @Descriptions, @DatePurchase, @UnitAmount, @Amount, @TotalAmount, @Remarks,
                        @UnitNumber, @UnitID, @EncodedBy, GETDATE(), @ComputerName, 1
                    );

                IF (@@ROWCOUNT > 0)
                    BEGIN
                        SELECT
                            'SUCCESS' AS [Message_Code];
                    END;
            END;
        ELSE
            BEGIN
                SELECT
                    'PROJECT NAME ALREADY EXISTS' AS [Message_Code];
            END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveUser]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_SaveUser]
    @GroupId AS INT = NULL,
    @UserId AS INT = NULL,
    @UserPassword AS NVARCHAR(MAX) = NULL,
    @UserName AS VARCHAR(200) = NULL,
    @StaffName AS VARCHAR(200) = NULL,
    @Middlename AS VARCHAR(50) = NULL,
    @Lastname AS VARCHAR(50) = NULL,
    @EmailAddress AS VARCHAR(100) = NULL,
    @Phone AS VARCHAR(20) = NULL,
    @Mode AS VARCHAR(10) = ''
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Message_Code AS NVARCHAR(MAX) = N'';

    IF @Mode = 'NEW'
    BEGIN

        IF NOT EXISTS
        (
            SELECT [tblUser].[UserName]
            FROM [dbo].[tblUser]
            WHERE [tblUser].[UserName] = @UserName
        )
        BEGIN
            INSERT INTO [dbo].[tblUser]
            (
                [GroupId],
                [UserName],
                [UserPassword],
                [UserPasswordIncrypt],
                [StaffName],
                [Middlename],
                [Lastname],
                [EmailAddress],
                [Phone],
                [IsDelete]
            )
            VALUES
            (   @GroupId,      -- GroupId - int
                @UserName,     -- UserName - varchar(100)
                @UserPassword, -- UserPassword - nvarchar(max)
                NULL,          -- UserPasswordIncrypt - varchar(200)
                @StaffName,    -- StaffName - varchar(200)
                @Middlename,   -- Middlename - varchar(50)
                @Lastname,     -- Lastname - varchar(50)
                @EmailAddress, -- EmailAddress - varchar(100)
                @Phone,        -- Phone - varchar(20)
                0              -- IsDelete - bit
                );


            IF (@@ROWCOUNT > 0)
            BEGIN
                SET @Message_Code = N'SUCCESS';
            END;
            ELSE
            BEGIN
                SET @Message_Code = ERROR_MESSAGE();
            END;
        END;
        ELSE
        BEGIN
            SET @Message_Code = N'User Name already exist';
        END;

    END;
    ELSE IF @Mode = 'EDIT'
        IF NOT EXISTS
        (
            SELECT [tblUser].[UserName]
            FROM [dbo].[tblUser]
            WHERE [tblUser].[UserName] = @UserName
        )
        BEGIN
            UPDATE [dbo].[tblUser]
            SET [tblUser].[GroupId] = @GroupId,
                [tblUser].[UserPassword] = @UserPassword,
                [tblUser].[UserName] = @UserName,
                [tblUser].[StaffName] = @StaffName,
                [tblUser].[Lastname] = @Lastname,
                [tblUser].[Middlename] = @Middlename,
                [tblUser].[EmailAddress] = @EmailAddress,
                [tblUser].[Phone] = @Phone
            WHERE [tblUser].[UserId] = @UserId;

            IF (@@ROWCOUNT > 0)
            BEGIN
                SET @Message_Code = N'SUCCESS';
            END;
            ELSE
            BEGIN
                SET @Message_Code = ERROR_MESSAGE();
            END;

        END;
        ELSE
        BEGIN
            SET @Message_Code = N'User Name already exist';
        END;
    SELECT @Message_Code AS [Message_Code];
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveUserGroup]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_SaveUserGroup] @GroupName AS VARCHAR(50) = NULL
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Message_Code NVARCHAR(MAX) = N'';
    IF NOT EXISTS
    (
        SELECT [tblGroup].[GroupName]
        FROM [dbo].[tblGroup]
        WHERE [tblGroup].[GroupName] = @GroupName
    )
    BEGIN


        INSERT INTO [dbo].[tblGroup]
        (
            [GroupName],
            [IsDelete]
        )
        VALUES
        (   UPPER(@GroupName), -- GroupName - varchar(50)
            0           -- IsDelete - bit
            );
        IF (@@ROWCOUNT > 0)
        BEGIN
            MERGE INTO [dbo].[tblGroupFormControls] AS [target]
            USING
            (
                SELECT [tblFormControlsMaster].[FormId],
                       [tblFormControlsMaster].[ControlId],
                       [tblGroup].[GroupId],
                       1 AS [IsVisible],
                       0 AS [IsDelete]
                FROM [dbo].[tblFormControlsMaster]
                    CROSS JOIN [dbo].[tblGroup]
            ) AS [source]
            ON [target].[FormId] = [source].[FormId]
               AND [target].[ControlId] = [source].[ControlId]
               AND [target].[GroupId] = [source].[GroupId]
            WHEN NOT MATCHED THEN
                INSERT
                (
                    [FormId],
                    [ControlId],
                    [GroupId],
                    [IsVisible],
                    [IsDelete]
                )
                VALUES
                ([source].[FormId], [source].[ControlId], [source].[GroupId], [source].[IsVisible], [source].[IsDelete]);
            SET @Message_Code = N'SUCCESS';
        END;
    END;
    ELSE
    BEGIN
        SET @Message_Code = ERROR_MESSAGE();
    END;

    SELECT @Message_Code AS [Message_Code];
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_SelectBankName]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SelectBankName]
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT ISNULL([tblBankName].[BankName], '') AS [BankName]
    FROM [dbo].[tblBankName]
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_SelectFloorTypes]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SelectFloorTypes]
-- Add the parameters for the stored procedure here

AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        -- Insert statements for procedure here
        SELECT
            -1           AS [RecId],
            '--SELECT--' AS [FloorTypesDescription]
        UNION
        SELECT
            [tblFloorTypes].[RecId],
            [tblFloorTypes].[FloorTypesDescription]
        FROM
            [dbo].[tblFloorTypes];
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_SelectLocation]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SelectLocation]
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        -- Insert statements for procedure here
        SELECT
            [tblLocationMstr].[RecId],
            [tblLocationMstr].[Descriptions]
        FROM
            [dbo].[tblLocationMstr]
        UNION
        SELECT
            -1,
            '--SELECT--';
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_SelectPaymentMode]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SelectPaymentMode]
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;


    --SELECT -1 AS ModeType,'--SELECT--' AS Mode
    --UNION
    SELECT 'PDC' AS [ModeType],
           'PDC' AS [Mode]
    UNION
    SELECT 'BANK' AS [ModeType],
           'BANK' AS [Mode]
    UNION
    SELECT 'CASH' AS [ModeType],
           'CASH' AS [Mode]
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_SelectProject]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SelectProject]
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        -- Insert statements for procedure here

        SELECT
            -1           AS [RecId],
            '--SELECT--' AS [ProjectName]
        UNION
        SELECT
            [tblProjectMstr].[RecId],
            [tblProjectMstr].[ProjectName]
        FROM
            [dbo].[tblProjectMstr]
        WHERE
            ISNULL([tblProjectMstr].[IsActive], 0) = 1;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_SelectProjectType]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SelectProjectType]
-- Add the parameters for the stored procedure here

AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        -- Insert statements for procedure here
        SELECT
            -1           AS [Recid],
            '--SELECT--' AS [ProjectTypeName]
        UNION
        SELECT
            [tblProjectType].[Recid],
            [tblProjectType].[ProjectTypeName]
        FROM
            [dbo].[tblProjectType] WITH (NOLOCK);



    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_TerminateContract]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_TerminateContract]
    @ReferenceID  VARCHAR(50) = NULL,
    @EncodedBy    INT         = NULL,
    @ComputerName VARCHAR(20) = NULL
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        DECLARE @Message_Code NVARCHAR(MAX);
        -- Insert statements for procedure here
        UPDATE
            [dbo].[tblUnitReference]
        SET
            [tblUnitReference].[IsTerminated] = 1,
            [tblUnitReference].[IsUnitMoveOut] = 1,
            [tblUnitReference].[LastCHangedBy] = @EncodedBy,
            [tblUnitReference].[UnitMoveOutDate] = GETDATE(),
            [tblUnitReference].[TerminationDate] = GETDATE()
        WHERE
            [tblUnitReference].[RefId] = @ReferenceID;

        IF (@@ROWCOUNT > 0)
            BEGIN
                -- Log a success event
                INSERT INTO [dbo].[LoggingEvent]
                    (
                        [EventType],
                        [EventMessage]
                    )
                VALUES
                    (
                        'SUCCESS',
                        'Result From : sp_TerminateContract -(' + @ReferenceID
                        + ': IsTerminated= 1,IsDone=1) tblUnitReference updated successfully'
                    );

                SET @Message_Code = N'SUCCESS';
            END;
        ELSE
            BEGIN
                -- Log an error event
                INSERT INTO [dbo].[LoggingEvent]
                    (
                        [EventType],
                        [EventMessage]
                    )
                VALUES
                    (
                        'ERROR', 'Result From : sp_TerminateContract -' + 'No rows affected in tblUnitReference table'
                    );

            END;

        UPDATE
            [dbo].[tblUnitMstr]
        SET
            [tblUnitMstr].[UnitStatus] = 'HOLD'
        --LastCHangedBy = @EncodedBy,
        --ComputerName = @ComputerName,
        --LastChangedDate = GETDATE()
        WHERE
            [RecId] =
            (
                SELECT
                    [tblUnitReference].[UnitId]
                FROM
                    [dbo].[tblUnitReference]
                WHERE
                    [tblUnitReference].[RefId] = @ReferenceID
            );

        IF (@@ROWCOUNT > 0)
            BEGIN
                -- Log a success event
                INSERT INTO [dbo].[LoggingEvent]
                    (
                        [EventType],
                        [EventMessage]
                    )
                VALUES
                    (
                        'SUCCESS',
                        'Result From : sp_TerminateContract -(UnitStatus= HOLD) tblUnitMstr updated successfully'
                    );

                SET @Message_Code = N'SUCCESS';
            END;
        ELSE
            BEGIN
                -- Log an error event
                INSERT INTO [dbo].[LoggingEvent]
                    (
                        [EventType],
                        [EventMessage]
                    )
                VALUES
                    (
                        'ERROR', 'Result From : sp_TerminateContract -' + 'No rows affected in tblUnitMstr table'
                    );

            END;
        -- Log the error message
        DECLARE @ErrorMessage NVARCHAR(MAX);
        SET @ErrorMessage = ERROR_MESSAGE();

        IF @ErrorMessage <> ''
            BEGIN
                -- Log an error event
                INSERT INTO [dbo].[LoggingEvent]
                    (
                        [EventType],
                        [EventMessage]
                    )
                VALUES
                    (
                        'ERROR', 'From : sp_TerminateContract -' + @ErrorMessage
                    );

                -- Insert into a logging table
                INSERT INTO [dbo].[ErrorLog]
                    (
                        [ProcedureName],
                        [ErrorMessage],
                        [LogDateTime]
                    )
                VALUES
                    (
                        'sp_TerminateContract', @ErrorMessage, GETDATE()
                    );

                -- Return an error message				
                SET @Message_Code = @ErrorMessage;
            END;

        SELECT
            @Message_Code AS [Message_Code];

    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateAnnouncement]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_UpdateAnnouncement] @Message AS NVARCHAR(MAX) = ''
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    UPDATE [dbo].[tblAnnouncement]
    SET [tblAnnouncement].[AnnounceMessage] = @Message

	IF @@ROWCOUNT > 0
	BEGIN
	SELECT 'SUCCESS' AS Message_Code
	END

END
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateClient]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_UpdateClient]
    @ClientID        VARCHAR(50),
    @ClientType        VARCHAR(50),
    @ClientName        VARCHAR(100),
    @Age               INT            = 0,
    @PostalAddress     VARCHAR(100)   = NULL,
    @DateOfBirth       DATE           = NULL,
    @TelNumber         VARCHAR(20)    = NULL,
    @Gender            BIT            = NULL,
    @Nationality       VARCHAR(50)    = NULL,
    @Occupation        VARCHAR(100)   = NULL,
    @AnnualIncome      DECIMAL(18, 2) = 0,
    @EmployerName      VARCHAR(100)   = NULL,
    @EmployerAddress   VARCHAR(200)   = NULL,
    @SpouseName        VARCHAR(100)   = NULL,
    @ChildrenNames     VARCHAR(500)   = NULL,
    @TotalPersons      INT            = 0,
    @MaidName          VARCHAR(100)   = NULL,
    @DriverName        VARCHAR(100)   = NULL,
    @VisitorsPerDay    INT            = 0,
    @BuildingSecretary INT            = 0,
    @EncodedBy         INT            = 0,
    @ComputerName      VARCHAR(50)    = NULL,
	@TIN_No      VARCHAR(50)    = NULL,
	@IsActive BIT = NULL
AS
    BEGIN
        SET NOCOUNT ON;




		update [tblClientMstr] 
		set [ClientType] = @ClientType,
		[ClientName] = @ClientName,
		[Age] = @Age,
		[PostalAddress] = @PostalAddress,
		[DateOfBirth] = @DateOfBirth,
		[TelNumber] = @TelNumber,
		[Gender] = @Gender,
		[Nationality] = @Nationality,
		[Occupation] = @Occupation,
		[AnnualIncome] = @AnnualIncome,
		[EmployerName] = @EmployerName,
		[EmployerAddress] = @EmployerAddress,
		[SpouseName]=@SpouseName,
		[ChildrenNames]=@ChildrenNames,
		[TotalPersons] = @TotalPersons,
		[MaidName] = @MaidName,
		[DriverName] = @DriverName,
		[VisitorsPerDay] = @VisitorsPerDay,
		[BuildingSecretary]=@BuildingSecretary,
		[LastChangedDate] = GETDATE(),
		[LastChangedBy] = @EncodedBy,
		--[IsActive]= @IsActive,
		[ComputerName] = @ComputerName,
		[TIN_No] = @TIN_No
		WHERE [ClientID] = @ClientID
        

        IF (@@ROWCOUNT > 0)
            BEGIN
                SELECT
                    'SUCCESS' AS [Message_Code];
            END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateCOMMERCIALSettings]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UpdateCOMMERCIALSettings]
    @GenVat DECIMAL(18, 2) = NULL,
    @SecurityAndMaintenance DECIMAL(18, 2) = NULL,
    @WithHoldingTax DECIMAL(18, 2) = NULL,
    @PenaltyPct DECIMAL(18, 2) = NULL,
    @LastChangedBy INT = NULL
AS
BEGIN

    SET NOCOUNT ON;


    UPDATE [dbo].[tblRatesSettings]
    SET [tblRatesSettings].[GenVat] = @GenVat,
        [tblRatesSettings].[SecurityAndMaintenance] = @SecurityAndMaintenance,
        [tblRatesSettings].[WithHoldingTax] = @WithHoldingTax,
        [tblRatesSettings].[PenaltyPct] = @PenaltyPct,
        [tblRatesSettings].[LastChangedBy] = @LastChangedBy,
        [tblRatesSettings].[LastChangedDate] = GETDATE()
    WHERE [tblRatesSettings].[ProjectType] = 'COMMERCIAL';

    IF (@@ROWCOUNT > 0)
    BEGIN
        SELECT 'SUCCESS' AS [Message_Code];
    END;
    ELSE
    BEGIN
        SELECT ERROR_MESSAGE() AS [Message_Code];
    END;


END;
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateCompany]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_UpdateCompany]
    @RecId INT = NULL,
    @CompanyName VARCHAR(200) = NULL,
    @CompanyAddress VARCHAR(500) = NULL,
    @CompanyTIN VARCHAR(20) = NULL,
    @CompanyOwnerName VARCHAR(100) = NULL,
    @ComputerName VARCHAR(100) = NULL,
    @EncodedBy INT = NULL
AS
BEGIN
    DECLARE @Message_Code VARCHAR(MAX) = ''

    IF EXISTS
    (
        SELECT 1
        FROM [dbo].[tblCompany]
        WHERE [tblCompany].[CompanyName] = UPPER(@CompanyName)
    )
    BEGIN

        UPDATE [dbo].[tblCompany]
        SET [tblCompany].[CompanyName] = UPPER(@CompanyName),
            [tblCompany].[CompanyAddress] = @CompanyAddress,
            [tblCompany].[CompanyTIN] = @CompanyTIN,
            [tblCompany].[CompanyOwnerName] = UPPER(@CompanyOwnerName),
            [tblCompany].[LastChangedBy] = @EncodedBy,
            [tblCompany].[LastChangedDate] = GETDATE(),
            [tblCompany].[ComputerName] = @ComputerName
        WHERE [tblCompany].[RecId] = @RecId
        IF @@ROWCOUNT > 0
        BEGIN
            SET @Message_Code = 'SUCCESS'
        END
        ELSE
        BEGIN
            SET @Message_Code = ERROR_MESSAGE();
        END
    END
    ELSE
    BEGIN
        SET @Message_Code = 'COMPANY NOT EXIST';
    END

    SELECT @Message_Code AS [Message_Code]
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateGroupFormControls]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_UpdateGroupFormControls]
    @FormId AS    INT = NULL,
    @ControlId AS INT = NULL,
    @GroupId AS   INT = NULL,
    @IsVisible AS BIT = NULL
AS
    BEGIN
        SET NOCOUNT ON;

        DECLARE @Message_Code AS NVARCHAR(MAX) = N'';
        UPDATE
            [dbo].[tblGroupFormControls]
        SET
            [tblGroupFormControls].[IsVisible] = @IsVisible
        WHERE
            [tblGroupFormControls].[FormId] = @FormId
            AND [tblGroupFormControls].[ControlId] = @ControlId
            AND [tblGroupFormControls].[GroupId] = @GroupId;


        IF (@@ROWCOUNT > 0)
            BEGIN
                SET @Message_Code = N'SUCCESS';
            END;
        ELSE
            BEGIN
                SET @Message_Code = ERROR_MESSAGE();
            END;
        SELECT
            @Message_Code AS [Message_Code];
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateLocationById]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UpdateLocationById]
    @RecId        INT,
    @Descriptions VARCHAR(50)  = NULL,
    @LocAddress   VARCHAR(500) = NULL
--@IsActive bit = NULL

AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;


        UPDATE
            [dbo].[tblLocationMstr]
        SET
            [tblLocationMstr].[Descriptions] = @Descriptions,
            [tblLocationMstr].[LocAddress] = @LocAddress
        WHERE
            [tblLocationMstr].[RecId] = @RecId;

        IF (@@ROWCOUNT > 0)
            BEGIN

                SELECT
                    'SUCCESS' AS [Message_Code];

            END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateORNumber]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_UpdateORNumber]
    @RcptID AS VARCHAR(20) = NULL,
    @CompanyORNo AS VARCHAR(20) = NULL,
    @EncodedBy AS INT = NULL
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    UPDATE [dbo].[tblReceipt]
    SET [tblReceipt].[CompanyORNo] = @CompanyORNo,
        [tblReceipt].[EncodedBy] = @EncodedBy,
        [tblReceipt].[EncodedDate] = GETDATE()
    WHERE [tblReceipt].[RcptID] = @RcptID;
    UPDATE [dbo].[tblPaymentMode]
    SET [tblPaymentMode].[CompanyORNo] = @CompanyORNo
    WHERE [tblPaymentMode].[RcptID] = @RcptID;

    IF @@ROWCOUNT > 0
    BEGIN
        SELECT 'SUCCESS' AS Message_Code;

    END;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateProjectById]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UpdateProjectById]
    @RecId          INT,
    @ProjectType    VARCHAR(50)  = NULL,
    @LocId          INT,
    @ProjectName    VARCHAR(50)  = NULL,
    @Descriptions   VARCHAR(500) = NULL,
    @ProjectAddress VARCHAR(500) = NULL
AS
    BEGIN

        SET NOCOUNT ON;


        UPDATE
            [dbo].[tblProjectMstr]
        SET
            [tblProjectMstr].[LocId] = @LocId,
            [tblProjectMstr].[Descriptions] = @Descriptions,
            [tblProjectMstr].[ProjectName] = @ProjectName,
            [tblProjectMstr].[ProjectType] = @ProjectType,
            [tblProjectMstr].[ProjectAddress] = @ProjectAddress
        WHERE
            [tblProjectMstr].[RecId] = @RecId;

        IF (@@ROWCOUNT > 0)
            BEGIN

                SELECT
                    'SUCCESS' AS [Message_Code];

            END;
    END;

GO
/****** Object:  StoredProcedure [dbo].[sp_UpdatePurchaseItemById]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UpdatePurchaseItemById]
    @RecId         INT,
    @ProjectId     INT,
    @Descriptions  VARCHAR(50)    = NULL,
    @DatePurchase  VARCHAR(500)   = NULL,
    @UnitAmount    DECIMAL(18, 2) = NULL,
    @Amount        DECIMAL(18, 2) = NULL,
    @TotalAmount   DECIMAL(18, 2) = NULL,
    @Remarks       VARCHAR(200)   = NULL,
    @UnitNumber    VARCHAR(50)    = NULL,
    @UnitID        INT            = NULL,
    @LastChangedBy INT            = NULL,
    @ComputerName  VARCHAR(50)    = NULL
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        IF EXISTS
            (
                SELECT
                    *
                FROM
                    [dbo].[tblProjPurchItem]
                WHERE
                    [tblProjPurchItem].[RecId] = @RecId
            )
            BEGIN

                UPDATE
                    [dbo].[tblProjPurchItem]
                SET
                    [tblProjPurchItem].[ProjectId] = @ProjectId,
                    [tblProjPurchItem].[Descriptions] = @Descriptions,
                    [tblProjPurchItem].[DatePurchase] = @DatePurchase,
                    [tblProjPurchItem].[UnitAmount] = @UnitAmount,
                    [tblProjPurchItem].[Amount] = @Amount,
                    [tblProjPurchItem].[TotalAmount] = @TotalAmount,
                    [tblProjPurchItem].[Remarks] = @Remarks,
                    [tblProjPurchItem].[UnitNumber] = @UnitNumber,
                    [tblProjPurchItem].[UnitID] = @UnitID,
                    [tblProjPurchItem].[LastChangedBy] = @LastChangedBy,
                    [tblProjPurchItem].[LastChangedDate] = GETDATE(),
                    [tblProjPurchItem].[ComputerName] = @ComputerName
                WHERE
                    [tblProjPurchItem].[RecId] = @RecId;

                IF (@@ROWCOUNT > 0)
                    BEGIN

                        SELECT
                            'SUCCESS' AS [Message_Code];

                    END;
            END;
        ELSE
            BEGIN

                SELECT
                    'NOT EXISTS' AS [Message_Code];

            END;
    END;
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateRESIDENTIALSettings]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UpdateRESIDENTIALSettings]
    @GenVat DECIMAL(18, 2) = NULL,
    @SecurityAndMaintenance DECIMAL(18, 2) = NULL,
    @PenaltyPct DECIMAL(18, 2) = NULL,
    @LastChangedBy INT = NULL
AS
BEGIN

    SET NOCOUNT ON;


    UPDATE [dbo].[tblRatesSettings]
    SET [tblRatesSettings].[GenVat] = @GenVat,
        [tblRatesSettings].[SecurityAndMaintenance] = @SecurityAndMaintenance,
        [tblRatesSettings].[PenaltyPct] = @PenaltyPct,
        [tblRatesSettings].[LastChangedBy] = @LastChangedBy,
        [tblRatesSettings].[LastChangedDate] = GETDATE()
    WHERE [tblRatesSettings].[ProjectType] = 'RESIDENTIAL';

    IF (@@ROWCOUNT > 0)
    BEGIN
        SELECT 'SUCCESS' AS [Message_Code];
    END;
    ELSE
    BEGIN
        SELECT ERROR_MESSAGE() AS [Message_Code];
    END;

END;
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateUnitById]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UpdateUnitById]
    @RecId INT,
    @ProjectId INT = NULL,
    @IsParking BIT = NULL,
    @FloorNo INT = NULL,
    @AreaSqm DECIMAL(18, 2) = NULL,
    @AreaRateSqm DECIMAL(18, 2) = NULL,
    @AreaTotalAmount DECIMAL(18, 2) = NULL,
    @FloorType VARCHAR(50) = NULL,
    @BaseRental DECIMAL(18, 2) = NULL,
    @DetailsofProperty VARCHAR(300) = NULL,
    @UnitNo VARCHAR(20) = NULL,
    @UnitSequence INT = NULL,
    @BaseRentalVatAmount DECIMAL(18, 2) = NULL,
    @BaseRentalWithVatAmount DECIMAL(18, 2) = NULL,
    @BaseRentalTax DECIMAL(18, 2) = NULL,
    @IsNonVat BIT = NULL,
    @TotalRental DECIMAL(18, 2) = NULL,
    @SecAndMainAmount DECIMAL(18, 2) = NULL,
    @SecAndMainVatAmount DECIMAL(18, 2) = NULL,
    @SecAndMainWithVatAmount DECIMAL(18, 2) = NULL,
    @Vat DECIMAL(18, 2) = NULL,
    @Tax DECIMAL(18, 2) = NULL,
    @TaxAmount DECIMAL(18, 2) = NULL,
    @LastChangedBy INT = NULL,
    @ComputerName VARCHAR(20) = NULL
AS
BEGIN
    DECLARE @Message_Code VARCHAR(100) = '';
    UPDATE [dbo].[tblUnitMstr]
    SET [tblUnitMstr].[ProjectId] = @ProjectId,
        [tblUnitMstr].[IsParking] = @IsParking,
        [tblUnitMstr].[FloorNo] = @FloorNo,
        [tblUnitMstr].[AreaSqm] = @AreaSqm,
        [tblUnitMstr].[AreaRateSqm] = @AreaRateSqm,
        [tblUnitMstr].[AreaTotalAmount] = @AreaTotalAmount,
        [tblUnitMstr].[FloorType] = @FloorType,
        [tblUnitMstr].[BaseRental] = @BaseRental,
        [tblUnitMstr].[DetailsofProperty] = @DetailsofProperty,
        [tblUnitMstr].[UnitNo] = @UnitNo,
        [tblUnitMstr].[UnitSequence] = @UnitSequence,
        [tblUnitMstr].[BaseRentalVatAmount] = @BaseRentalVatAmount,
        [tblUnitMstr].[BaseRentalWithVatAmount] = @BaseRentalWithVatAmount,
        [tblUnitMstr].[BaseRentalTax] = @BaseRentalTax,
        [tblUnitMstr].[IsNonVat] = @IsNonVat,
        [tblUnitMstr].[TotalRental] = @TotalRental,
        [tblUnitMstr].[SecAndMainAmount] = @SecAndMainAmount,
        [tblUnitMstr].[SecAndMainVatAmount] = @SecAndMainVatAmount,
        [tblUnitMstr].[SecAndMainWithVatAmount] = @SecAndMainWithVatAmount,
        [tblUnitMstr].[Vat] = @Vat,
        [tblUnitMstr].[Tax] = @Tax,
        [tblUnitMstr].[TaxAmount] = @TaxAmount,
        [tblUnitMstr].[LastChangedBy] = @LastChangedBy,
        [tblUnitMstr].[LastChangedDate] = GETDATE(),
        [tblUnitMstr].[ComputerName] = @ComputerName
    WHERE [tblUnitMstr].[RecId] = @RecId
          AND [tblUnitMstr].[UnitStatus] = 'VACANT'

    IF (@@ROWCOUNT > 0)
    BEGIN
        SET @Message_Code = 'SUCCESS';
    END
    ELSE
    BEGIN
        SET @Message_Code = 'THIS UNIT CURRENTLY OPEN IN CONTRACT, MODIFICATION IS NOT PERMITTED';
    END
    SELECT @Message_Code AS [Message_Code];
END
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateUserInfo]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_UpdateUserInfo]
    @UserId AS INT,
    @UserName VARCHAR(50),
    @UserPassword NVARCHAR(50),
    @StaffName VARCHAR(100),
    @Middlename VARCHAR(50),
    @Lastname VARCHAR(50),
    @EmailAddress VARCHAR(50),
    @Phone VARCHAR(20)
AS
BEGIN
    DECLARE @Message_Code VARCHAR(100) = '';
    IF EXISTS
    (
        SELECT 1
        FROM [dbo].[tblUser]
        WHERE [tblUser].[UserId] = @UserId
    )
    BEGIN
        UPDATE [dbo].[tblUser]
        SET [tblUser].[UserName] = @UserName,
            [tblUser].[UserPassword] = @UserPassword,
            [tblUser].[StaffName] = @StaffName,
            [tblUser].[Middlename] = @Middlename,
            [tblUser].[Lastname] = @Lastname,
            [tblUser].[EmailAddress] = @EmailAddress,
            [tblUser].[Phone] = @Phone;

        IF @@ROWCOUNT > 0
        BEGIN
            SET @Message_Code = 'SUCCESS';
        END;
    END;
    ELSE
    BEGIN
        SET @Message_Code = 'User not exixt';
    END;

    SELECT @Message_Code AS [Message_Code];
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdateWAREHOUSESettings]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UpdateWAREHOUSESettings]
    @GenVat DECIMAL(18, 2) = NULL,
    @SecurityAndMaintenance DECIMAL(18, 2) = NULL,
    @WithHoldingTax DECIMAL(18, 2) = NULL,
    @PenaltyPct DECIMAL(18, 2) = NULL,
    @LastChangedBy INT = NULL
AS
BEGIN

    SET NOCOUNT ON;


    UPDATE [dbo].[tblRatesSettings]
    SET [tblRatesSettings].[GenVat] = @GenVat,
        [tblRatesSettings].[SecurityAndMaintenance] = @SecurityAndMaintenance,
        [tblRatesSettings].[WithHoldingTax] = @WithHoldingTax,
        [tblRatesSettings].[PenaltyPct] = @PenaltyPct,
        [tblRatesSettings].[LastChangedBy] = @LastChangedBy,
        [tblRatesSettings].[LastChangedDate] = GETDATE()
    WHERE [tblRatesSettings].[ProjectType] = 'WAREHOUSE';

    IF (@@ROWCOUNT > 0)
    BEGIN
        SELECT 'SUCCESS' AS [Message_Code];
    END;
    ELSE
    BEGIN
        SELECT ERROR_MESSAGE() AS [Message_Code];
    END;


END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Ad hoc distributed queries]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Ad hoc distributed queries]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    Declare @Output VarChar(max)
    Set @Output = ''

    select  @Output = 'Status: Ad Hoc Distributed Queries are enabled'
    from    sys.configurations
    where   name = 'Ad Hoc Distributed Queries'
            and value_in_use = 1

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Ad-Hoc-Distributed-Queries'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End
END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Agent Service]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Agent Service]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    Declare @Output VarChar(max)
    DECLARE @service NVARCHAR(100)

    Set @Output = ''


    If Convert(VarChar(100), ServerProperty('Edition')) Like 'Express%'
      Select @Output = 'SQL Server Agent not installed for express editions'
    Else If Is_SrvRoleMember('sysadmin') = 0
      Select @Output = 'You need to be a member of the sysadmin server role to run this check'
    Else
      Begin
        SELECT @service = CASE WHEN CHARINDEX('\',@@SERVERNAME)>0
               THEN N'SQLAgent$'+@@SERVICENAME
               ELSE N'SQLSERVERAGENT' END

        Create Table #Temp(Output VarChar(1000))
        Insert Into #Temp
        EXEC master..xp_servicecontrol N'QUERYSTATE', @service

        Select  Top 1 @Output = Output
        From    #Temp
        Where   Output Not Like 'Running%'

        Drop    Table #Temp
      End


    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'Could not find running SQL Agent:'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End
END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Auto close]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Auto close]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    Declare @Output VarChar(max)
    Set @Output = ''

    Select @Output = @Output + 'Database set to Auto Close' + Char(13) + Char(10)
    Where   DatabaseProperty(db_name(), 'IsAutoClose') = 1

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Auto-close'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End
END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Auto create statistics]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Auto create statistics]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    Declare @Output VarChar(max)
    Set @Output = ''

    Select @Output = @Output + 'Database not set to Auto Create Statistics' + Char(13) + Char(10)
    Where  DatabaseProperty(db_name(), 'IsAutoCreateStatistics') = 0

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Auto-create-statistics'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End
END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Auto Shrink]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Auto Shrink]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    Declare @Output VarChar(max)
    Set @Output = ''

    Select @Output = @Output + 'Database set to Auto Shrink' + Char(13) + Char(10)
    Where  DatabaseProperty(db_name(), 'IsAutoShrink') = 1

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Auto-shrink'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End
END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Auto update statistics]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Auto update statistics]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    Declare @Output VarChar(max)
    Set @Output = ''

    Select @Output = @Output + 'Database not set to Auto Update Statistics' + Char(13) + Char(10)
    Where  DatabaseProperty(db_name(), 'IsAutoUpdateStatistics') = 0

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Auto-update-statistics'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End
END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Buffer cache hit ratio]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Buffer cache hit ratio]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    Declare @Output VarChar(max), @PermissionsErrors VarChar(max)
    Set @Output = ''
    Set @PermissionsErrors = SQLCop.DmOsPerformanceCountersPermissionErrors()

    If (@PermissionsErrors = '')
        SELECT  @Output = Convert(DECIMAL(4,1), (a.cntr_value * 1.0 / b.cntr_value) * 100.0)
        FROM    sys.dm_os_performance_counters  a
                JOIN  (
                    SELECT cntr_value,OBJECT_NAME
                    FROM   sys.dm_os_performance_counters
                    WHERE  counter_name collate SQL_LATIN1_GENERAL_CP1_CI_AI = 'Buffer cache hit ratio base'
                            AND OBJECT_NAME collate SQL_LATIN1_GENERAL_CP1_CI_AI like '%Buffer Manager%'
                    ) b
                    ON  a.OBJECT_NAME = b.OBJECT_NAME
        WHERE   a.counter_name collate SQL_LATIN1_GENERAL_CP1_CI_AI = 'Buffer cache hit ratio'
                AND a.OBJECT_NAME collate SQL_LATIN1_GENERAL_CP1_CI_AI like '%:Buffer Manager%'
                and Convert(DECIMAL(4,1), (a.cntr_value * 1.0 / b.cntr_value) * 100.0) < 95
    Else
        Set @Output = @PermissionsErrors

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Buffer-cache-hit-ratio'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End
END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Column collation does not match database default]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Column collation does not match database default]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    DECLARE @Output VarChar(max)
    SET @Output = ''

    SELECT  @Output = @Output + C.TABLE_SCHEMA + '.' + C.TABLE_NAME + '.' + C.COLUMN_NAME + Char(13) + Char(10)
    FROM    INFORMATION_SCHEMA.COLUMNS C
            INNER JOIN INFORMATION_SCHEMA.TABLES T
                ON C.Table_Name = T.Table_Name
    WHERE   T.Table_Type = 'BASE TABLE'
            AND COLLATION_NAME <> convert(VarChar(100), DATABASEPROPERTYEX(db_name(), 'Collation'))
            AND COLUMNPROPERTY(OBJECT_ID(C.TABLE_NAME), COLUMN_NAME, 'IsComputed') = 0
            AND C.TABLE_SCHEMA <> 'tSQLt'
    Order By C.TABLE_SCHEMA, C.TABLE_NAME, C.COLUMN_NAME

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'hhttps://github.com/red-gate/SQLCop/wiki/Column-collation-does-not-match-database-default'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End

END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Column data types (Numeric vs. Int)]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Column data types (Numeric vs. Int)]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    Declare @Output VarChar(max)
    Set @Output = ''

    Select  @Output = @Output + ProblemItem + Char(13) + Char(10)
    From    (
            SELECT  TABLE_SCHEMA + '.' + TABLE_NAME + '.' + COLUMN_NAME As ProblemItem
            FROM    INFORMATION_SCHEMA.COLUMNS C
            WHERE   C.DATA_TYPE IN ('numeric','decimal')
                    AND NUMERIC_SCALE = 0
                    AND NUMERIC_PRECISION <= 18
                    AND TABLE_SCHEMA <> 'tSQLt'
            ) As Problems
    Order By ProblemItem

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Column-data-types-numeric-vs-int'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End

END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Column Name Problems]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Column Name Problems]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    DECLARE @Output VarChar(max)
    SET @Output = ''

    SELECT  @Output = @Output + TABLE_SCHEMA + '.' + TABLE_NAME + '.' + COLUMN_NAME + Char(13) + Char(10)
    FROM    INFORMATION_SCHEMA.COLUMNS
    WHERE   COLUMN_NAME COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI LIKE '%[^a-z0-9_$]%'
            And TABLE_SCHEMA <> 'tSQLt'
    Order By TABLE_SCHEMA,TABLE_NAME,COLUMN_NAME

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Column-name-problems'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End

END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Columns of data type Text/nText]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Columns of data type Text/nText]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    DECLARE @Output VarChar(max)
    SET @Output = ''

    SELECT  @Output = @Output + SCHEMA_NAME(o.uid) + '.' + o.Name + '.' + col.name + Char(13) + Char(10)
    from    syscolumns col
            Inner Join sysobjects o
                On col.id = o.id
            inner join systypes
                On col.xtype = systypes.xtype
    Where   o.type = 'U'
            And ObjectProperty(o.id, N'IsMSShipped') = 0
            AND systypes.name IN ('text','ntext')
            And SCHEMA_NAME(o.uid) <> 'tSQLt'
    Order By SCHEMA_NAME(o.uid),o.Name, col.Name

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Columns-of-data-type-Text-or-nText'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End

END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Columns with float data type]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Columns with float data type]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    DECLARE @Output VarChar(max)
    SET @Output = ''

    SELECT  @Output = @Output + TABLE_SCHEMA + '.' + TABLE_NAME + '.' + COLUMN_NAME + Char(13) + Char(10)
    FROM    INFORMATION_SCHEMA.COLUMNS
    WHERE   DATA_TYPE IN ('float', 'real')
            AND TABLE_SCHEMA <> 'tSQLt'
    Order By TABLE_SCHEMA,TABLE_NAME,COLUMN_NAME

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Columns-with-float-data-type'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End

END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Columns with image data type]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Columns with image data type]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    DECLARE @Output VarChar(max)
    SET @Output = ''

    SELECT  @Output = @Output + SCHEMA_NAME(o.uid) + '.' + o.Name + '.' + col.name
    from    syscolumns col
            Inner Join sysobjects o
                On col.id = o.id
            inner join systypes
                On col.xtype = systypes.xtype
    Where   o.type = 'U'
            And ObjectProperty(o.id, N'IsMSShipped') = 0
            And systypes.name In ('image')
            And SCHEMA_NAME(o.uid) <> 'tSQLt'
    Order By SCHEMA_NAME(o.uid),o.Name, col.Name

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Columns-with-image-data-type'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End

END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Compatibility Level]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Compatibility Level]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    Declare @Output VarChar(max)
    Set @Output = ''

    Select @Output = @Output + name + Char(13) + Char(10)
    FROM   sys.databases
    WHERE  compatibility_level != 10 * CONVERT(Int, CONVERT(FLOAT, CONVERT(VARCHAR(3), SERVERPROPERTY('productversion'))))

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Compatibility-level'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End

END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Database and Log files on the same disk]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Database and Log files on the same disk]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    Declare @Output VarChar(max)
    Set @Output = ''

    Select @Output = @Output + db_name() + Char(13) + Char(10)
    FROM   sys.database_files
    Having Count(*) != Count(Distinct Left(Physical_Name, 3))

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Database-and-log-on-same-disk'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End
END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Database collation]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Database collation]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    Declare @Output VarChar(max)
    Set @Output = ''

    Select  @Output = @Output + 'Warning: Collation conflict between user database and TempDB' + Char(13) + Char(10)
    Where   DatabasePropertyEx('TempDB', 'Collation') <> DatabasePropertyEx(db_name(), 'Collation')

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Database-collation'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End
END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Database Mail]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Database Mail]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    Declare @Output VarChar(max)
    Set @Output = ''

    select @Output = @Output + 'Status: Database Mail procedures are enabled' + Char(13) + Char(10)
    from   sys.configurations
    where  name = 'Database Mail XPs'
           and value_in_use = 1

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Database-mail'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End

END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Decimal Size Problem]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Decimal Size Problem]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    Declare @Output VarChar(max)
    Set @Output = ''

    Select @Output = @Output + Schema_Name(schema_id) + '.' + name + Char(13) + Char(10)
    From    sys.objects
    WHERE   schema_id <> Schema_ID('SQLCop')
            And schema_id <> Schema_Id('tSQLt')
            and (
            REPLACE(REPLACE(Object_Definition(object_id), ' ', ''), 'decimal]','decimal') COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI LIKE '%decimal[^(]%'
            Or REPLACE(REPLACE(Object_Definition(object_id), ' ', ''), 'numeric]','numeric') COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI LIKE '%[^i][^s]numeric[^(]%'
            )
    Order By Schema_Name(schema_id), name

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Decimal-Size-Problem'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End
END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Forwarded Records]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Forwarded Records]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    DECLARE @Output VarChar(max)
    SET @Output = ''

    If Exists(Select compatibility_level from sys.databases Where database_id = db_ID() And compatibility_level > 80)
        Begin
            Create Table #Results(ProblemItem VarChar(1000))

            Insert Into #Results(ProblemItem)
            Exec (' SELECT  SCHEMA_NAME(O.Schema_Id) + ''.'' + O.name As ProblemItem
                    FROM    sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, ''DETAILED'') AS ps
                            INNER JOIN sys.indexes AS i
                                ON ps.OBJECT_ID = i.OBJECT_ID
                                AND ps.index_id = i.index_id
                            INNER JOIN sys.objects as O
                                On i.OBJECT_ID = O.OBJECT_ID
                    WHERE  ps.forwarded_record_count > 0
                    Order By SCHEMA_NAME(O.Schema_Id),O.name')

            If Exists(Select 1 From #Results)
                Select  @Output = @Output + ProblemItem + Char(13) + Char(10)
                From    #Results

        End
    Else
      Set @Output = 'Unable to check index forwarded records when compatibility is set to 80 or below'

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Forwarded-records'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End

END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Fragmented Indexes]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Fragmented Indexes]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    DECLARE @Output VarChar(max)
    SET @Output = ''

    Create Table #Result (ProblemItem VarChar(1000))

    If Exists(Select compatibility_level from sys.databases Where database_id = db_ID() And compatibility_level > 80)
        If Exists(Select 1 From fn_my_permissions(NULL, 'DATABASE') WHERE permission_name = 'VIEW DATABASE STATE')
            Begin
                Insert Into #Result(ProblemItem)
                Exec('
                        SELECT  OBJECT_NAME(OBJECT_ID) + ''.'' + s.name As ProblemItem
                        FROM    sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL , NULL, N''LIMITED'') d
                                join sysindexes s
                                    ON  d.OBJECT_ID = s.id
                                    and d.index_id = s.indid
                        Where   avg_fragmentation_in_percent >= 30
                                And OBJECT_NAME(OBJECT_ID) + ''.'' + s.name > ''''
                                And page_count > 1000
                                Order By Object_Name(OBJECT_ID), s.name')
            End
        Else
            Set @Output = 'You do not have VIEW DATABASE STATE permissions within this database'
        Else
            Set @Output = 'Unable to check index fragmentation when compatibility is set to 80 or below'

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Fragmented-indexes'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End
END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Instant File Initialization]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Instant File Initialization]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    DECLARE @Output VarChar(max)
    SET @Output = ''

    CREATE TABLE #Output(Value VarChar(8000))

    If Exists(select * from sys.configurations Where name='xp_cmdshell' and value_in_use = 1)
        Begin
            If Is_SrvRoleMember('sysadmin') = 1
                Begin
                    Insert Into #Output EXEC ('xp_cmdshell ''whoami /priv''');

                    If Not Exists(Select 1 From #Output Where Value LIKE '%SeManageVolumePrivilege%')
                        Select @Output = 'Instant File Initialization disabled'
                    Else
                        Select  @Output = 'Instant File Initialization disabled'
                        From    #Output
                        Where   Value LIKE '%SeManageVolumePrivilege%'
                                And Value Like '%disabled%'
                End
            Else
                Set @Output = 'You do not have the appropriate permissions to run xp_cmdshell'
        End
    Else
        Begin
            Set @Output = 'xp_cmdshell must be enabled to determine if instant file initialization is enabled.'
        End
    Drop Table #Output

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Instant-file-initialization'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End
END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Invalid Objects]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Invalid Objects]
AS
BEGIN
    --  Test to identify Invalid Stored Procedures and Views
    --  If any invalid objects are found then fail the test with list of affected objects
    --  If you require a comprehensive list of Invalid Objects you can use the SQL Prompt find invalid objects functionality:
    --  https://documentation.red-gate.com/sp/sql-refactoring/refactoring-an-object-or-batch/finding-invalid-objects

    --  Written by Chris Unwin 17/09/2019

    SET NOCOUNT ON;

    --Assemble
    -- Declare and set output

    DECLARE @Output VARCHAR(MAX);
    SET @Output = '';

    -- Act
    -- Fetch all invalid objects from sys.sql_expression_dpenedencies and write to output

    SELECT @Output
        = @Output + 'Invalid ' + (CASE
                                      WHEN ob.type = 'P' THEN
                                          'stored procedure '
                                      WHEN ob.type = 'V' THEN
                                          'view '
                                      ELSE
                                          'object type ' + ob.type + ' '
                                  END
                                 ) + '[' + SCHEMA_NAME(ob.schema_id) + '].[' + OBJECT_NAME(dep.referencing_id)
          + '] relies on missing object [' + dep.referenced_schema_name + '].[' + dep.referenced_entity_name + ']'
          + CHAR(13) + CHAR(10)
    FROM sys.sql_expression_dependencies dep
        INNER JOIN sys.objects ob
            ON ob.object_id = dep.referencing_id
    WHERE dep.is_ambiguous = 0
          AND dep.referenced_id IS NULL
          AND dep.referenced_schema_name <> 'tSQLt'
          AND SCHEMA_NAME(ob.schema_id) <> 'tSQLt'
          AND SCHEMA_NAME(ob.schema_id) <> 'SQLCop';

    -- Assert
    -- Check if output is blank and pass, else fail with list of invalid objects

    IF @Output > ''
    BEGIN
        SET @Output = CHAR(13) + CHAR(10) + @Output;
        EXEC tSQLt.Fail @Output;
    END;
END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Login Language]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Login Language]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    Declare @Output VarChar(max)
    Declare @DefaultLanguage VarChar(100)

    Set @Output = ''

    Select  @DefaultLanguage = L.name
    From    sys.configurations C
            Inner Join sys.syslanguages L
              On C.value = L.langid
              And C.name = 'default language'

    Select  @Output = @Output + name + Char(13) + Char(10)
    From    sys.server_principals
    Where   default_language_name <> @DefaultLanguage
    Order By name

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Login-language'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End
END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Max degree of parallelism]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Max degree of parallelism]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    Declare @Output VarChar(max), @Warning VarChar(max)
    Set @Output = ''
    Set @Warning = 'Warning: Max degree of parallelism is setup to use all cores'

    IF (SERVERPROPERTY('EngineEdition') = 5 OR SERVERPROPERTY('EngineEdition') = 8)
        BEGIN
            select @Output = @Warning
            from   sys.database_scoped_configurations
            where  name = 'MAXDOP'
                and value = 0
        END
    ELSE
        BEGIN
            select @Output = @Warning
            from   sys.configurations
            where  name = 'max degree of parallelism'
                and value_in_use = 0
        END

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Max-degree-of-parallelism'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End
END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Missing Foreign Key Indexes]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Missing Foreign Key Indexes]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    DECLARE @Output VarChar(max)
    SET @Output = ''

    If Exists(Select 1 From fn_my_permissions(NULL, 'DATABASE') WHERE permission_name = 'VIEW DATABASE STATE')
        SELECT  @Output = @Output + Convert(VarChar(300), fk.foreign_key_name) + Char(13) + Char(10)
        FROM    (
                SELECT  fk.name AS foreign_key_name,
                        'PARENT' as foreign_key_type,
                        fkc.parent_object_id AS object_id,
                        STUFF(( SELECT ', ' + QUOTENAME(c.name)
                                FROM    sys.foreign_key_columns ifkc
                                        INNER JOIN sys.columns c
                                            ON ifkc.parent_object_id = c.object_id
                                            AND ifkc.parent_column_id = c.column_id
                                WHERE fk.object_id = ifkc.constraint_object_id
                                ORDER BY ifkc.constraint_column_id
                                FOR XML PATH('')), 1, 2, '') AS fk_columns,
                        (   SELECT  QUOTENAME(ifkc.parent_column_id,'(')
                            FROM    sys.foreign_key_columns ifkc
                            WHERE   fk.object_id = ifkc.constraint_object_id
                            ORDER BY ifkc.constraint_column_id
                            FOR XML PATH('')) AS fk_columns_compare
                FROM    sys.foreign_keys fk
                        INNER JOIN sys.foreign_key_columns fkc
                            ON fk.object_id = fkc.constraint_object_id
                WHERE fkc.constraint_column_id = 1

                UNION ALL

                SELECT  fk.name AS foreign_key_name,
                        'REFERENCED' as foreign_key_type,
                        fkc.referenced_object_id AS object_id,
                        STUFF(( SELECT  ', ' + QUOTENAME(c.name)
                                FROM    sys.foreign_key_columns ifkc
                                        INNER JOIN sys.columns c
                                            ON ifkc.referenced_object_id = c.object_id
                                            AND ifkc.referenced_column_id = c.column_id
                                WHERE fk.object_id = ifkc.constraint_object_id
                                ORDER BY ifkc.constraint_column_id
                                FOR XML PATH('')), 1, 2, '') AS fk_columns,
                        (   SELECT  QUOTENAME(ifkc.referenced_column_id,'(')
                            FROM    sys.foreign_key_columns ifkc
                            WHERE   fk.object_id = ifkc.constraint_object_id
                            ORDER BY ifkc.constraint_column_id
                            FOR XML PATH('')) AS fk_columns_compare
                FROM    sys.foreign_keys fk
                        INNER JOIN sys.foreign_key_columns fkc
                            ON fk.object_id = fkc.constraint_object_id
                WHERE   fkc.constraint_column_id = 1
                ) fk
                INNER JOIN (
                    SELECT  object_id,
                            SUM(row_count) AS row_count
                    FROM    sys.dm_db_partition_stats ps
                    WHERE   index_id IN (1,0)
                    GROUP BY object_id
                ) rc
                    ON fk.object_id = rc.object_id
                LEFT OUTER JOIN (
                    SELECT  i.object_id,
                            i.name,
                            (
                            SELECT  QUOTENAME(ic.column_id,'(')
                            FROM    sys.index_columns ic
                            WHERE   i.object_id = ic.object_id
                                    AND i.index_id = ic.index_id
                                    AND is_included_column = 0
                            ORDER BY key_ordinal ASC
                            FOR XML PATH('')
                            ) AS indexed_compare
                    FROM    sys.indexes i
                    ) i
                ON fk.object_id = i.object_id
                AND i.indexed_compare LIKE fk.fk_columns_compare + '%'
        WHERE   i.name IS NULL
        ORDER BY OBJECT_NAME(fk.object_id), fk.fk_columns
    Else
        Set @Output = 'You do not have VIEW DATABASE STATE permissions within this database'

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Missing-foreign-key-indexes'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End
END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Missing Foreign Keys]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Missing Foreign Keys]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    DECLARE @Output VarChar(max)
    DECLARE @AcceptableSymbols VARCHAR(100)

    SET @AcceptableSymbols = '_$'
    SET @Output = ''

    SELECT  @Output = @Output + C.TABLE_SCHEMA + '.' + C.TABLE_NAME + '.' + C.COLUMN_NAME + Char(13) + Char(10)
    FROM    INFORMATION_SCHEMA.COLUMNS C
            INNER Join INFORMATION_SCHEMA.TABLES T
              ON C.TABLE_NAME = T.TABLE_NAME
              AND T.TABLE_TYPE = 'BASE TABLE'
              AND T.TABLE_SCHEMA = C.TABLE_SCHEMA
            LEFT Join INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE U
              ON C.TABLE_NAME = U.TABLE_NAME
              AND C.COLUMN_NAME = U.COLUMN_NAME
              AND U.TABLE_SCHEMA = C.TABLE_SCHEMA
    WHERE   U.COLUMN_NAME IS Null
            And C.TABLE_SCHEMA <> 'tSQLt'
            AND C.COLUMN_NAME COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI Like '%id'
    ORDER BY C.TABLE_SCHEMA, C.TABLE_NAME, C.COLUMN_NAME

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Missing-foreign-keys'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End

END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Old Backups]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Old Backups]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    Declare @Output VarChar(max)
    Set @Output = ''

    Select  @Output = @Output + 'Outdated Backup For '+ D.name + Char(13) + Char(10)
    FROM    sys.databases As D
            Left Join msdb.dbo.backupset As B
              On  B.database_name = D.name
              And B.type = 'd'
    WHERE   D.state != 6
    GROUP BY D.name
    Having Coalesce(DATEDIFF(D, Max(backup_finish_date), Getdate()), 1000) > 7
    ORDER BY D.Name

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Old-backups'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End
END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Ole Automation Procedures]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Ole Automation Procedures]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    Declare @Output VarChar(max)
    Set @Output = ''

    select @Output = @Output + 'Warning: Ole Automation procedures are enabled' + Char(13) + Char(10)
    from   sys.configurations
    where  name = 'Ole Automation Procedures'
           and value_in_use = 1

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Ole-automation-procedures'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End
END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Orphaned Users]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Orphaned Users]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    Declare @Output VarChar(max)
    Set @Output = ''

    Set NOCOUNT ON
    If is_rolemember('db_owner') = 1
        Begin
            Declare @Temp Table(UserName sysname, UserSid VarBinary(85))

            Insert Into @Temp Exec sp_change_users_login 'report'

            Select @Output = @Output + UserName + Char(13) + Char(10)
            From   @Temp
            Order By UserName
        End
    Else
        Set @Output = 'Only members of db_owner can perform this check.'

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Orphaned-Users'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End

END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Page life expectancy]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Page life expectancy]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    Declare @Output VarChar(max), @PermissionsError VarChar(max)
    Set @Output = ''
    Set @PermissionsError = SQLCop.DmOsPerformanceCountersPermissionErrors()
    
    If (@PermissionsError = '')
        SELECT  @Output = @Output + Convert(VarChar(100), cntr_value) + Char(13) + Char(10)
        FROM    sys.dm_os_performance_counters
        WHERE   counter_name collate SQL_LATIN1_GENERAL_CP1_CI_AI = 'Page life expectancy'
                AND OBJECT_NAME collate SQL_LATIN1_GENERAL_CP1_CI_AI like '%:Buffer Manager%'
                And cntr_value <= 300
    Else
        Set @Output = @PermissionsError

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Page-life-expectancy'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End
END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Procedures Named SP_]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Procedures Named SP_]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    Declare @Output VarChar(max)
    Set @Output = ''

    SELECT  @Output = @Output + SPECIFIC_SCHEMA + '.' + SPECIFIC_NAME + Char(13) + Char(10)
    From    INFORMATION_SCHEMA.ROUTINES
    Where   SPECIFIC_NAME COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI LIKE 'sp[_]%'
            And SPECIFIC_NAME COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI NOT LIKE '%diagram%'
            AND ROUTINE_SCHEMA <> 'tSQLt'
    Order By SPECIFIC_SCHEMA,SPECIFIC_NAME

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Procedures-named-SP_'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End
END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Procedures that call undocumented procedures]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Procedures that call undocumented procedures]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012
    -- Updates contributed by Claude Harvey

    SET NOCOUNT ON

    Declare @Output VarChar(max)
    Set @Output = ''

    DECLARE @Temp TABLE(ProcedureName VARCHAR(50))

    INSERT INTO @Temp VALUES('sp_MStablespace')
    INSERT INTO @Temp VALUES('sp_who2')
    INSERT INTO @Temp VALUES('sp_tempdbspace')
    INSERT INTO @Temp VALUES('sp_MSkilldb')
    INSERT INTO @Temp VALUES('sp_MSindexspace')
    INSERT INTO @Temp VALUES('sp_MShelptype')
    INSERT INTO @Temp VALUES('sp_MShelpindex')
    INSERT INTO @Temp VALUES('sp_MShelpcolumns')
    INSERT INTO @Temp VALUES('sp_MSforeachtable')
    INSERT INTO @Temp VALUES('sp_MSforeachdb')
    INSERT INTO @Temp VALUES('sp_fixindex')
    INSERT INTO @Temp VALUES('sp_columns_rowset')
    INSERT INTO @Temp VALUES('sp_MScheck_uid_owns_anything')
    INSERT INTO @Temp VALUES('sp_MSgettools_path')
    INSERT INTO @Temp VALUES('sp_gettypestring')
    INSERT INTO @Temp VALUES('sp_MSdrop_object')
    INSERT INTO @Temp VALUES('sp_MSget_qualified_name')
    INSERT INTO @Temp VALUES('sp_MSgetversion')
    INSERT INTO @Temp VALUES('xp_dirtree')
    INSERT INTO @Temp VALUES('xp_subdirs')
    INSERT INTO @Temp VALUES('xp_enum_oledb_providers')
    INSERT INTO @Temp VALUES('xp_enumcodepages')
    INSERT INTO @Temp VALUES('xp_enumdsn')
    INSERT INTO @Temp VALUES('xp_enumerrorlogs')
    INSERT INTO @Temp VALUES('xp_enumgroups')
    INSERT INTO @Temp VALUES('xp_fileexist')
    INSERT INTO @Temp VALUES('xp_fixeddrives')
    INSERT INTO @Temp VALUES('xp_getnetname')
    INSERT INTO @Temp VALUES('xp_readerrorlog')
    INSERT INTO @Temp VALUES('sp_msdependencies')
    INSERT INTO @Temp VALUES('xp_qv')
    INSERT INTO @Temp VALUES('xp_delete_file')
    INSERT INTO @Temp VALUES('sp_checknames')
    INSERT INTO @Temp VALUES('sp_enumoledbdatasources')
    INSERT INTO @Temp VALUES('sp_MS_marksystemobject')
    INSERT INTO @Temp VALUES('sp_MSaddguidcolumn')
    INSERT INTO @Temp VALUES('sp_MSaddguidindex')
    INSERT INTO @Temp VALUES('sp_MSaddlogin_implicit_ntlogin')
    INSERT INTO @Temp VALUES('sp_MSadduser_implicit_ntlogin')
    INSERT INTO @Temp VALUES('sp_MSdbuseraccess')
    INSERT INTO @Temp VALUES('sp_MSdbuserpriv')
    INSERT INTO @Temp VALUES('sp_MSloginmappings')
    INSERT INTO @Temp VALUES('sp_MStablekeys')
    INSERT INTO @Temp VALUES('sp_MStablerefs')
    INSERT INTO @Temp VALUES('sp_MSuniquetempname')
    INSERT INTO @Temp VALUES('sp_MSuniqueobjectname')
    INSERT INTO @Temp VALUES('sp_MSuniquecolname')
    INSERT INTO @Temp VALUES('sp_MSuniquename')
    INSERT INTO @Temp VALUES('sp_MSunc_to_drive')
    INSERT INTO @Temp VALUES('sp_MSis_pk_col')
    INSERT INTO @Temp VALUES('xp_get_MAPI_default_profile')
    INSERT INTO @Temp VALUES('xp_get_MAPI_profiles')
    INSERT INTO @Temp VALUES('xp_regdeletekey')
    INSERT INTO @Temp VALUES('xp_regdeletevalue')
    INSERT INTO @Temp VALUES('xp_regread')
    INSERT INTO @Temp VALUES('xp_regenumvalues')
    INSERT INTO @Temp VALUES('xp_regaddmultistring')
    INSERT INTO @Temp VALUES('xp_regremovemultistring')
    INSERT INTO @Temp VALUES('xp_regwrite')
    INSERT INTO @Temp VALUES('xp_varbintohexstr')
    INSERT INTO @Temp VALUES('sp_MSguidtostr')

    SELECT @Output = @Output + SCHEMA_NAME(o.schema_id) + '.' + o.name + Char(13) + Char(10)
    FROM   sys.objects o
           INNER JOIN syscomments c
             ON o.object_id = c.id
             AND o.type = 'P'
           INNER JOIN @Temp t
             ON c.text COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI LIKE '%' + t.ProcedureName + '%'
    WHERE  type = 'P'
           AND o.is_ms_shipped = 0
           AND SCHEMA_NAME(o.schema_id) <> 'tSQLt'
           AND SCHEMA_NAME(o.schema_id) <> 'SQLCop'
    ORDER BY SCHEMA_NAME(o.schema_id), o.name

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Procedures-that-call-undocumented-procedures'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End
END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Procedures using dynamic SQL without sp_executesql]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Procedures using dynamic SQL without sp_executesql]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    Declare @Output VarChar(max)
    Set @Output = ''

    SELECT  @Output = @Output + SCHEMA_NAME(so.uid) + '.' + so.name + Char(13) + Char(10)
    From    sys.sql_modules sm
            Inner Join sys.sysobjects so
                On  sm.object_id = so.id
                And so.type = 'P'
    Where   so.uid <> Schema_Id('tSQLt')
            And so.uid <> Schema_Id('SQLCop')
            And Replace(sm.definition, ' ', '') COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI Like '%Exec(%'
            And Replace(sm.definition, ' ', '') COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI Not Like '%sp_Executesql%'
            And OBJECTPROPERTY(so.id, N'IsMSShipped') = 0
    Order By SCHEMA_NAME(so.uid),so.name

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Procedures-using-dynamic-SQL-without-sp_executesql'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End

END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Procedures with @@Identity]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Procedures with @@Identity]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    Declare @Output VarChar(max)
    Set @Output = ''

    Select  @Output = @Output + Schema_Name(schema_id) + '.' + name + Char(13) + Char(10)
    From    sys.all_objects
    Where   type = 'P'
            AND name Not In('sp_helpdiagrams','sp_upgraddiagrams','sp_creatediagram','testProcedures with @@Identity')
            And Object_Definition(object_id) COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI Like '%@@identity%'
            And is_ms_shipped = 0
            and schema_id <> Schema_id('tSQLt')
            and schema_id <> Schema_id('SQLCop')
    ORDER BY Schema_Name(schema_id), name

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Procedures-with-@@Identity'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End

END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Procedures With SET ROWCOUNT]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Procedures With SET ROWCOUNT]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    Declare @Output VarChar(max)
    Set @Output = ''

    SELECT  @Output = @Output + Schema_Name(schema_id) + '.' + name + Char(13) + Char(10)
    From    sys.all_objects
    Where   type = 'P'
            AND name Not In('sp_helpdiagrams','sp_upgraddiagrams','sp_creatediagram','testProcedures With SET ROWCOUNT')
            And Replace(Object_Definition(Object_id), ' ', '') COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI Like '%SETROWCOUNT%'
            And is_ms_shipped = 0
            and schema_id <> Schema_id('tSQLt')
            and schema_id <> Schema_id('SQLCop')
    ORDER BY Schema_Name(schema_id) + '.' + name

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Procedures-With-SET-ROWCOUNT'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End
END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Procedures without SET NOCOUNT ON]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Procedures without SET NOCOUNT ON]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    Declare @Output VarChar(max)
    Set @Output = ''

    SELECT  @Output = @Output + Schema_Name(schema_id) + '.' + name + Char(13) + Char(10)
    From    sys.all_objects
    Where   Type = 'P'
            AND name Not In('sp_helpdiagrams','sp_upgraddiagrams','sp_creatediagram','testProcedures without SET NOCOUNT ON')
            And Object_Definition(Object_id) COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI not Like '%SET NOCOUNT ON%'
            And is_ms_shipped = 0
            and schema_id <> Schema_id('tSQLt')
            and schema_id <> Schema_id('SQLCop')
    ORDER BY Schema_Name(schema_id) + '.' + name

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Procedures-without-set-nocount-on'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End

END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Service Account]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Service Account]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    Declare @Output VarChar(max)
    Set @Output = ''

    --Declare a variable to hold the value
    DECLARE @ServiceAccount varchar(100)

    --Retrieve the Service account from registry
    EXECUTE master.dbo.xp_instance_regread
            N'HKEY_LOCAL_MACHINE',
            N'SYSTEM\CurrentControlSet\Services\MSSQLSERVER',
            N'ObjectName',
            @ServiceAccount OUTPUT,
            N'no_output'

    --Display the Service Account
    SELECT @Output = 'Service account set to LocalSystem'
    Where  @ServiceAccount = 'LocalSystem'

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Service-Account'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End

END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Table name problems]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Table name problems]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    DECLARE @Output VarChar(max)
    DECLARE @AcceptableSymbols VARCHAR(100)

    SET @AcceptableSymbols = '_$'
    SET @Output = ''

    SELECT  @Output = @Output + TABLE_SCHEMA + '.' + TABLE_NAME + Char(13) + Char(10)
    FROM    INFORMATION_SCHEMA.TABLES
    WHERE   TABLE_NAME COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI Like '%[^a-z' + @AcceptableSymbols + ']%'
            AND TABLE_SCHEMA <> 'tSQLt'
    ORDER BY TABLE_SCHEMA,TABLE_NAME

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Table-name-problems'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End
END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Tables that start with tbl]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Tables that start with tbl]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    DECLARE @Output VarChar(max)
    SET @Output = ''

    SELECT  @Output = @Output + TABLE_SCHEMA + '.' + TABLE_NAME + Char(13) + Char(10)
    From    INFORMATION_SCHEMA.TABLES
    WHERE   TABLE_TYPE = 'BASE TABLE'
            And TABLE_NAME COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI LIKE 'tbl%'
            And TABLE_SCHEMA <> 'tSQLt'
    Order By TABLE_SCHEMA,TABLE_NAME

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Tables-that-start-with-tbl'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End
END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Tables without a primary key]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Tables without a primary key]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012
    -- Updates contributed by Claude Harvey

    SET NOCOUNT ON

    DECLARE @Output VarChar(max)
    SET @Output = ''

    SELECT  @Output = @Output + QUOTENAME(AllTables.schemaName) + '.' + QUOTENAME(AllTables.name) + Char(13) + Char(10)
    FROM    (
            SELECT  name, object_id, SCHEMA_NAME(schema_id) AS schemaName
            From    sys.tables
            ) AS AllTables
            LEFT JOIN (
                SELECT parent_object_id
                From sys.objects
                WHERE  type = 'PK'
                ) AS PrimaryKeys
                ON AllTables.object_id = PrimaryKeys.parent_object_id
    WHERE   PrimaryKeys.parent_object_id Is Null
            AND AllTables.schemaName <> 'tSQLt'

    ORDER BY AllTables.schemaName, AllTables.name

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Tables-without-a-primary-key'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End
END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Tables without any data]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Tables without any data]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    DECLARE @Output VarChar(max)
    SET @Output = ''

    SELECT  @Output = @Output + QUOTENAME(SCHEMA_NAME(t.schema_id)) + '.' + QUOTENAME(t.name) + Char(13) + Char(10)
    FROM    sys.tables t JOIN sys.dm_db_partition_stats p ON t.object_id=p.object_id
    WHERE   SCHEMA_NAME(t.schema_id) <> 'tSQLt'
    AND     p.row_count = 0
    ORDER BY SCHEMA_NAME(t.schema_id), t.name

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'Empty tables in your database:'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End
END;
GO
/****** Object:  StoredProcedure [SQLCop].[test UniqueIdentifier with NewId]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test UniqueIdentifier with NewId]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    DECLARE @Output VarChar(max)
    SET @Output = ''

    SELECT  @Output = @Output + so.name + '.' + col.name + Char(13) + Char(10)
    FROM    sysobjects so
            INNER JOIN sysindexes sind
                ON so.id=sind.id
            INNER JOIN sysindexkeys sik
                ON sind.id=sik.id
                AND sind.indid=sik.indid
            INNER JOIN syscolumns col
                ON col.id=sik.id
                AND col.colid=sik.colid
            INNER JOIN systypes
                ON col.xtype = systypes.xtype
            INNER JOIN syscomments
                ON col.cdefault = syscomments.id
    WHERE   sind.Status & 16 = 16
            AND systypes.name = 'uniqueidentifier'
            AND keyno = 1
            AND sind.OrigFillFactor = 0
            AND syscomments.TEXT COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI Like '%newid%'
            and so.name <> 'tSQLt'
    ORDER BY so.name, sik.keyno

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Uniqueidentifier-with-NewId'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End
END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Unnamed Constraints]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Unnamed Constraints]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    DECLARE @Output VarChar(max)
    SET @Output = ''

    SELECT  @Output = @Output + CONSTRAINT_SCHEMA + '.' + CONSTRAINT_NAME + Char(13) + Char(10)
    From    INFORMATION_SCHEMA.CONSTRAINT_TABLE_USAGE
    Where   CONSTRAINT_NAME collate sql_latin1_general_CP1_CI_AI Like '%[_][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
            And TABLE_NAME <> 'sysdiagrams'
            And CONSTRAINT_SCHEMA <> 'tSQLt'
    Order By CONSTRAINT_SCHEMA,CONSTRAINT_NAME

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Unnamed-constraints'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End

END;
GO
/****** Object:  StoredProcedure [SQLCop].[test User Aliases]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test User Aliases]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    Declare @Output VarChar(max)
    Set @Output = ''

    Select @Output = @Output + Name + Char(13) + Char(10)
    From   sysusers
    Where  IsAliased = 1
    Order By Name

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/User-aliases'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End
END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Varchar Size Problem]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Varchar Size Problem]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    Declare @Output VarChar(max)
    Set @Output = ''

    Select  @Output = @Output + ProblemItem + Char(13) + Char(10)
    From    (
            SELECT  DISTINCT su.name + '.' + so.Name As ProblemItem
            From    syscomments sc
                    Inner Join sysobjects so
                        On  sc.id = so.id
                        And so.xtype = 'P'
                    INNER JOIN sys.schemas su
                        ON so.uid = su.schema_id
            Where   REPLACE(Replace(sc.text, ' ', ''), 'varchar]','varchar') COLLATE SQL_LATIN1_GENERAL_CP1_CI_AI Like '%varchar[^(]%'
                    And ObjectProperty(sc.Id, N'IsMSSHIPPED') = 0
                    And su.schema_id <> schema_id('tSQLt')
                    and su.schema_id <> Schema_id('SQLCop')
            ) As Problems
    Order By ProblemItem

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Varchar-size-problem'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End

END;
GO
/****** Object:  StoredProcedure [SQLCop].[test Wide Table]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test Wide Table]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    DECLARE @Output VarChar(max)
    SET @Output = ''

    Select  @Output = @Output + C.TABLE_SCHEMA + '.' + C.TABLE_NAME + Char(13) + Char(10)
    From    INFORMATION_SCHEMA.TABLES T
            INNER JOIN INFORMATION_SCHEMA.COLUMNS C
              On  T.TABLE_NAME = C.TABLE_NAME
              AND T.TABLE_SCHEMA = C.TABLE_SCHEMA
              And T.TABLE_TYPE = 'BASE TABLE'
            INNER JOIN systypes S
                On C.DATA_TYPE = S.name
    WHERE   C.TABLE_SCHEMA <> 'tSQLt'
    GROUP BY C.TABLE_SCHEMA,C.TABLE_NAME
    HAVING SUM(ISNULL(NULLIF(CONVERT(BIGINT,S.Length), 8000), 0) + ISNULL(NULLIF(C.CHARACTER_MAXIMUM_LENGTH, 2147483647), 0)) > 8060
    ORDER BY C.TABLE_SCHEMA,C.TABLE_NAME

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/Wide-tables'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End
END;
GO
/****** Object:  StoredProcedure [SQLCop].[test xp_cmdshell is enabled]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [SQLCop].[test xp_cmdshell is enabled]
AS
BEGIN
    -- Written by George Mastros
    -- February 25, 2012

    SET NOCOUNT ON

    Declare @Output VarChar(max)
    Set @Output = ''

    select @Output = @Output + 'Warning: xp_cmdshell is enabled' + Char(13) + Char(10)
    from   sys.configurations
    where  name = 'xp_cmdshell'
           and value_in_use = 1

    If @Output > ''
        Begin
            Set @Output = Char(13) + Char(10)
                          + 'For more information:  '
                          + 'https://github.com/red-gate/SQLCop/wiki/xp_cmdshell-is-enabled'
                          + Char(13) + Char(10)
                          + Char(13) + Char(10)
                          + @Output
            EXEC tSQLt.Fail @Output
        End
END;
GO
/****** Object:  StoredProcedure [tSQLt].[ApplyConstraint]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[ApplyConstraint]
       @TableName NVARCHAR(MAX),
       @ConstraintName NVARCHAR(MAX),
       @SchemaName NVARCHAR(MAX) = NULL, --parameter preserved for backward compatibility. Do not use. Will be removed soon.
       @NoCascade BIT = 0
AS
BEGIN
  DECLARE @ConstraintType NVARCHAR(MAX);
  DECLARE @ConstraintObjectId INT;
  
  SELECT @ConstraintType = ConstraintType, @ConstraintObjectId = ConstraintObjectId
    FROM tSQLt.Private_ResolveApplyConstraintParameters (@TableName, @ConstraintName, @SchemaName);

  IF @ConstraintType = 'CHECK_CONSTRAINT'
  BEGIN
    EXEC tSQLt.Private_ApplyCheckConstraint @ConstraintObjectId;
    RETURN 0;
  END

  IF @ConstraintType = 'FOREIGN_KEY_CONSTRAINT'
  BEGIN
    EXEC tSQLt.Private_ApplyForeignKeyConstraint @ConstraintObjectId, @NoCascade;
    RETURN 0;
  END;  
   
  IF @ConstraintType IN('UNIQUE_CONSTRAINT', 'PRIMARY_KEY_CONSTRAINT')
  BEGIN
    EXEC tSQLt.Private_ApplyUniqueConstraint @ConstraintObjectId;
    RETURN 0;
  END;  
   
  RAISERROR ('ApplyConstraint could not resolve the object names, ''%s'', ''%s''. Be sure to call ApplyConstraint and pass in two parameters, such as: EXEC tSQLt.ApplyConstraint ''MySchema.MyTable'', ''MyConstraint''', 
             16, 10, @TableName, @ConstraintName);
  RETURN 0;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[ApplyTrigger]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[ApplyTrigger]
  @TableName NVARCHAR(MAX),
  @TriggerName NVARCHAR(MAX)
AS
BEGIN
  DECLARE @OrgTableObjectId INT;
  SELECT @OrgTableObjectId = OrgTableObjectId FROM tSQLt.Private_GetOriginalTableInfo(OBJECT_ID(@TableName)) orgTbl
  IF(@OrgTableObjectId IS NULL)
  BEGIN
    RAISERROR('%s does not exist or was not faked by tSQLt.FakeTable.', 16, 10, @TableName);
  END;
  
  DECLARE @FullTriggerName NVARCHAR(MAX);
  DECLARE @TriggerObjectId INT;
  SELECT @FullTriggerName = QUOTENAME(SCHEMA_NAME(schema_id))+'.'+QUOTENAME(name), @TriggerObjectId = object_id
  FROM sys.objects WHERE PARSENAME(@TriggerName,1) = name AND parent_object_id = @OrgTableObjectId;
  
  DECLARE @TriggerCode NVARCHAR(MAX);
  SELECT @TriggerCode = m.definition
    FROM sys.sql_modules m
   WHERE m.object_id = @TriggerObjectId;
  
  IF (@TriggerCode IS NULL)
  BEGIN
    RAISERROR('%s is not a trigger on %s', 16, 10, @TriggerName, @TableName);
  END;
 
  EXEC tSQLt.RemoveObject @FullTriggerName;
  
  EXEC(@TriggerCode);
END;
GO
/****** Object:  StoredProcedure [tSQLt].[AssertEmptyTable]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[AssertEmptyTable]
  @TableName NVARCHAR(MAX),
  @Message NVARCHAR(MAX) = ''
AS
BEGIN
  EXEC tSQLt.AssertObjectExists @TableName;

  DECLARE @FullName NVARCHAR(MAX);
  IF(OBJECT_ID(@TableName) IS NULL AND OBJECT_ID('tempdb..'+@TableName) IS NOT NULL)
  BEGIN
    SET @FullName = CASE WHEN LEFT(@TableName,1) = '[' THEN @TableName ELSE QUOTENAME(@TableName)END;
  END;
  ELSE
  BEGIN
    SET @FullName = tSQLt.Private_GetQuotedFullName(OBJECT_ID(@TableName));
  END;

  DECLARE @cmd NVARCHAR(MAX);
  DECLARE @exists INT;
  SET @cmd = 'SELECT @exists = CASE WHEN EXISTS(SELECT 1 FROM '+@FullName+') THEN 1 ELSE 0 END;'
  EXEC sp_executesql @cmd,N'@exists INT OUTPUT', @exists OUTPUT;
  
  IF(@exists = 1)
  BEGIN
    DECLARE @TableToText NVARCHAR(MAX);
    EXEC tSQLt.TableToText @TableName = @FullName,@txt = @TableToText OUTPUT;
    DECLARE @Msg NVARCHAR(MAX);
    SET @Msg = @FullName + ' was not empty:' + CHAR(13) + CHAR(10)+ @TableToText;
    EXEC tSQLt.Fail @Message,@Msg;
  END
END
GO
/****** Object:  StoredProcedure [tSQLt].[AssertEquals]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[AssertEquals]
    @Expected SQL_VARIANT,
    @Actual SQL_VARIANT,
    @Message NVARCHAR(MAX) = ''
AS
BEGIN
    IF ((@Expected = @Actual) OR (@Actual IS NULL AND @Expected IS NULL))
      RETURN 0;

    DECLARE @Msg NVARCHAR(MAX);
    SELECT @Msg = 'Expected: <' + ISNULL(CAST(@Expected AS NVARCHAR(MAX)), 'NULL') + 
                  '> but was: <' + ISNULL(CAST(@Actual AS NVARCHAR(MAX)), 'NULL') + '>';
    IF((COALESCE(@Message,'') <> '') AND (@Message NOT LIKE '% ')) SET @Message = @Message + ' ';
    EXEC tSQLt.Fail @Message, @Msg;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[AssertEqualsString]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[AssertEqualsString]
    @Expected NVARCHAR(MAX),
    @Actual NVARCHAR(MAX),
    @Message NVARCHAR(MAX) = ''
AS
BEGIN
    IF ((@Expected = @Actual) OR (@Actual IS NULL AND @Expected IS NULL))
      RETURN 0;

    DECLARE @Msg NVARCHAR(MAX);
    SELECT @Msg = CHAR(13)+CHAR(10)+
                  'Expected: ' + ISNULL('<'+@Expected+'>', 'NULL') +
                  CHAR(13)+CHAR(10)+
                  'but was : ' + ISNULL('<'+@Actual+'>', 'NULL');
    EXEC tSQLt.Fail @Message, @Msg;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[AssertEqualsTable]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[AssertEqualsTable]
    @Expected NVARCHAR(MAX),
    @Actual NVARCHAR(MAX),
    @Message NVARCHAR(MAX) = NULL,
    @FailMsg NVARCHAR(MAX) = 'Unexpected/missing resultset rows!'
AS
BEGIN

    EXEC tSQLt.AssertObjectExists @Expected;
    EXEC tSQLt.AssertObjectExists @Actual;

    DECLARE @ResultTable NVARCHAR(MAX);    
    DECLARE @ResultColumn NVARCHAR(MAX);    
    DECLARE @ColumnList NVARCHAR(MAX);    
    DECLARE @UnequalRowsExist INT;
    DECLARE @CombinedMessage NVARCHAR(MAX);

    SELECT @ResultTable = tSQLt.Private::CreateUniqueObjectName();
    SELECT @ResultColumn = 'RC_' + @ResultTable;

    EXEC tSQLt.Private_CreateResultTableForCompareTables 
      @ResultTable = @ResultTable,
      @ResultColumn = @ResultColumn,
      @BaseTable = @Expected;
        
    SELECT @ColumnList = tSQLt.Private_GetCommaSeparatedColumnList(@ResultTable, @ResultColumn);

    EXEC tSQLt.Private_ValidateThatAllDataTypesInTableAreSupported @ResultTable, @ColumnList;    
    
    EXEC @UnequalRowsExist = tSQLt.Private_CompareTables 
      @Expected = @Expected,
      @Actual = @Actual,
      @ResultTable = @ResultTable,
      @ColumnList = @ColumnList,
      @MatchIndicatorColumnName = @ResultColumn;
        
    SET @CombinedMessage = ISNULL(@Message + CHAR(13) + CHAR(10),'') + @FailMsg;
    EXEC tSQLt.Private_CompareTablesFailIfUnequalRowsExists 
      @UnequalRowsExist = @UnequalRowsExist,
      @ResultTable = @ResultTable,
      @ResultColumn = @ResultColumn,
      @ColumnList = @ColumnList,
      @FailMsg = @CombinedMessage;   
END;
GO
/****** Object:  StoredProcedure [tSQLt].[AssertEqualsTableSchema]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[AssertEqualsTableSchema]
    @Expected NVARCHAR(MAX),
    @Actual NVARCHAR(MAX),
    @Message NVARCHAR(MAX) = NULL
AS
BEGIN
  INSERT INTO tSQLt.Private_AssertEqualsTableSchema_Expected([RANK(column_id)],name,system_type_id,user_type_id,max_length,precision,scale,collation_name,is_nullable)
  SELECT 
      RANK()OVER(ORDER BY C.column_id),
      C.name,
      CAST(C.system_type_id AS NVARCHAR(MAX))+QUOTENAME(TS.name) system_type_id,
      CAST(C.user_type_id AS NVARCHAR(MAX))+CASE WHEN TU.system_type_id<> TU.user_type_id THEN QUOTENAME(SCHEMA_NAME(TU.schema_id))+'.' ELSE '' END + QUOTENAME(TU.name) user_type_id,
      C.max_length,
      C.precision,
      C.scale,
      C.collation_name,
      C.is_nullable
    FROM sys.columns AS C
    JOIN sys.types AS TS
      ON C.system_type_id = TS.user_type_id
    JOIN sys.types AS TU
      ON C.user_type_id = TU.user_type_id
   WHERE C.object_id = OBJECT_ID(@Expected);
  INSERT INTO tSQLt.Private_AssertEqualsTableSchema_Actual([RANK(column_id)],name,system_type_id,user_type_id,max_length,precision,scale,collation_name,is_nullable)
  SELECT 
      RANK()OVER(ORDER BY C.column_id),
      C.name,
      CAST(C.system_type_id AS NVARCHAR(MAX))+QUOTENAME(TS.name) system_type_id,
      CAST(C.user_type_id AS NVARCHAR(MAX))+CASE WHEN TU.system_type_id<> TU.user_type_id THEN QUOTENAME(SCHEMA_NAME(TU.schema_id))+'.' ELSE '' END + QUOTENAME(TU.name) user_type_id,
      C.max_length,
      C.precision,
      C.scale,
      C.collation_name,
      C.is_nullable
    FROM sys.columns AS C
    JOIN sys.types AS TS
      ON C.system_type_id = TS.user_type_id
    JOIN sys.types AS TU
      ON C.user_type_id = TU.user_type_id
   WHERE C.object_id = OBJECT_ID(@Actual);
  
  EXEC tSQLt.AssertEqualsTable 'tSQLt.Private_AssertEqualsTableSchema_Expected','tSQLt.Private_AssertEqualsTableSchema_Actual',@Message=@Message,@FailMsg='Unexpected/missing column(s)';  
END;
GO
/****** Object:  StoredProcedure [tSQLt].[AssertLike]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[AssertLike] 
  @ExpectedPattern NVARCHAR(MAX),
  @Actual NVARCHAR(MAX),
  @Message NVARCHAR(MAX) = ''
AS
BEGIN
  IF (LEN(@ExpectedPattern) > 4000)
  BEGIN
    RAISERROR ('@ExpectedPattern may not exceed 4000 characters.', 16, 10);
  END;

  IF ((@Actual LIKE @ExpectedPattern) OR (@Actual IS NULL AND @ExpectedPattern IS NULL))
  BEGIN
    RETURN 0;
  END

  DECLARE @Msg NVARCHAR(MAX);
  SELECT @Msg = CHAR(13) + CHAR(10) + 'Expected: <' + ISNULL(@ExpectedPattern, 'NULL') + '>' +
                CHAR(13) + CHAR(10) + ' but was: <' + ISNULL(@Actual, 'NULL') + '>';
  EXEC tSQLt.Fail @Message, @Msg;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[AssertNotEquals]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[AssertNotEquals]
    @Expected SQL_VARIANT,
    @Actual SQL_VARIANT,
    @Message NVARCHAR(MAX) = ''
AS
BEGIN
  IF (@Expected = @Actual)
  OR (@Expected IS NULL AND @Actual IS NULL)
  BEGIN
    DECLARE @Msg NVARCHAR(MAX);
    SET @Msg = 'Expected actual value to not ' + 
               COALESCE('equal <' + tSQLt.Private_SqlVariantFormatter(@Expected)+'>', 'be NULL') + 
               '.';
    EXEC tSQLt.Fail @Message,@Msg;
  END;
  RETURN 0;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[AssertObjectDoesNotExist]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[AssertObjectDoesNotExist]
    @ObjectName NVARCHAR(MAX),
    @Message NVARCHAR(MAX) = ''
AS
BEGIN
     DECLARE @Msg NVARCHAR(MAX);
     IF OBJECT_ID(@ObjectName) IS NOT NULL
     OR(@ObjectName LIKE '#%' AND OBJECT_ID('tempdb..'+@ObjectName) IS NOT NULL)
     BEGIN
         SELECT @Msg = '''' + @ObjectName + ''' does exist!';
         EXEC tSQLt.Fail @Message,@Msg;
     END;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[AssertObjectExists]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[AssertObjectExists]
    @ObjectName NVARCHAR(MAX),
    @Message NVARCHAR(MAX) = ''
AS
BEGIN
    DECLARE @Msg NVARCHAR(MAX);
    IF(@ObjectName LIKE '#%')
    BEGIN
     IF OBJECT_ID('tempdb..'+@ObjectName) IS NULL
     BEGIN
         SELECT @Msg = '''' + COALESCE(@ObjectName, 'NULL') + ''' does not exist';
         EXEC tSQLt.Fail @Message, @Msg;
         RETURN 1;
     END;
    END
    ELSE
    BEGIN
     IF OBJECT_ID(@ObjectName) IS NULL
     BEGIN
         SELECT @Msg = '''' + COALESCE(@ObjectName, 'NULL') + ''' does not exist';
         EXEC tSQLt.Fail @Message, @Msg;
         RETURN 1;
     END;
    END;
    RETURN 0;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[AssertResultSetsHaveSameMetaData]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [tSQLt].[AssertResultSetsHaveSameMetaData]
	@expectedCommand [nvarchar](max),
	@actualCommand [nvarchar](max)
WITH EXECUTE AS CALLER
AS
EXTERNAL NAME [tSQLtCLR].[tSQLtCLR.StoredProcedures].[AssertResultSetsHaveSameMetaData]
GO
/****** Object:  StoredProcedure [tSQLt].[AssertStringIn]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [tSQLt].[AssertStringIn]
  @Expected tSQLt.AssertStringTable READONLY,
  @Actual NVARCHAR(MAX),
  @Message NVARCHAR(MAX) = ''
AS
BEGIN
  IF(NOT EXISTS(SELECT 1 FROM @Expected WHERE value = @Actual))
  BEGIN
    DECLARE @ExpectedMessage NVARCHAR(MAX);
    SELECT value INTO #ExpectedSet FROM @Expected;
    EXEC tSQLt.TableToText @TableName = '#ExpectedSet', @OrderBy = 'value',@txt = @ExpectedMessage OUTPUT;
    SET @ExpectedMessage = ISNULL('<'+@Actual+'>','NULL')+CHAR(13)+CHAR(10)+'is not in'+CHAR(13)+CHAR(10)+@ExpectedMessage;
    EXEC tSQLt.Fail @Message, @ExpectedMessage;
  END;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[CaptureOutput]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [tSQLt].[CaptureOutput]
	@command [nvarchar](max)
WITH EXECUTE AS CALLER
AS
EXTERNAL NAME [tSQLtCLR].[tSQLtCLR.StoredProcedures].[CaptureOutput]
GO
/****** Object:  StoredProcedure [tSQLt].[DefaultResultFormatter]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[DefaultResultFormatter]
AS
BEGIN
    DECLARE @Msg1 NVARCHAR(MAX);
    DECLARE @Msg2 NVARCHAR(MAX);
    DECLARE @Msg3 NVARCHAR(MAX);
    DECLARE @Msg4 NVARCHAR(MAX);
    DECLARE @IsSuccess INT;
    DECLARE @SuccessCnt INT;
    DECLARE @Severity INT;
    
    SELECT ROW_NUMBER() OVER(ORDER BY Result DESC, Name ASC) No,Name [Test Case Name],
           RIGHT(SPACE(7)+CAST(DATEDIFF(MILLISECOND,TestStartTime,TestEndTime) AS VARCHAR(7)),7) AS [Dur(ms)], Result
      INTO #TestResultOutput
      FROM tSQLt.TestResult;
    
    EXEC tSQLt.TableToText @Msg1 OUTPUT, '#TestResultOutput', 'No';

    SELECT @Msg3 = Msg, 
           @IsSuccess = 1 - SIGN(FailCnt + ErrorCnt),
           @SuccessCnt = SuccessCnt
      FROM tSQLt.TestCaseSummary();
      
    SELECT @Severity = 16*(1-@IsSuccess);
    
    SELECT @Msg2 = REPLICATE('-',LEN(@Msg3)),
           @Msg4 = CHAR(13)+CHAR(10);
    
    
    EXEC tSQLt.Private_Print @Msg4,0;
    EXEC tSQLt.Private_Print '+----------------------+',0;
    EXEC tSQLt.Private_Print '|Test Execution Summary|',0;
    EXEC tSQLt.Private_Print '+----------------------+',0;
    EXEC tSQLt.Private_Print @Msg4,0;
    EXEC tSQLt.Private_Print @Msg1,0;
    EXEC tSQLt.Private_Print @Msg2,0;
    EXEC tSQLt.Private_Print @Msg3, @Severity;
    EXEC tSQLt.Private_Print @Msg2,0;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[DropClass]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[DropClass]
    @ClassName NVARCHAR(MAX)
AS
BEGIN
    DECLARE @Cmd NVARCHAR(MAX);

    WITH ObjectInfo(name, type) AS
         (
           SELECT QUOTENAME(SCHEMA_NAME(O.schema_id))+'.'+QUOTENAME(O.name) , O.type
             FROM sys.objects AS O
            WHERE O.schema_id = SCHEMA_ID(PARSENAME(@ClassName,1))
         ),
         TypeInfo(name) AS
         (
           SELECT QUOTENAME(SCHEMA_NAME(T.schema_id))+'.'+QUOTENAME(T.name)
             FROM sys.types AS T
            WHERE T.schema_id = SCHEMA_ID(PARSENAME(@ClassName,1))
         ),
         XMLSchemaInfo(name) AS
         (
           SELECT QUOTENAME(SCHEMA_NAME(XSC.schema_id))+'.'+QUOTENAME(XSC.name)
             FROM sys.xml_schema_collections AS XSC
            WHERE XSC.schema_id = SCHEMA_ID(PARSENAME(@ClassName,1))
         ),
         DropStatements(no,cmd) AS
         (
           SELECT 10,
                  'DROP ' +
                  CASE type WHEN 'P' THEN 'PROCEDURE'
                            WHEN 'PC' THEN 'PROCEDURE'
                            WHEN 'U' THEN 'TABLE'
                            WHEN 'IF' THEN 'FUNCTION'
                            WHEN 'TF' THEN 'FUNCTION'
                            WHEN 'FN' THEN 'FUNCTION'
                            WHEN 'V' THEN 'VIEW'
                   END +
                   ' ' + 
                   name + 
                   ';'
              FROM ObjectInfo
             UNION ALL
           SELECT 20,
                  'DROP TYPE ' +
                   name + 
                   ';'
              FROM TypeInfo
             UNION ALL
           SELECT 30,
                  'DROP XML SCHEMA COLLECTION ' +
                   name + 
                   ';'
              FROM XMLSchemaInfo
             UNION ALL
            SELECT 10000,'DROP SCHEMA ' + QUOTENAME(name) +';'
              FROM sys.schemas
             WHERE schema_id = SCHEMA_ID(PARSENAME(@ClassName,1))
         ),
         StatementBlob(xml)AS
         (
           SELECT cmd [text()]
             FROM DropStatements
            ORDER BY no
              FOR XML PATH(''), TYPE
         )
    SELECT @Cmd = xml.value('/', 'NVARCHAR(MAX)') 
      FROM StatementBlob;

    EXEC(@Cmd);
END;
GO
/****** Object:  StoredProcedure [tSQLt].[EnableExternalAccess]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[EnableExternalAccess]
  @try BIT = 0,
  @enable BIT = 1
AS
BEGIN
  BEGIN TRY
    IF @enable = 1
    BEGIN
      EXEC('ALTER ASSEMBLY tSQLtCLR WITH PERMISSION_SET = EXTERNAL_ACCESS;');
    END
    ELSE
    BEGIN
      EXEC('ALTER ASSEMBLY tSQLtCLR WITH PERMISSION_SET = SAFE;');
    END
  END TRY
  BEGIN CATCH
    IF(@try = 0)
    BEGIN
      DECLARE @Message NVARCHAR(4000);
      SET @Message = 'The attempt to ' +
                      CASE WHEN @enable = 1 THEN 'enable' ELSE 'disable' END +
                      ' tSQLt features requiring EXTERNAL_ACCESS failed' +
                      ': '+ERROR_MESSAGE();
      RAISERROR(@Message,16,10);
    END;
    RETURN -1;
  END CATCH;
  RETURN 0;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[ExpectException]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[ExpectException]
@ExpectedMessage NVARCHAR(MAX) = NULL,
@ExpectedSeverity INT = NULL,
@ExpectedState INT = NULL,
@Message NVARCHAR(MAX) = NULL,
@ExpectedMessagePattern NVARCHAR(MAX) = NULL,
@ExpectedErrorNumber INT = NULL
AS
BEGIN
 IF(EXISTS(SELECT 1 FROM #ExpectException WHERE ExpectException = 1))
 BEGIN
   DELETE #ExpectException;
   RAISERROR('Each test can only contain one call to tSQLt.ExpectException.',16,10);
 END;
 
 INSERT INTO #ExpectException(ExpectException, ExpectedMessage, ExpectedSeverity, ExpectedState, ExpectedMessagePattern, ExpectedErrorNumber, FailMessage)
 VALUES(1, @ExpectedMessage, @ExpectedSeverity, @ExpectedState, @ExpectedMessagePattern, @ExpectedErrorNumber, @Message);
END;
GO
/****** Object:  StoredProcedure [tSQLt].[ExpectNoException]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[ExpectNoException]
  @Message NVARCHAR(MAX) = NULL
AS
BEGIN
 IF(EXISTS(SELECT 1 FROM #ExpectException WHERE ExpectException = 0))
 BEGIN
   DELETE #ExpectException;
   RAISERROR('Each test can only contain one call to tSQLt.ExpectNoException.',16,10);
 END;
 IF(EXISTS(SELECT 1 FROM #ExpectException WHERE ExpectException = 1))
 BEGIN
   DELETE #ExpectException;
   RAISERROR('tSQLt.ExpectNoException cannot follow tSQLt.ExpectException inside a single test.',16,10);
 END;
 
 INSERT INTO #ExpectException(ExpectException, FailMessage)
 VALUES(0, @Message);
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Fail]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Fail]
    @Message0 NVARCHAR(MAX) = '',
    @Message1 NVARCHAR(MAX) = '',
    @Message2 NVARCHAR(MAX) = '',
    @Message3 NVARCHAR(MAX) = '',
    @Message4 NVARCHAR(MAX) = '',
    @Message5 NVARCHAR(MAX) = '',
    @Message6 NVARCHAR(MAX) = '',
    @Message7 NVARCHAR(MAX) = '',
    @Message8 NVARCHAR(MAX) = '',
    @Message9 NVARCHAR(MAX) = ''
AS
BEGIN
   DECLARE @WarningMessage NVARCHAR(MAX);
   SET @WarningMessage = '';

   IF XACT_STATE() = -1
   BEGIN
     SET @WarningMessage = CHAR(13)+CHAR(10)+'Warning: Uncommitable transaction detected!';

     DECLARE @TranName NVARCHAR(MAX);
     SELECT @TranName = TranName
       FROM tSQLt.TestResult
      WHERE Id = (SELECT MAX(Id) FROM tSQLt.TestResult);

     DECLARE @TranCount INT;
     SET @TranCount = @@TRANCOUNT;
     ROLLBACK;
     WHILE(@TranCount>0)
     BEGIN
       BEGIN TRAN;
       SET @TranCount = @TranCount -1;
     END;
     SAVE TRAN @TranName;
   END;

   INSERT INTO tSQLt.TestMessage(Msg)
   SELECT COALESCE(@Message0, '!NULL!')
        + COALESCE(@Message1, '!NULL!')
        + COALESCE(@Message2, '!NULL!')
        + COALESCE(@Message3, '!NULL!')
        + COALESCE(@Message4, '!NULL!')
        + COALESCE(@Message5, '!NULL!')
        + COALESCE(@Message6, '!NULL!')
        + COALESCE(@Message7, '!NULL!')
        + COALESCE(@Message8, '!NULL!')
        + COALESCE(@Message9, '!NULL!')
        + @WarningMessage;
        
   RAISERROR('tSQLt.Failure',16,10);
END;
GO
/****** Object:  StoredProcedure [tSQLt].[FakeFunction]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[FakeFunction]
  @FunctionName NVARCHAR(MAX),
  @FakeFunctionName NVARCHAR(MAX)
AS
BEGIN
  DECLARE @FunctionObjectId INT;
  DECLARE @FakeFunctionObjectId INT;
  DECLARE @IsScalarFunction BIT;

  EXEC tSQLt.Private_ValidateObjectsCompatibleWithFakeFunction 
               @FunctionName = @FunctionName,
               @FakeFunctionName = @FakeFunctionName,
               @FunctionObjectId = @FunctionObjectId OUT,
               @FakeFunctionObjectId = @FakeFunctionObjectId OUT,
               @IsScalarFunction = @IsScalarFunction OUT;

  EXEC tSQLt.RemoveObject @ObjectName = @FunctionName;

  EXEC tSQLt.Private_CreateFakeFunction 
               @FunctionName = @FunctionName,
               @FakeFunctionName = @FakeFunctionName,
               @FunctionObjectId = @FunctionObjectId,
               @FakeFunctionObjectId = @FakeFunctionObjectId,
               @IsScalarFunction = @IsScalarFunction;

END;
GO
/****** Object:  StoredProcedure [tSQLt].[FakeTable]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[FakeTable]
    @TableName NVARCHAR(MAX),
    @SchemaName NVARCHAR(MAX) = NULL, --parameter preserved for backward compatibility. Do not use. Will be removed soon.
    @Identity BIT = NULL,
    @ComputedColumns BIT = NULL,
    @Defaults BIT = NULL
AS
BEGIN
   DECLARE @OrigSchemaName NVARCHAR(MAX);
   DECLARE @OrigTableName NVARCHAR(MAX);
   DECLARE @NewNameOfOriginalTable NVARCHAR(4000);
   DECLARE @OrigTableFullName NVARCHAR(MAX); SET @OrigTableFullName = NULL;
   
   SELECT @OrigSchemaName = @SchemaName,
          @OrigTableName = @TableName
   
   IF(@OrigTableName NOT IN (PARSENAME(@OrigTableName,1),QUOTENAME(PARSENAME(@OrigTableName,1)))
      AND @OrigSchemaName IS NOT NULL)
   BEGIN
     RAISERROR('When @TableName is a multi-part identifier, @SchemaName must be NULL!',16,10);
   END

   SELECT @SchemaName = CleanSchemaName,
          @TableName = CleanTableName
     FROM tSQLt.Private_ResolveFakeTableNamesForBackwardCompatibility(@TableName, @SchemaName);
   
   EXEC tSQLt.Private_ValidateFakeTableParameters @SchemaName,@OrigTableName,@OrigSchemaName;

   EXEC tSQLt.Private_RenameObjectToUniqueName @SchemaName, @TableName, @NewNameOfOriginalTable OUTPUT;

   SELECT @OrigTableFullName = S.base_object_name
     FROM sys.synonyms AS S 
    WHERE S.object_id = OBJECT_ID(@SchemaName + '.' + @NewNameOfOriginalTable);

   IF(@OrigTableFullName IS NOT NULL)
   BEGIN
     IF(COALESCE(OBJECT_ID(@OrigTableFullName,'U'),OBJECT_ID(@OrigTableFullName,'V')) IS NULL)
     BEGIN
       RAISERROR('Cannot fake synonym %s.%s as it is pointing to %s, which is not a table or view!',16,10,@SchemaName,@TableName,@OrigTableFullName);
     END;
   END;
   ELSE
   BEGIN
     SET @OrigTableFullName = @SchemaName + '.' + @NewNameOfOriginalTable;
   END;

   EXEC tSQLt.Private_CreateFakeOfTable @SchemaName, @TableName, @OrigTableFullName, @Identity, @ComputedColumns, @Defaults;

   EXEC tSQLt.Private_MarkFakeTable @SchemaName, @TableName, @NewNameOfOriginalTable;
END
GO
/****** Object:  StoredProcedure [tSQLt].[GetNewTranName]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[GetNewTranName]
  @TranName CHAR(32) OUTPUT
AS
BEGIN
  SELECT @TranName = LEFT('tSQLtTran'+REPLACE(CAST(NEWID() AS NVARCHAR(60)),'-',''),32);
END;
GO
/****** Object:  StoredProcedure [tSQLt].[InstallExternalAccessKey]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[InstallExternalAccessKey]
AS
BEGIN
  IF(NOT EXISTS(SELECT * FROM sys.fn_my_permissions(NULL,'server') AS FMP WHERE FMP.permission_name = 'CONTROL SERVER'))
  BEGIN
    RAISERROR('Only principals with CONTROL SERVER permission can execute this procedure.',16,10);
    RETURN -1;
  END;

  DECLARE @cmd NVARCHAR(MAX);
  DECLARE @cmd2 NVARCHAR(MAX);
  DECLARE @master_sys_sp_executesql NVARCHAR(MAX); SET @master_sys_sp_executesql = 'master.sys.sp_executesql';

  SET @cmd = 'IF EXISTS(SELECT * FROM sys.assemblies WHERE name = ''tSQLtExternalAccessKey'') DROP ASSEMBLY tSQLtExternalAccessKey;';
  EXEC @master_sys_sp_executesql @cmd;

  SET @cmd2 = 'SELECT @cmd = ''DROP ASSEMBLY ''+QUOTENAME(A.name)+'';'''+ 
              '  FROM master.sys.assemblies AS A'+
              ' WHERE A.clr_name LIKE ''tsqltexternalaccesskey, %'';';
  EXEC sys.sp_executesql @cmd2,N'@cmd NVARCHAR(MAX) OUTPUT',@cmd OUT;
  EXEC @master_sys_sp_executesql @cmd;

  SELECT @cmd = 
         'CREATE ASSEMBLY tSQLtExternalAccessKey AUTHORIZATION dbo FROM ' +
         BH.prefix +
         ' WITH PERMISSION_SET = SAFE;'       
    FROM tSQLt.Private_GetExternalAccessKeyBytes() AS PGEAKB
   CROSS APPLY tSQLt.Private_Bin2Hex(PGEAKB.ExternalAccessKeyBytes) BH;
  EXEC @master_sys_sp_executesql @cmd;

  IF SUSER_ID('tSQLtExternalAccessKey') IS NOT NULL DROP LOGIN tSQLtExternalAccessKey;

  SET @cmd = N'IF ASYMKEY_ID(''tSQLtExternalAccessKey'') IS NOT NULL DROP ASYMMETRIC KEY tSQLtExternalAccessKey;';
  EXEC @master_sys_sp_executesql @cmd;

  SET @cmd2 = 'SELECT @cmd = ISNULL(''DROP LOGIN ''+QUOTENAME(SP.name)+'';'','''')+''DROP ASYMMETRIC KEY '' + QUOTENAME(AK.name) + '';'''+
              '  FROM master.sys.asymmetric_keys AS AK'+
              '  JOIN tSQLt.Private_GetExternalAccessKeyBytes() AS PGEAKB'+
              '    ON AK.thumbprint = PGEAKB.ExternalAccessKeyThumbPrint'+
              '  LEFT JOIN master.sys.server_principals AS SP'+
              '    ON AK.sid = SP.sid;';
  EXEC sys.sp_executesql @cmd2,N'@cmd NVARCHAR(MAX) OUTPUT',@cmd OUT;
  EXEC @master_sys_sp_executesql @cmd;

  SET @cmd = 'CREATE ASYMMETRIC KEY tSQLtExternalAccessKey FROM ASSEMBLY tSQLtExternalAccessKey;';
  EXEC @master_sys_sp_executesql @cmd;
 
  SET @cmd = 'CREATE LOGIN tSQLtExternalAccessKey FROM ASYMMETRIC KEY tSQLtExternalAccessKey;';
  EXEC @master_sys_sp_executesql @cmd;

  SET @cmd = 'DROP ASSEMBLY tSQLtExternalAccessKey;';
  EXEC @master_sys_sp_executesql @cmd;

  SET @cmd = 'GRANT EXTERNAL ACCESS ASSEMBLY TO tSQLtExternalAccessKey;';
  EXEC @master_sys_sp_executesql @cmd;

END;
GO
/****** Object:  StoredProcedure [tSQLt].[LogCapturedOutput]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[LogCapturedOutput] @text NVARCHAR(MAX)
AS
BEGIN
  INSERT INTO tSQLt.CaptureOutputLog (OutputText) VALUES (@text);
END;
GO
/****** Object:  StoredProcedure [tSQLt].[NewConnection]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [tSQLt].[NewConnection]
	@command [nvarchar](max)
WITH EXECUTE AS CALLER
AS
EXTERNAL NAME [tSQLtCLR].[tSQLtCLR.StoredProcedures].[NewConnection]
GO
/****** Object:  StoredProcedure [tSQLt].[NewTestClass]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[NewTestClass]
    @ClassName NVARCHAR(MAX)
AS
BEGIN
  BEGIN TRY
    EXEC tSQLt.Private_DisallowOverwritingNonTestSchema @ClassName;

    EXEC tSQLt.DropClass @ClassName = @ClassName;

    DECLARE @QuotedClassName NVARCHAR(MAX);
    SELECT @QuotedClassName = tSQLt.Private_QuoteClassNameForNewTestClass(@ClassName);

    EXEC ('CREATE SCHEMA ' + @QuotedClassName);  
    EXEC tSQLt.Private_MarkSchemaAsTestClass @QuotedClassName;
  END TRY
  BEGIN CATCH
    DECLARE @ErrMsg NVARCHAR(MAX);SET @ErrMsg = ERROR_MESSAGE() + ' (Error originated in ' + ERROR_PROCEDURE() + ')';
    DECLARE @ErrSvr INT;SET @ErrSvr = ERROR_SEVERITY();
    
    RAISERROR(@ErrMsg, @ErrSvr, 10);
  END CATCH;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[NullTestResultFormatter]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[NullTestResultFormatter]
AS
BEGIN
  RETURN 0;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_ApplyCheckConstraint]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_ApplyCheckConstraint]
  @ConstraintObjectId INT
AS
BEGIN
  DECLARE @Cmd NVARCHAR(MAX);
  SELECT @Cmd = 'CONSTRAINT ' + QUOTENAME(name) + ' CHECK' + definition 
    FROM sys.check_constraints
   WHERE object_id = @ConstraintObjectId;
  
  DECLARE @QuotedTableName NVARCHAR(MAX);
  
  SELECT @QuotedTableName = QuotedTableName FROM tSQLt.Private_GetQuotedTableNameForConstraint(@ConstraintObjectId);

  EXEC tSQLt.Private_RenameObjectToUniqueNameUsingObjectId @ConstraintObjectId;
  SELECT @Cmd = 'ALTER TABLE ' + @QuotedTableName + ' ADD ' + @Cmd
    FROM sys.objects 
   WHERE object_id = @ConstraintObjectId;

  EXEC (@Cmd);

END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_ApplyForeignKeyConstraint]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_ApplyForeignKeyConstraint] 
  @ConstraintObjectId INT,
  @NoCascade BIT
AS
BEGIN
  DECLARE @SchemaName NVARCHAR(MAX);
  DECLARE @OrgTableName NVARCHAR(MAX);
  DECLARE @TableName NVARCHAR(MAX);
  DECLARE @ConstraintName NVARCHAR(MAX);
  DECLARE @CreateFkCmd NVARCHAR(MAX);
  DECLARE @AlterTableCmd NVARCHAR(MAX);
  DECLARE @CreateIndexCmd NVARCHAR(MAX);
  DECLARE @FinalCmd NVARCHAR(MAX);
  
  SELECT @SchemaName = SchemaName,
         @OrgTableName = OrgTableName,
         @TableName = TableName,
         @ConstraintName = OBJECT_NAME(@ConstraintObjectId)
    FROM tSQLt.Private_GetQuotedTableNameForConstraint(@ConstraintObjectId);
      
  SELECT @CreateFkCmd = cmd, @CreateIndexCmd = CreIdxCmd
    FROM tSQLt.Private_GetForeignKeyDefinition(@SchemaName, @OrgTableName, @ConstraintName, @NoCascade);
  SELECT @AlterTableCmd = 'ALTER TABLE ' + QUOTENAME(@SchemaName) + '.' + QUOTENAME(@TableName) + 
                          ' ADD ' + @CreateFkCmd;
  SELECT @FinalCmd = @CreateIndexCmd + @AlterTableCmd;

  EXEC tSQLt.Private_RenameObjectToUniqueName @SchemaName, @ConstraintName;
  EXEC (@FinalCmd);
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_ApplyUniqueConstraint]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_ApplyUniqueConstraint] 
  @ConstraintObjectId INT
AS
BEGIN
  DECLARE @SchemaName NVARCHAR(MAX);
  DECLARE @OrgTableName NVARCHAR(MAX);
  DECLARE @TableName NVARCHAR(MAX);
  DECLARE @ConstraintName NVARCHAR(MAX);
  DECLARE @CreateConstraintCmd NVARCHAR(MAX);
  DECLARE @AlterColumnsCmd NVARCHAR(MAX);
  
  SELECT @SchemaName = SchemaName,
         @OrgTableName = OrgTableName,
         @TableName = TableName,
         @ConstraintName = OBJECT_NAME(@ConstraintObjectId)
    FROM tSQLt.Private_GetQuotedTableNameForConstraint(@ConstraintObjectId);
      
  SELECT @AlterColumnsCmd = NotNullColumnCmd,
         @CreateConstraintCmd = CreateConstraintCmd
    FROM tSQLt.Private_GetUniqueConstraintDefinition(@ConstraintObjectId, QUOTENAME(@SchemaName) + '.' + QUOTENAME(@TableName));

  EXEC tSQLt.Private_RenameObjectToUniqueName @SchemaName, @ConstraintName;
  EXEC (@AlterColumnsCmd);
  EXEC (@CreateConstraintCmd);
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_CleanTestResult]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_CleanTestResult]
AS
BEGIN
   DELETE FROM tSQLt.TestResult;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_CompareTables]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_CompareTables]
    @Expected NVARCHAR(MAX),
    @Actual NVARCHAR(MAX),
    @ResultTable NVARCHAR(MAX),
    @ColumnList NVARCHAR(MAX),
    @MatchIndicatorColumnName NVARCHAR(MAX)
AS
BEGIN
    DECLARE @cmd NVARCHAR(MAX);
    DECLARE @RestoredRowIndexCounterColName NVARCHAR(MAX);
    SET @RestoredRowIndexCounterColName = @MatchIndicatorColumnName + '_RR';
    
    SELECT @cmd = 
    '
    INSERT INTO ' + @ResultTable + ' (' + @MatchIndicatorColumnName + ', ' + @ColumnList + ') 
    SELECT 
      CASE 
        WHEN RestoredRowIndex.'+@RestoredRowIndexCounterColName+' <= CASE WHEN [_{Left}_]<[_{Right}_] THEN [_{Left}_] ELSE [_{Right}_] END
         THEN ''='' 
        WHEN RestoredRowIndex.'+@RestoredRowIndexCounterColName+' <= [_{Left}_] 
         THEN ''<'' 
        ELSE ''>'' 
      END AS ' + @MatchIndicatorColumnName + ', ' + @ColumnList + '
    FROM(
      SELECT SUM([_{Left}_]) AS [_{Left}_], 
             SUM([_{Right}_]) AS [_{Right}_], 
             ' + @ColumnList + ' 
      FROM (
        SELECT 1 AS [_{Left}_], 0[_{Right}_], ' + @ColumnList + '
          FROM ' + @Expected + '
        UNION ALL 
        SELECT 0[_{Left}_], 1 AS [_{Right}_], ' + @ColumnList + ' 
          FROM ' + @Actual + '
      ) AS X 
      GROUP BY ' + @ColumnList + ' 
    ) AS CollapsedRows
    CROSS APPLY (
       SELECT TOP(CASE WHEN [_{Left}_]>[_{Right}_] THEN [_{Left}_] 
                       ELSE [_{Right}_] END) 
              ROW_NUMBER() OVER(ORDER BY(SELECT 1)) 
         FROM (SELECT 1 
                 FROM ' + @Actual + ' UNION ALL SELECT 1 FROM ' + @Expected + ') X(X)
              ) AS RestoredRowIndex(' + @RestoredRowIndexCounterColName + ');';
    
    EXEC (@cmd); --MainGroupQuery
    
    SET @cmd = 'SET @r = 
         CASE WHEN EXISTS(
                  SELECT 1 
                    FROM ' + @ResultTable + 
                 ' WHERE ' + @MatchIndicatorColumnName + ' IN (''<'', ''>'')) 
              THEN 1 ELSE 0 
         END';
    DECLARE @UnequalRowsExist INT;
    EXEC sp_executesql @cmd, N'@r INT OUTPUT',@UnequalRowsExist OUTPUT;
    
    RETURN @UnequalRowsExist;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_CompareTablesFailIfUnequalRowsExists]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_CompareTablesFailIfUnequalRowsExists]
 @UnequalRowsExist INT,
 @ResultTable NVARCHAR(MAX),
 @ResultColumn NVARCHAR(MAX),
 @ColumnList NVARCHAR(MAX),
 @FailMsg NVARCHAR(MAX)
AS
BEGIN
  IF @UnequalRowsExist > 0
  BEGIN
   DECLARE @TableToTextResult NVARCHAR(MAX);
   DECLARE @OutputColumnList NVARCHAR(MAX);
   SELECT @OutputColumnList = '[_m_],' + @ColumnList;
   EXEC tSQLt.TableToText @TableName = @ResultTable, @OrderBy = @ResultColumn, @PrintOnlyColumnNameAliasList = @OutputColumnList, @txt = @TableToTextResult OUTPUT;
   
   DECLARE @Message NVARCHAR(MAX);
   SELECT @Message = @FailMsg + CHAR(13) + CHAR(10);

    EXEC tSQLt.Fail @Message, @TableToTextResult;
  END;
END
GO
/****** Object:  StoredProcedure [tSQLt].[Private_CreateFakeFunction]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_CreateFakeFunction]
  @FunctionName NVARCHAR(MAX),
  @FakeFunctionName NVARCHAR(MAX),
  @FunctionObjectId INT,
  @FakeFunctionObjectId INT,
  @IsScalarFunction BIT
AS
BEGIN
  DECLARE @ReturnType NVARCHAR(MAX);
  SELECT @ReturnType = T.TypeName
    FROM sys.parameters AS P
   CROSS APPLY tSQLt.Private_GetFullTypeName(P.user_type_id,P.max_length,P.precision,P.scale,NULL) AS T
   WHERE P.object_id = @FunctionObjectId
     AND P.parameter_id = 0;
     
  DECLARE @ParameterList NVARCHAR(MAX);
  SELECT @ParameterList = COALESCE(
     STUFF((SELECT ','+P.name+' '+T.TypeName+CASE WHEN T.IsTableType = 1 THEN ' READONLY' ELSE '' END
              FROM sys.parameters AS P
             CROSS APPLY tSQLt.Private_GetFullTypeName(P.user_type_id,P.max_length,P.precision,P.scale,NULL) AS T
             WHERE P.object_id = @FunctionObjectId
               AND P.parameter_id > 0
             ORDER BY P.parameter_id
               FOR XML PATH(''),TYPE
           ).value('.','NVARCHAR(MAX)'),1,1,''),'');
           
  DECLARE @ParameterCallList NVARCHAR(MAX);
  SELECT @ParameterCallList = COALESCE(
     STUFF((SELECT ','+P.name
              FROM sys.parameters AS P
             CROSS APPLY tSQLt.Private_GetFullTypeName(P.user_type_id,P.max_length,P.precision,P.scale,NULL) AS T
             WHERE P.object_id = @FunctionObjectId
               AND P.parameter_id > 0
             ORDER BY P.parameter_id
               FOR XML PATH(''),TYPE
           ).value('.','NVARCHAR(MAX)'),1,1,''),'');


  IF(@IsScalarFunction = 1)
  BEGIN
    EXEC('CREATE FUNCTION '+@FunctionName+'('+@ParameterList+') RETURNS '+@ReturnType+' AS BEGIN RETURN '+@FakeFunctionName+'('+@ParameterCallList+');END;'); 
  END
  ELSE
  BEGIN
    EXEC('CREATE FUNCTION '+@FunctionName+'('+@ParameterList+') RETURNS TABLE AS RETURN SELECT * FROM '+@FakeFunctionName+'('+@ParameterCallList+');'); 
  END;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_CreateFakeOfTable]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_CreateFakeOfTable]
  @SchemaName NVARCHAR(MAX),
  @TableName NVARCHAR(MAX),
  @OrigTableFullName NVARCHAR(MAX),
  @Identity BIT,
  @ComputedColumns BIT,
  @Defaults BIT
AS
BEGIN
   DECLARE @Cmd NVARCHAR(MAX);
   DECLARE @Cols NVARCHAR(MAX);
   
   SELECT @Cols = 
   (
    SELECT
       ',' +
       QUOTENAME(name) + 
       cc.ColumnDefinition +
       dc.DefaultDefinition + 
       id.IdentityDefinition +
       CASE WHEN cc.IsComputedColumn = 1 OR id.IsIdentityColumn = 1 
            THEN ''
            ELSE ' NULL'
       END
      FROM sys.columns c
     CROSS APPLY tSQLt.Private_GetDataTypeOrComputedColumnDefinition(c.user_type_id, c.max_length, c.precision, c.scale, c.collation_name, c.object_id, c.column_id, @ComputedColumns) cc
     CROSS APPLY tSQLt.Private_GetDefaultConstraintDefinition(c.object_id, c.column_id, @Defaults) AS dc
     CROSS APPLY tSQLt.Private_GetIdentityDefinition(c.object_id, c.column_id, @Identity) AS id
     WHERE object_id = OBJECT_ID(@OrigTableFullName)
     ORDER BY column_id
     FOR XML PATH(''), TYPE
    ).value('.', 'NVARCHAR(MAX)');
    
   SELECT @Cmd = 'CREATE TABLE ' + @SchemaName + '.' + @TableName + '(' + STUFF(@Cols,1,1,'') + ')';
   
   EXEC (@Cmd);
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_CreateProcedureSpy]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_CreateProcedureSpy]
    @ProcedureObjectId INT,
    @OriginalProcedureName NVARCHAR(MAX),
    @LogTableName NVARCHAR(MAX),
    @CommandToExecute NVARCHAR(MAX) = NULL
AS
BEGIN
    DECLARE @Cmd NVARCHAR(MAX);
    DECLARE @ProcParmList NVARCHAR(MAX),
            @TableColList NVARCHAR(MAX),
            @ProcParmTypeList NVARCHAR(MAX),
            @TableColTypeList NVARCHAR(MAX);
            
    DECLARE @Seperator CHAR(1),
            @ProcParmTypeListSeparater CHAR(1),
            @ParamName sysname,
            @TypeName sysname,
            @IsOutput BIT,
            @IsCursorRef BIT,
            @IsTableType BIT;
            

      
    SELECT @Seperator = '', @ProcParmTypeListSeparater = '', 
           @ProcParmList = '', @TableColList = '', @ProcParmTypeList = '', @TableColTypeList = '';
      
    DECLARE Parameters CURSOR FOR
     SELECT p.name, t.TypeName, p.is_output, p.is_cursor_ref, t.IsTableType
       FROM sys.parameters p
       CROSS APPLY tSQLt.Private_GetFullTypeName(p.user_type_id,p.max_length,p.precision,p.scale,NULL) t
      WHERE object_id = @ProcedureObjectId;
    
    OPEN Parameters;
    
    FETCH NEXT FROM Parameters INTO @ParamName, @TypeName, @IsOutput, @IsCursorRef, @IsTableType;
    WHILE (@@FETCH_STATUS = 0)
    BEGIN
        IF @IsCursorRef = 0
        BEGIN
            SELECT @ProcParmList = @ProcParmList + @Seperator + 
                                   CASE WHEN @IsTableType = 1 
                                     THEN '(SELECT * FROM '+@ParamName+' FOR XML PATH(''row''),TYPE,ROOT('''+STUFF(@ParamName,1,1,'')+'''))' 
                                     ELSE @ParamName 
                                   END, 
                   @TableColList = @TableColList + @Seperator + '[' + STUFF(@ParamName,1,1,'') + ']', 
                   @ProcParmTypeList = @ProcParmTypeList + @ProcParmTypeListSeparater + @ParamName + ' ' + @TypeName + 
                                       CASE WHEN @IsTableType = 1 THEN ' READONLY' ELSE ' = NULL ' END+ 
                                       CASE WHEN @IsOutput = 1 THEN ' OUT' ELSE '' END, 
                   @TableColTypeList = @TableColTypeList + ',[' + STUFF(@ParamName,1,1,'') + '] ' + 
                          CASE 
                               WHEN @IsTableType = 1
                               THEN 'XML'
                               WHEN @TypeName LIKE '%nchar%'
                                 OR @TypeName LIKE '%nvarchar%'
                               THEN 'NVARCHAR(MAX)'
                               WHEN @TypeName LIKE '%char%'
                               THEN 'VARCHAR(MAX)'
                               ELSE @TypeName
                          END + ' NULL';

            SELECT @Seperator = ',';        
            SELECT @ProcParmTypeListSeparater = ',';
        END
        ELSE
        BEGIN
            SELECT @ProcParmTypeList = @ProcParmTypeListSeparater + @ParamName + ' CURSOR VARYING OUTPUT';
            SELECT @ProcParmTypeListSeparater = ',';
        END;
        
        FETCH NEXT FROM Parameters INTO @ParamName, @TypeName, @IsOutput, @IsCursorRef, @IsTableType;
    END;
    
    CLOSE Parameters;
    DEALLOCATE Parameters;
    
    DECLARE @InsertStmt NVARCHAR(MAX);
    SELECT @InsertStmt = 'INSERT INTO ' + @LogTableName + 
                         CASE WHEN @TableColList = '' THEN ' DEFAULT VALUES'
                              ELSE ' (' + @TableColList + ') SELECT ' + @ProcParmList
                         END + ';';
                         
    SELECT @Cmd = 'CREATE TABLE ' + @LogTableName + ' (_id_ int IDENTITY(1,1) PRIMARY KEY CLUSTERED ' + @TableColTypeList + ');';
    EXEC(@Cmd);

    SELECT @Cmd = 'CREATE PROCEDURE ' + @OriginalProcedureName + ' ' + @ProcParmTypeList + 
                  ' AS BEGIN ' + 
                     @InsertStmt + 
                     ISNULL(@CommandToExecute, '') + ';' +
                  ' END;';
    EXEC(@Cmd);

    RETURN 0;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_CreateResultTableForCompareTables]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_CreateResultTableForCompareTables]
 @ResultTable NVARCHAR(MAX),
 @ResultColumn NVARCHAR(MAX),
 @BaseTable NVARCHAR(MAX)
AS
BEGIN
  DECLARE @Cmd NVARCHAR(MAX);
  SET @Cmd = '
     SELECT ''='' AS ' + @ResultColumn + ', Expected.* INTO ' + @ResultTable + ' 
       FROM tSQLt.Private_NullCellTable N 
       LEFT JOIN ' + @BaseTable + ' AS Expected ON N.I <> N.I 
     TRUNCATE TABLE ' + @ResultTable + ';' --Need to insert an actual row to prevent IDENTITY property from transfering (IDENTITY_COL can't be NULLable);
  EXEC(@Cmd);
END
GO
/****** Object:  StoredProcedure [tSQLt].[Private_DisallowOverwritingNonTestSchema]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_DisallowOverwritingNonTestSchema]
  @ClassName NVARCHAR(MAX)
AS
BEGIN
  IF SCHEMA_ID(@ClassName) IS NOT NULL AND tSQLt.Private_IsTestClass(@ClassName) = 0
  BEGIN
    RAISERROR('Attempted to execute tSQLt.NewTestClass on ''%s'' which is an existing schema but not a test class', 16, 10, @ClassName);
  END
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_GetCursorForRunAll]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_GetCursorForRunAll]
  @TestClassCursor CURSOR VARYING OUTPUT
AS
BEGIN
  SET @TestClassCursor = CURSOR LOCAL FAST_FORWARD FOR
   SELECT Name
     FROM tSQLt.TestClasses;

  OPEN @TestClassCursor;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_GetCursorForRunNew]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_GetCursorForRunNew]
  @TestClassCursor CURSOR VARYING OUTPUT
AS
BEGIN
  SET @TestClassCursor = CURSOR LOCAL FAST_FORWARD FOR
   SELECT TC.Name
     FROM tSQLt.TestClasses AS TC
     JOIN tSQLt.Private_NewTestClassList AS PNTCL
       ON PNTCL.ClassName = TC.Name;

  OPEN @TestClassCursor;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_GetSetupProcedureName]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_GetSetupProcedureName]
  @TestClassId INT = NULL,
  @SetupProcName NVARCHAR(MAX) OUTPUT
AS
BEGIN
    SELECT @SetupProcName = tSQLt.Private_GetQuotedFullName(object_id)
      FROM sys.procedures
     WHERE schema_id = @TestClassId
       AND LOWER(name) = 'setup';
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_Init]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_Init]
AS
BEGIN
  EXEC tSQLt.Private_CleanTestResult;

  DECLARE @enable BIT; SET @enable = 1;
  DECLARE @version_match BIT;SET @version_match = 0;
  BEGIN TRY
    EXEC sys.sp_executesql N'SELECT @r = CASE WHEN I.Version = I.ClrVersion THEN 1 ELSE 0 END FROM tSQLt.Info() AS I;',N'@r BIT OUTPUT',@version_match OUT;
  END TRY
  BEGIN CATCH
    RAISERROR('Cannot access CLR. Assembly might be in an invalid state. Try running EXEC tSQLt.EnableExternalAccess @enable = 0; or reinstalling tSQLt.',16,10);
    RETURN;
  END CATCH;
  IF(@version_match = 0)
  BEGIN
    RAISERROR('tSQLt is in an invalid state. Please reinstall tSQLt.',16,10);
    RETURN;
  END;

  IF((SELECT SqlEdition FROM tSQLt.Info()) <> 'SQL Azure')
  BEGIN
    EXEC tSQLt.EnableExternalAccess @enable = @enable, @try = 1;
  END;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_InputBuffer]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_InputBuffer]
  @InputBuffer NVARCHAR(MAX) OUTPUT
AS
BEGIN
  CREATE TABLE #inputbuffer(EventType SYSNAME, Parameters SMALLINT, EventInfo NVARCHAR(MAX));
  INSERT INTO #inputbuffer
  EXEC('DBCC INPUTBUFFER(@@SPID) WITH NO_INFOMSGS;');
  SELECT @InputBuffer = I.EventInfo FROM #inputbuffer AS I;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_MarkFakeTable]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_MarkFakeTable]
  @SchemaName NVARCHAR(MAX),
  @TableName NVARCHAR(MAX),
  @NewNameOfOriginalTable NVARCHAR(4000)
AS
BEGIN
   DECLARE @UnquotedSchemaName NVARCHAR(MAX);SET @UnquotedSchemaName = OBJECT_SCHEMA_NAME(OBJECT_ID(@SchemaName+'.'+@TableName));
   DECLARE @UnquotedTableName NVARCHAR(MAX);SET @UnquotedTableName = OBJECT_NAME(OBJECT_ID(@SchemaName+'.'+@TableName));

   EXEC sys.sp_addextendedproperty 
      @name = N'tSQLt.FakeTable_OrgTableName', 
      @value = @NewNameOfOriginalTable, 
      @level0type = N'SCHEMA', @level0name = @UnquotedSchemaName, 
      @level1type = N'TABLE',  @level1name = @UnquotedTableName;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_MarkObjectBeforeRename]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_MarkObjectBeforeRename]
    @SchemaName NVARCHAR(MAX), 
    @OriginalName NVARCHAR(MAX)
AS
BEGIN
  INSERT INTO tSQLt.Private_RenamedObjectLog (ObjectId, OriginalName) 
  VALUES (OBJECT_ID(@SchemaName + '.' + @OriginalName), @OriginalName);
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_MarkSchemaAsTestClass]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_MarkSchemaAsTestClass]
  @QuotedClassName NVARCHAR(MAX)
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @UnquotedClassName NVARCHAR(MAX);

  SELECT @UnquotedClassName = name
    FROM sys.schemas
   WHERE QUOTENAME(name) = @QuotedClassName;

  EXEC sp_addextendedproperty @name = N'tSQLt.TestClass', 
                              @value = 1,
                              @level0type = 'SCHEMA',
                              @level0name = @UnquotedClassName;

  INSERT INTO tSQLt.Private_NewTestClassList(ClassName)
  SELECT @UnquotedClassName
   WHERE NOT EXISTS
             (
               SELECT * 
                 FROM tSQLt.Private_NewTestClassList AS NTC
                 WITH(UPDLOCK,ROWLOCK,HOLDLOCK)
                WHERE NTC.ClassName = @UnquotedClassName
             );
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_OutputTestResults]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_OutputTestResults]
  @TestResultFormatter NVARCHAR(MAX) = NULL
AS
BEGIN
    DECLARE @Formatter NVARCHAR(MAX);
    SELECT @Formatter = COALESCE(@TestResultFormatter, tSQLt.GetTestResultFormatter());
    EXEC (@Formatter);
END
GO
/****** Object:  StoredProcedure [tSQLt].[Private_Print]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_Print] 
    @Message NVARCHAR(MAX),
    @Severity INT = 0
AS 
BEGIN
    DECLARE @SPos INT;SET @SPos = 1;
    DECLARE @EPos INT;
    DECLARE @Len INT; SET @Len = LEN(@Message);
    DECLARE @SubMsg NVARCHAR(MAX);
    DECLARE @Cmd NVARCHAR(MAX);
    
    DECLARE @CleanedMessage NVARCHAR(MAX);
    SET @CleanedMessage = REPLACE(@Message,'%','%%');
    
    WHILE (@SPos <= @Len)
    BEGIN
      SET @EPos = CHARINDEX(CHAR(13)+CHAR(10),@CleanedMessage+CHAR(13)+CHAR(10),@SPos);
      SET @SubMsg = SUBSTRING(@CleanedMessage, @SPos, @EPos - @SPos);
      SET @Cmd = N'RAISERROR(@Msg,@Severity,10) WITH NOWAIT;';
      EXEC sp_executesql @Cmd, 
                         N'@Msg NVARCHAR(MAX),@Severity INT',
                         @SubMsg,
                         @Severity;
      SELECT @SPos = @EPos + 2,
             @Severity = 0; --Print only first line with high severity
    END

    RETURN 0;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_PrintXML]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_PrintXML]
    @Message XML
AS 
BEGIN
    SELECT @Message FOR XML PATH('');--Required together with ":XML ON" sqlcmd statement to allow more than 1mb to be returned
    RETURN 0;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_RemoveSchemaBinding]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_RemoveSchemaBinding]
  @object_id INT
AS
BEGIN
  DECLARE @cmd NVARCHAR(MAX);
  SELECT @cmd = tSQLt.[Private]::GetAlterStatementWithoutSchemaBinding(SM.definition)
    FROM sys.sql_modules AS SM
   WHERE SM.object_id = @object_id;
   EXEC(@cmd);
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_RemoveSchemaBoundReferences]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_RemoveSchemaBoundReferences]
  @object_id INT
AS
BEGIN
  DECLARE @cmd NVARCHAR(MAX);
  SELECT @cmd = 
  (
    SELECT 
      'EXEC tSQLt.Private_RemoveSchemaBoundReferences @object_id = '+STR(SED.referencing_id)+';'+
      'EXEC tSQLt.Private_RemoveSchemaBinding @object_id = '+STR(SED.referencing_id)+';'
      FROM
      (
        SELECT DISTINCT SEDI.referencing_id,SEDI.referenced_id 
          FROM sys.sql_expression_dependencies AS SEDI
         WHERE SEDI.is_schema_bound_reference = 1
      ) AS SED 
     WHERE SED.referenced_id = @object_id
       FOR XML PATH(''),TYPE
  ).value('.','NVARCHAR(MAX)');
  EXEC(@cmd);
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_RenameObjectToUniqueName]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_RenameObjectToUniqueName]
    @SchemaName NVARCHAR(MAX),
    @ObjectName NVARCHAR(MAX),
    @NewName NVARCHAR(MAX) = NULL OUTPUT
AS
BEGIN
   SET @NewName=tSQLt.Private::CreateUniqueObjectName();

   DECLARE @RenameCmd NVARCHAR(MAX);
   SET @RenameCmd = 'EXEC sp_rename ''' + 
                          @SchemaName + '.' + @ObjectName + ''', ''' + 
                          @NewName + ''';';
   
   EXEC tSQLt.Private_MarkObjectBeforeRename @SchemaName, @ObjectName;


   EXEC tSQLt.SuppressOutput @RenameCmd;

END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_RenameObjectToUniqueNameUsingObjectId]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_RenameObjectToUniqueNameUsingObjectId]
    @ObjectId INT,
    @NewName NVARCHAR(MAX) = NULL OUTPUT
AS
BEGIN
   DECLARE @SchemaName NVARCHAR(MAX);
   DECLARE @ObjectName NVARCHAR(MAX);
   
   SELECT @SchemaName = QUOTENAME(OBJECT_SCHEMA_NAME(@ObjectId)), @ObjectName = QUOTENAME(OBJECT_NAME(@ObjectId));
   
   EXEC tSQLt.Private_RenameObjectToUniqueName @SchemaName,@ObjectName, @NewName OUTPUT;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_ResetNewTestClassList]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_ResetNewTestClassList]
AS
BEGIN
  SET NOCOUNT ON;
  DELETE FROM tSQLt.Private_NewTestClassList;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_Run]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_Run]
   @TestName NVARCHAR(MAX),
   @TestResultFormatter NVARCHAR(MAX)
AS
BEGIN
SET NOCOUNT ON;
    DECLARE @FullName NVARCHAR(MAX);
    DECLARE @TestClassId INT;
    DECLARE @IsTestClass BIT;
    DECLARE @IsTestCase BIT;
    DECLARE @IsSchema BIT;
    DECLARE @SetUp NVARCHAR(MAX);SET @SetUp = NULL;
    
    SELECT @TestName = tSQLt.Private_GetLastTestNameIfNotProvided(@TestName);
    EXEC tSQLt.Private_SaveTestNameForSession @TestName;
    
    SELECT @TestClassId = schemaId,
           @FullName = quotedFullName,
           @IsTestClass = isTestClass,
           @IsSchema = isSchema,
           @IsTestCase = isTestCase
      FROM tSQLt.Private_ResolveName(@TestName);

    IF @IsSchema = 1
    BEGIN
        EXEC tSQLt.Private_RunTestClass @FullName;
    END
    
    IF @IsTestCase = 1
    BEGIN
      DECLARE @SetupProcName NVARCHAR(MAX);
      EXEC tSQLt.Private_GetSetupProcedureName @TestClassId, @SetupProcName OUTPUT;

      EXEC tSQLt.Private_RunTest @FullName, @SetupProcName;
    END;

    EXEC tSQLt.Private_OutputTestResults @TestResultFormatter;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_RunAll]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_RunAll]
  @TestResultFormatter NVARCHAR(MAX)
AS
BEGIN
  EXEC tSQLt.Private_RunCursor @TestResultFormatter = @TestResultFormatter, @GetCursorCallback = 'tSQLt.Private_GetCursorForRunAll';
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_RunCursor]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_RunCursor]
  @TestResultFormatter NVARCHAR(MAX),
  @GetCursorCallback NVARCHAR(MAX)
AS
BEGIN
  SET NOCOUNT ON;
  DECLARE @TestClassName NVARCHAR(MAX);
  DECLARE @TestProcName NVARCHAR(MAX);

  DECLARE @TestClassCursor CURSOR;
  EXEC @GetCursorCallback @TestClassCursor = @TestClassCursor OUT;
----  
  WHILE(1=1)
  BEGIN
    FETCH NEXT FROM @TestClassCursor INTO @TestClassName;
    IF(@@FETCH_STATUS<>0)BREAK;

    EXEC tSQLt.Private_RunTestClass @TestClassName;
    
  END;
  
  CLOSE @TestClassCursor;
  DEALLOCATE @TestClassCursor;
  
  EXEC tSQLt.Private_OutputTestResults @TestResultFormatter;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_RunMethodHandler]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_RunMethodHandler]
  @RunMethod NVARCHAR(MAX),
  @TestResultFormatter NVARCHAR(MAX) = NULL,
  @TestName NVARCHAR(MAX) = NULL
AS
BEGIN
  SELECT @TestResultFormatter = ISNULL(@TestResultFormatter,tSQLt.GetTestResultFormatter());

  EXEC tSQLt.Private_Init;
  IF(@@ERROR = 0)
  BEGIN  
    IF(EXISTS(SELECT * FROM sys.parameters AS P WHERE P.object_id = OBJECT_ID(@RunMethod) AND name = '@TestName'))
    BEGIN
      EXEC @RunMethod @TestName = @TestName, @TestResultFormatter = @TestResultFormatter;
    END;
    ELSE
    BEGIN  
      EXEC @RunMethod @TestResultFormatter = @TestResultFormatter;
    END;
  END;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_RunNew]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_RunNew]
  @TestResultFormatter NVARCHAR(MAX)
AS
BEGIN
  EXEC tSQLt.Private_RunCursor @TestResultFormatter = @TestResultFormatter, @GetCursorCallback = 'tSQLt.Private_GetCursorForRunNew';
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_RunTest]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_RunTest]
   @TestName NVARCHAR(MAX),
   @SetUp NVARCHAR(MAX) = NULL
AS
BEGIN
    DECLARE @Msg NVARCHAR(MAX); SET @Msg = '';
    DECLARE @Msg2 NVARCHAR(MAX); SET @Msg2 = '';
    DECLARE @Cmd NVARCHAR(MAX); SET @Cmd = '';
    DECLARE @TestClassName NVARCHAR(MAX); SET @TestClassName = '';
    DECLARE @TestProcName NVARCHAR(MAX); SET @TestProcName = '';
    DECLARE @Result NVARCHAR(MAX); SET @Result = 'Success';
    DECLARE @TranName CHAR(32); EXEC tSQLt.GetNewTranName @TranName OUT;
    DECLARE @TestResultId INT;
    DECLARE @PreExecTrancount INT;

    DECLARE @VerboseMsg NVARCHAR(MAX);
    DECLARE @Verbose BIT;
    SET @Verbose = ISNULL((SELECT CAST(Value AS BIT) FROM tSQLt.Private_GetConfiguration('Verbose')),0);
    
    TRUNCATE TABLE tSQLt.CaptureOutputLog;
    CREATE TABLE #ExpectException(ExpectException INT,ExpectedMessage NVARCHAR(MAX), ExpectedSeverity INT, ExpectedState INT, ExpectedMessagePattern NVARCHAR(MAX), ExpectedErrorNumber INT, FailMessage NVARCHAR(MAX));

    IF EXISTS (SELECT 1 FROM sys.extended_properties WHERE name = N'SetFakeViewOnTrigger')
    BEGIN
      RAISERROR('Test system is in an invalid state. SetFakeViewOff must be called if SetFakeViewOn was called. Call SetFakeViewOff after creating all test case procedures.', 16, 10) WITH NOWAIT;
      RETURN -1;
    END;

    SELECT @Cmd = 'EXEC ' + @TestName;
    
    SELECT @TestClassName = OBJECT_SCHEMA_NAME(OBJECT_ID(@TestName)), --tSQLt.Private_GetCleanSchemaName('', @TestName),
           @TestProcName = tSQLt.Private_GetCleanObjectName(@TestName);
           
    INSERT INTO tSQLt.TestResult(Class, TestCase, TranName, Result) 
        SELECT @TestClassName, @TestProcName, @TranName, 'A severe error happened during test execution. Test did not finish.'
        OPTION(MAXDOP 1);
    SELECT @TestResultId = SCOPE_IDENTITY();

    IF(@Verbose = 1)
    BEGIN
      SET @VerboseMsg = 'tSQLt.Run '''+@TestName+'''; --Starting';
      EXEC tSQLt.Private_Print @Message =@VerboseMsg, @Severity = 0;
    END;

    BEGIN TRAN;
    SAVE TRAN @TranName;

    SET @PreExecTrancount = @@TRANCOUNT;
    
    TRUNCATE TABLE tSQLt.TestMessage;

    DECLARE @TmpMsg NVARCHAR(MAX);
    DECLARE @TestEndTime DATETIME; SET @TestEndTime = NULL;
    BEGIN TRY
        IF (@SetUp IS NOT NULL) EXEC @SetUp;
        EXEC (@Cmd);
        SET @TestEndTime = GETDATE();
        IF(EXISTS(SELECT 1 FROM #ExpectException WHERE ExpectException = 1))
        BEGIN
          SET @TmpMsg = COALESCE((SELECT FailMessage FROM #ExpectException)+' ','')+'Expected an error to be raised.';
          EXEC tSQLt.Fail @TmpMsg;
        END
    END TRY
    BEGIN CATCH
        SET @TestEndTime = ISNULL(@TestEndTime,GETDATE());
        IF ERROR_MESSAGE() LIKE '%tSQLt.Failure%'
        BEGIN
            SELECT @Msg = Msg FROM tSQLt.TestMessage;
            SET @Result = 'Failure';
        END
        ELSE
        BEGIN
          DECLARE @ErrorInfo NVARCHAR(MAX);
          SELECT @ErrorInfo = 
            COALESCE(ERROR_MESSAGE(), '<ERROR_MESSAGE() is NULL>') + 
            '[' +COALESCE(LTRIM(STR(ERROR_SEVERITY())), '<ERROR_SEVERITY() is NULL>') + ','+COALESCE(LTRIM(STR(ERROR_STATE())), '<ERROR_STATE() is NULL>') + ']' +
            '{' + COALESCE(ERROR_PROCEDURE(), '<ERROR_PROCEDURE() is NULL>') + ',' + COALESCE(CAST(ERROR_LINE() AS NVARCHAR), '<ERROR_LINE() is NULL>') + '}';

          IF(EXISTS(SELECT 1 FROM #ExpectException))
          BEGIN
            DECLARE @ExpectException INT;
            DECLARE @ExpectedMessage NVARCHAR(MAX);
            DECLARE @ExpectedMessagePattern NVARCHAR(MAX);
            DECLARE @ExpectedSeverity INT;
            DECLARE @ExpectedState INT;
            DECLARE @ExpectedErrorNumber INT;
            DECLARE @FailMessage NVARCHAR(MAX);
            SELECT @ExpectException = ExpectException,
                   @ExpectedMessage = ExpectedMessage, 
                   @ExpectedSeverity = ExpectedSeverity,
                   @ExpectedState = ExpectedState,
                   @ExpectedMessagePattern = ExpectedMessagePattern,
                   @ExpectedErrorNumber = ExpectedErrorNumber,
                   @FailMessage = FailMessage
              FROM #ExpectException;

            IF(@ExpectException = 1)
            BEGIN
              SET @Result = 'Success';
              SET @TmpMsg = COALESCE(@FailMessage+' ','')+'Exception did not match expectation!';
              IF(ERROR_MESSAGE() <> @ExpectedMessage)
              BEGIN
                SET @TmpMsg = @TmpMsg +CHAR(13)+CHAR(10)+
                           'Expected Message: <'+@ExpectedMessage+'>'+CHAR(13)+CHAR(10)+
                           'Actual Message  : <'+ERROR_MESSAGE()+'>';
                SET @Result = 'Failure';
              END
              IF(ERROR_MESSAGE() NOT LIKE @ExpectedMessagePattern)
              BEGIN
                SET @TmpMsg = @TmpMsg +CHAR(13)+CHAR(10)+
                           'Expected Message to be like <'+@ExpectedMessagePattern+'>'+CHAR(13)+CHAR(10)+
                           'Actual Message            : <'+ERROR_MESSAGE()+'>';
                SET @Result = 'Failure';
              END
              IF(ERROR_NUMBER() <> @ExpectedErrorNumber)
              BEGIN
                SET @TmpMsg = @TmpMsg +CHAR(13)+CHAR(10)+
                           'Expected Error Number: '+CAST(@ExpectedErrorNumber AS NVARCHAR(MAX))+CHAR(13)+CHAR(10)+
                           'Actual Error Number  : '+CAST(ERROR_NUMBER() AS NVARCHAR(MAX));
                SET @Result = 'Failure';
              END
              IF(ERROR_SEVERITY() <> @ExpectedSeverity)
              BEGIN
                SET @TmpMsg = @TmpMsg +CHAR(13)+CHAR(10)+
                           'Expected Severity: '+CAST(@ExpectedSeverity AS NVARCHAR(MAX))+CHAR(13)+CHAR(10)+
                           'Actual Severity  : '+CAST(ERROR_SEVERITY() AS NVARCHAR(MAX));
                SET @Result = 'Failure';
              END
              IF(ERROR_STATE() <> @ExpectedState)
              BEGIN
                SET @TmpMsg = @TmpMsg +CHAR(13)+CHAR(10)+
                           'Expected State: '+CAST(@ExpectedState AS NVARCHAR(MAX))+CHAR(13)+CHAR(10)+
                           'Actual State  : '+CAST(ERROR_STATE() AS NVARCHAR(MAX));
                SET @Result = 'Failure';
              END
              IF(@Result = 'Failure')
              BEGIN
                SET @Msg = @TmpMsg;
              END
            END 
            ELSE
            BEGIN
                SET @Result = 'Failure';
                SET @Msg = 
                  COALESCE(@FailMessage+' ','')+
                  'Expected no error to be raised. Instead this error was encountered:'+
                  CHAR(13)+CHAR(10)+
                  @ErrorInfo;
            END
          END
          ELSE
          BEGIN
            SET @Result = 'Error';
            SET @Msg = @ErrorInfo;
          END  
        END;
    END CATCH

    BEGIN TRY
        ROLLBACK TRAN @TranName;
    END TRY
    BEGIN CATCH
        DECLARE @PostExecTrancount INT;
        SET @PostExecTrancount = @PreExecTrancount - @@TRANCOUNT;
        IF (@@TRANCOUNT > 0) ROLLBACK;
        BEGIN TRAN;
        IF(   @Result <> 'Success'
           OR @PostExecTrancount <> 0
          )
        BEGIN
          SELECT @Msg = COALESCE(@Msg, '<NULL>') + ' (There was also a ROLLBACK ERROR --> ' + COALESCE(ERROR_MESSAGE(), '<ERROR_MESSAGE() is NULL>') + '{' + COALESCE(ERROR_PROCEDURE(), '<ERROR_PROCEDURE() is NULL>') + ',' + COALESCE(CAST(ERROR_LINE() AS NVARCHAR), '<ERROR_LINE() is NULL>') + '})';
          SET @Result = 'Error';
        END
    END CATCH    

    If(@Result <> 'Success') 
    BEGIN
      SET @Msg2 = @TestName + ' failed: (' + @Result + ') ' + @Msg;
      EXEC tSQLt.Private_Print @Message = @Msg2, @Severity = 0;
    END

    IF EXISTS(SELECT 1 FROM tSQLt.TestResult WHERE Id = @TestResultId)
    BEGIN
        UPDATE tSQLt.TestResult SET
            Result = @Result,
            Msg = @Msg,
            TestEndTime = @TestEndTime
         WHERE Id = @TestResultId;
    END
    ELSE
    BEGIN
        INSERT tSQLt.TestResult(Class, TestCase, TranName, Result, Msg)
        SELECT @TestClassName, 
               @TestProcName,  
               '?', 
               'Error', 
               'TestResult entry is missing; Original outcome: ' + @Result + ', ' + @Msg;
    END    
      

    COMMIT;

    IF(@Verbose = 1)
    BEGIN
    SET @VerboseMsg = 'tSQLt.Run '''+@TestName+'''; --Finished';
      EXEC tSQLt.Private_Print @Message =@VerboseMsg, @Severity = 0;
    END;

END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_RunTestClass]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_RunTestClass]
  @TestClassName NVARCHAR(MAX)
AS
BEGIN
    DECLARE @TestCaseName NVARCHAR(MAX);
    DECLARE @TestClassId INT; SET @TestClassId = tSQLt.Private_GetSchemaId(@TestClassName);
    DECLARE @SetupProcName NVARCHAR(MAX);
    EXEC tSQLt.Private_GetSetupProcedureName @TestClassId, @SetupProcName OUTPUT;
    
    DECLARE testCases CURSOR LOCAL FAST_FORWARD 
        FOR
     SELECT tSQLt.Private_GetQuotedFullName(object_id)
       FROM sys.procedures
      WHERE schema_id = @TestClassId
        AND LOWER(name) LIKE 'test%';

    OPEN testCases;
    
    FETCH NEXT FROM testCases INTO @TestCaseName;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        EXEC tSQLt.Private_RunTest @TestCaseName, @SetupProcName;

        FETCH NEXT FROM testCases INTO @TestCaseName;
    END;

    CLOSE testCases;
    DEALLOCATE testCases;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_SaveTestNameForSession]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_SaveTestNameForSession] 
  @TestName NVARCHAR(MAX)
AS
BEGIN
  DELETE FROM tSQLt.Run_LastExecution
   WHERE SessionId = @@SPID;  

  INSERT INTO tSQLt.Run_LastExecution(TestName, SessionId, LoginTime)
  SELECT TestName = @TestName,
         session_id,
         login_time
    FROM sys.dm_exec_sessions
   WHERE session_id = @@SPID;
END
GO
/****** Object:  StoredProcedure [tSQLt].[Private_SetConfiguration]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_SetConfiguration]
  @Name NVARCHAR(100),
  @Value SQL_VARIANT
AS
BEGIN
  IF(EXISTS(SELECT 1 FROM tSQLt.Private_Configurations WITH(ROWLOCK,UPDLOCK) WHERE Name = @Name))
  BEGIN
    UPDATE tSQLt.Private_Configurations SET
           Value = @Value
     WHERE Name = @Name;
  END;
  ELSE
  BEGIN
     INSERT tSQLt.Private_Configurations(Name,Value)
     VALUES(@Name,@Value);
  END;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_SetFakeViewOff_SingleView]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_SetFakeViewOff_SingleView]
  @ViewName NVARCHAR(MAX)
AS
BEGIN
  DECLARE @Cmd NVARCHAR(MAX),
          @SchemaName NVARCHAR(MAX),
          @TriggerName NVARCHAR(MAX);
          
  SELECT @SchemaName = QUOTENAME(OBJECT_SCHEMA_NAME(ObjId)),
         @TriggerName = QUOTENAME(OBJECT_NAME(ObjId) + '_SetFakeViewOn')
    FROM (SELECT OBJECT_ID(@ViewName) AS ObjId) X;
  
  SET @Cmd = 'DROP TRIGGER %SCHEMA_NAME%.%TRIGGER_NAME%;';
      
  SET @Cmd = REPLACE(@Cmd, '%SCHEMA_NAME%', @SchemaName);
  SET @Cmd = REPLACE(@Cmd, '%TRIGGER_NAME%', @TriggerName);
  
  EXEC(@Cmd);
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_SetFakeViewOn_SingleView]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_SetFakeViewOn_SingleView]
  @ViewName NVARCHAR(MAX)
AS
BEGIN
  DECLARE @Cmd NVARCHAR(MAX),
          @SchemaName NVARCHAR(MAX),
          @TriggerName NVARCHAR(MAX);
          
  SELECT @SchemaName = OBJECT_SCHEMA_NAME(ObjId),
         @ViewName = OBJECT_NAME(ObjId),
         @TriggerName = OBJECT_NAME(ObjId) + '_SetFakeViewOn'
    FROM (SELECT OBJECT_ID(@ViewName) AS ObjId) X;

  SET @Cmd = 
     'CREATE TRIGGER $$SCHEMA_NAME$$.$$TRIGGER_NAME$$
      ON $$SCHEMA_NAME$$.$$VIEW_NAME$$ INSTEAD OF INSERT AS
      BEGIN
         RAISERROR(''Test system is in an invalid state. SetFakeViewOff must be called if SetFakeViewOn was called. Call SetFakeViewOff after creating all test case procedures.'', 16, 10) WITH NOWAIT;
         RETURN;
      END;
     ';
      
  SET @Cmd = REPLACE(@Cmd, '$$SCHEMA_NAME$$', QUOTENAME(@SchemaName));
  SET @Cmd = REPLACE(@Cmd, '$$VIEW_NAME$$', QUOTENAME(@ViewName));
  SET @Cmd = REPLACE(@Cmd, '$$TRIGGER_NAME$$', QUOTENAME(@TriggerName));
  EXEC(@Cmd);

  EXEC sp_addextendedproperty @name = N'SetFakeViewOnTrigger', 
                               @value = 1,
                               @level0type = 'SCHEMA',
                               @level0name = @SchemaName, 
                               @level1type = 'VIEW',
                               @level1name = @ViewName,
                               @level2type = 'TRIGGER',
                               @level2name = @TriggerName;

  RETURN 0;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_ValidateFakeTableParameters]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_ValidateFakeTableParameters]
  @SchemaName NVARCHAR(MAX),
  @OrigTableName NVARCHAR(MAX),
  @OrigSchemaName NVARCHAR(MAX)
AS
BEGIN
   IF @SchemaName IS NULL
   BEGIN
        DECLARE @FullName NVARCHAR(MAX); SET @FullName = @OrigTableName + COALESCE('.' + @OrigSchemaName, '');
        
        RAISERROR ('FakeTable could not resolve the object name, ''%s''. (When calling tSQLt.FakeTable, avoid the use of the @SchemaName parameter, as it is deprecated.)', 
                   16, 10, @FullName);
   END;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_ValidateObjectsCompatibleWithFakeFunction]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_ValidateObjectsCompatibleWithFakeFunction]
  @FunctionName NVARCHAR(MAX),
  @FakeFunctionName NVARCHAR(MAX),
  @FunctionObjectId INT OUTPUT,
  @FakeFunctionObjectId INT OUTPUT,
  @IsScalarFunction BIT OUTPUT
AS
BEGIN
  SET @FunctionObjectId = OBJECT_ID(@FunctionName);
  SET @FakeFunctionObjectId = OBJECT_ID(@FakeFunctionName);

  IF(@FunctionObjectId IS NULL)
  BEGIN
    RAISERROR('%s does not exist!',16,10,@FunctionName);
  END;
  IF(@FakeFunctionObjectId IS NULL)
  BEGIN
    RAISERROR('%s does not exist!',16,10,@FakeFunctionName);
  END;
  
  DECLARE @FunctionType CHAR(2);
  DECLARE @FakeFunctionType CHAR(2);
  SELECT @FunctionType = type FROM sys.objects WHERE object_id = @FunctionObjectId;
  SELECT @FakeFunctionType = type FROM sys.objects WHERE object_id = @FakeFunctionObjectId;

  IF((@FunctionType IN('FN','FS') AND @FakeFunctionType NOT IN('FN','FS'))
     OR
     (@FunctionType IN('TF','IF','FT') AND @FakeFunctionType NOT IN('TF','IF','FT'))
     OR
     (@FunctionType NOT IN('FN','FS','TF','IF','FT'))
     )    
  BEGIN
    RAISERROR('Both parameters must contain the name of either scalar or table valued functions!',16,10);
  END;
  
  SET @IsScalarFunction = CASE WHEN @FunctionType IN('FN','FS') THEN 1 ELSE 0 END;
  
  IF(EXISTS(SELECT 1 
              FROM sys.parameters AS P
             WHERE P.object_id IN(@FunctionObjectId,@FakeFunctionObjectId)
             GROUP BY P.name, P.max_length, P.precision, P.scale, P.parameter_id
            HAVING COUNT(1) <> 2
           ))
  BEGIN
    RAISERROR('Parameters of both functions must match! (This includes the return type for scalar functions.)',16,10);
  END; 
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_ValidateProcedureCanBeUsedWithSpyProcedure]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_ValidateProcedureCanBeUsedWithSpyProcedure]
    @ProcedureName NVARCHAR(MAX)
AS
BEGIN
    IF NOT EXISTS(SELECT 1 FROM sys.procedures WHERE object_id = OBJECT_ID(@ProcedureName))
    BEGIN
      RAISERROR('Cannot use SpyProcedure on %s because the procedure does not exist', 16, 10, @ProcedureName) WITH NOWAIT;
    END;
    
    IF (1020 < (SELECT COUNT(*) FROM sys.parameters WHERE object_id = OBJECT_ID(@ProcedureName)))
    BEGIN
      RAISERROR('Cannot use SpyProcedure on procedure %s because it contains more than 1020 parameters', 16, 10, @ProcedureName) WITH NOWAIT;
    END;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Private_ValidateThatAllDataTypesInTableAreSupported]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Private_ValidateThatAllDataTypesInTableAreSupported]
 @ResultTable NVARCHAR(MAX),
 @ColumnList NVARCHAR(MAX)
AS
BEGIN
    BEGIN TRY
      EXEC('DECLARE @EatResult INT; SELECT @EatResult = COUNT(1) FROM ' + @ResultTable + ' GROUP BY ' + @ColumnList + ';');
    END TRY
    BEGIN CATCH
      RAISERROR('The table contains a datatype that is not supported for tSQLt.AssertEqualsTable. Please refer to http://tsqlt.org/user-guide/assertions/assertequalstable/ for a list of unsupported datatypes.',16,10);
    END CATCH
END;
GO
/****** Object:  StoredProcedure [tSQLt].[RemoveExternalAccessKey]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[RemoveExternalAccessKey]
AS
BEGIN
  IF(NOT EXISTS(SELECT * FROM sys.fn_my_permissions(NULL,'server') AS FMP WHERE FMP.permission_name = 'CONTROL SERVER'))
  BEGIN
    RAISERROR('Only principals with CONTROL SERVER permission can execute this procedure.',16,10);
    RETURN -1;
  END;

  DECLARE @master_sys_sp_executesql NVARCHAR(MAX); SET @master_sys_sp_executesql = 'master.sys.sp_executesql';

  IF SUSER_ID('tSQLtExternalAccessKey') IS NOT NULL DROP LOGIN tSQLtExternalAccessKey;
  EXEC @master_sys_sp_executesql N'IF ASYMKEY_ID(''tSQLtExternalAccessKey'') IS NOT NULL DROP ASYMMETRIC KEY tSQLtExternalAccessKey;';
  EXEC @master_sys_sp_executesql N'IF EXISTS(SELECT * FROM sys.assemblies WHERE name = ''tSQLtExternalAccessKey'') DROP ASSEMBLY tSQLtExternalAccessKey;';
END;
GO
/****** Object:  StoredProcedure [tSQLt].[RemoveObject]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[RemoveObject] 
    @ObjectName NVARCHAR(MAX),
    @NewName NVARCHAR(MAX) = NULL OUTPUT,
    @IfExists INT = 0
AS
BEGIN
  DECLARE @ObjectId INT;
  SELECT @ObjectId = OBJECT_ID(@ObjectName);
  
  IF(@ObjectId IS NULL)
  BEGIN
    IF(@IfExists = 1) RETURN;
    RAISERROR('%s does not exist!',16,10,@ObjectName);
  END;

  EXEC tSQLt.Private_RenameObjectToUniqueNameUsingObjectId @ObjectId, @NewName = @NewName OUTPUT;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[RemoveObjectIfExists]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[RemoveObjectIfExists] 
    @ObjectName NVARCHAR(MAX),
    @NewName NVARCHAR(MAX) = NULL OUTPUT
AS
BEGIN
  EXEC tSQLt.RemoveObject @ObjectName = @ObjectName, @NewName = @NewName OUT, @IfExists = 1;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[RenameClass]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[RenameClass]
   @SchemaName NVARCHAR(MAX),
   @NewSchemaName NVARCHAR(MAX)
AS
BEGIN
  DECLARE @MigrateObjectsCommand NVARCHAR(MAX);

  SELECT @NewSchemaName = PARSENAME(@NewSchemaName, 1),
         @SchemaName = PARSENAME(@SchemaName, 1);

  EXEC tSQLt.NewTestClass @NewSchemaName;

  SELECT @MigrateObjectsCommand = (
    SELECT Cmd AS [text()] FROM (
    SELECT 'ALTER SCHEMA ' + QUOTENAME(@NewSchemaName) + ' TRANSFER ' + QUOTENAME(@SchemaName) + '.' + QUOTENAME(name) + ';' AS Cmd
      FROM sys.objects
     WHERE schema_id = SCHEMA_ID(@SchemaName)
       AND type NOT IN ('PK', 'F')
    UNION ALL 
    SELECT 'ALTER SCHEMA ' + QUOTENAME(@NewSchemaName) + ' TRANSFER XML SCHEMA COLLECTION::' + QUOTENAME(@SchemaName) + '.' + QUOTENAME(name) + ';' AS Cmd
      FROM sys.xml_schema_collections
     WHERE schema_id = SCHEMA_ID(@SchemaName)
    UNION ALL 
    SELECT 'ALTER SCHEMA ' + QUOTENAME(@NewSchemaName) + ' TRANSFER TYPE::' + QUOTENAME(@SchemaName) + '.' + QUOTENAME(name) + ';' AS Cmd
      FROM sys.types
     WHERE schema_id = SCHEMA_ID(@SchemaName)
    ) AS Cmds
       FOR XML PATH(''), TYPE).value('.', 'NVARCHAR(MAX)');

  EXEC (@MigrateObjectsCommand);

  EXEC tSQLt.DropClass @SchemaName;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Reset]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Reset]
AS
BEGIN
  EXEC tSQLt.Private_ResetNewTestClassList;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[ResultSetFilter]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [tSQLt].[ResultSetFilter]
	@ResultsetNo [int],
	@Command [nvarchar](max)
WITH EXECUTE AS CALLER
AS
EXTERNAL NAME [tSQLtCLR].[tSQLtCLR.StoredProcedures].[ResultSetFilter]
GO
/****** Object:  StoredProcedure [tSQLt].[Run]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Run]
   @TestName NVARCHAR(MAX) = NULL,
   @TestResultFormatter NVARCHAR(MAX) = NULL
AS
BEGIN
  EXEC tSQLt.Private_RunMethodHandler @RunMethod = 'tSQLt.Private_Run', @TestResultFormatter = @TestResultFormatter, @TestName = @TestName; 
END;
GO
/****** Object:  StoredProcedure [tSQLt].[RunAll]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[RunAll]
AS
BEGIN
  EXEC tSQLt.Private_RunMethodHandler @RunMethod = 'tSQLt.Private_RunAll';
END;
GO
/****** Object:  StoredProcedure [tSQLt].[RunC]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[RunC]
AS
BEGIN
  DECLARE @TestName NVARCHAR(MAX);SET @TestName = NULL;
  DECLARE @InputBuffer NVARCHAR(MAX);
  EXEC tSQLt.Private_InputBuffer @InputBuffer = @InputBuffer OUT;
  IF(@InputBuffer LIKE 'EXEC tSQLt.RunC;--%')
  BEGIN
    SET @TestName = LTRIM(RTRIM(STUFF(@InputBuffer,1,18,'')));
  END;
  EXEC tSQLt.Run @TestName = @TestName;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[RunNew]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[RunNew]
AS
BEGIN
  EXEC tSQLt.Private_RunMethodHandler @RunMethod = 'tSQLt.Private_RunNew';
END;
GO
/****** Object:  StoredProcedure [tSQLt].[RunTest]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[RunTest]
   @TestName NVARCHAR(MAX)
AS
BEGIN
  RAISERROR('tSQLt.RunTest has been retired. Please use tSQLt.Run instead.', 16, 10);
END;
GO
/****** Object:  StoredProcedure [tSQLt].[RunTestClass]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[RunTestClass]
   @TestClassName NVARCHAR(MAX)
AS
BEGIN
    EXEC tSQLt.Run @TestClassName;
END
GO
/****** Object:  StoredProcedure [tSQLt].[RunWithNullResults]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[RunWithNullResults]
    @TestName NVARCHAR(MAX) = NULL
AS
BEGIN
  EXEC tSQLt.Run @TestName = @TestName, @TestResultFormatter = 'tSQLt.NullTestResultFormatter';
END;
GO
/****** Object:  StoredProcedure [tSQLt].[RunWithXmlResults]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[RunWithXmlResults]
   @TestName NVARCHAR(MAX) = NULL
AS
BEGIN
  EXEC tSQLt.Run @TestName = @TestName, @TestResultFormatter = 'tSQLt.XmlResultFormatter';
END;
GO
/****** Object:  StoredProcedure [tSQLt].[SetFakeViewOff]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[SetFakeViewOff]
  @SchemaName NVARCHAR(MAX)
AS
BEGIN
  DECLARE @ViewName NVARCHAR(MAX);
    
  DECLARE viewNames CURSOR LOCAL FAST_FORWARD FOR
   SELECT QUOTENAME(OBJECT_SCHEMA_NAME(t.parent_id)) + '.' + QUOTENAME(OBJECT_NAME(t.parent_id)) AS viewName
     FROM sys.extended_properties ep
     JOIN sys.triggers t
       on ep.major_id = t.object_id
     WHERE ep.name = N'SetFakeViewOnTrigger'  
  OPEN viewNames;
  
  FETCH NEXT FROM viewNames INTO @ViewName;
  WHILE @@FETCH_STATUS = 0
  BEGIN
    EXEC tSQLt.Private_SetFakeViewOff_SingleView @ViewName;
    
    FETCH NEXT FROM viewNames INTO @ViewName;
  END;
  
  CLOSE viewNames;
  DEALLOCATE viewNames;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[SetFakeViewOn]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[SetFakeViewOn]
  @SchemaName NVARCHAR(MAX)
AS
BEGIN
  DECLARE @ViewName NVARCHAR(MAX);
    
  DECLARE viewNames CURSOR LOCAL FAST_FORWARD FOR
  SELECT QUOTENAME(OBJECT_SCHEMA_NAME(object_id)) + '.' + QUOTENAME([name]) AS viewName
    FROM sys.views
   WHERE schema_id = SCHEMA_ID(@SchemaName);
  
  OPEN viewNames;
  
  FETCH NEXT FROM viewNames INTO @ViewName;
  WHILE @@FETCH_STATUS = 0
  BEGIN
    EXEC tSQLt.Private_SetFakeViewOn_SingleView @ViewName;
    
    FETCH NEXT FROM viewNames INTO @ViewName;
  END;
  
  CLOSE viewNames;
  DEALLOCATE viewNames;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[SetTestResultFormatter]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[SetTestResultFormatter]
    @Formatter NVARCHAR(4000)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM sys.extended_properties WHERE [name] = N'tSQLt.ResultsFormatter')
    BEGIN
        EXEC sp_dropextendedproperty @name = N'tSQLt.ResultsFormatter',
                                    @level0type = 'SCHEMA',
                                    @level0name = 'tSQLt',
                                    @level1type = 'PROCEDURE',
                                    @level1name = 'Private_OutputTestResults';
    END;

    EXEC sp_addextendedproperty @name = N'tSQLt.ResultsFormatter', 
                                @value = @Formatter,
                                @level0type = 'SCHEMA',
                                @level0name = 'tSQLt',
                                @level1type = 'PROCEDURE',
                                @level1name = 'Private_OutputTestResults';
END;
GO
/****** Object:  StoredProcedure [tSQLt].[SetVerbose]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[SetVerbose]
  @Verbose BIT = 1
AS
BEGIN
  EXEC tSQLt.Private_SetConfiguration @Name = 'Verbose', @Value = @Verbose;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[SpyProcedure]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[SpyProcedure]
    @ProcedureName NVARCHAR(MAX),
    @CommandToExecute NVARCHAR(MAX) = NULL
AS
BEGIN
    DECLARE @ProcedureObjectId INT;
    SELECT @ProcedureObjectId = OBJECT_ID(@ProcedureName);

    EXEC tSQLt.Private_ValidateProcedureCanBeUsedWithSpyProcedure @ProcedureName;

    DECLARE @LogTableName NVARCHAR(MAX);
    SELECT @LogTableName = QUOTENAME(OBJECT_SCHEMA_NAME(@ProcedureObjectId)) + '.' + QUOTENAME(OBJECT_NAME(@ProcedureObjectId)+'_SpyProcedureLog');

    EXEC tSQLt.Private_RenameObjectToUniqueNameUsingObjectId @ProcedureObjectId;

    EXEC tSQLt.Private_CreateProcedureSpy @ProcedureObjectId, @ProcedureName, @LogTableName, @CommandToExecute;

    RETURN 0;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[StubRecord]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[StubRecord](@SnTableName AS NVARCHAR(MAX), @BintObjId AS BIGINT)  
AS   
BEGIN  

    RAISERROR('Warning, tSQLt.StubRecord is not currently supported. Use at your own risk!', 0, 1) WITH NOWAIT;

    DECLARE @VcInsertStmt NVARCHAR(MAX),  
            @VcInsertValues NVARCHAR(MAX);  
    DECLARE @SnColumnName NVARCHAR(MAX); 
    DECLARE @SintDataType SMALLINT; 
    DECLARE @NvcFKCmd NVARCHAR(MAX);  
    DECLARE @VcFKVal NVARCHAR(MAX); 
  
    SET @VcInsertStmt = 'INSERT INTO ' + @SnTableName + ' ('  
      
    DECLARE curColumns CURSOR  
        LOCAL FAST_FORWARD  
    FOR  
    SELECT syscolumns.name,  
           syscolumns.xtype,  
           cmd.cmd  
    FROM syscolumns  
        LEFT OUTER JOIN dbo.sysconstraints ON syscolumns.id = sysconstraints.id  
                                      AND syscolumns.colid = sysconstraints.colid  
                                      AND sysconstraints.status = 1    -- Primary key constraints only  
        LEFT OUTER JOIN (select fkeyid id,fkey colid,N'select @V=cast(min('+syscolumns.name+') as NVARCHAR) from '+sysobjects.name cmd  
                        from sysforeignkeys   
                        join sysobjects on sysobjects.id=sysforeignkeys.rkeyid  
                        join syscolumns on sysobjects.id=syscolumns.id and syscolumns.colid=rkey) cmd  
            on cmd.id=syscolumns.id and cmd.colid=syscolumns.colid  
    WHERE syscolumns.id = OBJECT_ID(@SnTableName)  
      AND (syscolumns.isnullable = 0 )  
    ORDER BY ISNULL(sysconstraints.status, 9999), -- Order Primary Key constraints first  
             syscolumns.colorder  
  
    OPEN curColumns  
  
    FETCH NEXT FROM curColumns  
    INTO @SnColumnName, @SintDataType, @NvcFKCmd  
  
    -- Treat the first column retrieved differently, no commas need to be added  
    -- and it is the ObjId column  
    IF @@FETCH_STATUS = 0  
    BEGIN  
        SET @VcInsertStmt = @VcInsertStmt + @SnColumnName  
        SELECT @VcInsertValues = ')VALUES(' + ISNULL(CAST(@BintObjId AS nvarchar), 'NULL')  
  
        FETCH NEXT FROM curColumns  
        INTO @SnColumnName, @SintDataType, @NvcFKCmd  
    END  
    ELSE  
    BEGIN  
        -- No columns retrieved, we need to insert into any first column  
        SELECT @VcInsertStmt = @VcInsertStmt + syscolumns.name  
        FROM syscolumns  
        WHERE syscolumns.id = OBJECT_ID(@SnTableName)  
          AND syscolumns.colorder = 1  
  
        SELECT @VcInsertValues = ')VALUES(' + ISNULL(CAST(@BintObjId AS nvarchar), 'NULL')  
  
    END  
  
    WHILE @@FETCH_STATUS = 0  
    BEGIN  
        SET @VcInsertStmt = @VcInsertStmt + ',' + @SnColumnName  
        SET @VcFKVal=',0'  
        if @NvcFKCmd is not null  
        BEGIN  
            set @VcFKVal=null  
            exec sp_executesql @NvcFKCmd,N'@V NVARCHAR(MAX) output',@VcFKVal output  
            set @VcFKVal=isnull(','''+@VcFKVal+'''',',NULL')  
        END  
        SET @VcInsertValues = @VcInsertValues + @VcFKVal  
  
        FETCH NEXT FROM curColumns  
        INTO @SnColumnName, @SintDataType, @NvcFKCmd  
    END  
      
    CLOSE curColumns  
    DEALLOCATE curColumns  
  
    SET @VcInsertStmt = @VcInsertStmt + @VcInsertValues + ')'  
  
    IF EXISTS (SELECT 1   
               FROM syscolumns  
               WHERE status = 128   
                 AND id = OBJECT_ID(@SnTableName))  
    BEGIN  
        SET @VcInsertStmt = 'SET IDENTITY_INSERT ' + @SnTableName + ' ON ' + CHAR(10) +   
                             @VcInsertStmt + CHAR(10) +   
                             'SET IDENTITY_INSERT ' + @SnTableName + ' OFF '  
    END  
  
    EXEC (@VcInsertStmt)    -- Execute the actual INSERT statement  
  
END
GO
/****** Object:  StoredProcedure [tSQLt].[SuppressOutput]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [tSQLt].[SuppressOutput]
	@command [nvarchar](max)
WITH EXECUTE AS CALLER
AS
EXTERNAL NAME [tSQLtCLR].[tSQLtCLR.StoredProcedures].[SuppressOutput]
GO
/****** Object:  StoredProcedure [tSQLt].[TableToText]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[TableToText]
    @txt NVARCHAR(MAX) OUTPUT,
    @TableName NVARCHAR(MAX),
    @OrderBy NVARCHAR(MAX) = NULL,
    @PrintOnlyColumnNameAliasList NVARCHAR(MAX) = NULL
AS
BEGIN
    SET @txt = tSQLt.Private::TableToString(@TableName, @OrderBy, @PrintOnlyColumnNameAliasList);
END;
GO
/****** Object:  StoredProcedure [tSQLt].[Uninstall]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[Uninstall]
AS
BEGIN
  DROP TYPE tSQLt.Private;

  EXEC tSQLt.DropClass 'tSQLt';  
  
  DROP ASSEMBLY tSQLtCLR;
END;
GO
/****** Object:  StoredProcedure [tSQLt].[XmlResultFormatter]    Script Date: 4/11/2024 9:06:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [tSQLt].[XmlResultFormatter]
AS
BEGIN
    DECLARE @XmlOutput XML;

    SELECT @XmlOutput = (
      SELECT *--Tag, Parent, [testsuites!1!hide!hide], [testsuite!2!name], [testsuite!2!tests], [testsuite!2!errors], [testsuite!2!failures], [testsuite!2!timestamp], [testsuite!2!time], [testcase!3!classname], [testcase!3!name], [testcase!3!time], [failure!4!message]  
        FROM (
          SELECT 1 AS Tag,
                 NULL AS Parent,
                 'root' AS [testsuites!1!hide!hide],
                 NULL AS [testsuite!2!id],
                 NULL AS [testsuite!2!name],
                 NULL AS [testsuite!2!tests],
                 NULL AS [testsuite!2!errors],
                 NULL AS [testsuite!2!failures],
                 NULL AS [testsuite!2!timestamp],
                 NULL AS [testsuite!2!time],
                 NULL AS [testsuite!2!hostname],
                 NULL AS [testsuite!2!package],
                 NULL AS [properties!3!hide!hide],
                 NULL AS [testcase!4!classname],
                 NULL AS [testcase!4!name],
                 NULL AS [testcase!4!time],
                 NULL AS [failure!5!message],
                 NULL AS [failure!5!type],
                 NULL AS [error!6!message],
                 NULL AS [error!6!type],
                 NULL AS [system-out!7!hide],
                 NULL AS [system-err!8!hide]
          UNION ALL
          SELECT 2 AS Tag, 
                 1 AS Parent,
                 'root',
                 ROW_NUMBER()OVER(ORDER BY Class),
                 Class,
                 COUNT(1),
                 SUM(CASE Result WHEN 'Error' THEN 1 ELSE 0 END),
                 SUM(CASE Result WHEN 'Failure' THEN 1 ELSE 0 END),
                 CONVERT(VARCHAR(19),MIN(TestResult.TestStartTime),126),
                 CAST(CAST(DATEDIFF(MILLISECOND,MIN(TestResult.TestStartTime),MAX(TestResult.TestEndTime))/1000.0 AS NUMERIC(20,3))AS VARCHAR(MAX)),
                 CAST(SERVERPROPERTY('ServerName') AS NVARCHAR(MAX)),
                 'tSQLt',
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL
            FROM tSQLt.TestResult
          GROUP BY Class
          UNION ALL
          SELECT 3 AS Tag,
                 2 AS Parent,
                 'root',
                 NULL,
                 Class,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 Class,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL
            FROM tSQLt.TestResult
           GROUP BY Class
          UNION ALL
          SELECT 4 AS Tag,
                 2 AS Parent,
                 'root',
                 NULL,
                 Class,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 Class,
                 TestCase,
                 CAST(CAST(DATEDIFF(MILLISECOND,TestResult.TestStartTime,TestResult.TestEndTime)/1000.0 AS NUMERIC(20,3))AS VARCHAR(MAX)),
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL
            FROM tSQLt.TestResult
          UNION ALL
          SELECT 5 AS Tag,
                 4 AS Parent,
                 'root',
                 NULL,
                 Class,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 Class,
                 TestCase,
                 CAST(CAST(DATEDIFF(MILLISECOND,TestResult.TestStartTime,TestResult.TestEndTime)/1000.0 AS NUMERIC(20,3))AS VARCHAR(MAX)),
                 Msg,
                 'tSQLt.Fail',
                 NULL,
                 NULL,
                 NULL,
                 NULL
            FROM tSQLt.TestResult
           WHERE Result IN ('Failure')
          UNION ALL
          SELECT 6 AS Tag,
                 4 AS Parent,
                 'root',
                 NULL,
                 Class,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 Class,
                 TestCase,
                 CAST(CAST(DATEDIFF(MILLISECOND,TestResult.TestStartTime,TestResult.TestEndTime)/1000.0 AS NUMERIC(20,3))AS VARCHAR(MAX)),
                 NULL,
                 NULL,
                 Msg,
                 'SQL Error',
                 NULL,
                 NULL
            FROM tSQLt.TestResult
           WHERE Result IN ( 'Error')
          UNION ALL
          SELECT 7 AS Tag,
                 2 AS Parent,
                 'root',
                 NULL,
                 Class,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 Class,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL
            FROM tSQLt.TestResult
           GROUP BY Class
          UNION ALL
          SELECT 8 AS Tag,
                 2 AS Parent,
                 'root',
                 NULL,
                 Class,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 Class,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL
            FROM tSQLt.TestResult
           GROUP BY Class
        ) AS X
       ORDER BY [testsuite!2!name],CASE WHEN Tag IN (7,8) THEN 1 ELSE 0 END, [testcase!4!name], Tag
       FOR XML EXPLICIT
       );

    EXEC tSQLt.Private_PrintXML @XmlOutput;
END;
GO
