USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_SavePurchaseItem]    Script Date: 11/9/2023 10:04:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_SavePurchaseItem]
@ProjectId INT = NULL,
@Descriptions VARCHAR(200) = NULL,
@DatePurchase DateTime = NULL,
@UnitAmount INT = NULL,
@Amount DECIMAL(18,2) = NULL,
@TotalAmount DECIMAL(18,2) = NULL,
@Remarks VARCHAR(200) = NULL,
@UnitNumber VARCHAR(50) = NULL,
@UnitID INT = NULL,
@EncodedBy INT = NULL,
@ComputerName VARCHAR(50) = NULL

	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	--CREATE TABLE tblProjPurchItem (RecId INT IDENTITY(1,1), ProjectId INT,Descriptions VARCHAR(200), DatePurchase DateTime,UnitAmount MONEY,Amount Money,Remarks VARCHAR(200))
--ALTER TABLE tblProjPurchItem ADD EncodedBy INT,EncodedDate DATETIME,LastChangedBy INT,LastChangedDate DATETIME,ComputerName VARCHAR(50),IsActive BIT

	IF NOT EXISTS (SELECT * FROM tblProjPurchItem WHERE Descriptions = @Descriptions and ProjectId = @ProjectId)
		BEGIN
			INSERT INTO tblProjPurchItem(ProjectId,Descriptions,DatePurchase,UnitAmount,Amount,TotalAmount,Remarks,UnitNumber,UnitID,EncodedBy,EncodedDate,ComputerName,IsActive)
			VALUES
			(@ProjectId,@Descriptions,@DatePurchase,@UnitAmount,@Amount,@TotalAmount,@Remarks,@UnitNumber,@UnitID,@EncodedBy,GETDATE(),@ComputerName,1)

			IF(@@ROWCOUNT > 0)
				BEGIN
					SELECT 'SUCCESS' AS Message_Code
				END
		END
	ELSE
		BEGIN
			SELECT 'PROJECT NAME ALREADY EXISTS' AS Message_Code
		END
END
