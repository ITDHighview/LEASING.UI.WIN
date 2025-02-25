USE [LEASINGDB]
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[sp_MoveOutAndCloseContractForRenewal]
    @ReferenceID  VARCHAR(50) = NULL,
    @EncodedBy    INT         = NULL,
    @ComputerName VARCHAR(20) = NULL
AS
    BEGIN
        -- SET NOCOUNT ON added to prevent extra result sets from
        -- interfering with SELECT statements.
        SET NOCOUNT ON;

        DECLARE @Message_Code NVARCHAR(MAX);

        /*Move Out*/
        UPDATE
            [dbo].[tblUnitReference]
        SET
            [tblUnitReference].[IsUnitMoveOut] = 1,
            [tblUnitReference].[UnitMoveOutDate] = GETDATE()
        WHERE
            [tblUnitReference].[RefId] = @ReferenceID;

        /*Close Contract*/
        UPDATE
            [dbo].[tblUnitReference]
        SET
            [tblUnitReference].[IsDone] = 1,
            [tblUnitReference].[LastCHangedBy] = @EncodedBy,
            [tblUnitReference].[ContactDoneDate] = GETDATE()
        WHERE
            [tblUnitReference].[RefId] = @ReferenceID;


        UPDATE
            [dbo].[tblUnitMstr]
        SET
            [tblUnitMstr].[UnitStatus] = 'VACANT'
        WHERE
            [RecId] =
            (
                SELECT
                    [tblUnitReference].[UnitId]
                FROM
                    [dbo].[tblUnitReference] WITH (NOLOCK)
                WHERE
                    [tblUnitReference].[RefId] = @ReferenceID
            );


        IF (@@ROWCOUNT > 0)
            BEGIN
                -- Log a success event
                INSERT INTO [dbo].[LoggingEvent]
                    (
                        [EventType],
                        [EventMessage],
                        [UserId],
                        [ComputerName]
                    )
                VALUES
                    (
                        'SUCCESS',
                        '[sp_MoveOutAndCloseContractForRenewal] ReferenceID=' + @ReferenceID + ' EncodedBy='+ CAST(@EncodedBy AS VARCHAR(20)) + ' ComputerName=' + @ComputerName, 
						@EncodedBy, 
						@ComputerName
                    );

                SET @Message_Code = N'SUCCESS';
            END;


        -- Log the error message
        DECLARE @ErrorMessage NVARCHAR(MAX);
        SET @ErrorMessage = ERROR_MESSAGE();

        IF @ErrorMessage <> ''
            BEGIN
                -- Log an error event
                INSERT INTO [dbo].[LoggingEvent]
                    (
                        [EventType],
                        [EventMessage],
                        [UserId],
                        [ComputerName]
                    )
                VALUES
                    (
                        'ERROR',
                        '[sp_MoveOutAndCloseContractForRenewal] ReferenceID=' + @ReferenceID + ' EncodedBy='+ CAST(@EncodedBy AS VARCHAR(20)) + ' ComputerName=' + @ComputerName, 
						@EncodedBy, 
						@ComputerName
                    );

                -- Insert into a logging table
                INSERT INTO [dbo].[ErrorLog]
                    (
                        [ProcedureName],
                        [ErrorMessage],
                        [LogDateTime],
                        [Category],
                        [UserId],
                        [ComputerName]
                    )
                VALUES
                    (
                        '[sp_MoveOutAndCloseContractForRenewal] ReferenceID=' + @ReferenceID + ' EncodedBy='+ CAST(@EncodedBy AS VARCHAR(20)) + ' ComputerName=' + @ComputerName, 
						@ErrorMessage, 
						GETDATE(),
                        'SP', 
						@EncodedBy, 
						@ComputerName
                    );

                -- Return an error message				
                SET @Message_Code = @ErrorMessage;
            END;

        SELECT
            @Message_Code AS [Message_Code];

    END;
GO

