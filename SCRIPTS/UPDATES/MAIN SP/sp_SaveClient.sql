USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_SaveClient]    Script Date: 11/9/2023 10:03:27 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_SaveClient]
    @ClientType VARCHAR(50),
    @ClientName VARCHAR(100),
    @Age INT= 0,
    @PostalAddress VARCHAR(100)= null,
    @DateOfBirth DATE= null,
    @TelNumber VARCHAR(20)= null,
    @Gender BIT= null,
    @Nationality VARCHAR(50)= null,
    @Occupation VARCHAR(100)= null,
    @AnnualIncome DECIMAL(18, 2)= 0,
    @EmployerName VARCHAR(100)= null,
    @EmployerAddress VARCHAR(200)= null,
    @SpouseName VARCHAR(100)= null,
    @ChildrenNames VARCHAR(500)= null,
    @TotalPersons INT= 0,
    @MaidName VARCHAR(100)= null,
    @DriverName VARCHAR(100)= null,
    @VisitorsPerDay INT= 0,
    --@IsTwoMonthAdvanceRental BIT = null,
    --@IsThreeMonthSecurityDeposit BIT = null,
    --@Is10PostDatedChecks BIT = null,
    --@IsPhotoCopyValidID BIT = null,
    --@Is2X2Picture BIT = null,
    @BuildingSecretary INT= 0,
    @EncodedBy INT= 0,
    @ComputerName VARCHAR(50)= null
AS
BEGIN
    SET NOCOUNT ON;


    -- Insert the record into tblClientMstr
    INSERT INTO tblClientMstr
    (
      
        ClientType,
        ClientName,
        Age,
        PostalAddress,
        DateOfBirth,
        TelNumber,
        Gender,
        Nationality,
        Occupation,
        AnnualIncome,
        EmployerName,
        EmployerAddress,
        SpouseName,
        ChildrenNames,
        TotalPersons,
        MaidName,
        DriverName,
        VisitorsPerDay,
        --IsTwoMonthAdvanceRental,
        --IsThreeMonthSecurityDeposit,
        --Is10PostDatedChecks,
        --IsPhotoCopyValidID,
        --Is2X2Picture,
        BuildingSecretary,
        EncodedDate,
        EncodedBy,    
		IsActive,
        ComputerName
    )
    VALUES
    (
       
        @ClientType,
        @ClientName,
        @Age,
        @PostalAddress,
        @DateOfBirth,
        @TelNumber,
        @Gender,
        @Nationality,
        @Occupation,
        @AnnualIncome,
        @EmployerName,
        @EmployerAddress,
        @SpouseName,
        @ChildrenNames,
        @TotalPersons,
        @MaidName,
        @DriverName,
        @VisitorsPerDay,
        --@IsTwoMonthAdvanceRental,
        --@IsThreeMonthSecurityDeposit,
        --@Is10PostDatedChecks,
        --@IsPhotoCopyValidID,
        --@Is2X2Picture,
        @BuildingSecretary,
        GETDATE(),
        @EncodedBy,
		1,
		@ComputerName
		)

		if(@@ROWCOUNT > 0)
		BEGIN
			SELECT 'SUCCESS' AS Message_Code
		END
END;