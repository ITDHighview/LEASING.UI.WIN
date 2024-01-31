SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
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
