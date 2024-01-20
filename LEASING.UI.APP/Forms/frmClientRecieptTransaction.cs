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
    public partial class frmClientRecieptTransaction : Form
    {
        ComputationContext ComputationContext = new ComputationContext();
        public frmClientRecieptTransaction()
        {
            InitializeComponent();
        }
        private void M_GetContractList()
        {

            dgvContractList.DataSource = null;
            using (DataSet dt = ComputationContext.GetContractList())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    dgvContractList.DataSource = dt.Tables[0];
                }

            }
        }
        private void M_GetContractList(string refid)
        {

            dgvReceiptList.DataSource = null;
            using (DataSet dt = ComputationContext.GetReceiptByRefId(refid))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    dgvReceiptList.DataSource = dt.Tables[0];
                }

            }
        }

        private void frmClientRecieptTransaction_Load(object sender, EventArgs e)
        {
            M_GetContractList();
        }

        private void dgvContractList_SelectionChanged(object sender, EventArgs e)
        {
            if (dgvContractList.Rows.Count > 0)
            {
                M_GetContractList(Convert.ToString(dgvContractList.CurrentRow.Cells["RefId"].Value));
            }
        }

        private void dgvReceiptList_CellClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                if (this.dgvReceiptList.Columns[e.ColumnIndex].Name == "ColPrint")
                {
                    bool IsNoOR = false;

                    if (string.IsNullOrEmpty(Convert.ToString(dgvReceiptList.CurrentRow.Cells["CompanyORNo"].Value)) && !string.IsNullOrEmpty(Convert.ToString(dgvReceiptList.CurrentRow.Cells["CompanyPRNo"].Value)))
                    {
                        IsNoOR = true;
                    }
                    else if (!string.IsNullOrEmpty(Convert.ToString(dgvReceiptList.CurrentRow.Cells["CompanyORNo"].Value)) && string.IsNullOrEmpty(Convert.ToString(dgvReceiptList.CurrentRow.Cells["CompanyPRNo"].Value)))
                    {
                        IsNoOR = false;
                    }
                    else if (!string.IsNullOrEmpty(Convert.ToString(dgvReceiptList.CurrentRow.Cells["CompanyORNo"].Value)) && !string.IsNullOrEmpty(Convert.ToString(dgvReceiptList.CurrentRow.Cells["CompanyPRNo"].Value)))
                    {
                        IsNoOR = false;
                    }

                    frmRecieptSelection forms = new frmRecieptSelection(Convert.ToString(dgvReceiptList.CurrentRow.Cells["TranID"].Value), Convert.ToString(dgvReceiptList.CurrentRow.Cells["RefId"].Value));
                    forms.IsNoOR = IsNoOR;

                    forms.ShowDialog();
                }
                else if (this.dgvReceiptList.Columns[e.ColumnIndex].Name == "ColEditOR")
                {
                    frmEditORNumber forms = new frmEditORNumber();
                    forms.RcptID = Convert.ToString(dgvReceiptList.CurrentRow.Cells["RcptID"].Value);
                    forms.ShowDialog();
                    if (forms.IsProceed)
                    {
                        M_GetContractList();
                    }
                }
                //else if (this.dgvList.Columns[e.ColumnIndex].Name == "ColLedger")
                //{
                //    frmClosedClientTransaction forms = new frmClosedClientTransaction();
                //    forms.ComputationRecid = Convert.ToInt32(dgvList.CurrentRow.Cells["RecId"].Value);
                //    forms.ClientId = Convert.ToString(dgvList.CurrentRow.Cells["ClientID"].Value);
                //    forms.ShowDialog();
                //}
            }
        }
    }
}
