USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_UpdatePurchaseItemById]    Script Date: 11/9/2023 10:05:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_UpdatePurchaseItemById] 
					@RecId INT,
					@ProjectId INT,
					@Descriptions VARCHAR(50) = NULL,
					@DatePurchase VARCHAR(500) = NULL,
					@UnitAmount DECIMAL(18,2) = NULL,
					@Amount DECIMAL(18,2) = NULL,
					@TotalAmount DECIMAL(18,2) = NULL,
					@Remarks VARCHAR(200) = NULL,
					@UnitNumber VARCHAR(50) = NULL,
					@UnitID INT = NULL,
					@LastChangedBy int = NULL,
					@ComputerName VARCHAR(50) = NULL
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	if  EXISTS(SELECT * FROM tblProjPurchItem WHERE RecId = @RecId)
		BEGIN

			UPDATE tblProjPurchItem SET ProjectId = @ProjectId,
			Descriptions = @Descriptions,
			DatePurchase = @DatePurchase,
			UnitAmount = @UnitAmount,
			Amount = @Amount,
			TotalAmount = @TotalAmount,
			Remarks = @Remarks,
			UnitNumber = @UnitNumber,
			UnitID = @UnitID,
			LastChangedBy=@LastChangedBy,
			LastChangedDate=GETDATE(),
			ComputerName=@ComputerName 
			WHERE RecId = @RecId

			if(@@ROWCOUNT > 0)
				BEGIN

					SELECT 'SUCCESS' AS Message_Code

				END
		END
	ELSE
				BEGIN

					SELECT 'NOT EXISTS' AS Message_Code

				END
END
