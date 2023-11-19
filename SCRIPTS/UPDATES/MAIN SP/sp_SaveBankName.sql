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
ALTER PROCEDURE sp_SaveBankName 
@BankName VARCHAR(50)= NULL
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @Message_Code VARCHAR(MAX)= ''
    -- Insert statements for procedure here
	IF NOT EXISTS(SELECT BankName FROm tblBankName WHERE BankName = @BankName)
		BEGIN
			INSERT INTO tblBankName(BankName)VALUES(@BankName)
				if(@@ROWCOUNT > 0)
					BEGIN
						SET @Message_Code = 'SUCCESS'
					END
		END
	ELSE
		BEGIN
			
						SET @Message_Code = 'THIS BANK IS ALREADy EXISTST!'
					
		END

		SELECT @Message_Code AS Message_Code
END

GO
