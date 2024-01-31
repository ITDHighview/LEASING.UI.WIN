SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
CREATE PROCEDURE [dbo].[sp_ContractSignedWarehouseReport] @RefId AS VARCHAR(20) = NULL
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    SET NOCOUNT ON;


    CREATE TABLE [#temptable]
    (
        [ThisDay] VARCHAR(10),
        [OfMonth] VARCHAR(10),
        [ClientName] VARCHAR(100),
        [ClientAddress] VARCHAR(500),
        [UnitNo] VARCHAR(20),
        [UnitArea] VARCHAR(20),
        [StartDate] VARCHAR(10),
        [EndDate] VARCHAR(10),
        [RentalAmountInWords] VARCHAR(500),
        [RentalAmountWithCurrency] VARCHAR(50),
        [SecAndSecurityAmountInWords] VARCHAR(500),
        [SecAndSecurityAmountWithCurrency] VARCHAR(50),
        [TotalAmountInWords] VARCHAR(500),
        [TotalAmountWithCurrency] VARCHAR(50),
        [VATPCT] VARCHAR(50),
    );

    INSERT INTO [#temptable]
    (
        [ThisDay],
        [OfMonth],
        [ClientName],
        [ClientAddress],
        [UnitNo],
        [UnitArea],
        [StartDate],
        [EndDate],
        [RentalAmountInWords],
        [RentalAmountWithCurrency],
        [SecAndSecurityAmountInWords],
        [SecAndSecurityAmountWithCurrency],
        [TotalAmountInWords],
        [TotalAmountWithCurrency],
        [VATPCT]
    )
    VALUES
    (   NULL, -- ThisDay - varchar(10)
        NULL, -- OfMonth - varchar(10)
        NULL, -- ClientName - varchar(100)
        NULL, -- ClientAddress - varchar(500)
        NULL, -- UnitNo - varchar(20)
        NULL, -- UnitArea - varchar(20)
        NULL, -- StartDate - varchar(10)
        NULL, -- EndDate - varchar(10)
        NULL, -- RentalAmountInWords - varchar(500)
        NULL, -- RentalAmountWithCurrency - varchar(50)
        NULL, -- SecAndSecurityAmountInWords - varchar(500)
        NULL, -- SecAndSecurityAmountWithCurrency - varchar(50)
        NULL, -- TotalAmountInWords - varchar(500)
        NULL, -- TotalAmountWithCurrency - varchar(50)
        NULL  -- VATPCT - varchar(50)
        );


    SELECT [#temptable].[ThisDay],
           [#temptable].[OfMonth],
           [#temptable].[ClientName],
           [#temptable].[ClientAddress],
           [#temptable].[UnitNo],
           [#temptable].[UnitArea],
           [#temptable].[StartDate],
           [#temptable].[EndDate],
           [#temptable].[RentalAmountInWords],
           [#temptable].[RentalAmountWithCurrency],
           [#temptable].[SecAndSecurityAmountInWords],
           [#temptable].[SecAndSecurityAmountWithCurrency],
           [#temptable].[TotalAmountInWords],
           [#temptable].[TotalAmountWithCurrency],
           [#temptable].[VATPCT]
    FROM [#temptable];
END;
GO
