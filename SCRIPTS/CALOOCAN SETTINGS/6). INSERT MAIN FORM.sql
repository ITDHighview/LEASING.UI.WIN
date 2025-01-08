USE [LEASINGDB]
/*Disregard the [MenuId] not been use - plan to drop the column*/
INSERT INTO [dbo].[tblForm]
    (
        [MenuId],
        [FormName],
        [FormDescription],
        [IsDelete]
    )
VALUES
    (
        0, 'frmMainDashboard', 'MAIN FORM', 0
    )

