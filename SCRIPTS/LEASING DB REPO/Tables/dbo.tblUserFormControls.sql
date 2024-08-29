CREATE TABLE [dbo].[tblUserFormControls]
(
[UserControlId] [int] NOT NULL IDENTITY(1, 1),
[FormId] [int] NULL,
[ControlId] [int] NULL,
[UserId] [int] NULL,
[IsVisible] [bit] NULL,
[IsDelete] [bit] NULL
) ON [PRIMARY]
GO
