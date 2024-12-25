USE [LEASINGDB]


CREATE TABLE [tblPenaltyWaive]
    (
        [RecId]            INT           IDENTITY(1, 1),
        [RefId]            VARCHAR(150),
        [LedgMonth]        DATE,
        [LedgerRecId]      INT,
        [Amount]           DECIMAL(18, 2)
            DEFAULT 0,
        [PenaltyOldAmount] DECIMAL(18, 2)
            DEFAULT 0,
        [Requestor]        NVARCHAR(150),
        [Remarks]          NVARCHAR(2000),
        [EncodedBy]        INT,
        [EncodedDate]      DATETIME,
        [ComputerName]     VARCHAR(30)
    )