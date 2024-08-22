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
    public partial class frmSelectClient : Form
    {
        #region Context
        private ClientContext _client = new ClientContext();
        private ComputationContext _contract = new ComputationContext();
        private PaymentContext _payment = new PaymentContext();
        #endregion

        #region Variables
        public int contractId { get; set; } = 0;
        public string contractNumber { get; set; } = string.Empty;
        public string clientNumber { get; set; } = string.Empty;
        public string XML { get; set; } = string.Empty;
        public string transactionNumber = string.Empty;
        public string TypeOf { get; set; } = string.Empty;
        public int totalMonthlyRental { get; set; } = 0;
        public bool IsProceed { get; set; } = false;

        public decimal receiveAmount { get; set; } = 0;
        public decimal changeAmount { get; set; } = 0;
        public string _Company_OR_Number_ { get; set; } = string.Empty;
        public string _Company_PR_Number_ { get; set; } = string.Empty;
        public string _Bank_Account_Name_ { get; set; } = string.Empty;
        public string _Bank_Branch_ { get; set; } = string.Empty;
        public string _Bank_Account_Number_ { get; set; } = string.Empty;
        public string _Bank_Name_ { get; set; } = string.Empty;
        public string _Bank_Serial_No_ { get; set; } = string.Empty;
        public string paymentRemarks { get; set; } = string.Empty;
        public string _Bank_Reference_Number_ { get; set; } = string.Empty;
        public string modeType { get; set; } = string.Empty;
        private bool IsPartialPayment = false;
        public string _Company_Original_Receipt_Date_ { get; set; } = string.Empty;

        #endregion

        #region Call Methods
        private void OnInitialized()
        {
            this.FormLoadDisableControl();
            this.FormLoadReadOnlyControls();
            this._getContractById();
            this._getMonthLedgerBrowseByContractIdClientNumber();
            this.btnGenerate.Text = this.btnGenerateLable();
        }

        private string btnGenerateLableByTotalAmount() => Functions.ConvertStringToDecimal(this.txtTotalForPayment.Text) > 0 ? "PROCEED TO PAYMENT >>>" : "PROCEED >>>";
        private string btnGenerateLable() =>
                       this.TypeOf == "PARKING" ? "PROCEED >>>" : this.btnGenerateLableByTotalAmount();

        private void FormLoadReadOnlyControls()
        {
            txtTwoMonAdv.ReadOnly = true;
            txtThreeMonSecDep.ReadOnly = true;
            txtTotalForPayment.ReadOnly = true;
        }
        private void FormLoadDisableControl()
        {
            dtpFrom.Enabled = false;
            dtpTo.Enabled = false;
            btnPrintReciept.Enabled = false;
            txtAmountPaid.Enabled = false;
            txtBalanceAmount.Enabled = false;
            txtTwoMonAdv.Enabled = false;
            txtThreeMonSecDep.Enabled = false;
            txtTotalForPayment.Enabled = false;
        }
        private bool _isPaymentValid()
        {
            if (string.IsNullOrEmpty(this.clientNumber))
            {
                Functions.MessageShow("Client  cannot be empty!.");
                return false;
            }

            //if (ddlFloorType.SelectedText == "--SELECT--")
            //{
            //    MessageBox.Show("Floor Type cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            //    return false;
            //}


            return true;
        }
        private void _getMonthLedgerBrowseByContractIdClientNumber()
        {
            try
            {
                dgvLedgerList.DataSource = null;
                using (DataSet dt = _contract.GetMonthLedgerBrowseByContractIdClientNumber(this.contractId, this.clientNumber))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {

                        dgvLedgerList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("_getMonthLedgerBrowseByContractIdClientNumber()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("_getMonthLedgerBrowseByContractIdClientNumber()", ex.ToString());
            }


        }
        private void _getContractById()
        {
            try
            {
                using (DataSet dt = _contract.GetContractById(this.contractId))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        this.contractNumber = Convert.ToString(dt.Tables[0].Rows[0]["RefId"]);
                        txtClientName.Text = Convert.ToString(dt.Tables[0].Rows[0]["InquiringClient"]);
                        this.clientNumber = Convert.ToString(dt.Tables[0].Rows[0]["ClientID"]);
                        dtpFrom.Text = Convert.ToString(dt.Tables[0].Rows[0]["StatDate"]);
                        dtpTo.Text = Convert.ToString(dt.Tables[0].Rows[0]["FinishDate"]);
                        this.totalMonthlyRental = Convert.ToInt32(dt.Tables[0].Rows[0]["TotalRent"]);
                        txtTwoMonAdv.Text = Convert.ToString(dt.Tables[0].Rows[0]["TwoMonAdvance"]);
                        txtThreeMonSecDep.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecDeposit"]);
                        txtTotalForPayment.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecDeposit"]);
                        //txtTotalForPayment.Text = Convert.ToString(dt.Tables[0].Rows[0]["TotalForPayment"]);
                        txtAmountPaid.Text = Convert.ToString(dt.Tables[0].Rows[0]["TotalPayAMount"]);
                        txtBalanceAmount.Text = Convert.ToString(dt.Tables[0].Rows[0]["FirtsPaymentBalanceAmount"]);
                        TypeOf = Convert.ToString(dt.Tables[0].Rows[0]["TypeOf"]);
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("_getContractById()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("_getContractById()", ex.ToString());
            }

        }
        private string UnitPaymentResultLable() =>
                       Functions.ConvertStringToDecimal(this.txtTotalForPayment.Text) > 0 ? "PAYMENT" : "SAVE";
        private void _generatePayment()
        {
            try
            {
                if (string.IsNullOrEmpty(this.contractNumber))
                {
                    return;
                }
                var result = _payment.GenerateFirstPayment(
                   this.contractNumber,
                   Functions.ConvertStringToDecimal(this.txtTotalForPayment.Text),
                   this.receiveAmount,
                   this.changeAmount,
                   Functions.ConvertStringToDecimal(this.txtThreeMonSecDep.Text),
                   this._Company_OR_Number_,
                   this._Company_PR_Number_,
                   this._Bank_Account_Name_,
                   this._Bank_Account_Number_,
                   this._Bank_Name_,
                   this._Bank_Serial_No_,
                   this.paymentRemarks,
                   this._Bank_Reference_Number_,
                   this.modeType,
                   this._Bank_Branch_,
                   this._Company_Original_Receipt_Date_,
                    out transactionNumber);
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

                Functions.MessageShow($"{this.UnitPaymentResultLable()} : {result}");

                this.IsProceed = true;
                this.btnGenerate.Enabled = false;
                this.btnPrintReciept.Enabled = true;
            }
            catch (Exception ex)
            {
                Functions.LogError("_generatePayment()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("_generatePayment()", ex.ToString());
            }

        }
        private void _generatePaymentParking()
        {
            try
            {
                if (string.IsNullOrEmpty(this.contractNumber))
                {
                    return;
                }
                var result = _payment.GenerateFirstPaymentParking(
                   this.contractNumber,
                   Functions.ConvertStringToDecimal(this.txtTotalForPayment.Text),
                   this.receiveAmount,
                   this.changeAmount,
                   Functions.ConvertStringToDecimal(this.txtThreeMonSecDep.Text),
                   this._Company_OR_Number_,
                   this._Company_PR_Number_,
                   this._Bank_Account_Name_,
                   this._Bank_Account_Number_,
                   this._Bank_Name_,
                   this._Bank_Serial_No_,
                   this.paymentRemarks,
                   this._Bank_Reference_Number_,
                   this.modeType,
                   this._Bank_Branch_,
                   this._Company_Original_Receipt_Date_,
                    out transactionNumber);
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

                Functions.MessageShow($"Transaction {result}" + Environment.NewLine + "you can now proceed for contract approval and move in.");

                this.IsProceed = true;
                this.btnGenerate.Enabled = false;
                this.btnPrintReciept.Enabled = true;
            }
            catch (Exception ex)
            {
                Functions.LogError("_generatePaymentParking()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("_generatePaymentParking()", ex.ToString());
            }

        }
        private void _showClientUnitsTaken()
        {
            if (string.IsNullOrEmpty(this.clientNumber))
            {
                return;
            }
            frmCheckClientUnits unitTaken = new frmCheckClientUnits();
            unitTaken.ClientId = this.clientNumber;
            unitTaken.ShowDialog();
        }
        private string _getPaymentLevel()
        {

            return "FIRST";
        }
        private void _showPrintReceiptForm()
        {
            frmRecieptSelection receipt = new frmRecieptSelection(this.transactionNumber, this.contractNumber, this._getPaymentLevel());
            using (DataSet dt = _payment.CheckIfOrIsEmpty(this.transactionNumber))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    if (string.IsNullOrEmpty(Convert.ToString(dt.Tables[0].Rows[0]["CompanyORNo"])) && !string.IsNullOrEmpty(Convert.ToString(dt.Tables[0].Rows[0]["CompanyPRNo"])))
                    {
                        receipt.IsNoOR = true;
                    }
                    else if (!string.IsNullOrEmpty(Convert.ToString(dt.Tables[0].Rows[0]["CompanyORNo"])) && string.IsNullOrEmpty(Convert.ToString(dt.Tables[0].Rows[0]["CompanyPRNo"])))
                    {
                        receipt.IsNoOR = false;
                    }
                    else if (!string.IsNullOrEmpty(Convert.ToString(dt.Tables[0].Rows[0]["CompanyORNo"])) && !string.IsNullOrEmpty(Convert.ToString(dt.Tables[0].Rows[0]["CompanyPRNo"])))
                    {
                        receipt.IsNoOR = false;
                    }
                }
            }
            receipt.ShowDialog();
        }
        private bool _checkTranIDContractNumberIsEmpty()
        {
            if (string.IsNullOrEmpty(this.transactionNumber) && string.IsNullOrEmpty(this.contractNumber))
            {
                return true;
            }

            return false;
        }
        private void _showPaymentPrintReceipt()
        {
            if (this._checkTranIDContractNumberIsEmpty())
            {
                return;
            }

            this._showPrintReceiptForm();
        }
        private bool _initPayment(frmPaymentMode1 pForm)
        {
            pForm.contractId = contractId;
            pForm.clientNumber = clientNumber;
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
            this.paymentRemarks = pForm.PaymentRemarks;
            this._Bank_Reference_Number_ = pForm.REF;
            this._Bank_Branch_ = pForm.BankBranch;
            this.modeType = pForm.ModeType;
            this._Company_Original_Receipt_Date_ = pForm.RecieptDate;
            //this.XML = pForm.XML;
            return true;
        }
        private void _recievePayment(frmReceivePayment pForm)
        {
            pForm.Amount = this.txtTotalForPayment.Text;
            pForm.ShowDialog();

            if (!pForm.IsProceed)
            {
                return;
            }
            if (pForm.IsPartialPayment)
            {
                this.btnPrintReciept.Enabled = false;
                this.IsPartialPayment = true;

            }

            this.receiveAmount = Functions.ConvertStringToDecimal(pForm.txtReceiveAmount.Text);
            this.changeAmount = 0;
        }
        private void _initReciept(frmRecieptSelection pForm)
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
            this._getContractById();
        }
        private string PaymentMessageConfirmByPaymentAmount() =>
            Functions.ConvertStringToDecimal(this.txtTotalForPayment.Text) > 0 ? "Are you sure you want to proceed  to this payment?" : "Are you sure you want to proceed this transaction?";
        private string PaymentMessageConfirmLable() =>
            this.TypeOf == "PARKING" ? "Are you sure you want to proceed this transaction?" : this.PaymentMessageConfirmByPaymentAmount();
        private string PaymentMessageConfirm() => this.PaymentMessageConfirmLable();
        private void _savePayment()
        {
            if (Functions.MessageConfirm(this.PaymentMessageConfirm()) == DialogResult.No)
            {
                Functions.GetNotification("PAYMENT", "Payment Cancel");
                return;
            }

            this._save();
        }
        private void _generatePaymentUnit()
        {
            if (Functions.ConvertStringToDecimal(this.txtTotalForPayment.Text) > 0)
            {
                var fPayment = new frmPaymentMode1();
                if (!this._initPayment(fPayment))
                {
                    return;
                }

                var fReceivePayment = new frmReceivePayment();
                this._recievePayment(fReceivePayment);

                this._generatePayment();

                if (this._checkTranIDContractNumberIsEmpty())
                {
                    Functions.MessageShow("No transaction code is generated, Please contact system administrator");
                    return;
                }

                if (!this.IsPartialPayment)
                {
                    /*If Partial Payment Dont show Reciept Printing*/
                    var fReciept = new frmRecieptSelection(this.transactionNumber, this.contractNumber, this._getPaymentLevel());
                    this._initReciept(fReciept);
                }
            }
            else
            {
                this._generatePayment();
            }


        }
        private void _save()
        {
            if (this.TypeOf == "PARKING")
            {
                this._generatePaymentParking();
            }
            else
            {
                this._generatePaymentUnit();
            }
        }

        #endregion

        #region Buttons
        private void btnCheckUnits_Click(object sender, EventArgs e)
        {
            this._showClientUnitsTaken();
        }
        private void btnGenerate_Click(object sender, EventArgs e)
        {
            this._savePayment();
        }
        private void btnPrintReciept_Click(object sender, EventArgs e)
        {
            this._showPaymentPrintReceipt();
        }
        #endregion

        #region TextBox
        private void radTextBox1_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }
        #endregion

        #region GridView
        private void dgvLedgerList_CellFormatting(object sender, Telerik.WinControls.UI.CellFormattingEventArgs e)
        {
            if (!string.IsNullOrEmpty(Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["Remarks"].Value)))
            {
                //Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["Remarks"].Value) == "FOR ADVANCE PAYMENT" ||
                if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["Remarks"].Value) == "FOR SECURITY DEPOSIT")
                {
                    e.CellElement.ForeColor = Color.White;
                    //e.CellElement.Font = new Font("Tahoma", 7f, FontStyle.Bold);

                    e.CellElement.DrawFill = true;
                    e.CellElement.GradientStyle = GradientStyles.Solid;
                    e.CellElement.BackColor = Color.Green;
                }
                else if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["Remarks"].Value) == "FOR ADVANCE PAYMENT" || Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["Remarks"].Value) == "FOR POST DATED CHECK")
                {
                    e.CellElement.ForeColor = Color.Black;

                    e.CellElement.DrawFill = true;
                    e.CellElement.GradientStyle = GradientStyles.Solid;
                    e.CellElement.BackColor = Color.Yellow;
                }
                else if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["Remarks"].Value) == "FOR FULL PAYMENT")
                {
                    e.CellElement.ForeColor = Color.White;

                    e.CellElement.DrawFill = true;
                    e.CellElement.GradientStyle = GradientStyles.Solid;
                    e.CellElement.BackColor = Color.Green;
                }
                //else if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["UnitStatus"].Value) == "OCCUPIED")
                //{
                //    e.CellElement.DrawFill = true;
                //    e.CellElement.GradientStyle = GradientStyles.Solid;
                //    e.CellElement.BackColor = Color.LightGreen;

                //}
                //else if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["UnitStatus"].Value) == "NOT AVAILABLE")
                //{
                //    e.CellElement.DrawFill = true;
                //    e.CellElement.GradientStyle = GradientStyles.Solid;
                //    e.CellElement.BackColor = Color.LightSalmon;

                //}
            }
        }
        #endregion

        public frmSelectClient()
        {
            InitializeComponent();
        }
        private void frmSelectClient_Load(object sender, EventArgs e)
        {
            Functions.EventCapturefrmName(this);
            this.OnInitialized();
        }
    }
}
