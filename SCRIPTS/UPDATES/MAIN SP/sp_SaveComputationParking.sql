USE [LEASINGDB];
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveComputationParking]    Script Date: 11/9/2023 10:03:50 PM ******/
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
ALTER PROCEDURE [dbo].[sp_SaveComputationParking]
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
    @IsFullPayment BIT = 0
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ComputationID AS INT = 0;
    DECLARE @ProjectType AS VARCHAR(20) = '';
    DECLARE @GenVat AS DECIMAL(18, 2) = 0;
    DECLARE @WithHoldingTax AS DECIMAL(18, 2) = 0;


    SELECT @ProjectType = [tblProjectMstr].[ProjectType]
    FROM [dbo].[tblUnitMstr] WITH (NOLOCK)
        INNER JOIN [dbo].[tblProjectMstr] WITH (NOLOCK)
            ON [tblUnitMstr].[ProjectId] = [tblProjectMstr].[RecId]
    WHERE [tblUnitMstr].[RecId] = @UnitId;


    SELECT @GenVat = [tblRatesSettings].[GenVat],
           @WithHoldingTax = [tblRatesSettings].[WithHoldingTax]
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
        [IsFullPayment]
    )
    VALUES
    (@ProjectId, @InquiringClient, @ClientMobile, @UnitId, @UnitNo, @StatDate, @FinishDate, GETDATE(), @Rental,
     @TotalRent, @Total, @EncodedBy, GETDATE(), 1, @ComputerName, @ClientID, @GenVat, @WithHoldingTax, @IsFullPayment);
    SET @ComputationID = SCOPE_IDENTITY();
    IF (@@ROWCOUNT > 0)
    BEGIN

        EXEC [dbo].[sp_GenerateLedger] @FromDate = @StatDate,
                                       @EndDate = @FinishDate,
                                       @LedgAmount = @TotalRent,
                                       @ComputationID = @ComputationID,
                                       @ClientID = @ClientID,
                                       @EncodedBy = @EncodedBy,
                                       @ComputerName = @ComputerName;

        SELECT 'SUCCESS' AS [Message_Code];
    END;
END;