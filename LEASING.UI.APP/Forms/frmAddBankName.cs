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
    public partial class frmAddBankName : Form
    {
       private PaymentContext _payment = new PaymentContext();
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
        private bool _isValid()
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
        private void _saveBankName()
        {
            try
            {
                string result = _payment.SaveBankNameInfo(this.txtBankName.Text);
                if (result.Equals("SUCCESS"))
                {
                    Functions.MessageShow("New Bank Name has been added successfully !");
                    this.strBankNameFormMode = "READ";
                    this._getBankNameBrowse();
                }
                else
                {                   
                    Functions.MessageShow(result);
                }
            }
            catch (Exception ex)
            {
                Functions.LogErrorIntoStoredProcedure("_saveBankName()", "Bank Name", ex.Message, DateTime.Now, this);

                Functions.MessageShow("An error occurred : " + ex.ToString() + " Please check the [ErrorLog] ");
            }
        }
        private void _deleteBankName()
        {
            try
            {
                string result = _payment.DeleteBankName(Convert.ToString(dgvList.CurrentRow.Cells["BankName"].Value));
                if (result.Equals("SUCCESS"))
                {
                    Functions.MessageShow("Deleted successfully !");
                    this.strBankNameFormMode = "READ";
                    this._getBankNameBrowse();
                }
                else
                {
                    Functions.MessageShow(result);
                }
            }
            catch (Exception ex)
            {
                Functions.LogErrorIntoStoredProcedure("_deleteBankName()", "Bank Name", ex.Message, DateTime.Now, this);

                Functions.MessageShow("An error occurred : " + ex.ToString() + " Please check the [ErrorLog] ");
            }
        }

        private void _getBankNameBrowse()
        {
            try
            {
                dgvList.DataSource = null;
                using (DataSet dt = _payment.GetBankNameBrowse())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        dgvList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogErrorIntoStoredProcedure("_getBankNameBrowse()", "Bank Name", ex.Message, DateTime.Now, this);

                Functions.MessageShow("An error occurred : " + ex.ToString() + " Please check the [ErrorLog] ");
            }

        }
        private void frmAddBankName_Load(object sender, EventArgs e)
        {
            this.strBankNameFormMode = "READ";
            this._getBankNameBrowse();
        }

        private void btnNew_Click(object sender, EventArgs e)
        {
            this.strBankNameFormMode = "NEW";
        }

        private void btnUndo_Click(object sender, EventArgs e)
        {
            strBankNameFormMode = "READ";
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (this._isValid())
            {
                if (MessageBox.Show("Are you sure you want to add this Bank Name ?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                {
                    this._saveBankName();
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
                        this._deleteBankName();
                    }
                }       
            }
        }
    }
}
