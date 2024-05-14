SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE   PROCEDURE [dbo].[sp_SaveClient]
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
    @TIN_No            VARCHAR(50)    = NULL
AS
    BEGIN TRY
        SET NOCOUNT ON;
        DECLARE @Message_Code VARCHAR(MAX) = '';
        DECLARE @ErrorMessage NVARCHAR(MAX) = N'';
        BEGIN TRANSACTION

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
                @ComputerName, @TIN_No
            );

        IF (@@ROWCOUNT > 0)
            BEGIN
                SET @Message_Code = 'SUCCESS'
                SET @ErrorMessage = N''
            END;
        SELECT
            @ErrorMessage AS [ErrorMessage],
            @Message_Code AS [Message_Code];
        COMMIT TRANSACTION

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION

        SET @Message_Code = 'ERROR'
        SET @ErrorMessage = ERROR_MESSAGE()

        INSERT INTO [dbo].[ErrorLog]
            (
                [ProcedureName],
                [ErrorMessage],
                [LogDateTime]
            )
        VALUES
            (
                'sp_SaveClient', @ErrorMessage, GETDATE()
            );

        SELECT
            @ErrorMessage AS [ErrorMessage],
            @Message_Code AS [Message_Code];
    END CATCH
GO
