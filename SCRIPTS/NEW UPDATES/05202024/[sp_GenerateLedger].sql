SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
--EXEC [sp_GenerateLedger] 
CREATE OR ALTER PROCEDURE [dbo].[sp_GenerateLedger]
    @FromDate          VARCHAR(10)    = NULL,
    @EndDate           VARCHAR(10)    = NULL,
    @LedgAmount        DECIMAL(18, 2) = NULL,
    @Rental            DECIMAL(18, 2) = NULL,
    @SecAndMaintenance DECIMAL(18, 2) = NULL,
    @ComputationID     INT            = NULL,
    @ClientID          VARCHAR(30)    = NULL,
    @EncodedBy         INT            = NULL,
    @ComputerName      VARCHAR(30)    = NULL,
    @UnitId            INT            = NULL,
    @IsRenewal         BIGINT         = 0
AS
    BEGIN

        SET NOCOUNT ON;
        DECLARE @Message_Code VARCHAR(MAX) = '';
        DECLARE @ErrorMessage NVARCHAR(MAX) = N'';
       
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


        SELECT
                @ProjectType                  = [tblProjectMstr].[ProjectType],
                @Unit_IsParking               = [tblUnitMstr].[IsParking],
                @Unit_IsNonVat                = [tblUnitMstr].[IsNonVat],
                @Unit_AreaSqm                 = [tblUnitMstr].[AreaSqm],
                @Unit_AreaRateSqm             = [tblUnitMstr].[AreaRateSqm],
                @Unit_AreaTotalAmount         = [tblUnitMstr].[AreaTotalAmount],
                @Unit_BaseRentalVatAmount     = [tblUnitMstr].[BaseRentalVatAmount],
                @Unit_BaseRentalWithVatAmount = [tblUnitMstr].[BaseRentalWithVatAmount],
                @Unit_BaseRentalTax           = [tblUnitMstr].[BaseRentalTax],
                @Unit_TotalRental             = [tblUnitMstr].[TotalRental],
                @Unit_SecAndMainAmount        = [tblUnitMstr].[SecAndMainAmount],
                @Unit_SecAndMainVatAmount     = [tblUnitMstr].[SecAndMainVatAmount],
                @Unit_SecAndMainWithVatAmount = [tblUnitMstr].[SecAndMainWithVatAmount],
                @Unit_Vat                     = [tblUnitMstr].[Vat],
                @Unit_Tax                     = [tblUnitMstr].[Tax],
                @Unit_TaxAmount               = [tblUnitMstr].[TaxAmount]
        FROM
                [dbo].[tblUnitMstr] WITH (NOLOCK)
            INNER JOIN
                [dbo].[tblProjectMstr] WITH (NOLOCK)
                    ON [tblUnitMstr].[ProjectId] = [tblProjectMstr].[RecId]
        WHERE
                [tblUnitMstr].[RecId] = @UnitId;

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
                        [MonthsCTE];



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
                    SELECT
                        [#GeneratedMonths].[Month],
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
                    FROM
                        [#GeneratedMonths]
                    UNION
                    SELECT
                        [#GeneratedMonths].[Month],
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
                    FROM
                        [#GeneratedMonths]
                    WHERE
                        @SecAndMaintenance IS NOT NULL



        IF (@@ROWCOUNT > 0)
            BEGIN
                UPDATE
                    [dbo].[tblUnitReference]
                SET
                    [tblUnitReference].[ClientID] = @ClientID,
                    [tblUnitReference].[LastCHangedBy] = @EncodedBy,
                    [tblUnitReference].[LastChangedDate] = GETDATE(),
                    [tblUnitReference].[ComputerName] = @ComputerName
                WHERE
                    [tblUnitReference].[RecId] = @ComputationID;
                SET @Message_Code = 'SUCCESS'
            END;


        SET @ErrorMessage = ERROR_MESSAGE()
        IF @ErrorMessage <> ''
            BEGIN

                INSERT INTO [dbo].[ErrorLog]
                    (
                        [ProcedureName],
                        [ErrorMessage],
                        [LogDateTime]
                    )
                VALUES
                    (
                        'sp_GenerateLedger', @ErrorMessage, GETDATE()
                    );
            END
        SELECT
            @ErrorMessage AS [ErrorMessage],
            @Message_Code AS [Message_Code];
        DROP TABLE [#GeneratedMonths];
    END






GO

