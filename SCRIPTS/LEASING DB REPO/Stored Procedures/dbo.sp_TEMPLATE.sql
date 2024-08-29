SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_TEMPLATE]
AS
    BEGIN

        SET NOCOUNT ON;
        DECLARE @Message_Code VARCHAR(MAX) = '';
        DECLARE @ErrorMessage NVARCHAR(MAX) = N'';
        BEGIN TRANSACTION

        IF (@@ROWCOUNT > 0)
            BEGIN

                SET @Message_Code = 'SUCCESS'
            END



        SET @ErrorMessage = ERROR_MESSAGE()
        IF @ErrorMessage <> ''
            BEGIN

                INSERT INTO [dbo].[ErrorLog]
                    (
                        [ProcedureName],
                        [ErrorMessage],
                        [LogDateTime]
                    )
                VALUES
                    (
                        'sp_TEMPLATE', @ErrorMessage, GETDATE()
                    );


            END
        SELECT
            @ErrorMessage AS [ErrorMessage],
            @Message_Code AS [Message_Code];
    END





--SELECT
--       @ErrorMessage AS [ErrorMessage],
--       @Message_Code AS [Message_Code],
--       @RcptID       AS [ReceiptID],
--       @TranID       AS [TranID]







GO
