-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE sp_GetClientReferencePaid 
	@ClientID VARCHAR(30) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
select 
tblClientMstr.ClientID,
tblClientMstr.ClientName,
tblUnitReference.RefId 
from tblClientMstr WITH(NOLOCK)
INNER JOIN tblUnitReference  WITH(NOLOCK)
ON tblClientMstr.ClientID = tblUnitReference.ClientID
WHERE ISNULL(tblUnitReference.IsSignedContract,0)=0 and ISNULL(tblUnitReference.IsUnitMove,0)=0 and tblClientMstr.ClientID = @ClientID

END
GO
