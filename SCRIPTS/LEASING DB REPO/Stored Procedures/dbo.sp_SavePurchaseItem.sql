SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_SavePurchaseItem]
    @ProjectId    INT            = NULL,
    @Descriptions VARCHAR(200)   = NULL,
    @DatePurchase DATETIME       = NULL,
    @UnitAmount   INT            = NULL,
    @Amount       DECIMAL(18, 2) = NULL,
    @TotalAmount  DECIMAL(18, 2) = NULL,
    @Remarks      VARCHAR(200)   = NULL,
    @UnitNumber   VARCHAR(50)    = NULL,
    @UnitID       INT            = NULL,
    @EncodedBy    INT            = NULL,
    @ComputerName VARCHAR(50)    = NULL
AS
    BEGIN

        SET NOCOUNT ON;

        IF NOT EXISTS
            (
                SELECT
                    *
                FROM
                    [dbo].[tblProjPurchItem]
                WHERE
                    [tblProjPurchItem].[Descriptions] = @Descriptions
                    AND [tblProjPurchItem].[ProjectId] = @ProjectId
            )
            BEGIN
                INSERT INTO [dbo].[tblProjPurchItem]
                    (
                        [ProjectId],
                        [Descriptions],
                        [DatePurchase],
                        [UnitAmount],
                        [Amount],
                        [TotalAmount],
                        [Remarks],
                        [UnitNumber],
                        [UnitID],
                        [EncodedBy],
                        [EncodedDate],
                        [ComputerName],
                        [IsActive]
                    )
                VALUES
                    (
                        @ProjectId, @Descriptions, @DatePurchase, @UnitAmount, @Amount, @TotalAmount, @Remarks,
                        @UnitNumber, @UnitID, @EncodedBy, GETDATE(), @ComputerName, 1
                    );

                IF (@@ROWCOUNT > 0)
                    BEGIN
                        SELECT
                            'SUCCESS' AS [Message_Code];
                    END;
            END;
        ELSE
            BEGIN
                SELECT
                    'PROJECT NAME ALREADY EXISTS' AS [Message_Code];
            END;
    END;
GO
