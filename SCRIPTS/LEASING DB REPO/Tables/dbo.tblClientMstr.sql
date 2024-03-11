CREATE TABLE [dbo].[tblClientMstr]
(
[RecId] [bigint] NOT NULL IDENTITY(10000000, 1),
[ClientID] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ClientType] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ClientName] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Age] [int] NULL,
[PostalAddress] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DateOfBirth] [date] NULL,
[Gender] [bit] NULL,
[TelNumber] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Nationality] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Occupation] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AnnualIncome] [decimal] (18, 2) NULL,
[EmployerName] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EmployerAddress] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SpouseName] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ChildrenNames] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TotalPersons] [int] NULL,
[MaidName] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DriverName] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[VisitorsPerDay] [int] NULL,
[IsTwoMonthAdvanceRental] [bit] NULL,
[IsThreeMonthSecurityDeposit] [bit] NULL,
[Is10PostDatedChecks] [bit] NULL,
[IsPhotoCopyValidID] [bit] NULL,
[Is2X2Picture] [bit] NULL,
[BuildingSecretary] [int] NULL,
[EncodedDate] [datetime] NULL,
[EncodedBy] [int] NULL,
[LastChangedBy] [int] NULL,
[LastChangedDate] [datetime] NULL,
[IsActive] [bit] NULL,
[ComputerName] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsMap] [bit] NULL,
[TIN_No] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[tr_tblClientMstr]
ON [dbo].[tblClientMstr]
FOR INSERT
AS
BEGIN

    UPDATE [dbo].[tblClientMstr]
    SET [tblClientMstr].[ClientID] = [tblClientMstr].[ClientType] + CONVERT([VARCHAR](5000), [Inserted].[RecId])
    FROM [dbo].[tblClientMstr]
        INNER JOIN [Inserted]
            ON [Inserted].[RecId] = [tblClientMstr].[RecId]
    WHERE [Inserted].[RecId] = [tblClientMstr].[RecId]

END
GO
