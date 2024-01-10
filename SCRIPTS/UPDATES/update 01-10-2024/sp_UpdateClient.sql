USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveClient]    Script Date: 1/10/2024 7:10:58 AM ******/
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
