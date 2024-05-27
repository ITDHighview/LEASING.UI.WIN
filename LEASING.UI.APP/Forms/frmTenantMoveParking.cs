using LEASING.UI.APP.Common;
using LEASING.UI.APP.Context;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace LEASING.UI.APP.Forms
{
    public partial class frmTenantMoveParking : Form
    {
        PaymentContext PaymentContext = new PaymentContext();
        UnitContext UnitContext = new UnitContext();
        public frmTenantMoveParking()
        {
            InitializeComponent();
        }

        private void M_GetForMoveInParkingList()
        {
            try
            {
                dgvList.DataSource = null;
                using (DataSet dt = PaymentContext.GetForMoveInParkingList())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        dgvList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_GetForMoveInParkingList()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_GetForMoveInParkingList()", ex.ToString());
            }
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
                                M_GetForMoveInParkingList();
                            }
                            else
                            {
                                MessageBox.Show(result, "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                            }
                        }
                        catch (Exception ex)
                        {
                            Functions.LogError("Cell Click : ColApproved", this.Text, ex.ToString(), DateTime.Now, this);
                            Functions.ErrorShow("Cell Click : ColApproved", ex.ToString());
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

        private void btnRefresh_Click(object sender, EventArgs e)
        {
            M_GetForMoveInParkingList();
        }

        private void frmTenantMoveParking_Load(object sender, EventArgs e)
        {
            M_GetForMoveInParkingList();
        }

        private void btnPrintAuthorization_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(Convert.ToString(dgvList.CurrentRow.Cells["RefId"].Value)))
            {
                frmMoveInAuthorizationReport MoveIn = new frmMoveInAuthorizationReport(Convert.ToString(dgvList.CurrentRow.Cells["RefId"].Value));
                MoveIn.Show();
            }
        }
    }
}
