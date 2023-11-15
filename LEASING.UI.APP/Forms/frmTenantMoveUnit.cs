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
            dgvList.DataSource = null;
            using (DataSet dt = PaymentContext.GetForMoveInUnitList())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    dgvList.DataSource = dt.Tables[0];
                }
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

                            LogErrorIntoStoredProcedure("sp_LogError", "sp_MovedIn: " + "Move-In", result, DateTime.Now);
                        }
                    }
                    catch (Exception ex)
                    {                    
                        LogErrorIntoStoredProcedure("sp_LogError", "sp_MovedIn: " + "Move-In", ex.Message, DateTime.Now);                  
                        MessageBox.Show("An error occurred : " + ex.ToString() + " Please check the log table details.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
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
    }
}
