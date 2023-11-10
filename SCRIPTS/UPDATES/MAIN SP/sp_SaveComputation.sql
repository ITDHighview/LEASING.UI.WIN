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
	@Applicabledate1 VARCHAR(10),
	@Applicabledate2 VARCHAR(10),
	@Rental decimal(18, 2) NULL,
	@SecAndMaintenance decimal(18, 2),
	@TotalRent decimal(18, 2),
	@Advancemonths1 decimal(18, 2),
	@Advancemonths2 decimal(18, 2),
	@SecDeposit decimal(18, 2),
	@Total decimal(18, 2),
	@EncodedBy int,	
	@ComputerName varchar(30),
	@ClientID varchar(50)
AS
BEGIN
    SET NOCOUNT ON;

	DECLARE @ComputationID AS INT = 0

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
	[Applicabledate1],
	[Applicabledate2],
	[Rental],
	[SecAndMaintenance] ,
	[TotalRent] ,
	[Advancemonths1],
	[Advancemonths2] ,
	[SecDeposit] ,
	[Total],
	[EncodedBy] ,
	[EncodedDate],
	[IsActive],
	[ComputerName],
	[ClientID]
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
	@Applicabledate1,
	@Applicabledate2,
	@Rental,
	@SecAndMaintenance,
	@TotalRent,
	@Advancemonths1,
	@Advancemonths2,
	@SecDeposit,
	@Total,
	@EncodedBy,
	GETDATE(),
	1,
	@ComputerName,
	@ClientID
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