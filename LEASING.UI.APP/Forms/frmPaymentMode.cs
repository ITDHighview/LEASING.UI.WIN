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
    public partial class frmPaymentMode : Form
    {
        PaymentContext PaymentContext = new PaymentContext();
        public bool IsProceed = false;
        public string CompanyORNo { get; set; }
        public string BankAccountName { get; set; }
        public string BankAccountNumber { get; set; }
        public string BankName { get; set; }
        public string SerialNo { get; set; }
        public string PaymentRemarks { get; set; }
        public string REF { get; set; }
        public int ModeType { get; set; }
        public frmPaymentMode()
        {
            InitializeComponent();
        }
        private string _strPaymentmMode;
        public string strPaymentmMode
        {
            get
            {
                return _strPaymentmMode;
            }
            set
            {
                _strPaymentmMode = value;
                switch (_strPaymentmMode)
                {
                    case "CASE":

                        txtCompanyORNo.Enabled = true;
                        txtReferrence.Enabled = false;
                        txtBankName.Enabled = false;
                        txtBankAccountName.Enabled = false;
                        txtBankAccountNo.Enabled = false;
                        txtSerialNo.Enabled = false;

                        break;
                    case "BANK":
                        txtCompanyORNo.Enabled = true;
                        txtReferrence.Enabled = true;
                        txtBankName.Enabled = true;
                        txtBankAccountName.Enabled = true;
                        txtBankAccountNo.Enabled = true;
                        txtSerialNo.Enabled = false;

                        break;
                    case "PDC":
                        txtCompanyORNo.Enabled = true;
                        txtReferrence.Enabled = false;
                        txtBankName.Enabled = true;
                        txtBankAccountName.Enabled = true;
                        txtBankAccountNo.Enabled = true;
                        txtSerialNo.Enabled = true;

                        break;

                    default:
                        break;
                }
            }
        }

        private void ClearFields()
        {
            txtCompanyORNo.Text = string.Empty;
            txtReferrence.Text = string.Empty;
            txtBankName.Text = string.Empty;
            txtBankAccountName.Text = string.Empty;
            txtBankAccountNo.Text = string.Empty;
            txtSerialNo.Text = string.Empty;
        }
        private void M_GetSelectPaymentMode()
        {

            ddlSelectMode.DataSource = null;
            using (DataSet dt = PaymentContext.GetSelectPaymentMode())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    ddlSelectMode.DisplayMember = "Mode";
                    ddlSelectMode.ValueMember = "ModeType";
                    ddlSelectMode.DataSource = dt.Tables[0];
                }
            }
        }

        private void frmPaymentMode_Load(object sender, EventArgs e)
        {
            ClearFields();
            M_GetSelectPaymentMode();
        }

        private void ddlSelectMode_SelectedIndexChanged(object sender, Telerik.WinControls.UI.Data.PositionChangedEventArgs e)
        {
            if (Convert.ToInt32(ddlSelectMode.SelectedValue) == 1)
            {
                strPaymentmMode = "CASE";
            }
            else if (Convert.ToInt32(ddlSelectMode.SelectedValue) == 2)
            {
                strPaymentmMode = "BANK";
            }
            else
            {
                strPaymentmMode = "PDC";
            }
        }

        private void btnOk_Click(object sender, EventArgs e)
        {
            IsProceed = true;
            if (ddlSelectMode.SelectedIndex > 0)
            {
                ModeType = Convert.ToInt32(ddlSelectMode.SelectedValue);
            }
                 CompanyORNo = txtCompanyORNo.Text;
                BankAccountName = txtBankAccountName.Text;
                BankAccountNumber = txtBankAccountNo.Text;
                BankName = txtBankName.Text;
                SerialNo = txtSerialNo.Text;
                PaymentRemarks = txtRemarks.Text;
                REF = txtReferrence.Text;
            this.Close();
        }
    }
}
