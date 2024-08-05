USE [LEASINGDB]
TRUNCATE TABLE [dbo].[tblSetupClientType]
INSERT INTO [dbo].[tblSetupClientType]
    (
        [ClientType],
        [ClientCode]
    )
VALUES
    (
        'INDIVIDUAL', 'INDV'
    ),
    (
        'CORPORATE', 'CORP'
    ),
    (
        'PARTNERSHIP', 'PART'
    ),
    (
        'PROPRIETORSHIP', 'PROP'
    )