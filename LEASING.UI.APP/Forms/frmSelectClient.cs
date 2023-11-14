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
        public string MonthsAdvance1 { get; set; }
        public string MonthsAdvance2 { get; set; }
        public string RefId { get; set; }

        public string ClientId { get; set; }
        public bool IsProceed { get; set; }
        public string FromDate { get; set; }
        public string Todate { get; set; }
        public int TotalAmount { get; set; }


        public decimal ReceiveAmount { get; set; }
        public decimal ChangeAmount { get; set; }

        public string CompanyORNo { get; set; }
        public string BankAccountName { get; set; }
        public string BankAccountNumber { get; set; }
        public string BankName { get; set; }
        public string SerialNo { get; set; }
        public string PaymentRemarks { get; set; }
        public string REF { get; set; }
        public int ModeType { get; set; }
        public frmSelectClient()
        {
            InitializeComponent();
            //data.Columns.Add("ID", typeof(int));
            //data.Columns.Add("Name", typeof(string));
            //data.Columns.Add("Age", typeof(int));
            //data.Columns.Add("Date", typeof(DateTime));



            // Bind the DataTable to the DataGridView
            //dgvLedgerList.DataSource = data;
        }

        //private void GenerateDataForMonths(DateTime startDate, DateTime endDate)
        //{
        //    DateTime currentDate = startDate;

        //    while (currentDate <= endDate)
        //    {
        //        data.Rows.Add(data.Rows.Count + 1, $"Person {data.Rows.Count + 1}", 20 + data.Rows.Count, currentDate);
        //        currentDate = currentDate.AddMonths(1);
        //    }
        //}
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
            using (DataSet dt = ComputationContext.GetMonthLedgerByRefIdAndClientId(ComputationRecid, ClientId, MonthsAdvance1, MonthsAdvance2))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {

                    dgvLedgerList.DataSource = dt.Tables[0];
                }
            }
        }

        //private void M_GetClientTypeAndID()
        //{

        //    txtClientType.Text = string.Empty;
        //    txtClientId.Text = string.Empty;
        //    using (DataSet dt = ClientContext.GetGetClientTypeAndID(ClientId))
        //    {
        //        if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
        //        {
        //            txtClientType.Text = Convert.ToString(dt.Tables[0].Rows[0]["ClientType"]);
        //            txtClientId.Text = Convert.ToString(dt.Tables[0].Rows[0]["ClientID"]);
        //        }
        //    }
        //}
        private void frmSelectClient_Load(object sender, EventArgs e)
        {
            //M_GetSelecClient();
            M_GetComputationById();
            //M_GetClientTypeAndID();
            M_GetMonthLedgerByRefIdAndClientId();
            //lblPostDatedCheck.Text = string.Empty;
            //lblPostDatedCheck.Text = "(" +"0"+ ")" + " POST-DATED CHECKS:";
            //txtTotal.Text = string.Empty;
        }
        private void M_GetComputationById()
        {

            using (DataSet dt = ComputationContext.GetComputationById(ComputationRecid))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    RefId = Convert.ToString(dt.Tables[0].Rows[0]["RefId"]);
                    txtClientName.Text = Convert.ToString(dt.Tables[0].Rows[0]["InquiringClient"]);
                    //txtReferenceId.Text = Convert.ToString(dt.Tables[0].Rows[0]["RefId"]);
                    ////ddlProject.SelectedValue = Convert.ToInt32(dt.Tables[0].Rows[0]["ProjectId"]);
                    ClientId = Convert.ToString(dt.Tables[0].Rows[0]["ClientID"]);
                    //txtProjectType.Text = Convert.ToString(dt.Tables[0].Rows[0]["ProjectType"]);
                    //txtProjectAddress.Text = Convert.ToString(dt.Tables[0].Rows[0]["ProjectAddress"]);
                    //dtpTransactionDate.Text = Convert.ToString(dt.Tables[0].Rows[0]["TransactionDate"]);
                    //txtClient.Text = Convert.ToString(dt.Tables[0].Rows[0]["InquiringClient"]);
                    //txtContactNumber.Text = Convert.ToString(dt.Tables[0].Rows[0]["ClientMobile"]);
                    //txtUnitNumber.Text = Convert.ToString(dt.Tables[0].Rows[0]["UnitNo"]);
                    //txtFloorType.Text = Convert.ToString(dt.Tables[0].Rows[0]["FloorType"]);
                    dtpFrom.Text = Convert.ToString(dt.Tables[0].Rows[0]["StatDate"]);
                    dtpTo.Text = Convert.ToString(dt.Tables[0].Rows[0]["FinishDate"]);
                    //txtRental.Text = Convert.ToString(dt.Tables[0].Rows[0]["Rental"]);
                    //txtSecAndMaintenance.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecAndMaintenance"]);
                    TotalRental = Convert.ToInt32(dt.Tables[0].Rows[0]["TotalRent"]);
                    MonthsAdvance1 = Convert.ToString(dt.Tables[0].Rows[0]["Applicabledate1"]);
                    MonthsAdvance2 = Convert.ToString(dt.Tables[0].Rows[0]["Applicabledate2"]);
                    txtTwoMonAdv.Text = Convert.ToString(dt.Tables[0].Rows[0]["TwoMonAdvance"]);
                    txtThreeMonSecDep.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecDeposit"]);
                    //txtTotal.Text = Convert.ToString(dt.Tables[0].Rows[0]["Total"]);
                    txtTotalForPayment.Text = Convert.ToString(dt.Tables[0].Rows[0]["TotalForPayment"]);
                }
            }
        }



        private void M_sp_GenerateFirstPayment()
        {

            var result = PaymentContext.GenerateFirstPayment(RefId, txtTotalForPayment.Text == string.Empty ? 0 : decimal.Parse(txtTotalForPayment.Text), ReceiveAmount, ChangeAmount, txtThreeMonSecDep.Text == string.Empty ? 0 : decimal.Parse(txtThreeMonSecDep.Text),CompanyORNo,BankAccountName,BankAccountNumber,BankName,SerialNo,PaymentRemarks,REF,ModeType);
            if (result.Equals("SUCCESS"))
            {
                MessageBox.Show("SUCCESS", "System Message", MessageBoxButtons.OK);
                IsProceed = true;
                this.Close();
            }
        }

        private void radTextBox1_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }
        //private int CountMonths(DateTime startDate, DateTime endDate)
        //{
        //    // The rest of the code remains the same as in the previous example
        //    if (endDate < startDate)
        //    {
        //        DateTime temp = startDate;
        //        startDate = endDate;
        //        endDate = temp;
        //    }

        //    int months = ((endDate.Year - startDate.Year) * 12) + endDate.Month - startDate.Month;

        //    if (endDate.Day >= startDate.Day)
        //    {
        //        months++;
        //    }

        //    return months;
        //}


        private void radDateTimePicker2_ValueChanged(object sender, EventArgs e)
        {
            //DateTime startDate = DateTime.ParseExact(dtpFrom.Value.ToString("MM/dd/yyyy"), "MM/dd/yyyy", null);
            //DateTime endDate = DateTime.ParseExact(dtpTo.Value.ToString("MM/dd/yyyy"), "MM/dd/yyyy", null);

            //int numberOfMonths = CountMonths(startDate, endDate);
            //lblPostDatedCheck.Text = "(" + Convert.ToString(numberOfMonths) + ")" + " POST-DATED CHECKS:";
            //txtTotal.Text = Convert.ToString(TotalRental * numberOfMonths);
        }


        //private void M_Generatedler()
        //{


        //    var result  = ComputationContext.GenerateLedger(dtpFrom.Value.ToString("MM/dd/yyyy"), dtpFrom.Value.ToString("MM/dd/yyyy"), dtpTo.Value.ToString("MM/dd/yyyy"), TotalRental, ComputationRecid, Convert.ToString(ddlClientList.SelectedValue), 1);
        //    if (result.Equals("SUCCESS"))
        //    {
        //        MessageBox.Show("New Reference has been generated successfully !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
        //        this.Close();    
        //    }
        //    else
        //    {
        //        MessageBox.Show(result, "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);

        //    }
        //}
        private void btnSave_Click(object sender, EventArgs e)
        {
            if (IsComputationValid())
            {
                if (MessageBox.Show("Are you sure you want to generate ledger for this Reference ?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                {
                    //M_Generatedler();
                }
            }
        }

        private void btnCheckUnits_Click(object sender, EventArgs e)
        {
            //data.Clear(); // Clear existing data

            //DateTime startDate = dtpFrom.Value;
            //DateTime endDate = dtpTo.Value;

            //if (startDate > endDate)
            //{
            //    MessageBox.Show("Start date cannot be after end date.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            //    return;
            //}

            //GenerateDataForMonths(startDate, endDate);

            frmCheckClientUnits forms = new frmCheckClientUnits();
            forms.ClientId = ClientId;
            forms.ShowDialog();
        }

        private void dgvLedgerList_CellFormatting(object sender, Telerik.WinControls.UI.CellFormattingEventArgs e)
        {
            if (!string.IsNullOrEmpty(Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["Remarks"].Value)))
            {
                if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["Remarks"].Value) == "FOR ADVANCE PAYMENT" || Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["Remarks"].Value) == "FOR 3 MONTHS SECURITY DEPOSIT")
                {
                    e.CellElement.ForeColor = Color.White;
                    //e.CellElement.Font = new Font("Tahoma", 7f, FontStyle.Bold);

                    e.CellElement.DrawFill = true;
                    e.CellElement.GradientStyle = GradientStyles.Solid;
                    e.CellElement.BackColor = Color.Green;
                }
                else if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["Remarks"].Value) == "FOR POST DATED CHECK")
                {
                    // e.CellElement.ForeColor = Color.White;

                    e.CellElement.DrawFill = true;
                    e.CellElement.GradientStyle = GradientStyles.Solid;
                    e.CellElement.BackColor = Color.Yellow;
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
            frmPaymentMode frmPaymentMode = new frmPaymentMode();
            frmPaymentMode.ShowDialog();
            if (frmPaymentMode.IsProceed)
            {
                CompanyORNo = frmPaymentMode.CompanyORNo;
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
                    ChangeAmount = frmReceivePayment.txtChangeAmount.Text == string.Empty ? 0 : decimal.Parse(frmReceivePayment.txtChangeAmount.Text);
                    M_sp_GenerateFirstPayment();
                }
            }
        }
    }
}
