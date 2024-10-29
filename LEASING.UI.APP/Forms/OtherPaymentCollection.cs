using LEASING.UI.APP.Common;
using LEASING.UI.APP.Context;
using LEASING.UI.APP.Models;
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

namespace LEASING.UI.APP.Forms
{
    public partial class OtherPaymentCollection : Form
    {
        private PaymentModel _model;
        private PaymentContext _payment;
        private string _vVatPCT { get; set; } = "0.00";
        private string _vTaxPCT { get; set; } = "0.00";
        public int contractId { get; set; } = 0;
        public string contractNumber { get; set; } = string.Empty;
        public string clientNumber { get; set; } = string.Empty;
        public string transactionNumber = string.Empty;
        public decimal receiveAmount { get; set; } = 0;
        public decimal changeAmount { get; set; } = 0;

        #region ModeOfPayment
        public string _Company_OR_Number_ { get; set; } = string.Empty;
        public string _Company_PR_Number_ { get; set; } = string.Empty;
        public string _Bank_Account_Name_ { get; set; } = string.Empty;
        public string _Bank_Branch_ { get; set; } = string.Empty;
        public string _Bank_Account_Number_ { get; set; } = string.Empty;
        public string _Bank_Name_ { get; set; } = string.Empty;
        public string _Bank_Serial_No_ { get; set; } = string.Empty;
        public string _PaymentRemarks_ { get; set; } = string.Empty;
        public string _Bank_Reference_Number_ { get; set; } = string.Empty;
        public string _ModeType_ { get; set; } = string.Empty;
        public string _Company_Original_Receipt_Date_ { get; set; } = string.Empty;
        public string _Company_Check_Date_ { get; set; } = string.Empty;
        #endregion
        public OtherPaymentCollection()
        {
            _model = new PaymentModel();
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
                        btnNew.Enabled = false;
                        btnSearchClient.Enabled = true;

                        txtClientID.Enabled = true;
                        txtClientID.ReadOnly = true;
                        txtClientID.Text = string.Empty;

                        txtClientName.Enabled = true;
                        txtClientName.ReadOnly = true;
                        txtClientName.Text = string.Empty;

                        ddlTypeName.Enabled = true;
                        ddlTypeName.SelectedIndex = 0;

                        ddlUnitList.Enabled = true;
                        ddlUnitList.SelectedIndex = -1;



                        txtAmount.Enabled = true;
                        txtAmount.Text = "0.00";

                        chkIsVatApplied.Enabled = true;
                        chkIsVatApplied.Checked = true;
                        txtVatPCT.Enabled = true;
                        txtVatPCT.ReadOnly = true;
                        txtVatPCT.Text = "0.00";
                        txtVatAmount.Enabled = true;
                        txtVatAmount.ReadOnly = true;
                        txtVatAmount.Text = "0.00";

                        chkIsTaxApplied.Enabled = true;
                        chkIsTaxApplied.Checked = true;
                        txtTaxPCT.ReadOnly = true;
                        txtTaxPCT.Text = "0.00";
                        txtTaxAmount.ReadOnly = true;
                        txtTaxAmount.Text = "0.00";

                        txtTotalAmount.ReadOnly = true;
                        txtTotalAmount.Enabled = true;
                        txtTotalAmount.Text = "0.00";

                        break;
                    case "READ":
                        btnUndo.Enabled = false;
                        btnSave.Enabled = false;
                        btnNew.Enabled = true;
                        btnSearchClient.Enabled = false;

                        txtClientID.Enabled = false;
                        txtClientID.ReadOnly = true;
                        txtClientID.Text = string.Empty;

                        txtClientName.Enabled = false;
                        txtClientName.ReadOnly = true;
                        txtClientName.Text = string.Empty;

                        ddlTypeName.Enabled = false;
                        ddlTypeName.SelectedIndex = -1;

                        ddlUnitList.Enabled = false;
                        ddlUnitList.SelectedIndex = -1;

                        txtAmount.Enabled = false;
                        txtAmount.Text = "0.00";

                        chkIsVatApplied.Enabled = false;
                        chkIsVatApplied.Checked = false;
                        txtVatPCT.Enabled = false;
                        txtVatPCT.ReadOnly = true;
                        txtVatPCT.Text = "0.00";
                        txtVatAmount.Enabled = false;
                        txtVatAmount.ReadOnly = true;
                        txtVatAmount.Text = "0.00";

                        chkIsTaxApplied.Enabled = false;
                        chkIsTaxApplied.Checked = false;
                        txtTaxPCT.Enabled = false;
                        txtTaxPCT.ReadOnly = true;
                        txtTaxPCT.Text = "0.00";
                        txtTaxAmount.Enabled = false;
                        txtTaxAmount.ReadOnly = true;
                        txtTaxAmount.Text = "0.00";

                        txtTotalAmount.ReadOnly = true;
                        txtTotalAmount.Enabled = false;
                        txtTotalAmount.Text = "0.00";

                        break;

                    default:
                        break;
                }
            }
        }
        private bool _isValid()
        {
            if (string.IsNullOrEmpty(txtClientID.Text))
            {
                MessageBox.Show("Client cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            if (ddlTypeName.SelectedIndex == 0)
            {
                MessageBox.Show("Please select Payment Type !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            if (string.IsNullOrEmpty(txtAmount.Text) || txtAmount.Text == "0" || txtAmount.Text == "0.00")
            {
                MessageBox.Show("Amount cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            return true;
        }
        private void GetVatAmount()
        {
            var result = ((Functions.ConvertStringToDecimal(txtAmount.Text) * Functions.ConvertStringToDecimal(_vVatPCT)) / 100);
            txtVatAmount.Text = result.ToString("N2");
        }
        private void GetTaxAmount()
        {
            var result = ((Functions.ConvertStringToDecimal(txtAmount.Text) * Functions.ConvertStringToDecimal(_vTaxPCT)) / 100);
            txtTaxAmount.Text = result.ToString("N2");
        }
        private void RemoveVat()
        {
            txtVatPCT.Text = "0.00";
            txtVatAmount.Text = "0.00";
        }
        private void RemoveTax()
        {
            txtTaxPCT.Text = "0.00";
            txtTaxAmount.Text = "0.00";
        }
        private void ReAddVat()
        {
            GetVatAmount();
            txtVatPCT.Text = _vVatPCT;
        }
        private void ReAddTax()
        {
            GetTaxAmount();
            txtTaxPCT.Text = _vTaxPCT;
        }
        private void GetTotalAmount()
        {
            var result = ((Functions.ConvertStringToDecimal(txtAmount.Text) + Functions.ConvertStringToDecimal(txtVatAmount.Text)) - Functions.ConvertStringToDecimal(txtTaxAmount.Text));
            txtTotalAmount.Text = result.ToString("N2");
        }
        private void frmOtherPayment_Load(object sender, EventArgs e)
        {
            Functions.EventCapturefrmName(this);
            this.FormMode = ModeStatus.READ.ToString();
            GetOtherPaymentTypeList();
            GetOtherPaymentBrowse();
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
            this._savePayment();
        }

        private void _savePayment()
        {
            if (this._isValid())
            {
                if (Functions.MessageConfirm("Are you sure you want to save this Payment ?") == DialogResult.No)
                {
                    Functions.GetNotification("PAYMENT", "Payment Cancel");
                    return;

                }
                this._generateOtherPayment();
            }
        }
        private bool _checkTranIDIsEmpty()
        {
            if (string.IsNullOrEmpty(this.transactionNumber))
            {
                return true;
            }

            return false;
        }
        private void _generateOtherPayment()
        {
            if (Functions.ConvertStringToDecimal(this.txtAmount.Text) > 0)
            {
                var fPayment = new OtherPaymentModeForm();
                if (!this._initPayment(fPayment))
                {
                    return;
                }

                var fReceivePayment = new OtherPaymentReceiveCollection();
                this._recievePayment(fReceivePayment);

                this._generatePayment();

                if (this._checkTranIDIsEmpty())
                {
                    Functions.MessageShow("No transaction code is generated, Please contact system administrator");
                    return;
                }

                var fReciept = new PrintReceiptOtherPaymentCategory(this.transactionNumber, this.contractNumber, this._getPaymentLevel());
                this._initReciept(fReciept);

            }
        }
        private string _getPaymentLevel()
        {

            return "OTHER";
        }
        private void _initReciept(PrintReceiptOtherPaymentCategory pForm)
        {
            if (string.IsNullOrEmpty(this._Company_OR_Number_) && !string.IsNullOrEmpty(this._Company_PR_Number_))
            {
                pForm.IsNoOR = true;
            }
            else if (!string.IsNullOrEmpty(this._Company_OR_Number_) && string.IsNullOrEmpty(this._Company_PR_Number_))
            {
                pForm.IsNoOR = false;
            }

            pForm.ShowDialog();
            //this._getContractById();
        }
        private void _recievePayment(OtherPaymentReceiveCollection pForm)
        {
            pForm.Amount = this.txtTotalAmount.Text;
            pForm.ShowDialog();

            if (!pForm.IsProceed)
            {
                return;
            }
            //if (pForm.IsPartialPayment)
            //{
            //    this.btnPrintReciept.Enabled = false;
            //    this.IsPartialPayment = true;

            //}

            this.receiveAmount = Functions.ConvertStringToDecimal(pForm.txtReceiveAmount.Text);
            this.changeAmount = 0;
        }
        private bool _initPayment(OtherPaymentModeForm pForm)
        {
            pForm.contractId = 0;
            pForm.clientNumber = txtClientID.Text;
            pForm.ShowDialog();
            if (!pForm.IsProceed)
            {
                return false; ;
            }

            this._Company_OR_Number_ = pForm.CompanyORNo;
            this._Company_PR_Number_ = pForm.CompanyPRNo;
            this._Bank_Account_Name_ = pForm.BankAccountName;
            this._Bank_Account_Number_ = pForm.BankAccountNumber;
            this._Bank_Name_ = pForm.BankName;
            this._Bank_Serial_No_ = pForm.SerialNo;
            this._PaymentRemarks_ = pForm.PaymentRemarks;
            this._Bank_Reference_Number_ = pForm.REF;
            this._Bank_Branch_ = pForm.BankBranch;
            this._ModeType_ = pForm.ModeType;
            this._Company_Original_Receipt_Date_ = pForm.RecieptDate;
            this._Company_Check_Date_ = pForm.CheckDate;
            //this.XML = pForm.XML;
            return true;
        }
        private void _generatePayment()
        {
            try
            {
                _model.ClientID = txtClientID.Text;
                _model.OtherPaymentTypeName = Convert.ToString(ddlTypeName.SelectedValue);
                _model.OtherPaymentAmount = Functions.ConvertStringToDecimal(txtAmount.Text);
                _model.OtherPaymentVatPCT = Functions.ConvertStringToDecimal(txtVatPCT.Text);
                _model.OtherPaymentVatAmount = Functions.ConvertStringToDecimal(txtVatAmount.Text);
                _model.OtherPaymentIsVatApplied = chkIsVatApplied.Checked;
                _model.OtherPaymentTaxPCT = Functions.ConvertStringToDecimal(txtTaxPCT.Text);
                _model.OtherPaymentTaxAmount = Functions.ConvertStringToDecimal(txtTaxAmount.Text);
                _model.OtherPaymentTaxIsApplied = chkIsTaxApplied.Checked;
                _model.UnitId = Convert.ToInt32(ddlUnitList.SelectedValue);

                _model.RefId = this.contractNumber;
                _model.PaidAmount = Functions.ConvertStringToDecimal(this.txtTotalAmount.Text);
                _model.ReceiveAmount = this.receiveAmount;
                _model.ChangeAmount = this.changeAmount;
                _model.CompanyORNo = this._Company_OR_Number_;
                _model.CompanyPRNo = this._Company_PR_Number_;
                _model.BankAccountName = this._Bank_Account_Name_;
                _model.BankAccountNumber = this._Bank_Account_Number_;
                _model.BankName = this._Bank_Name_;
                _model.SerialNo = this._Bank_Serial_No_;
                _model.PaymentRemarks = this._PaymentRemarks_;
                _model.REF = this._Bank_Reference_Number_;
                _model.ModeType = this._ModeType_;
                _model.BankBranch = this._Bank_Branch_;
                _model.ReceiptDate = this._Company_Original_Receipt_Date_;
                _model.CheckDate = this._Company_Check_Date_;
                //_model.TransID = this.transactionNumber;
                string result = _payment.SaveOtherPayment(_model, out transactionNumber);

                Functions.ShowLoadingBar("Processing...");

                if (string.IsNullOrEmpty(result))
                {
                    Functions.MessageShow("Response Empty.");
                    return;
                }

                if (!result.Equals("SUCCESS"))
                {
                    Functions.MessageShow(result);
                    return;
                }

                Functions.MessageShow("Payment has been save successfully !");


                _model.ClientID = string.Empty;
                _model.OtherPaymentTypeName = string.Empty;
                _model.OtherPaymentAmount = 0;

                _model.OtherPaymentVatPCT = 0;
                _model.OtherPaymentVatAmount = 0;
                _model.OtherPaymentIsVatApplied = false;
                _model.OtherPaymentTaxPCT = 0;
                _model.OtherPaymentTaxAmount = 0;
                _model.OtherPaymentTaxIsApplied = false;
                _model.UnitId = 0;

                _model.RefId = string.Empty;
                _model.PaidAmount = 0;
                _model.ReceiveAmount = 0;
                _model.ChangeAmount = 0;
                _model.CompanyORNo = string.Empty;
                _model.CompanyPRNo = string.Empty;
                _model.BankAccountName = string.Empty;
                _model.BankAccountNumber = string.Empty;
                _model.BankName = string.Empty;
                _model.SerialNo = string.Empty;
                _model.PaymentRemarks = string.Empty;
                _model.REF = string.Empty;
                _model.ModeType = string.Empty;
                _model.BankBranch = string.Empty;
                _model.ReceiptDate = string.Empty;
                _model.CheckDate = string.Empty;


                GetOtherPaymentBrowse();
                this.FormMode = ModeStatus.READ.ToString();

            }
            catch (Exception ex)
            {
                Functions.LogError("_generatePayment()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("_generatePayment()", ex.ToString());
            }
        }
        private void GetOtherPaymentTypeList()
        {
            try
            {
                ddlTypeName.DataSource = null;
                using (DataSet dt = _payment.GetOtherPaymentTypeList())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        ddlTypeName.DataSource = dt.Tables[0];
                        ddlTypeName.ValueMember = "OtherPaymentTypeName";
                        ddlTypeName.DisplayMember = "OtherPaymentTypeName";
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("GetOtherPaymentTypeList()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("GetOtherPaymentTypeList()", ex.ToString());
            }


        }
        private void GetUnitList(string clientID)
        {
            try
            {
                ddlUnitList.DataSource = null;
                using (DataSet dt = _payment.GetUnitByClientID(clientID))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        ddlUnitList.DataSource = dt.Tables[0];
                        ddlUnitList.ValueMember = "ValueMember";
                        ddlUnitList.DisplayMember = "DisplayMember";
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("GetOtherPaymentTypeList()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("GetOtherPaymentTypeList()", ex.ToString());
            }


        }
        private void GetOtherPaymentBrowse()
        {
            try
            {
                dgvList.DataSource = null;
                using (DataSet dt = _payment.GetOtherPaymentBrowse())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        dgvList.DataSource = dt.Tables[0];

                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("GetOtherPaymentBrowse()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("GetOtherPaymentBrowse()", ex.ToString());
            }


        }
        private void GetOtherPaymentTypeRateByName()
        {
            try
            {
                _vVatPCT = "0.00";
                _vTaxPCT = "0.00";
                using (DataSet dt = _payment.GetOtherPaymentTypeRateByName(ddlTypeName.Text))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        _vVatPCT = Convert.ToString(dt.Tables[0].Rows[0]["OtherPaymentVatPCT"]);
                        _vTaxPCT = Convert.ToString(dt.Tables[0].Rows[0]["OtherPaymentTaxPCT"]);

                        txtVatPCT.Text = _vVatPCT;
                        txtTaxPCT.Text = _vTaxPCT;
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("GetOtherPaymentTypeRateByName()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("GetOtherPaymentTypeRateByName()", ex.ToString());
            }


        }
        private void txtAmount_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void txtVatPCT_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void txtVatAmount_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void txtTaxPCT_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void txtTaxAmount_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void txtAmount_TextChanged(object sender, EventArgs e)
        {
            GetVatAmount();
            GetTaxAmount();
            GetTotalAmount();
        }

        private void chkIsVatApplied_ToggleStateChanged(object sender, Telerik.WinControls.UI.StateChangedEventArgs args)
        {
            if (chkIsVatApplied.Checked == true)
            {
                ReAddVat();
                GetTotalAmount();
            }
            else
            {
                RemoveVat();
                GetTotalAmount();
            }
        }

        private void chkIsTaxApplied_ToggleStateChanged(object sender, Telerik.WinControls.UI.StateChangedEventArgs args)
        {
            if (chkIsTaxApplied.Checked == true)
            {
                ReAddTax();
                GetTotalAmount();
            }
            else
            {
                RemoveTax();
                GetTotalAmount();
            }
        }

        private void ddlTypeName_SelectedIndexChanged(object sender, Telerik.WinControls.UI.Data.PositionChangedEventArgs e)
        {
            if (ddlTypeName.SelectedIndex > 0)
            {
                GetOtherPaymentTypeRateByName();
            }
        }

        private void btnSearchClient_Click(object sender, EventArgs e)
        {
            ClientBrowse SearchClient = new ClientBrowse();
            SearchClient.ShowDialog();
            if (SearchClient.IsProceed)
            {
                this.txtClientID.Text = SearchClient.ClientID;
                this.txtClientName.Text = SearchClient.ClientName;
                this.GetUnitList(SearchClient.ClientID);
                this.txtClientID.Focus();
            }
        }
    }
}
