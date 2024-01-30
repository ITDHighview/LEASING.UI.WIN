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
        //private DataTable data = new DataTable();
        ClientContext ClientContext = new ClientContext();
        ComputationContext ComputationContext = new ComputationContext();
        PaymentContext PaymentContext = new PaymentContext();
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
        public string BankAccountNumber { get; set; }
        public string BankName { get; set; }
        public string SerialNo { get; set; }
        public string PaymentRemarks { get; set; }
        public string REF { get; set; }
        public string ModeType { get; set; }
        public frmSelectClient()
        {
            InitializeComponent();          
        }   
        private bool IsComputationValid()
        {
            if (ClientId == string.Empty)
            {
                MessageBox.Show("Client  cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
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
        private void frmSelectClient_Load(object sender, EventArgs e)
        {
            dtpFrom.Enabled = false;
            dtpTo.Enabled = false;
            txtTwoMonAdv.ReadOnly = true;
            txtThreeMonSecDep.ReadOnly = true;
            txtTotalForPayment.ReadOnly = true;

            M_GetComputationById();       
            M_GetMonthLedgerByRefIdAndClientId();
            btnPrintReciept.Enabled = false;
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
                }
            }
        }
        private void M_sp_GenerateFirstPayment()
        {
            var result = PaymentContext.GenerateFirstPayment(RefId, txtTotalForPayment.Text == string.Empty ? 0 : decimal.Parse(txtTotalForPayment.Text), ReceiveAmount, ChangeAmount, txtThreeMonSecDep.Text == string.Empty ? 0 : decimal.Parse(txtThreeMonSecDep.Text),CompanyORNo, CompanyPRNo,BankAccountName, BankAccountNumber,BankName,SerialNo,PaymentRemarks,REF,ModeType,out TransID);
            if (result.Equals("SUCCESS"))
            {
                MessageBox.Show("PAYMENT SUCCESS", "System Message", MessageBoxButtons.OK);
                IsProceed = true;
                btnGenerate.Enabled = false;
                btnPrintReciept.Enabled = true;
            }
            else
            {
                MessageBox.Show(result, "System Message", MessageBoxButtons.OK);
            }
        }
        private void radTextBox1_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }     
        private void radDateTimePicker2_ValueChanged(object sender, EventArgs e)
        {
            
        }
        private void btnCheckUnits_Click(object sender, EventArgs e)
        {           
            frmCheckClientUnits forms = new frmCheckClientUnits();
            forms.ClientId = ClientId;
            forms.ShowDialog();
        }
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
        private void btnGenerate_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Are you sure you want to proceed  to this payment?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
            {
                frmPaymentMode frmPaymentMode = new frmPaymentMode();
                frmPaymentMode.ShowDialog();
                if (frmPaymentMode.IsProceed)
                {
                    CompanyORNo = frmPaymentMode.CompanyORNo;
                    CompanyPRNo = frmPaymentMode.CompanyPRNo;
                    BankAccountName = frmPaymentMode.BankAccountName;
                    BankAccountNumber = frmPaymentMode.BankAccountNumber;
                    BankName = frmPaymentMode.BankName;
                    SerialNo = frmPaymentMode.SerialNo;
                    PaymentRemarks = frmPaymentMode.PaymentRemarks;
                    REF = frmPaymentMode.REF;
                    ModeType = frmPaymentMode.ModeType;

                    frmReceivePayment frmReceivePayment = new frmReceivePayment();
                    frmReceivePayment.Amount = txtTotalForPayment.Text;
                    frmReceivePayment.ShowDialog();
                    if (frmReceivePayment.IsProceed)
                    {
                       
                        ReceiveAmount = frmReceivePayment.txtReceiveAmount.Text == string.Empty ? 0 : decimal.Parse(frmReceivePayment.txtReceiveAmount.Text);
                        ChangeAmount = frmReceivePayment.txtPenaltyAmount.Text == string.Empty ? 0 : decimal.Parse(frmReceivePayment.txtPenaltyAmount.Text);
                        M_sp_GenerateFirstPayment();
                        frmRecieptSelection frmRecieptSelection = new frmRecieptSelection(TransID, RefId);
                        if (string.IsNullOrEmpty(CompanyORNo) && !string.IsNullOrEmpty(CompanyPRNo))
                        {
                            frmRecieptSelection.IsNoOR = true;
                        }
                        else if (!string.IsNullOrEmpty(CompanyORNo) && string.IsNullOrEmpty(CompanyPRNo))
                        {
                            frmRecieptSelection.IsNoOR = false;
                        }
                        //else
                        //{
                        //    frmRecieptSelection.IsNoOR = false;
                        //}
                        frmRecieptSelection.ShowDialog();
                    }
                }
            }
        }
        private void btnPrintReciept_Click(object sender, EventArgs e)
        {
            frmRecieptSelection frmRecieptSelection = new frmRecieptSelection(TransID, RefId);
            using (DataSet dt = PaymentContext.CheckIfOrIsEmpty(TransID))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    if (string.IsNullOrEmpty(Convert.ToString(dt.Tables[0].Rows[0]["CompanyORNo"])) && !string.IsNullOrEmpty(Convert.ToString(dt.Tables[0].Rows[0]["CompanyPRNo"])))
                    {
                        frmRecieptSelection.IsNoOR = true;
                    }
                    else if (!string.IsNullOrEmpty(Convert.ToString(dt.Tables[0].Rows[0]["CompanyORNo"])) && string.IsNullOrEmpty(Convert.ToString(dt.Tables[0].Rows[0]["CompanyPRNo"])))
                    {
                        frmRecieptSelection.IsNoOR = false;
                    }
                    else if (!string.IsNullOrEmpty(Convert.ToString(dt.Tables[0].Rows[0]["CompanyORNo"])) && !string.IsNullOrEmpty(Convert.ToString(dt.Tables[0].Rows[0]["CompanyPRNo"])))
                    {
                        frmRecieptSelection.IsNoOR = false;
                    }
                }
            }
            frmRecieptSelection.ShowDialog();
        }
    }
}
