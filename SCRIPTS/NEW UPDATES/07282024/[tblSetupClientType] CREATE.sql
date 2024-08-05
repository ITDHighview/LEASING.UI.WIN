USE [LEASINGDB]
CREATE TABLE [tblSetupClientType]
    (
        [RecId]      INT IDENTITY(1, 1),
        [ClientCode] VARCHAR(150),
        [ClientType] VARCHAR(150)
    )