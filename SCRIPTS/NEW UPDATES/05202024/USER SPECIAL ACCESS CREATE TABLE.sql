USE [LEASINGDB]
CREATE TABLE [dbo].[tblFormSpecialControlsMaster]
    (
        [ControlId]          [INT]          NOT NULL IDENTITY(1, 1),
        [FormId]             [INT]          NULL,
        [ControlName]        [VARCHAR](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        [ControlDescription] [VARCHAR](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
        [IsBackRoundControl] [BIT]          NULL,
        [IsHeaderControl]    [BIT]          NULL,
        [IsDelete]           [BIT]          NULL
    )

CREATE TABLE [dbo].[tblUserFormControls]
    (
        [UserControlId] [INT] NOT NULL IDENTITY(1, 1),
        [FormId]        [INT] NULL,
        [ControlId]     [INT] NULL,
        [UserId]        [INT] NULL,
        [IsVisible]     [BIT] NULL,
        [IsDelete]      [BIT] NULL
    )
