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
        ClientContext ClientContext = new ClientContext();
        ComputationContext ComputationContext = new ComputationContext();
        PaymentContext PaymentContext = new PaymentContext();
        #endregion

        #region Variables
        public int TotalRental { get; set; }
        public int ComputationRecid { get; set; }
        public string TransID = string.Empty;
        public string RefId { get; set; }
        public string ClientId { get; set; }
        public bool IsProceed { get; set; }
        public string FromDate { get; set; }
        public string Todate { get; set; }
        public int TotalAmount { get; set; }
        public decimal ReceiveAmount { get; set; }
        public decimal ChangeAmount { get; set; }
        public string CompanyORNo { get; set; }
        public string CompanyPRNo { get; set; }
        public string BankAccountName { get; set; }
        public string BankBranch { get; set; }
        public string BankAccountNumber { get; set; }
        public string BankName { get; set; }
        public string SerialNo { get; set; }
        public string PaymentRemarks { get; set; }
        public string REF { get; set; }
        public string ModeType { get; set; }
        #endregion

        #region Call Methods
        private void OnInitialized()
        {
            this.FormLoadDisableControl();
            this.FormLoadReadOnlyControls();
            this.M_GetComputationById();
            this.M_GetMonthLedgerByRefIdAndClientId();
        }
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
        }
        private bool IsComputationValid()
        {
            if (string.IsNullOrEmpty(ClientId))
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
        private void M_GetMonthLedgerByRefIdAndClientId()
        {

            dgvLedgerList.DataSource = null;
            using (DataSet dt = ComputationContext.GetMonthLedgerByRefIdAndClientId(ComputationRecid, ClientId))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {

                    dgvLedgerList.DataSource = dt.Tables[0];
                }
            }
        }
        private void M_GetComputationById()
        {
            using (DataSet dt = ComputationContext.GetComputationById(ComputationRecid))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    RefId = Convert.ToString(dt.Tables[0].Rows[0]["RefId"]);
                    txtClientName.Text = Convert.ToString(dt.Tables[0].Rows[0]["InquiringClient"]);
                    ClientId = Convert.ToString(dt.Tables[0].Rows[0]["ClientID"]);
                    dtpFrom.Text = Convert.ToString(dt.Tables[0].Rows[0]["StatDate"]);
                    dtpTo.Text = Convert.ToString(dt.Tables[0].Rows[0]["FinishDate"]);
                    TotalRental = Convert.ToInt32(dt.Tables[0].Rows[0]["TotalRent"]);
                    txtTwoMonAdv.Text = Convert.ToString(dt.Tables[0].Rows[0]["TwoMonAdvance"]);
                    txtThreeMonSecDep.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecDeposit"]);
                    txtTotalForPayment.Text = Convert.ToString(dt.Tables[0].Rows[0]["TotalForPayment"]);
                    txtAmountPaid.Text = Convert.ToString(dt.Tables[0].Rows[0]["TotalPayAMount"]);
                    txtBalanceAmount.Text = Convert.ToString(dt.Tables[0].Rows[0]["FirtsPaymentBalanceAmount"]);
                }
            }
        }
        private decimal fn_ConvertStringToDecimal(string amountString)
        {
            if (string.IsNullOrEmpty(amountString))
            {
                return 0;
            }
            return decimal.Parse(amountString);
        }
        private void GeneratePayment()
        {
            if (string.IsNullOrEmpty(this.RefId))
            {
                return;
            }
            var result = PaymentContext.GenerateFirstPayment(
               this.RefId,
               this.fn_ConvertStringToDecimal(this.txtTotalForPayment.Text),
               this.ReceiveAmount,
               this.ChangeAmount,
               this.fn_ConvertStringToDecimal(this.txtThreeMonSecDep.Text),
               this.CompanyORNo,
               this.CompanyPRNo,
               this.BankAccountName,
               this.BankAccountNumber,
               this.BankName,
               this.SerialNo,
               this.PaymentRemarks,
               this.REF,
               this.ModeType,
               this.BankBranch,
                out TransID);

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

            Functions.MessageShow($"PAYMENT {result}");

            IsProceed = true;
            btnGenerate.Enabled = false;
            btnPrintReciept.Enabled = true;
        }
        private void ShowClientUnitsTaken()
        {
            if (string.IsNullOrEmpty(this.ClientId))
            {
                return;
            }
            frmCheckClientUnits CheckClientUnits = new frmCheckClientUnits();
            CheckClientUnits.ClientId = this.ClientId;
            CheckClientUnits.ShowDialog();
        }
        private string GetPaymentLevel()
        {

            return "FIRST";
        }
        private void ShowPrintRecieptForm()
        {
            frmRecieptSelection RecieptSelection = new frmRecieptSelection(this.TransID, this.RefId,this.GetPaymentLevel());
            using (DataSet dt = PaymentContext.CheckIfOrIsEmpty(this.TransID))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    if (string.IsNullOrEmpty(Convert.ToString(dt.Tables[0].Rows[0]["CompanyORNo"])) && !string.IsNullOrEmpty(Convert.ToString(dt.Tables[0].Rows[0]["CompanyPRNo"])))
                    {
                        RecieptSelection.IsNoOR = true;
                    }
                    else if (!string.IsNullOrEmpty(Convert.ToString(dt.Tables[0].Rows[0]["CompanyORNo"])) && string.IsNullOrEmpty(Convert.ToString(dt.Tables[0].Rows[0]["CompanyPRNo"])))
                    {
                        RecieptSelection.IsNoOR = false;
                    }
                    else if (!string.IsNullOrEmpty(Convert.ToString(dt.Tables[0].Rows[0]["CompanyORNo"])) && !string.IsNullOrEmpty(Convert.ToString(dt.Tables[0].Rows[0]["CompanyPRNo"])))
                    {
                        RecieptSelection.IsNoOR = false;
                    }
                }
            }
            RecieptSelection.ShowDialog();
        }
        private bool CheckTranIDAndRefIdIsEmpty()
        {
            if (string.IsNullOrEmpty(this.TransID) && string.IsNullOrEmpty(this.RefId))
            {
                return true;
            }

            return false;
        }
        private void ShowPaymentPrintReciept()
        {
            if (this.CheckTranIDAndRefIdIsEmpty())
            {
                return;
            }

            this.ShowPrintRecieptForm();
        }
        private bool InitPayment(frmPaymentMode1 pForm)
        {
            pForm.ShowDialog();
            if (!pForm.IsProceed)
            {
                return false; ;
            }

            this.CompanyORNo = pForm.CompanyORNo;
            this.CompanyPRNo = pForm.CompanyPRNo;
            this.BankAccountName = pForm.BankAccountName;
            this.BankAccountNumber = pForm.BankAccountNumber;
            this.BankName = pForm.BankName;
            this.SerialNo = pForm.SerialNo;
            this.PaymentRemarks = pForm.PaymentRemarks;
            this.REF = pForm.REF;
            this.BankBranch = pForm.BankBranch;
            this.ModeType = pForm.ModeType;

            return true;
        }
        private void RecievePayment(frmReceivePayment pForm)
        {
            pForm.Amount = this.txtTotalForPayment.Text;
            pForm.ShowDialog();

            if (!pForm.IsProceed)
            {
                return;
            }

            this.ReceiveAmount = fn_ConvertStringToDecimal(pForm.txtReceiveAmount.Text);
            this.ChangeAmount = 0;
        }
        private void InitReciept(frmRecieptSelection pForm)
        {
            if (string.IsNullOrEmpty(this.CompanyORNo) && !string.IsNullOrEmpty(this.CompanyPRNo))
            {
                pForm.IsNoOR = true;
            }
            else if (!string.IsNullOrEmpty(this.CompanyORNo) && string.IsNullOrEmpty(this.CompanyPRNo))
            {
                pForm.IsNoOR = false;
            }

            pForm.ShowDialog();
            this.M_GetComputationById();
        }
        private void SavePayment()
        {
            if (Functions.MessageConfirm("Are you sure you want to proceed  to this payment?") == DialogResult.No)
            {
                Functions.GetNotification("PAYMENT", "Payment Cancel");
                return;
            }

            var fPayment = new frmPaymentMode1();
            if (!this.InitPayment(fPayment))
            {
                return;
            }

            var fReceivePayment = new frmReceivePayment();
            this.RecievePayment(fReceivePayment);

            this.GeneratePayment();

            if (CheckTranIDAndRefIdIsEmpty())
            {
                Functions.MessageShow("No transaction code is generated, Please contact system administrator");
                return;
            }

            var fReciept = new frmRecieptSelection(this.TransID, this.RefId,this.GetPaymentLevel());
            this.InitReciept(fReciept);
        }
        #endregion

        #region Buttons
        private void btnCheckUnits_Click(object sender, EventArgs e)
        {            
            this.ShowClientUnitsTaken();
        }
        private void btnGenerate_Click(object sender, EventArgs e)
        {
            this.SavePayment();
        }
        private void btnPrintReciept_Click(object sender, EventArgs e)
        {
            this.ShowPaymentPrintReciept();
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
                if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["Remarks"].Value) == "FOR ADVANCE PAYMENT" || Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["Remarks"].Value) == "FOR SECURITY DEPOSIT")
                {
                    e.CellElement.ForeColor = Color.White;
                    //e.CellElement.Font = new Font("Tahoma", 7f, FontStyle.Bold);

                    e.CellElement.DrawFill = true;
                    e.CellElement.GradientStyle = GradientStyles.Solid;
                    e.CellElement.BackColor = Color.Green;
                }
                else if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["Remarks"].Value) == "FOR POST DATED CHECK")
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
            this.OnInitialized();
        }
    }
}
