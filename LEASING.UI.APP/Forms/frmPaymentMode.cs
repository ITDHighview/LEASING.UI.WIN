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
        private PaymentContext _payment = new PaymentContext();
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
        public bool IsHold { get; set; } = false;
        public bool IsClearPDC { get; set; } = false;
        public string Amount = string.Empty;
        public int recid = 0;
        int DayCount = 0;
        public string RecieptDate { get; set; }

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
                        txtSerialNo.Enabled = true;
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
                    case "DC":
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
            try
            {
                ddlSelectMode.DataSource = null;
                using (DataSet dt = _payment.GetSelectPaymentMode())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        ddlSelectMode.DisplayMember = "Mode";
                        ddlSelectMode.ValueMember = "ModeType";
                        ddlSelectMode.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_GetSelectPaymentMode()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_GetSelectPaymentMode()", ex.ToString());
            }
        }
        private void M_GetSelectBanknName()
        {
            try
            {
                ddlbankName.DataSource = null;
                using (DataSet dt = _payment.GetBankNameBrowse())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        ddlbankName.DisplayMember = "BankName";
                        ddlbankName.ValueMember = "BankName";
                        ddlbankName.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_GetSelectBanknName()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_GetSelectBanknName()", ex.ToString());
            }
        }

        private void M_GetLedgerListOnQue()
        {
            try
            {
                dgvLedgerList.DataSource = null;
                using (DataSet dt = _payment.GetLedgerListOnQue(XML))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {

                        dgvLedgerList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_GetLedgerListOnQue()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_GetLedgerListOnQue()", ex.ToString());
            }
        }
        private void M_GetLedgerListOnQueTotalAMount()
        {

            txtPaidAmount.Text = string.Empty;
            try
            {
                using (DataSet dt = _payment.GetLedgerListOnQueTotalAMount(XML))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {

                        txtPaidAmount.Text = Convert.ToString(dt.Tables[0].Rows[0]["TOTAL_AMOUNT"]);
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_GetLedgerListOnQueTotalAMount()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_GetLedgerListOnQueTotalAMount()", ex.ToString());
            }
        }
        private bool IsPassValidation()
        {
            if (!chkHold.IsChecked)
            {
                if (string.IsNullOrEmpty(txtReceiveAmount.Text))
                {
                    Functions.MessageShow("Recieve Amount cannot be empty.");
                    return false;
                }
                if (Functions.ConvertStringToDecimal(txtReceiveAmount.Text) > Functions.ConvertStringToDecimal(txtPaidAmount.Text))
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
                    if (this.IsORExist())
                    {
                        MessageBox.Show("This OR Number: " + txtCompanyORNo.Text.Trim() + " is already exist!", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        return false;
                    }
                }
                if (!string.IsNullOrEmpty(txtPRNo.Text.Trim()))
                {
                    if (this.IsPRExist())
                    {
                        MessageBox.Show("This PR Number: " + txtPRNo.Text.Trim() + " is already exist!", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        return false;
                    }
                }
            }


            return true;
        }
        private bool IsORExist()
        {
            try
            {
                using (DataSet dt = _payment.GetCheckOrNumber(txtCompanyORNo.Text.Trim()))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {

                        return Convert.ToBoolean(dt.Tables[0].Rows[0]["IsExist"]);
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("IsORExist()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("IsORExist()", ex.ToString());
            }
            return false;
        }
        private bool IsPRExist()
        {
            try
            {
                using (DataSet dt = _payment.GetCheckPRNumber(txtPRNo.Text.Trim()))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {

                        return Convert.ToBoolean(dt.Tables[0].Rows[0]["IsExist"]);
                    }

                }
            }
            catch (Exception ex)
            {
                Functions.LogError("IsPRExist()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("IsPRExist()", ex.ToString());
            }
            return false;
        }
        private void OnInitialized()
        {
            this.ClearFields();
            this.M_GetSelectPaymentMode();
            this.M_GetSelectBanknName();
            this.M_GetLedgerListOnQue();
            this.M_GetLedgerListOnQueTotalAMount();
            this.dtpRecieptDate.Text = DateTime.Now.ToString("MM/dd/yyyy");

            this.IsClearPDC = false;
            this.IsHold = true;
            //this.ddlbankName.Text = string.Empty;
            //this.ddlbankName.SelectedIndex = -1;
            //this.radGroupBoxPDCStatus.Visible = false;

        }
        private string SelectModeOfPayment()
        {
            strPaymentmMode = Convert.ToString(ddlSelectMode.SelectedValue);
            if (strPaymentmMode == "PDC")
            {
                this.radGroupBoxPDCStatus.Visible = true;
                this.chkHold.IsChecked = true;
                this.chkClearPDC.IsChecked = false;
                this.radLabel8.Visible = false;
                this.txtRemarks.Visible = false;
                this.txtReceiveAmount.Text = txtPaidAmount.Text;
                this.btnOk.Text = "SAVE TRANSACTION>>>";
                this.txtReceiveAmount.Focus();
            }
            else
            {
                this.radGroupBoxPDCStatus.Visible = false;
                this.chkHold.IsChecked = false;
                this.chkClearPDC.IsChecked = false;
                this.radLabel8.Visible = true;
                this.txtRemarks.Visible = true;
                //this.txtReceiveAmount.Text = string.Empty;
                this.btnOk.Text = "PROCEED PAYMENT>>>";

                this.txtReceiveAmount.Focus();
            }
            return strPaymentmMode;
        }
        private void frmPaymentMode_Load(object sender, EventArgs e)
        {
            Functions.EventCapturefrmName(this);
            this.OnInitialized();
        }
        private void ddlSelectMode_SelectedIndexChanged(object sender, Telerik.WinControls.UI.Data.PositionChangedEventArgs e)
        {
            this.SelectModeOfPayment();
        }
        private void FormClose()
        {
            this.Close();
        }
        private void BindPaymentInfo()
        {

            this.ModeType = this.SelectModeOfPayment();
            this.CompanyORNo = this.txtCompanyORNo.Text;
            this.CompanyPRNo = this.txtPRNo.Text;
            this.BankAccountName = this.txtBankAccountName.Text;
            this.BankAccountNumber = this.txtBankAccountNo.Text;
            this.BankName = this.ddlbankName.Text;
            this.SerialNo = this.txtSerialNo.Text;
            this.PaymentRemarks = this.txtRemarks.Text;
            this.REF = this.txtReferrence.Text;
            this.BankBranch = this.txtBankBranch.Text;
            //this.IsHold = chkHold.IsChecked;
            //this.IsClearPDC = chkClearPDC.IsChecked;
            this.RecieptDate = dtpRecieptDate.Text;

        }
        private void SavePaymentInfo()
        {
            if (!this.IsProceed)
            {
                return;
            }

            this.BindPaymentInfo();
            this.FormClose();

        }

        private bool IsAmountValid()
        {
            bool AmountIsValid = false;

            var notEqual = Functions.ConvertStringToDecimal(txtReceiveAmount.Text) != Functions.ConvertStringToDecimal(txtPaidAmount.Text);

            if (!notEqual)
            {
                return false;
            }

            AmountIsValid = Functions.ConvertStringToDecimal(txtReceiveAmount.Text) < Functions.ConvertStringToDecimal(txtPaidAmount.Text) || Functions.ConvertStringToDecimal(txtReceiveAmount.Text) == Functions.ConvertStringToDecimal(txtPaidAmount.Text);

            return AmountIsValid;
        }

        private bool IsPaymentforPartial()
        {
            bool IsValidForPartialPayment = false;
            if (!this.IsAmountValid())
            {
                return false;
            }
            IsValidForPartialPayment = Functions.ConvertStringToDecimal(txtReceiveAmount.Text) < Functions.ConvertStringToDecimal(txtPaidAmount.Text);
            return IsValidForPartialPayment;
        }

        private string PaymentMessageInfo()
        {
            if (this.strPaymentmMode == "PDC")
            {
                if (chkHold.IsChecked == true)
                {
                    return "Are you sure you want to save this transaction?.";
                }
                else if (chkHold.IsChecked == false && chkClearPDC.IsChecked == true)
                {
                    if (this.IsPaymentforPartial())
                    {
                        return "Due amount is greater than  Recieve amount, would you like to pay as Partial payment?.";
                    }
                    else
                    {
                        return "Are you sure you want to proceed the payment?.";
                    }
                }
            }
            else
            {
                return "Are you sure you want to proceed the payment?.";
            }
           

            return "";
        }
        private void ProceedToPayment()
        {
            if (this.IsPassValidation())
            {
                if (Functions.MessageConfirm(this.PaymentMessageInfo()) == DialogResult.No)
                {
                    Functions.GetNotification("PAYMENT", "Payment Cancel.");
                    return;
                }

                this.IsProceed = true;
                this.SavePaymentInfo();
            }
        }
        private void btnOk_Click(object sender, EventArgs e)
        {
            this.ProceedToPayment();
        }

        private void txtPRNo_TextChanged(object sender, EventArgs e)
        {
            this.IsOR = !string.IsNullOrEmpty(txtPRNo.Text) ? true : false;
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



        private void dgvLedgerList_SelectionChanged(object sender, EventArgs e)
        {
            if (dgvLedgerList.Rows.Count >= 0 && Convert.ToString(dgvLedgerList.CurrentRow.Cells["PaymentStatus"].Value) == "HOLD")
            {
                ddlSelectMode.SelectedValue = Convert.ToString(dgvLedgerList.CurrentRow.Cells["ModeType"].Value);
                txtCompanyORNo.Text = Convert.ToString(dgvLedgerList.CurrentRow.Cells["CompanyORNo"].Value);
                txtPRNo.Text = Convert.ToString(dgvLedgerList.CurrentRow.Cells["CompanyPRNo"].Value);
                txtReferrence.Text = Convert.ToString(dgvLedgerList.CurrentRow.Cells["REF"].Value);
                ddlbankName.SelectedValue = Convert.ToString(dgvLedgerList.CurrentRow.Cells["BNK_NAME"].Value);
                txtBankBranch.Text = Convert.ToString(dgvLedgerList.CurrentRow.Cells["BankBranch"].Value);
                txtBankAccountName.Text = Convert.ToString(dgvLedgerList.CurrentRow.Cells["BNK_ACCT_NAME"].Value);
                txtBankAccountNo.Text = Convert.ToString(dgvLedgerList.CurrentRow.Cells["BNK_ACCT_NUMBER"].Value);
                txtSerialNo.Text = Convert.ToString(dgvLedgerList.CurrentRow.Cells["SERIAL_NO"].Value);
            }
        }

        private void chkHold_Click(object sender, EventArgs e)
        {
            chkClearPDC.IsChecked = false;
            IsClearPDC = false;
            IsHold = true;
            this.radLabel8.Visible = false;
            this.txtRemarks.Visible = false;
            btnOk.Text = "SAVE TRANSACTION>>>";
        }

        private void chkClearPDC_Click(object sender, EventArgs e)
        {
            chkHold.IsChecked = false;
            IsClearPDC = true;
            IsHold = false;
            this.radLabel8.Visible = true;
            this.txtRemarks.Visible = true;
            btnOk.Text = "PROCEED PAYMENT>>>";
        }
    }
}
