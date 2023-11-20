USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveComputationParking]    Script Date: 11/9/2023 10:03:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_SaveComputationParking]
	@ProjectId int,
	@InquiringClient varchar(500),
	@ClientMobile varchar(50),
	@UnitId int,
	@UnitNo varchar(50),
	@StatDate VARCHAR(10),
	@FinishDate VARCHAR(10),
	@Rental decimal(18, 2) NULL,
	@TotalRent decimal(18, 2),	
	@Total decimal(18, 2),
	@EncodedBy int,	
	@ComputerName varchar(30),
	@ClientID varchar(50)
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE @ComputationID AS INT = 0
	DECLARE @ProjectType AS VARCHAR(20) = ''
    DECLARE @GenVat AS DECIMAL(18, 2) = 0
    DECLARE @WithHoldingTax AS DECIMAL(18, 2) = 0
	

	SELECT @ProjectType = tblProjectMstr.ProjectType
    from tblUnitMstr WITH (NOLOCK)
        INNER JOIN tblProjectMstr WITH (NOLOCK)
            ON tblUnitMstr.ProjectId = tblProjectMstr.RecId
    WHERE tblUnitMstr.RecId = @UnitId


    select @GenVat = GenVat,
           @WithHoldingTax = WithHoldingTax
    from tblRatesSettings WITH (NOLOCK)
    where ProjectType = @ProjectType

	update tblUnitMstr set UnitStatus = 'RESERVED' WHERE RecId = @UnitId

    -- Insert the record into tblClientMstr
    INSERT INTO tblUnitReference
    (    
	[ProjectId],
	[InquiringClient],
	[ClientMobile] ,
	[UnitId] ,
	[UnitNo] ,
	[StatDate] ,
	[FinishDate] ,
	[TransactionDate],	
	[Rental],	
	[TotalRent] ,		
	[Total],
	[EncodedBy] ,
	[EncodedDate],
	[IsActive],
	[ComputerName],
	[ClientID],
	[GenVat],
    [WithHoldingTax]
    )
    VALUES
    (  
    @ProjectId,
	@InquiringClient,
	@ClientMobile,
	@UnitId,
	@UnitNo,
	@StatDate,
	@FinishDate,
	GETDATE(),
	@Rental,	
	@TotalRent,	
	@Total,
	@EncodedBy,
	GETDATE(),
	1,
	@ComputerName,
	@ClientID,
	@GenVat,
    @WithHoldingTax
		)
		SET  @ComputationID = SCOPE_IDENTITY();
		if(@@ROWCOUNT > 0)
		BEGIN

	EXEC [sp_GenerateLedger] 

			@FromDate =			@StatDate,
			@EndDate =			@FinishDate,
			@LedgAmount =		@TotalRent,
			@ComputationID =	@ComputationID,
			@ClientID =			@ClientID,
			@EncodedBy  =		@EncodedBy,
			@ComputerName  =	@ComputerName

			SELECT 'SUCCESS' AS Message_Code
		END
END;