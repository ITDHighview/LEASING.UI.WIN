SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE   PROCEDURE [dbo].[sp_UpdateClient]
    @ClientID          VARCHAR(50),
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
    @TIN_No            VARCHAR(50)    = NULL,
    @IsActive          BIT            = NULL
AS
    BEGIN

        SET NOCOUNT ON;
        DECLARE @Message_Code VARCHAR(MAX) = '';
        DECLARE @ErrorMessage NVARCHAR(MAX) = N'';

        UPDATE
            [dbo].[tblClientMstr]
        SET
            [tblClientMstr].[ClientType] = [dbo].[fnGetClientTypeCode](@ClientType),
            [tblClientMstr].[ClientName] = @ClientName,
            [tblClientMstr].[Age] = @Age,
            [tblClientMstr].[PostalAddress] = @PostalAddress,
            [tblClientMstr].[DateOfBirth] = @DateOfBirth,
            [tblClientMstr].[TelNumber] = @TelNumber,
            [tblClientMstr].[Gender] = @Gender,
            [tblClientMstr].[Nationality] = @Nationality,
            [tblClientMstr].[Occupation] = @Occupation,
            [tblClientMstr].[AnnualIncome] = @AnnualIncome,
            [tblClientMstr].[EmployerName] = @EmployerName,
            [tblClientMstr].[EmployerAddress] = @EmployerAddress,
            [tblClientMstr].[SpouseName] = @SpouseName,
            [tblClientMstr].[ChildrenNames] = @ChildrenNames,
            [tblClientMstr].[TotalPersons] = @TotalPersons,
            [tblClientMstr].[MaidName] = @MaidName,
            [tblClientMstr].[DriverName] = @DriverName,
            [tblClientMstr].[VisitorsPerDay] = @VisitorsPerDay,
            [tblClientMstr].[BuildingSecretary] = @BuildingSecretary,
            [tblClientMstr].[LastChangedDate] = GETDATE(),
            [tblClientMstr].[LastChangedBy] = @EncodedBy,
            --[IsActive]= @IsActive,
            [tblClientMstr].[ComputerName] = @ComputerName,
            [tblClientMstr].[TIN_No] = @TIN_No
        WHERE
            [tblClientMstr].[ClientID] = @ClientID


        IF (@@ROWCOUNT > 0)
            BEGIN
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
                        'sp_UpdateClient', @ErrorMessage, GETDATE()
                    );
            END
        SELECT
            @ErrorMessage AS [ErrorMessage],
            @Message_Code AS [Message_Code];

    END

GO
