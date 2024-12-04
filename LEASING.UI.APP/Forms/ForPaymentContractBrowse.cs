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
    public partial class ForPaymentContractBrowse : Form
    {
        ComputationContext ComputationContext = new ComputationContext();
        public ForPaymentContractBrowse()
        {
            InitializeComponent();
        }
        private void M_GetComputationList()
        {
            try
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
            catch (Exception ex)
            {
                Functions.LogError("M_GetComputationList()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_GetComputationList()", ex.ToString());
            }


        }
        private void frmGenerateTrasaction_Load(object sender, EventArgs e)
        {
            Functions.EventCapturefrmName(this);
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
                        ViewContractParkingInfo forms = new ViewContractParkingInfo();
                        forms.Recid = Convert.ToInt32(dgvList.CurrentRow.Cells["RecId"].Value);
                        forms.Text = Convert.ToString(dgvList.CurrentRow.Cells["ProjectName"].Value) + " - " + " PARKING";
                        forms.ShowDialog();
                    }
                    else
                    {
                        ViewContractUnitInfo forms = new ViewContractUnitInfo();
                        forms.Recid = Convert.ToInt32(dgvList.CurrentRow.Cells["RecId"].Value);
                        forms.Text = Convert.ToString(dgvList.CurrentRow.Cells["ProjectName"].Value) + " - " + " UNIT";
                        forms.ShowDialog();
                    }
                }
                else if (this.dgvList.Columns[e.ColumnIndex].Name == "ColGenerate")
                {
                    if (MessageBox.Show("Are you sure you want to generate ledger transaction to this Contract?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                    {
                        if (Convert.ToString(dgvList.CurrentRow.Cells["TypeOf"].Value) == "TYPE OF PARKING")
                        {
                            //frmClientTransactionParking forms = new frmClientTransactionParking();
                            //forms.ComputationRecid = Convert.ToInt32(dgvList.CurrentRow.Cells["RecId"].Value);
                            //forms.ClientId = Convert.ToString(dgvList.CurrentRow.Cells["ClientID"].Value);
                            //forms.ShowDialog();

                            FirstPaymentCollection forms = new FirstPaymentCollection();
                            forms.contractId = Convert.ToInt32(dgvList.CurrentRow.Cells["RecId"].Value);
                            //forms.IsFullPayment = Convert.ToString(dgvList.CurrentRow.Cells["PaymentCategory"].Value) == "FULL PAYMENT" ? true : false;
                            forms.ShowDialog();

                            M_GetComputationList();
                        }
                        else
                        {
                            FirstPaymentCollection forms = new FirstPaymentCollection();
                            forms.contractId = Convert.ToInt32(dgvList.CurrentRow.Cells["RecId"].Value);
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
