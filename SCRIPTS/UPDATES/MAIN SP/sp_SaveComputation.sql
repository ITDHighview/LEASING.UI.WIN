USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveComputation]    Script Date: 11/9/2023 10:03:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_SaveComputation]
    @ProjectId int,
    @InquiringClient varchar(500),
    @ClientMobile varchar(50),
    @UnitId int,
    @UnitNo varchar(50),
    @StatDate VARCHAR(10),
    @FinishDate VARCHAR(10),
    @Rental decimal(18, 2) NULL,
    @SecAndMaintenance decimal(18, 2),
    @TotalRent decimal(18, 2),
    @SecDeposit decimal(18, 2),
    @Total decimal(18, 2),
    @EncodedBy int,
    @ComputerName varchar(30),
    @ClientID varchar(50),
    @XML XML,
	@AdvancePaymentAmount decimal(18, 2)
AS
BEGIN
    SET NOCOUNT ON;
    DECLARE @ComputationID AS INT = 0
    DECLARE @ProjectType AS VARCHAR(20) = ''
    DECLARE @GenVat AS DECIMAL(18, 2) = 0
    DECLARE @WithHoldingTax AS DECIMAL(18, 2) = 0
	DECLARE @RefId AS VARCHAR(30)=''

    DECLARE @Message_Code AS VARCHAR(MAX) = ''
    CREATE TABLE #tblAdvancePayment (Months VARCHAR(10))
    IF (@XML IS NOT NULL)
    BEGIN
        INSERT INTO #tblAdvancePayment
        (
            Months
        )
        SELECT data.value('c1[1]', 'VARCHAR(10)')
        FROM @XML.nodes('/Table1') AS ParaValues(data)
    END

    SELECT @ProjectType = tblProjectMstr.ProjectType
    from tblUnitMstr WITH (NOLOCK)
        INNER JOIN tblProjectMstr WITH (NOLOCK)
            ON tblUnitMstr.ProjectId = tblProjectMstr.RecId
    WHERE tblUnitMstr.RecId = @UnitId


    select @GenVat = GenVat,
           @WithHoldingTax = WithHoldingTax
    from tblRatesSettings WITH (NOLOCK)
    where ProjectType = @ProjectType


    update tblUnitMstr
    set UnitStatus = 'RESERVED'
    WHERE RecId = @UnitId

    -- Insert the record into tblClientMstr
    INSERT INTO tblUnitReference
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
		[AdvancePaymentAmount]
    )
    VALUES
    (@ProjectId,
     @InquiringClient,
     @ClientMobile,
     @UnitId,
     @UnitNo,
     @StatDate,
     @FinishDate,
     GETDATE(),
     @Rental,
     @SecAndMaintenance,
     @TotalRent,
     @SecDeposit,
     @Total,
     @EncodedBy,
     GETDATE(),
     1  ,
     @ComputerName,
     @ClientID,
     @GenVat,
     @WithHoldingTax,
	 @AdvancePaymentAmount
    )
    SET @ComputationID = SCOPE_IDENTITY();
	
    if (@@ROWCOUNT > 0)
    BEGIN
	SELECT @RefId = RefId From tblUnitReference WHERE RecId = @ComputationID
        INSERT INTO tblAdvancePayment
        (
            Months,
            RefId,
            Amount
        )
        SELECT convert(DATE, Months),
               @RefId,
               @TotalRent
        FROM #tblAdvancePayment

        EXEC [sp_GenerateLedger] @FromDate = @StatDate,
                                 @EndDate = @FinishDate,
                                 @LedgAmount = @TotalRent,
                                 @ComputationID = @ComputationID,
                                 @ClientID = @ClientID,
                                 @EncodedBy = @EncodedBy,
                                 @ComputerName = @ComputerName

        SET @Message_Code = 'SUCCESS'

    END

    SELECT @Message_Code AS Message_Code
    DROP TABLE #tblAdvancePayment;
END;