using LEASING.UI.APP.Common;
using LEASING.UI.APP.Context;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;
using Telerik.WinControls;

namespace LEASING.UI.APP.Forms
{
    public partial class frmPaymentMode : Form
    {
        PaymentContext PaymentContext = new PaymentContext();
        public bool IsProceed = false;
        public string CompanyORNo { get; set; }
        public string CompanyPRNo { get; set; }
        public string BankAccountName { get; set; }
        public string BankAccountNumber { get; set; }
        public string BankName { get; set; }
        public string BankBranch { get; set; }
        public string SerialNo { get; set; }
        public string PaymentRemarks { get; set; }
        public string REF { get; set; }
        public string ModeType { get; set; }
        public string XML { get; set; }

        public bool IsOR { get; set; } = false;

        public bool IsPartialPayment = false;
        public string Amount = string.Empty;
        public int recid = 0;
        int DayCount = 0;
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
                    case "CASH":

                        txtCompanyORNo.Enabled = true;
                        txtPRNo.Enabled = true;
                        txtReferrence.Enabled = false;
                        ddlbankName.Enabled = false;
                        txtBankAccountName.Enabled = false;
                        txtBankBranch.Enabled = false;
                        txtBankAccountNo.Enabled = false;
                        txtSerialNo.Enabled = false;
                        ddlbankName.Text = string.Empty;
                        ddlbankName.SelectedIndex = -1;

                        break;
                    case "BANK":
                        txtCompanyORNo.Enabled = true;
                        txtPRNo.Enabled = true;
                        txtReferrence.Enabled = true;
                        ddlbankName.Enabled = true;
                        txtBankAccountName.Enabled = true;
                        txtBankAccountNo.Enabled = true;
                        txtSerialNo.Enabled = false;
                        txtBankBranch.Enabled = true;

                        break;
                    case "PDC":
                        txtCompanyORNo.Enabled = true;
                        txtPRNo.Enabled = true;
                        txtReferrence.Enabled = false;
                        ddlbankName.Enabled = true;
                        txtBankAccountName.Enabled = true;
                        txtBankAccountNo.Enabled = true;
                        txtBankBranch.Enabled = true;
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
            txtPRNo.Text = string.Empty;
            txtReferrence.Text = string.Empty;
            ddlbankName.Text = string.Empty;
            ddlbankName.SelectedIndex = 0;
            txtBankBranch.Text = string.Empty;
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
        private void M_GetSelectBanknName()
        {

            ddlbankName.DataSource = null;
            using (DataSet dt = PaymentContext.GetSelectBankName())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    ddlbankName.DisplayMember = "BankName";
                    ddlbankName.ValueMember = "BankName";
                    ddlbankName.DataSource = dt.Tables[0];
                }
            }
        }

        private void M_GetLedgerListOnQue()
        {

            dgvLedgerList.DataSource = null;
            using (DataSet dt = PaymentContext.GetLedgerListOnQue(XML))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {

                    dgvLedgerList.DataSource = dt.Tables[0];
                }
            }
        }
        private void M_GetLedgerListOnQueTotalAMount()
        {

            txtPaidAmount.Text = string.Empty;
            using (DataSet dt = PaymentContext.GetLedgerListOnQueTotalAMount(XML))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {

                    txtPaidAmount.Text = Convert.ToString(dt.Tables[0].Rows[0]["TOTAL_AMOUNT"]);
                }
            }
        }


        private bool IsValid()
        {
            if (string.IsNullOrEmpty(txtReceiveAmount.Text))
            {
                Functions.MessageShow("Recieve Amount cannot be empty.");
                return false;
            }
            if (decimal.Parse(txtReceiveAmount.Text) > decimal.Parse(txtPaidAmount.Text))
            {
                Functions.MessageShow("Recieve Amount cannot be greater then Due Amount.");
                return false;
            }
            if (string.IsNullOrEmpty(txtCompanyORNo.Text.Trim()) && IsOR == false)
            {
                MessageBox.Show("Please Provide OR Number or PR Number", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return false;
            }
            if (!string.IsNullOrEmpty(txtCompanyORNo.Text.Trim()))
            {
                if (M_CheckOrNumber())
                {
                    MessageBox.Show("This OR Number: " + txtCompanyORNo.Text.Trim() + " is already exist!", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    return false;
                }
            }
            if (!string.IsNullOrEmpty(txtPRNo.Text.Trim()))
            {
                if (M_CheckPRNumber())
                {
                    MessageBox.Show("This PR Number: " + txtPRNo.Text.Trim() + " is already exist!", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    return false;
                }
            }

            return true;
        }
        private bool M_CheckOrNumber()
        {

            bool IsExist = false;
            using (DataSet dt = PaymentContext.GetCheckOrNumber(txtCompanyORNo.Text.Trim()))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {

                    IsExist = Convert.ToBoolean(dt.Tables[0].Rows[0]["IsExist"]);
                }
                else
                {
                    IsExist = false;
                }
            }
            return IsExist;
        }
        private bool M_CheckPRNumber()
        {

            bool IsExist = false;
            using (DataSet dt = PaymentContext.GetCheckPRNumber(txtPRNo.Text.Trim()))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {

                    IsExist = Convert.ToBoolean(dt.Tables[0].Rows[0]["IsExist"]);
                }
                else
                {
                    IsExist = false;
                }
            }
            return IsExist;
        }

        private void frmPaymentMode_Load(object sender, EventArgs e)
        {
            ClearFields();
            M_GetSelectPaymentMode();
            M_GetSelectBanknName();
            M_GetLedgerListOnQue();
            M_GetLedgerListOnQueTotalAMount();
            ddlbankName.Text = string.Empty;
            ddlbankName.SelectedIndex = -1;
        }

        private void ddlSelectMode_SelectedIndexChanged(object sender, Telerik.WinControls.UI.Data.PositionChangedEventArgs e)
        {
            strPaymentmMode = Convert.ToString(ddlSelectMode.SelectedValue);
        }

        private void btnOk_Click(object sender, EventArgs e)
        {
            if (IsValid())
            {
                if (decimal.Parse(txtReceiveAmount.Text) != decimal.Parse(txtPaidAmount.Text))
                {
                    if (Functions.MessageConfirm("Due amount is not equal to Recieve amount, would you like to pay as Partial payment?.") == DialogResult.Yes)
                    {
                        IsProceed = true;
                        if (ddlSelectMode.SelectedIndex > 0)
                        {
                            ModeType = Convert.ToString(ddlSelectMode.SelectedValue);
                        }
                        CompanyORNo = txtCompanyORNo.Text;
                        CompanyPRNo = txtPRNo.Text;
                        BankAccountName = txtBankAccountName.Text;
                        BankAccountNumber = txtBankAccountNo.Text;
                        BankName = ddlbankName.Text;
                        SerialNo = txtSerialNo.Text;
                        PaymentRemarks = txtRemarks.Text;
                        REF = txtReferrence.Text;
                        BankBranch = txtBankBranch.Text;
                        this.Close();


                    }
                }
                else
                {
                    if (Functions.MessageConfirm("Are you sure you want to proceed the payment?.") == DialogResult.Yes)
                    {
                        IsProceed = true;
                        if (ddlSelectMode.SelectedIndex > 0)
                        {
                            ModeType = Convert.ToString(ddlSelectMode.SelectedValue);
                        }
                        CompanyORNo = txtCompanyORNo.Text;
                        CompanyPRNo = txtPRNo.Text;
                        BankAccountName = txtBankAccountName.Text;
                        BankAccountNumber = txtBankAccountNo.Text;
                        BankName = ddlbankName.Text;
                        SerialNo = txtSerialNo.Text;
                        PaymentRemarks = txtRemarks.Text;
                        REF = txtReferrence.Text;
                        BankBranch = txtBankBranch.Text;
                        this.Close();

                    }
                }
               
            }
        }

        private void txtPRNo_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtPRNo.Text))
            {
                IsOR = true;
            }
            else
            {
                IsOR = false;
            }
        }

        private void txtPaidAmount_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void txtReceiveAmount_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void txtPenaltyAmount_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void dgvLedgerList_CellFormatting(object sender, Telerik.WinControls.UI.CellFormattingEventArgs e)
        {
            if (!string.IsNullOrEmpty(Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value)))
            {
      
                 if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "PENDING")
                {
                    e.CellElement.ForeColor = Color.Black;
                    e.CellElement.DrawFill = true;
                    e.CellElement.GradientStyle = GradientStyles.Solid;
                    e.CellElement.BackColor = Color.Yellow;
                }
                else if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "FOR PAYMENT")
                {
                    e.CellElement.ForeColor = Color.White;
                    e.CellElement.DrawFill = true;
                    e.CellElement.GradientStyle = GradientStyles.Solid;
                    e.CellElement.BackColor = Color.Red;
                }
                else if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "HOLD")
                {
                    e.CellElement.ForeColor = Color.White;
                    e.CellElement.DrawFill = true;
                    e.CellElement.GradientStyle = GradientStyles.Solid;
                    e.CellElement.BackColor = Color.Red;
                }
            }
        }
    }
}
