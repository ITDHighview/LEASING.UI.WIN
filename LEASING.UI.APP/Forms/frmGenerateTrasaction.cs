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
    public partial class frmGenerateTrasaction : Form
    {
        ComputationContext ComputationContext = new ComputationContext();
        public frmGenerateTrasaction()
        {
            InitializeComponent();
        }
        private void M_GetComputationList()
        {
            dgvList.DataSource = null;
            using (DataSet dt = ComputationContext.GetComputationList())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {

                    dgvList.DataSource = dt.Tables[0];
                }
            }
        }
        private void frmGenerateTrasaction_Load(object sender, EventArgs e)
        {
            M_GetComputationList();
        }
        private void dgvList_CellClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                if (this.dgvList.Columns[e.ColumnIndex].Name == "ColEdit")
                {
                    if (Convert.ToString(dgvList.CurrentRow.Cells["TypeOf"].Value) == "TYPE OF PARKING")
                    {
                        frmEditParkingComputation forms = new frmEditParkingComputation();
                        forms.Recid = Convert.ToInt32(dgvList.CurrentRow.Cells["RecId"].Value);
                        forms.Text = Convert.ToString(dgvList.CurrentRow.Cells["ProjectName"].Value) + " - " + " PARKING";
                        forms.ShowDialog();
                    }
                    else
                    {
                        frmEditUnitComputation forms = new frmEditUnitComputation();
                        forms.Recid = Convert.ToInt32(dgvList.CurrentRow.Cells["RecId"].Value);
                        forms.Text = Convert.ToString(dgvList.CurrentRow.Cells["ProjectName"].Value) + " - " + " UNIT";
                        forms.ShowDialog();
                    }
                }
                else if (this.dgvList.Columns[e.ColumnIndex].Name == "ColGenerate")
                {
                    if (MessageBox.Show("Are you sure you want to generate transaction to this reference?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                    {
                        if (Convert.ToString(dgvList.CurrentRow.Cells["TypeOf"].Value) == "TYPE OF PARKING")
                        {
                            //frmClientTransactionParking forms = new frmClientTransactionParking();
                            //forms.ComputationRecid = Convert.ToInt32(dgvList.CurrentRow.Cells["RecId"].Value);
                            //forms.ClientId = Convert.ToString(dgvList.CurrentRow.Cells["ClientID"].Value);
                            //forms.ShowDialog();

                            frmSelectClient forms = new frmSelectClient();
                            forms.ComputationRecid = Convert.ToInt32(dgvList.CurrentRow.Cells["RecId"].Value);
                            //forms.IsFullPayment = Convert.ToString(dgvList.CurrentRow.Cells["PaymentCategory"].Value) == "FULL PAYMENT" ? true : false;
                            forms.ShowDialog();

                            M_GetComputationList();
                        }
                        else
                        {
                            frmSelectClient forms = new frmSelectClient();
                            forms.ComputationRecid = Convert.ToInt32(dgvList.CurrentRow.Cells["RecId"].Value);
                            //forms.IsFullPayment = Convert.ToString(dgvList.CurrentRow.Cells["PaymentCategory"].Value) == "FULL PAYMENT" ? true : false;
                            forms.ShowDialog();
                            M_GetComputationList();
                        }
                    }
                }
            }
        }
    }
}
