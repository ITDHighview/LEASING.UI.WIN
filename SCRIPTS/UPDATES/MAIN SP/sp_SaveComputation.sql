USE [LEASINGDB];
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveComputation]    Script Date: 11/9/2023 10:03:39 PM ******/
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
ALTER PROCEDURE [dbo].[sp_SaveComputation]
    @ProjectId            INT,
    @InquiringClient      VARCHAR(500),
    @ClientMobile         VARCHAR(50),
    @UnitId               INT,
    @UnitNo               VARCHAR(50),
    @StatDate             VARCHAR(10),
    @FinishDate           VARCHAR(10),
    @Rental               DECIMAL(18, 2) NULL,
    @SecAndMaintenance    DECIMAL(18, 2),
    @TotalRent            DECIMAL(18, 2),
    @SecDeposit           DECIMAL(18, 2),
    @Total                DECIMAL(18, 2),
    @EncodedBy            INT,
    @ComputerName         VARCHAR(30),
    @ClientID             VARCHAR(50),
    @XML                  XML,
    @AdvancePaymentAmount DECIMAL(18, 2),
	@IsFullPayment BIT = 0
AS
    BEGIN
        SET NOCOUNT ON;
        DECLARE @ComputationID AS INT = 0;
        DECLARE @ProjectType AS VARCHAR(20) = '';
        DECLARE @GenVat AS DECIMAL(18, 2) = 0;
        DECLARE @WithHoldingTax AS DECIMAL(18, 2) = 0;
        DECLARE @RefId AS VARCHAR(30) = '';

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
                            SELECT
                                [ParaValues].[data].[value]('c1[1]', 'VARCHAR(10)')
                            FROM
                                @XML.[nodes]('/Table1') AS [ParaValues]([data]);
            END;

        SELECT
                @ProjectType = [tblProjectMstr].[ProjectType]
        FROM
                [dbo].[tblUnitMstr] WITH (NOLOCK)
            INNER JOIN
                [dbo].[tblProjectMstr] WITH (NOLOCK)
                    ON [tblUnitMstr].[ProjectId] = [tblProjectMstr].[RecId]
        WHERE
                [tblUnitMstr].[RecId] = @UnitId;


        SELECT
            @GenVat         = [tblRatesSettings].[GenVat],
            @WithHoldingTax = [tblRatesSettings].[WithHoldingTax]
        FROM
            [dbo].[tblRatesSettings] WITH (NOLOCK)
        WHERE
            [tblRatesSettings].[ProjectType] = @ProjectType;


        UPDATE
            [dbo].[tblUnitMstr]
        SET
            [tblUnitMstr].[UnitStatus] = 'RESERVED'
        WHERE
            [tblUnitMstr].[RecId] = @UnitId;

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
                [AdvancePaymentAmount],
				IsFullPayment
            )
        VALUES
            (
                @ProjectId, @InquiringClient, @ClientMobile, @UnitId, @UnitNo, @StatDate, @FinishDate, GETDATE(),
                @Rental, @SecAndMaintenance, @TotalRent, @SecDeposit, @Total, @EncodedBy, GETDATE(), 1, @ComputerName,
                @ClientID, @GenVat, @WithHoldingTax, @AdvancePaymentAmount,@IsFullPayment
            );
        SET @ComputationID = SCOPE_IDENTITY();

        IF (@@ROWCOUNT > 0)
            BEGIN
                SELECT
                    @RefId = [tblUnitReference].[RefId]
                FROM
                    [dbo].[tblUnitReference]
                WHERE
                    [tblUnitReference].[RecId] = @ComputationID;
                INSERT INTO [dbo].[tblAdvancePayment]
                    (
                        [Months],
                        [RefId],
                        [Amount]
                    )
                            SELECT
                                CONVERT(DATE, [#tblAdvancePayment].[Months]),
                                @RefId,
                                @TotalRent
                            FROM
                                [#tblAdvancePayment];

                EXEC [dbo].[sp_GenerateLedger]
                    @FromDate = @StatDate,
                    @EndDate = @FinishDate,
                    @LedgAmount = @TotalRent,
                    @ComputationID = @ComputationID,
                    @ClientID = @ClientID,
                    @EncodedBy = @EncodedBy,
                    @ComputerName = @ComputerName;

                SET @Message_Code = 'SUCCESS';

            END;

        SELECT
            @Message_Code AS [Message_Code];
        DROP TABLE [#tblAdvancePayment];
    END;