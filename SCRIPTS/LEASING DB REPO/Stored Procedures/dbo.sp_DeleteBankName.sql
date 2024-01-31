SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_DeleteBankName] @BankName VARCHAR(50) = NULL
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        DECLARE @Message_Code VARCHAR(MAX) = '';
        -- Insert statements for procedure here
        IF EXISTS
            (
                SELECT
                    [tblBankName].[BankName]
                FROM
                    [dbo].[tblBankName]
                WHERE
                    [tblBankName].[BankName] = @BankName
            )
            BEGIN

                DELETE FROM
                [dbo].[tblBankName]
                WHERE
                    [tblBankName].[BankName] = @BankName;
                IF (@@ROWCOUNT > 0)
                    BEGIN
                        SET @Message_Code = 'SUCCESS';
                    END;
            END;

        SELECT
            @Message_Code AS [Message_Code];
    END;

GO
