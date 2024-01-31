SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_UpdatePurchaseItemById]
    @RecId         INT,
    @ProjectId     INT,
    @Descriptions  VARCHAR(50)    = NULL,
    @DatePurchase  VARCHAR(500)   = NULL,
    @UnitAmount    DECIMAL(18, 2) = NULL,
    @Amount        DECIMAL(18, 2) = NULL,
    @TotalAmount   DECIMAL(18, 2) = NULL,
    @Remarks       VARCHAR(200)   = NULL,
    @UnitNumber    VARCHAR(50)    = NULL,
    @UnitID        INT            = NULL,
    @LastChangedBy INT            = NULL,
    @ComputerName  VARCHAR(50)    = NULL
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        IF EXISTS
            (
                SELECT
                    *
                FROM
                    [dbo].[tblProjPurchItem]
                WHERE
                    [tblProjPurchItem].[RecId] = @RecId
            )
            BEGIN

                UPDATE
                    [dbo].[tblProjPurchItem]
                SET
                    [tblProjPurchItem].[ProjectId] = @ProjectId,
                    [tblProjPurchItem].[Descriptions] = @Descriptions,
                    [tblProjPurchItem].[DatePurchase] = @DatePurchase,
                    [tblProjPurchItem].[UnitAmount] = @UnitAmount,
                    [tblProjPurchItem].[Amount] = @Amount,
                    [tblProjPurchItem].[TotalAmount] = @TotalAmount,
                    [tblProjPurchItem].[Remarks] = @Remarks,
                    [tblProjPurchItem].[UnitNumber] = @UnitNumber,
                    [tblProjPurchItem].[UnitID] = @UnitID,
                    [tblProjPurchItem].[LastChangedBy] = @LastChangedBy,
                    [tblProjPurchItem].[LastChangedDate] = GETDATE(),
                    [tblProjPurchItem].[ComputerName] = @ComputerName
                WHERE
                    [tblProjPurchItem].[RecId] = @RecId;

                IF (@@ROWCOUNT > 0)
                    BEGIN

                        SELECT
                            'SUCCESS' AS [Message_Code];

                    END;
            END;
        ELSE
            BEGIN

                SELECT
                    'NOT EXISTS' AS [Message_Code];

            END;
    END;
GO
