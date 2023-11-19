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
    public partial class frmAddBankName : Form
    {
        PaymentContext PaymentContext = new PaymentContext();
        public frmAddBankName()
        {
            InitializeComponent();
        }
        private string _strBankNameFormMode;
        public string strBankNameFormMode
        {
            get
            {
                return _strBankNameFormMode;
            }
            set
            {
                _strBankNameFormMode = value;
                switch (_strBankNameFormMode)
                {
                    case "NEW":
                        btnUndo.Enabled = true;
                        btnSave.Enabled = true;
                        txtBankName.Enabled = true;
                        btnNew.Enabled = false;
                        txtBankName.Text = string.Empty;

                        break;
                    case "READ":
                        btnUndo.Enabled = false;
                        btnSave.Enabled = false;
                        txtBankName.Enabled = false;
                        btnNew.Enabled = true;
                        txtBankName.Text = string.Empty;
                        break;

                    default:
                        break;
                }
            }
        }
        private bool IsValid()
        {
            if (string.IsNullOrEmpty(txtBankName.Text))
            {
                MessageBox.Show("Bank Name cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            //if (string.IsNullOrEmpty(txtLocAddress.Text))
            //{
            //    MessageBox.Show("Address cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            //    return false;
            //}
            return true;
        }
        private void SaveBankName()
        {
            try
            {
                string result = PaymentContext.SaveNewBankName(txtBankName.Text);
                if (result.Equals("SUCCESS"))
                {
                    MessageBox.Show("New Bank Name has been added successfully !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    strBankNameFormMode = "READ";
                    M_GetBankNameList();
                }
                else
                {
                    MessageBox.Show(result, "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }
        private void DeleteBankName()
        {
            try
            {
                string result = PaymentContext.DeleteBankName(Convert.ToString(dgvList.CurrentRow.Cells["BankName"].Value));
                if (result.Equals("SUCCESS"))
                {
                    MessageBox.Show("Deleted successfully !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    strBankNameFormMode = "READ";
                    M_GetBankNameList();
                }
                else
                {
                    MessageBox.Show(result, "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void M_GetBankNameList()
        {
            dgvList.DataSource = null;
            using (DataSet dt = PaymentContext.GetSelectBankName())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    dgvList.DataSource = dt.Tables[0];
                }
            }
        }
        private void frmAddBankName_Load(object sender, EventArgs e)
        {
            strBankNameFormMode = "READ";
            M_GetBankNameList();
        }

        private void btnNew_Click(object sender, EventArgs e)
        {
            strBankNameFormMode = "NEW";
        }

        private void btnUndo_Click(object sender, EventArgs e)
        {
            strBankNameFormMode = "READ";
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (IsValid())
            {
                if (MessageBox.Show("Are you sure you want to add this Bank Name ?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                {
                    SaveBankName();
                }
            }
        }

        private void dgvList_CellClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                if (this.dgvList.Columns[e.ColumnIndex].Name == "ColRemoved")
                {
                    if (MessageBox.Show("Are you sure you want to delete this Bank Name ?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                    {
                        DeleteBankName();
                    }
                }       
            }
        }
    }
}
