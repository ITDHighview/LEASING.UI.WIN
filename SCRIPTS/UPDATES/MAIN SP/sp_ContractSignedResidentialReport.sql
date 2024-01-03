--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO
ALTER PROCEDURE [dbo].[sp_ContractSignedResidentialReport] @RefId AS VARCHAR(20) = NULL
-- WITH ENCRYPTION, RECOMPILE, EXECUTE AS CALLER|SELF|OWNER| 'user_name'
AS
BEGIN
    SET NOCOUNT ON;


    CREATE TABLE [#temptable]
    (
        [ThisDay] NVARCHAR(20),
        [OfMonth] NVARCHAR(20),
        [OfYear] NVARCHAR(20),
        [ProjectName] NVARCHAR(50),
        [ProjectAddress] NVARCHAR(500),
        [ClientName] NVARCHAR(100),
        [ClientAddress] NVARCHAR(500),
        [UnitNo] NVARCHAR(20),
        [UnitArea] NVARCHAR(20),
        [StartDate] NVARCHAR(20),
        [EndDate] NVARCHAR(20),
        [RentalAmountInWords] NVARCHAR(500),
        [SecAndSecurityAmountInWords] NVARCHAR(500),
        [TotalAmountInWords] NVARCHAR(500),
        [VATPCT] NVARCHAR(50),
    );

    INSERT INTO [#temptable]
    (
        [ThisDay],
        [OfMonth],
        [OfYear],
        [ProjectName],
        [ProjectAddress],
        [ClientName],
        [ClientAddress],
        [UnitNo],
        [UnitArea],
        [StartDate],
        [EndDate],
        [RentalAmountInWords],
        [SecAndSecurityAmountInWords],
        [TotalAmountInWords],
        [VATPCT]
    )
    VALUES
    (   '01',                                                                            -- ThisDay - varchar(10)
        'JANUARY',                                                                       -- OfMonth - varchar(10)
        '2024',                                                                          -- OfYear - varchar(10)  
        'OHAYO MANSION',                                                                 -- ProjectName - varchar(10)        
        'TEST ADDRESS TEST ADDRESS TEST ADDRESS TEST ADDRESS TEST ADDRESS TEST ADDRESS', -- ProjectAddress - varchar(10)        
        'MARK JASON GELISANGA',                                                          -- ClientName - varchar(100)
        'TEST ADDRESS',                                                                  -- ClientAddress - varchar(500)
        'UNIT NO. 1',                                                                    -- UnitNo - varchar(20)
        '38.6',                                                                          -- UnitArea - varchar(20)
        'JAN 03, 2024',                                                                  -- StartDate - varchar(10)
        'JAN 03, 2025',                                                                  -- EndDate - varchar(10)
        'Eleven Thousand Seven Hundred Sixty Pesos (Php 11,760.00)',                     -- RentalAmountInWords - varchar(500)      
        'Two Thousand Two Hundred Forty Pesos (Php 2,240.00)',                           -- SecAndSecurityAmountInWords - varchar(500)
        'Fourteen Thousand Pesos (Php 14,000.00)',                                       -- TotalAmountInWords - varchar(500)      
        '12%'                                                                            -- VATPCT - varchar(50)
        );


    SELECT [#temptable].[ThisDay],
           [#temptable].[OfMonth],
           [#temptable].[OfYear],
           [#temptable].[ProjectName],
           [#temptable].[ProjectAddress],
           [#temptable].[ClientName],
           [#temptable].[ClientAddress],
           [#temptable].[UnitNo],
           [#temptable].[UnitArea],
           [#temptable].[StartDate],
           [#temptable].[EndDate],
           [#temptable].[RentalAmountInWords],
           [#temptable].[SecAndSecurityAmountInWords],
           [#temptable].[TotalAmountInWords],
           [#temptable].[VATPCT]
    FROM [#temptable];
END;
GO
--SET QUOTED_IDENTIFIER ON|OFF
--SET ANSI_NULLS ON|OFF
--GO