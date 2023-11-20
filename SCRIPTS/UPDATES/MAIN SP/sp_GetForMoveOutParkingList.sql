USE [LEASINGDB]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetForMoveOutUnitList]    Script Date: 11/17/2023 10:34:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER PROCEDURE [dbo].[sp_GetForMoveOutParkingList]
-- Add the parameters for the stored procedure here

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    DECLARE @IsForMoveOut BIT = 0

    -- Insert statements for procedure here
    SELECT tblUnitReference.RecId,
           tblUnitReference.RefId,
           tblUnitReference.ProjectId,
           tblUnitReference.InquiringClient,
           tblUnitReference.ClientMobile,
           tblUnitReference.UnitId,
           tblUnitReference.UnitNo,
           tblUnitReference.StatDate,
           tblUnitReference.FinishDate,
           tblUnitReference.TransactionDate,
           tblUnitReference.Rental,
           tblUnitReference.SecAndMaintenance,
           tblUnitReference.TotalRent,
           tblUnitReference.AdvancePaymentAmount,
           tblUnitReference.SecDeposit,
           tblUnitReference.Total,
           tblUnitReference.EncodedBy,
           tblUnitReference.EncodedDate,
           tblUnitReference.LastCHangedBy,
           tblUnitReference.LastChangedDate,
           tblUnitReference.IsActive,
           tblUnitReference.ComputerName,
           tblUnitReference.ClientID,
           tblUnitReference.IsPaid,
           tblUnitReference.IsDone,
           tblUnitReference.HeaderRefId,
           tblUnitReference.IsSignedContract,
           tblUnitReference.IsUnitMove,
           tblUnitReference.IsUnitMoveOut,
           tblUnitReference.IsTerminated
    FROM tblUnitReference WITH (NOLOCK)
        INNER JOIN tblUnitMstr WITH (NOLOCK)
            ON tblUnitReference.UnitId = tblUnitMstr.RecId
    where ISNULL(tblUnitReference.IsPaid, 0) = 1
          and ISNULL(tblUnitReference.IsSignedContract, 0) = 1
          and ISNULL(tblUnitReference.IsUnitMove, 0) = 1
          and ISNULL(tblUnitReference.IsUnitMoveOut, 0) = 1        
          and ISNULL(tblUnitMstr.IsParking, 0) = 1
		  and ISNULL(tblUnitReference.IsDone, 0) = 0
		  and ISNULL(tblUnitReference.IsTerminated, 0) = 0
			or ISNULL(tblUnitReference.IsTerminated, 0) = 1
			  and ISNULL(tblUnitReference.IsSignedContract, 0) = 1
			  and ISNULL(tblUnitReference.IsUnitMove, 0) = 1
			  and ISNULL(tblUnitReference.IsUnitMoveOut, 0) = 1        
			  and ISNULL(tblUnitMstr.IsParking, 0) = 1
			  and ISNULL(tblUnitReference.IsDone, 0) = 0
              
          --and
          --(
          --    SELECT COUNT(*)
          --    from tblMonthLedger WITH (NOLOCK)
          --    where ReferenceID = tblUnitReference.RecId
          --          and ISNULL(IsPaid, 0) = 1
          --) > 0
END
