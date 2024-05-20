﻿using LEASING.UI.APP.Common;
using LEASING.UI.APP.Context;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace LEASING.UI.APP.Forms
{
    public partial class frmTenantMoveUnit : Form
    {
        public string sRefId { get; set; } = string.Empty;
        PaymentContext PaymentContext = new PaymentContext();
        UnitContext UnitContext = new UnitContext();
        public frmTenantMoveUnit()
        {
            InitializeComponent();
        }
        private void LogErrorIntoStoredProcedure(string storedProcedureName, string procedureName, string errorMessage, DateTime logDateTime)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(ConfigurationManager.ConnectionStrings["CONNECTIONS"].ToString()))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand(storedProcedureName, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        // Add parameters
                        command.Parameters.AddWithValue("@ProcedureName", procedureName);
                        command.Parameters.AddWithValue("@ErrorMessage", errorMessage);
                        command.Parameters.AddWithValue("@LogDateTime", logDateTime);
                        // Execute the stored procedure
                        command.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }
        private void M_GetForMoveInUnitList()
        {
            try
            {
                dgvList.DataSource = null;
                using (DataSet dt = PaymentContext.GetForMoveInUnitList())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        dgvList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogErrorIntoStoredProcedure("M_GetForMoveInUnitList()", this.Text, ex.Message, DateTime.Now, this);

                Functions.MessageShow("An error occurred : (" + ex.ToString() + ") Please check the [ErrorLog] ");
            }

        }
        private void frmTenantMoveUnit_Load(object sender, EventArgs e)
        {
            M_GetForMoveInUnitList();
        }
        private void btnRefresh_Click(object sender, EventArgs e)
        {
            M_GetForMoveInUnitList();
        }
        private void dgvList_CellClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                if (this.dgvList.Columns[e.ColumnIndex].Name == "ColApproved")
                {

                    if (MessageBox.Show("Are you sure you want tag this as Move-in?", "", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                    {
                        try
                        {
                            string result = UnitContext.MovedIn(Convert.ToString(dgvList.CurrentRow.Cells["RefId"].Value));
                            if (result.Equals("SUCCESS"))
                            {
                                MessageBox.Show("Move-In Successfully! ", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                                M_GetForMoveInUnitList();
                            }
                            else
                            {
                                MessageBox.Show(result, "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                            }
                        }
                        catch (Exception ex)
                        {
                            Functions.LogErrorIntoStoredProcedure("Cell Click : ColApproved", this.Text, ex.Message, DateTime.Now, this);

                            Functions.MessageShow("An error occurred : (" + ex.ToString() + ") Please check the [ErrorLog] ");
                        }
                    }
                }
                else if (this.dgvList.Columns[e.ColumnIndex].Name == "ColView")
                {
                    frmEditUnitComputation forms = new frmEditUnitComputation();
                    forms.Recid = Convert.ToInt32(dgvList.CurrentRow.Cells["RecId"].Value);
                    forms.ShowDialog();
                }
            }
        }

        private void btnPrintAuthorization_Click(object sender, EventArgs e)
        {//RefId
            if (dgvList.Rows.Count > 0)
            {
                if (!string.IsNullOrEmpty(Convert.ToString(dgvList.CurrentRow.Cells["RefId"].Value)))
                {
                    frmMoveInAuthorizationReport MoveIn = new frmMoveInAuthorizationReport(Convert.ToString(dgvList.CurrentRow.Cells["RefId"].Value));
                    MoveIn.Show();
                }
            }
        }
    }
}
