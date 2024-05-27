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
        private PaymentContext _payment;
        public frmAddBankName()
        {
            _payment = new PaymentContext();
            InitializeComponent();
        }
        enum ModeStatus
        {
            NEW,
            READ          
        }
        private string _FormMode;
        public string FormMode
        {
            get
            {
                return _FormMode;
            }
            set
            {
                _FormMode = value;
                switch (_FormMode)
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
        private void SaveBankName()
        {
            try
            {
                string result = _payment.SaveBankNameInfo(this.txtBankName.Text);
                if (result.Equals("SUCCESS"))
                {
                    Functions.MessageShow("New Bank Name has been added successfully !");
                    this.FormMode = ModeStatus.READ.ToString();
                    this.GetBankNameBrowse();
                }
                else
                {                   
                    Functions.MessageShow(result);
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("SaveBankName()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("SaveBankName()", ex.ToString());
            }
        }
        private void DeleteBankName()
        {
            try
            {
                string result = _payment.DeleteBankName(Convert.ToString(dgvList.CurrentRow.Cells["BankName"].Value));
                if (result.Equals("SUCCESS"))
                {
                    Functions.MessageShow("Deleted successfully !");
                    this.FormMode = ModeStatus.READ.ToString();
                    this.GetBankNameBrowse();
                }
                else
                {
                    Functions.MessageShow(result);
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("DeleteBankName()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("DeleteBankName()", ex.ToString());
            }
        }

        private void GetBankNameBrowse()
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
                Functions.LogError("GetBankNameBrowse()", "Bank Name", ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("GetBankNameBrowse()", ex.ToString());
            }
        }
        private void frmAddBankName_Load(object sender, EventArgs e)
        {
            this.FormMode = ModeStatus.READ.ToString();
            this.GetBankNameBrowse();
        }

        private void btnNew_Click(object sender, EventArgs e)
        {
            this.FormMode = ModeStatus.NEW.ToString();
        }

        private void btnUndo_Click(object sender, EventArgs e)
        {
            this.FormMode = ModeStatus.READ.ToString();
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (this._isValid())
            {
                if (Functions.MessageConfirm("Are you sure you want to add this Bank Name ?") == DialogResult.Yes)
                {
                    this.SaveBankName();
                }
            }
        }

        private void dgvList_CellClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                if (this.dgvList.Columns[e.ColumnIndex].Name == "ColRemoved")
                {
                    if (Functions.MessageConfirm("Are you sure you want to delete this Bank Name ?") == DialogResult.Yes)
                    {
                        this.DeleteBankName();
                    }
                }       
            }
        }
    }
}
