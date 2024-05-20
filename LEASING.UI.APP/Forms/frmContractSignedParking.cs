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
    public partial class frmContractSignedParking : Form
    {
        PaymentContext PaymentContext = new PaymentContext();
        ClientContext ClientContext = new ClientContext();
        public bool IsContractSigned { get; set; } = true;
        public string ReferenceId { get; set; } = string.Empty;
        public frmContractSignedParking()
        {
            InitializeComponent();
        }
        private void M_GetForContractSignedParkingList()
        {
            try
            {
                dgvList.DataSource = null;
                using (DataSet dt = PaymentContext.GetForContractSignedParkingList())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        dgvList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogErrorIntoStoredProcedure("M_GetForContractSignedParkingList()", this.Text, ex.Message, DateTime.Now, this);

                Functions.MessageShow("An error occurred : (" + ex.ToString() + ") Please check the [ErrorLog] ");
            }

        }
        private void dgvList_CellClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                if (this.dgvList.Columns[e.ColumnIndex].Name == "ColApproved")
                {
                    frmEditClient forms = new frmEditClient();
                    forms.ClientID = Convert.ToString(dgvList.CurrentRow.Cells["ClientID"].Value);
                    forms.IsContractSigned = IsContractSigned;
                    forms.ReferenceId = Convert.ToString(dgvList.CurrentRow.Cells["RefId"].Value);
                    forms.ShowDialog();
                    M_GetForContractSignedParkingList();
                }
                else if (this.dgvList.Columns[e.ColumnIndex].Name == "ColByPass")
                {
                    if (MessageBox.Show("Are you sure you want to approved?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                    {
                        try
                        {
                            var result = ClientContext.ConrtactSignedByPass(Convert.ToString(dgvList.CurrentRow.Cells["RefId"].Value));
                            if (result.Equals("SUCCESS"))
                            {
                                MessageBox.Show("Approved Successfully!", "System Message");
                                M_GetForContractSignedParkingList();
                            }
                            else
                            {
                                MessageBox.Show(result, "System Message");
                            }
                        }
                        catch (Exception ex)
                        {
                            Functions.LogErrorIntoStoredProcedure("Cell Click : ColByPass", this.Text, ex.Message, DateTime.Now, this);

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
        private void btnRefresh_Click(object sender, EventArgs e)
        {
            M_GetForContractSignedParkingList();
        }
        private void frmContractSignedParking_Load(object sender, EventArgs e)
        {
            M_GetForContractSignedParkingList();
        }
    }
}
