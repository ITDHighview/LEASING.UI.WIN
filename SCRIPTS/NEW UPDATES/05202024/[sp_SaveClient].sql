SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
CREATE OR ALTER PROCEDURE [dbo].[sp_SaveClient]
    --@ClientType        VARCHAR(50),
    --@ClientName        VARCHAR(100),
    --@Age               INT            = 0,
    --@PostalAddress     VARCHAR(100)   = NULL,
    --@DateOfBirth       DATE           = NULL,
    --@TelNumber         VARCHAR(20)    = NULL,
    --@Gender            BIT            = NULL,
    --@Nationality       VARCHAR(50)    = NULL,
    --@Occupation        VARCHAR(100)   = NULL,
    --@AnnualIncome      DECIMAL(18, 2) = 0,
    --@EmployerName      VARCHAR(100)   = NULL,
    --@EmployerAddress   VARCHAR(200)   = NULL,
    --@SpouseName        VARCHAR(100)   = NULL,
    --@ChildrenNames     VARCHAR(500)   = NULL,
    --@TotalPersons      INT            = 0,
    --@MaidName          VARCHAR(100)   = NULL,
    --@DriverName        VARCHAR(100)   = NULL,
    --@VisitorsPerDay    INT            = 0,
    --@BuildingSecretary INT            = 0,
    --@EncodedBy         INT            = 0,
    --@ComputerName      VARCHAR(50)    = NULL,
    --@TIN_No            VARCHAR(50)    = NULL,
    @XML XML = NULL
AS
    BEGIN
        SET NOCOUNT ON;
        DECLARE @Message_Code VARCHAR(MAX) = '';
        DECLARE @ErrorMessage NVARCHAR(MAX) = N'';

        IF (@XML IS NOT NULL)
            BEGIN
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
                            SELECT
                                [ParaValues].[data].[value]('c1[1]', 'VARCHAR(50)'),
                                [ParaValues].[data].[value]('c2[1]', 'VARCHAR(100)'),
                                [ParaValues].[data].[value]('c3[1]', 'INT'),
                                [ParaValues].[data].[value]('c4[1]', 'VARCHAR(100)'),
                                [ParaValues].[data].[value]('c5[1]', 'DATE'),
                                [ParaValues].[data].[value]('c6[1]', 'VARCHAR(20)'),
                                [ParaValues].[data].[value]('c7[1]', 'BIT'),
                                [ParaValues].[data].[value]('c8[1]', 'VARCHAR(50)'),
                                [ParaValues].[data].[value]('c9[1]', 'VARCHAR(100)'),
                                [ParaValues].[data].[value]('c10[1]', 'DECIMAL(18, 2)'),
                                [ParaValues].[data].[value]('c11[1]', 'VARCHAR(100)'),
                                [ParaValues].[data].[value]('c12[1]', 'VARCHAR(200)'),
                                [ParaValues].[data].[value]('c13[1]', 'VARCHAR(100)'),
                                [ParaValues].[data].[value]('c14[1]', 'VARCHAR(500)'),
                                [ParaValues].[data].[value]('c15[1]', 'INT'),
                                [ParaValues].[data].[value]('c16[1]', 'VARCHAR(100)'),
                                [ParaValues].[data].[value]('c17[1]', 'VARCHAR(100)'),
                                [ParaValues].[data].[value]('c18[1]', 'INT'),
                                [ParaValues].[data].[value]('c19[1]', 'INT'),
								GETDATE(),
                                [ParaValues].[data].[value]('c20[1]', 'INT'),
								1,
                                [ParaValues].[data].[value]('c21[1]', 'VARCHAR(50)'),
                                [ParaValues].[data].[value]('c22[1]', 'VARCHAR(50)')
                            FROM
                                @XML.[nodes]('/Table1') AS [ParaValues]([data]);
            --VALUES
            --    (
            --        @ClientType, @ClientName, @Age, @PostalAddress, @DateOfBirth, @TelNumber, @Gender, @Nationality,
            --        @Occupation, @AnnualIncome, @EmployerName, @EmployerAddress, @SpouseName, @ChildrenNames,
            --        @TotalPersons, @MaidName, @DriverName, @VisitorsPerDay, @BuildingSecretary, GETDATE(), @EncodedBy, 1,
            --        @ComputerName, @TIN_No
            --    );
            END;

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
                        'sp_SaveClient', @ErrorMessage, GETDATE()
                    );
            END
        SELECT
            @ErrorMessage AS [ErrorMessage],
            @Message_Code AS [Message_Code];
    END
GO

