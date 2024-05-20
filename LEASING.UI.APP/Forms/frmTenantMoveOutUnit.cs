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
    public partial class frmTenantMoveOutUnit : Form
    {
        PaymentContext PaymentContext = new PaymentContext();
        UnitContext UnitContext = new UnitContext();

        public string ReferenceId { get; set; } = string.Empty;
        public frmTenantMoveOutUnit()
        {
            InitializeComponent();
        }
        private void M_GetForMoveOutUnitList()
        {
            try
            {
                dgvList.DataSource = null;
                using (DataSet dt = PaymentContext.GetForMoveOutUnitList())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        dgvList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogErrorIntoStoredProcedure("M_GetForMoveOutUnitList()", this.Text, ex.Message, DateTime.Now, this);

                Functions.MessageShow("An error occurred : (" + ex.ToString() + ") Please check the [ErrorLog] ");
            }

        }

        private void dgvList_CellClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                if (this.dgvList.Columns[e.ColumnIndex].Name == "ColApproved")
                {

                    if (MessageBox.Show("Are you sure you want Close this Contract?", "", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                    {
                        try
                        {
                            string result = PaymentContext.CloseContract(Convert.ToString(dgvList.CurrentRow.Cells["RefId"].Value));
                            if (result.Equals("SUCCESS"))
                            {
                                MessageBox.Show("Close Contract Successfully! ", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                                M_GetForMoveOutUnitList();
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

        private void frmTenantMoveOutUnit_Load(object sender, EventArgs e)
        {
            M_GetForMoveOutUnitList();

        }
    }
}
