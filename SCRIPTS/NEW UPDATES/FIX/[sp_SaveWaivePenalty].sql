USE [LEASINGDB]
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_SaveWaivePenalty]
    @RefId        VARCHAR(150)   = NULL,
    @ReferenceID  INT            = NULL,
    @LedgerRecId  INT            = NULL,
    @Amount       DECIMAL(18, 2) = NULL,
    @Requestor    VARCHAR(150)   = NULL,
    @Remarks      VARCHAR(150)   = NULL,
    @EncodedBy    INT            = NULL,
    @ComputerName VARCHAR(150)   = NULL
AS
    BEGIN TRY

        SET NOCOUNT ON;

        DECLARE @Message_Code VARCHAR(MAX) = '';
        DECLARE @LedgeMonth VARCHAR(150) = ''
        DECLARE @PenaltyOldAmount DECIMAL(18, 2) = 0
        DECLARE @ErrorMessage NVARCHAR(MAX) = N'';

        BEGIN TRANSACTION
        SELECT
            @LedgeMonth       = [tblMonthLedger].[LedgMonth],
            @PenaltyOldAmount = COALESCE([tblMonthLedger].[LedgAmount], [tblMonthLedger].[LedgRentalAmount])
        FROM
            [dbo].[tblMonthLedger]
        WHERE
            [tblMonthLedger].[Recid] = @LedgerRecId
            AND [tblMonthLedger].[ReferenceID] = @ReferenceID

        BEGIN
            INSERT INTO [dbo].[tblPenaltyWaive]
                (
                    [RefId],
                    [LedgMonth],
                    [LedgerRecId],
                    [Amount],
                    [PenaltyOldAmount],
                    [Requestor],
                    [Remarks],
                    [EncodedBy],
                    [EncodedDate],
                    [ComputerName]
                )
            VALUES
                (
                    @RefId,            -- RefId - varchar(150)
                    @LedgeMonth,       -- LedgMonth - date
                    @LedgerRecId,      -- LedgerRecId - int
                    @Amount,           -- Amount - decimal(18, 2)
                    @PenaltyOldAmount, -- PenaltyOldAmount - decimal(18, 2)
                    @Requestor,        -- Requestor - nvarchar(150)
                    @Remarks,          -- Remarks - nvarchar(2000)
                    @EncodedBy,        -- EncodedBy - int
                    GETDATE(),         -- EncodedDate - datetime
                    @ComputerName      -- ComputerName - varchar(30)
                )
            IF (@@ROWCOUNT > 0)
                BEGIN
                    UPDATE
                        [dbo].[tblMonthLedger]
                    SET
                        [tblMonthLedger].[LedgAmount] = @Amount,
                        [tblMonthLedger].[LedgRentalAmount] = @Amount
                    WHERE
                        [tblMonthLedger].[Recid] = @LedgerRecId
                        AND [tblMonthLedger].[ReferenceID] = @ReferenceID

                    SET @Message_Code = 'SUCCESS'
                    SET @ErrorMessage = N''
                END
        END


        SELECT
            @ErrorMessage AS [ErrorMessage],
            @Message_Code AS [Message_Code];

        COMMIT TRANSACTION

    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION

        SET @Message_Code = 'ERROR'
        SET @ErrorMessage = ERROR_MESSAGE()

        INSERT INTO [dbo].[ErrorLog]
            (
                [ProcedureName],
                [ErrorMessage],
                [LogDateTime]
            )
        VALUES
            (
                'sp_SaveWaivePenalty', @ErrorMessage, GETDATE()
            );

        SELECT
            @ErrorMessage AS [ErrorMessage],
            @Message_Code AS [Message_Code];
    END CATCH
GO

