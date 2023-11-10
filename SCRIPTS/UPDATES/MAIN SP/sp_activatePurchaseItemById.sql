USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_activatePurchaseItemById]    Script Date: 11/9/2023 9:53:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
--EXEC sp_GetPurchaseItemInfoById @RecId = 2
-- =============================================
ALTER PROCEDURE [dbo].[sp_activatePurchaseItemById]
@RecId INT
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	--RecId INT IDENTITY(1,1), ProjectId INT,Descriptions VARCHAR(200), DatePurchase DateTime,UnitAmount MONEY,Amount Money,Remarks VARCHAR(200)
	--ADD EncodedBy INT,EncodedDate DATETIME,LastChangedBy INT,LastChangedDate DATETIME,ComputerName VARCHAR(50),IsActive BIT
    -- Insert statements for procedure here
	UPDATE tblProjPurchItem SET IsActive = 1 WHERE RecId = @RecId


	if(@@ROWCOUNT > 0)
		BEGIN
			SELECT 'SUCCESS' AS Message_Code
		END
	
	
END

