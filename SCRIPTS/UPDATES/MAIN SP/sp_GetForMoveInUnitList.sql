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
ALTER PROCEDURE sp_GetForMoveInUnitList
-- Add the parameters for the stored procedure here

AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

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
           tblUnitReference.Advancemonths1,
           tblUnitReference.Advancemonths2,
           tblUnitReference.SecDeposit,
           tblUnitReference.Total,
           tblUnitReference.EncodedBy,
           tblUnitReference.EncodedDate,
           tblUnitReference.LastCHangedBy,
           tblUnitReference.LastChangedDate,
           tblUnitReference.IsActive,
           tblUnitReference.ComputerName,
           tblUnitReference.ClientID,
           tblUnitReference.Applicabledate1,
           tblUnitReference.Applicabledate2,
           tblUnitReference.IsPaid,
           tblUnitReference.IsDone,
           tblUnitReference.HeaderRefId,
           tblUnitReference.IsSignedContract,
           tblUnitReference.IsUnitMove,
           tblUnitReference.IsTerminated
    FROM tblUnitReference WITH (NOLOCK)
        INNER JOIN tblUnitMstr WITH (NOLOCK)
            ON tblUnitReference.UnitId = tblUnitMstr.RecId
    where ISNULL(tblUnitReference.IsPaid, 0) = 1
          and ISNULL(tblUnitReference.IsDone, 0) = 0
          and ISNULL(tblUnitReference.IsSignedContract, 0) = 1
          and ISNULL(tblUnitReference.IsUnitMove, 0) = 0
          and ISNULL(tblUnitReference.IsTerminated, 0) = 0
          and ISNULL(tblUnitMstr.IsParking, 0) = 0
END
GO
