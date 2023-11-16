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
    public partial class frmClosedContracts : Form
    {
        PaymentContext PaymentContext = new PaymentContext();

        public frmClosedContracts()
        {
            InitializeComponent();
        }
        private void M_GetClosedContracts()
        {
            dgvList.DataSource = null;
            using (DataSet dt = PaymentContext.GetClosedContracts())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    dgvList.DataSource = dt.Tables[0];
                }
            }
        }

        private void frmClosedContracts_Load(object sender, EventArgs e)
        {
            M_GetClosedContracts();
        }

        private void dgvList_CellClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                if (this.dgvList.Columns[e.ColumnIndex].Name == "ColViewFile")
                {
                    frmGetContactSignedDocumentsByReference forms = new frmGetContactSignedDocumentsByReference();
                    forms.ClientID = Convert.ToString(dgvList.CurrentRow.Cells["ClientID"].Value);                
                    forms.ReferenceID = Convert.ToString(dgvList.CurrentRow.Cells["RefId"].Value);
                    forms.ShowDialog();                 
                }
                else if (this.dgvList.Columns[e.ColumnIndex].Name == "ColView")
                {
                    frmEditUnitComputation forms = new frmEditUnitComputation();
                    forms.Recid = Convert.ToInt32(dgvList.CurrentRow.Cells["RecId"].Value);
                    forms.ShowDialog();
                }
                else if (this.dgvList.Columns[e.ColumnIndex].Name == "ColLedger")
                {
                    frmClosedClientTransaction forms = new frmClosedClientTransaction();
                    forms.ComputationRecid = Convert.ToInt32(dgvList.CurrentRow.Cells["RecId"].Value);
                    forms.ClientId  = Convert.ToString(dgvList.CurrentRow.Cells["ClientID"].Value);
                    forms.ShowDialog();
                }          
            }
        }
    }
}
