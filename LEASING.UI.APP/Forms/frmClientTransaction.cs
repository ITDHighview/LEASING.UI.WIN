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
using Telerik.WinControls.UI;

namespace LEASING.UI.APP.Forms
{
    public partial class frmClientTransaction : Form
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
        public bool IsMoveOut { get; set; } = false;
        public frmClientTransaction()
        {
            InitializeComponent();

        }

        private void GetNotification(string CaptionText, string CaptionText2)
        {

            RadDesktopAlert radDesktopAlert1 = new RadDesktopAlert();
            //radDesktopAlert1.ContentImage = Properties.Resources.download24x24;
            radDesktopAlert1.CaptionText = CaptionText;
            radDesktopAlert1.ContentText = CaptionText2;
            //+ "ARAMCO : JUNE 2018\n"
            //+ "COMPANY : \n"
            //+ "GENERAL : ";
            radDesktopAlert1.AutoClose = true;
            radDesktopAlert1.AutoCloseDelay = 3;
            radDesktopAlert1.ShowOptionsButton = false;
            radDesktopAlert1.ShowPinButton = false;
            radDesktopAlert1.ShowCloseButton = true;
            //radDesktopAlert1.FixedSize = new Size(radDesktopAlert1.FixedSize.Width, 50);

            radDesktopAlert1.Popup.AlertElement.CaptionElement.CaptionGrip.BackColor = Color.Green;
            radDesktopAlert1.Popup.AlertElement.BorderColor = Color.Green;
            radDesktopAlert1.Popup.AlertElement.CaptionElement.TextAndButtonsElement.TextElement.ForeColor = Color.White;
            radDesktopAlert1.Popup.AlertElement.CaptionElement.CaptionGrip.GradientStyle = GradientStyles.Solid;
            radDesktopAlert1.Popup.AlertElement.ContentElement.Font = new Font("Tahoma", 8f, FontStyle.Italic);
            radDesktopAlert1.Popup.AlertElement.ContentElement.TextImageRelation = TextImageRelation.ImageBeforeText;
            //radDesktopAlert1.Popup.AlertElement.CaptionElement.TextAndButtonsElement.ForeColor = Color.White;
            radDesktopAlert1.Popup.AlertElement.ContentElement.ForeColor = Color.White;
            radDesktopAlert1.Popup.AlertElement.BackColor = Color.FromArgb(64, 64, 64);
            radDesktopAlert1.Popup.AlertElement.GradientStyle = GradientStyles.Solid;

            radDesktopAlert1.Show();
        }
        private void M_sp_GenerateFirstPayment()
        {
            if (Convert.ToString(dgvTransactionList.CurrentRow.Cells["TypeOf"].Value) == "TYPE OF UNIT")
            {
                var result = PaymentContext.GenerateSecondPayment(RefId,
              Convert.ToString(dgvLedgerList.CurrentRow.Cells["LedgAmount"].Value) == string.Empty ? 0 : decimal.Parse(Convert.ToString(dgvLedgerList.CurrentRow.Cells["LedgAmount"].Value)),
              ReceiveAmount,
              ChangeAmount,
              CompanyORNo,
              BankAccountName,
              BankAccountNumber,
              BankName,
              SerialNo,
              PaymentRemarks,
              REF,
              ModeType,
              Convert.ToInt32(dgvLedgerList.CurrentRow.Cells["Recid"].Value));
                if (result.Equals("SUCCESS"))
                {
                    MessageBox.Show("PAYMENT SUCCESS", "System Message", MessageBoxButtons.OK);
                    IsProceed = true;
                }
            }
            else
            {
                var result = PaymentContext.GeneratePaymentParking(RefId,
               Convert.ToString(dgvLedgerList.CurrentRow.Cells["LedgAmount"].Value) == string.Empty ? 0 : decimal.Parse(Convert.ToString(dgvLedgerList.CurrentRow.Cells["LedgAmount"].Value)),
               ReceiveAmount,
               ChangeAmount,
               CompanyORNo,
               BankAccountName,
               BankAccountNumber,
               BankName,
               SerialNo,
               PaymentRemarks,
               REF,
               ModeType,
               Convert.ToInt32(dgvLedgerList.CurrentRow.Cells["Recid"].Value));
                if (result.Equals("SUCCESS"))
                {
                    MessageBox.Show("PAYMENT SUCCESS", "System Message", MessageBoxButtons.OK);
                    IsProceed = true;
                }
            }
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

        private void M_GetLedgerList()
        {
            dgvLedgerList.DataSource = null;
            using (DataSet dt = ComputationContext.GetLedgerList(ComputationRecid, ClientId))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    dgvLedgerList.DataSource = dt.Tables[0];
                }
            }
        }

        private void M_GetReferenceByClientID()
        {

            dgvTransactionList.DataSource = null;
            using (DataSet dt = ComputationContext.GetReferenceByClientID(ClientId))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {

                    dgvTransactionList.DataSource = dt.Tables[0];
                }
            }
        }

        private void M_GetPaymentListByReferenceId()
        {

            dgvPaymentList.DataSource = null;
            using (DataSet dt = ComputationContext.GetPaymentListByReferenceId(RefId))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {

                    dgvPaymentList.DataSource = dt.Tables[0];
                }
            }
        }

        private void M_GetClientTypeAndID()
        {

            txtTotalPay.Text = string.Empty;
            txtPaymentStatus.Text = string.Empty;
            using (DataSet dt = ClientContext.GetGetClientTypeAndID(ClientId))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    txtTotalPay.Text = Convert.ToString(dt.Tables[0].Rows[0]["ClientType"]);
                    txtPaymentStatus.Text = Convert.ToString(dt.Tables[0].Rows[0]["ClientID"]);
                }
            }
        }
        private void frmSelectClient_Load(object sender, EventArgs e)
        {
            M_GetComputationById();
            M_GetClientTypeAndID();
            btnCloseContract.Enabled = IsMoveOut;
        }
        private void M_GetComputationById()
        {

            using (DataSet dt = ComputationContext.GetComputationById(ComputationRecid))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    RefId = Convert.ToString(dt.Tables[0].Rows[0]["RefId"]);
                    txtClientName.Text = Convert.ToString(dt.Tables[0].Rows[0]["InquiringClient"]);
                    IsMoveOut = Convert.ToBoolean(dt.Tables[0].Rows[0]["IsUnitMoveOut"]);

                    ////ddlProject.SelectedValue = Convert.ToInt32(dt.Tables[0].Rows[0]["ProjectId"]);
                    //ClientId = Convert.ToString(dt.Tables[0].Rows[0]["ClientID"]);
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
                    //txtTwoMonAdv.Text = Convert.ToString(dt.Tables[0].Rows[0]["TwoMonAdvance"]);
                    //txtThreeMonSecDep.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecDeposit"]);
                    //txtTotal.Text = Convert.ToString(dt.Tables[0].Rows[0]["Total"]);
                    //txtTotalForPayment.Text = Convert.ToString(dt.Tables[0].Rows[0]["TotalForPayment"]);
                }
            }
        }
        private void M_GetCheckPaymentStatus()
        {

            using (DataSet dt = PaymentContext.GetCheckPaymentStatus(RefId))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    txtPaymentStatus.Text = Convert.ToString(dt.Tables[0].Rows[0]["PAYMENT_STATUS"]);
                    if (Convert.ToString(dt.Tables[0].Rows[0]["PAYMENT_STATUS"]) == "IN-PROGRESS")
                    {

                        btnTerminateContract.Visible = true;
                    }
                    else if (Convert.ToString(dt.Tables[0].Rows[0]["PAYMENT_STATUS"]) == "PAYMENT DONE")
                    {
                        GetNotification("Payment Status", txtPaymentStatus.Text);
                        btnCloseContract.Enabled = IsMoveOut;
                        btnTerminateContract.Visible = false;
                    }

                }
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
            if (!string.IsNullOrEmpty(Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value)))
            {
                if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "PAID")
                {
                    e.CellElement.ForeColor = Color.White;
                    //e.CellElement.Font = new Font("Tahoma", 7f, FontStyle.Bold);

                    e.CellElement.DrawFill = true;
                    e.CellElement.GradientStyle = GradientStyles.Solid;
                    e.CellElement.BackColor = Color.Green;

                }
                else if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "PENDING")
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
                if (e.CellElement.ColumnInfo is GridViewCommandColumn && !(e.CellElement.RowElement is GridTableHeaderRowElement))
                {
                    GridViewCommandColumn column = (GridViewCommandColumn)e.CellElement.ColumnInfo;
                    RadButtonElement element = (RadButtonElement)e.CellElement.Children[0];

                    (element.Children[2] as Telerik.WinControls.Primitives.BorderPrimitive).Visibility =
                    Telerik.WinControls.ElementVisibility.Collapsed;
                    element.DisplayStyle = DisplayStyle.Image;
                    element.ImageAlignment = ContentAlignment.MiddleCenter;
                    element.Enabled = true;
                    element.Alignment = ContentAlignment.MiddleCenter;
                    element.Visibility = ElementVisibility.Visible;

                    if (column.Name == "ColPay")
                    {
                        if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "PAID")
                        {
                            //element.ImageAlignment = ContentAlignment.MiddleCenter;
                            //element.TextImageRelation = TextImageRelation.TextBeforeImage;
                            //element.Text = "Un-Map";
                            element.Image = Properties.Resources.cancel16;
                            element.ToolTipText = "This button is disabled";

                            element.Enabled = false;
                        }
                        //else
                        //{
                        //    element.ImageAlignment = ContentAlignment.MiddleCenter;
                        //    element.TextImageRelation = TextImageRelation.TextBeforeImage;
                        //    //element.Text = "Un-Map";
                        //    element.Image = Properties.Resources.ico_remove_item;
                        //    element.ToolTipText = "";
                        //    element.Enabled = false;
                        //}
                    }
                    if (column.Name == "ColHold")
                    {
                        if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "PAID")
                        {
                            element.ImageAlignment = ContentAlignment.MiddleCenter;
                            element.TextImageRelation = TextImageRelation.TextBeforeImage;
                            element.Image = Properties.Resources.cancel16;
                            element.ToolTipText = "This button is disabled";

                            element.Enabled = false;
                        }
                        //else
                        //{
                        //    element.ImageAlignment = ContentAlignment.MiddleCenter;
                        //    element.TextImageRelation = TextImageRelation.TextBeforeImage;
                        //    element.Image = Properties.Resources.apply_icon;
                        //    element.ToolTipText = "Done";
                        //   element.Enabled = false;
                        //}
                    }
                    if (column.Name == "ColPay")
                    {
                        if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "PENDING")
                        {
                            element.ImageAlignment = ContentAlignment.MiddleCenter;
                            element.TextImageRelation = TextImageRelation.TextBeforeImage;
                            element.Image = Properties.Resources.Bullet15_Arrow_Blue;
                            element.ToolTipText = "Click to Pay";

                            element.Enabled = true;
                        }
                        //else
                        //{
                        //    element.ImageAlignment = ContentAlignment.MiddleCenter;
                        //    element.TextImageRelation = TextImageRelation.TextBeforeImage;
                        //    element.Image = Properties.Resources.apply_icon;
                        //    element.ToolTipText = "Done";
                        //   element.Enabled = false;
                        //}
                    }
                    if (column.Name == "ColHold")
                    {
                        if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "PENDING")
                        {
                            element.ImageAlignment = ContentAlignment.MiddleCenter;
                            element.TextImageRelation = TextImageRelation.TextBeforeImage;
                            element.Image = Properties.Resources.bookmark_16;
                            element.ToolTipText = "Click to Hold";

                            element.Enabled = true;
                        }
                        //else
                        //{
                        //    element.ImageAlignment = ContentAlignment.MiddleCenter;
                        //    element.TextImageRelation = TextImageRelation.TextBeforeImage;
                        //    element.Image = Properties.Resources.apply_icon;
                        //    element.ToolTipText = "Done";
                        //   element.Enabled = false;
                        //}
                    }
                    if (column.Name == "ColPay")
                    {
                        if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "HOLD")
                        {
                            element.ImageAlignment = ContentAlignment.MiddleCenter;
                            element.TextImageRelation = TextImageRelation.TextBeforeImage;
                            element.Image = Properties.Resources.Bullet15_Arrow_Blue;
                            element.ToolTipText = "Click to Pay";

                            element.Enabled = true;
                        }
                        //else
                        //{
                        //    element.ImageAlignment = ContentAlignment.MiddleCenter;
                        //    element.TextImageRelation = TextImageRelation.TextBeforeImage;
                        //    element.Image = Properties.Resources.apply_icon;
                        //    element.ToolTipText = "Done";
                        //   element.Enabled = false;
                        //}
                    }
                    if (column.Name == "ColHold")
                    {
                        if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "HOLD")
                        {
                            element.ImageAlignment = ContentAlignment.MiddleCenter;
                            element.TextImageRelation = TextImageRelation.TextBeforeImage;
                            element.Image = Properties.Resources.cancel16;
                            element.ToolTipText = "this button is disaled";

                            element.Enabled = false;
                        }
                        //else
                        //{
                        //    element.ImageAlignment = ContentAlignment.MiddleCenter;
                        //    element.TextImageRelation = TextImageRelation.TextBeforeImage;
                        //    element.Image = Properties.Resources.apply_icon;
                        //    element.ToolTipText = "Done";
                        //   element.Enabled = false;
                        //}
                    }
                    if (column.Name == "ColPay")
                    {
                        if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "FOR PAYMENT")
                        {
                            element.ImageAlignment = ContentAlignment.MiddleCenter;
                            element.TextImageRelation = TextImageRelation.TextBeforeImage;
                            element.Image = Properties.Resources.Bullet15_Arrow_Blue;
                            element.ToolTipText = "Click to Pay";

                            element.Enabled = true;
                        }
                        //else
                        //{
                        //    element.ImageAlignment = ContentAlignment.MiddleCenter;
                        //    element.TextImageRelation = TextImageRelation.TextBeforeImage;
                        //    element.Image = Properties.Resources.apply_icon;
                        //    element.ToolTipText = "Done";
                        //   element.Enabled = false;
                        //}
                    }
                    if (column.Name == "ColHold")
                    {
                        if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "FOR PAYMENT")
                        {
                            element.ImageAlignment = ContentAlignment.MiddleCenter;
                            element.TextImageRelation = TextImageRelation.TextBeforeImage;
                            element.Image = Properties.Resources.bookmark_16;
                            element.ToolTipText = "Click to Hold";

                            element.Enabled = true;
                        }
                        //else
                        //{
                        //    element.ImageAlignment = ContentAlignment.MiddleCenter;
                        //    element.TextImageRelation = TextImageRelation.TextBeforeImage;
                        //    element.Image = Properties.Resources.apply_icon;
                        //    element.ToolTipText = "Done";
                        //   element.Enabled = false;
                        //}
                    }


                }
            }
        }

        private void radButton1_Click(object sender, EventArgs e)
        {
            dgvTransactionList.DataSource = null;
            dgvLedgerList.DataSource = null;
            dgvPaymentList.DataSource = null;
            ComputationRecid = 0;
            RefId = string.Empty;
            ClientId = string.Empty;
            txtClientName.Text = string.Empty;
            frmGetSelectClient forms = new frmGetSelectClient();
            forms.ShowDialog();
            if (forms.IsProceed)
            {
                ClientId = forms.ClientID;
            }
            M_GetReferenceByClientID();

            M_GetComputationById();
            M_GetCheckPaymentStatus();
            M_GetPaymentListByReferenceId();
        }

        private void dgvTransactionList_SelectionChanged(object sender, EventArgs e)
        {
            if (dgvTransactionList.Rows.Count > 0)
            {
                ComputationRecid = Convert.ToInt32(dgvTransactionList.CurrentRow.Cells["RecId"].Value);
                M_GetLedgerList();
                M_GetComputationById();
                M_GetCheckPaymentStatus();
                M_GetPaymentListByReferenceId();

            }
        }

        private void dgvPaymentList_CellFormatting(object sender, Telerik.WinControls.UI.CellFormattingEventArgs e)
        {
            e.CellElement.ForeColor = Color.White;
            //e.CellElement.Font = new Font("Tahoma", 7f, FontStyle.Bold);

            e.CellElement.DrawFill = true;
            e.CellElement.GradientStyle = GradientStyles.Solid;
            e.CellElement.BackColor = Color.Green;
        }

        private void dgvLedgerList_CellClick(object sender, GridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                if (this.dgvLedgerList.Columns[e.ColumnIndex].Name == "ColPay")
                {
                    if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "PENDING" || Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "HOLD" || Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "FOR PAYMENT")
                    {
                        if (MessageBox.Show("Are you sure you want to proceed  to this payment?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
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
                                frmReceivePayment.Amount = Convert.ToString(dgvLedgerList.CurrentRow.Cells["LedgAmount"].Value);
                                frmReceivePayment.ShowDialog();
                                if (frmReceivePayment.IsProceed)
                                {
                                    ReceiveAmount = frmReceivePayment.txtReceiveAmount.Text == string.Empty ? 0 : decimal.Parse(frmReceivePayment.txtReceiveAmount.Text);
                                    ChangeAmount = frmReceivePayment.txtChangeAmount.Text == string.Empty ? 0 : decimal.Parse(frmReceivePayment.txtChangeAmount.Text);
                                    M_sp_GenerateFirstPayment();
                                    M_GetCheckPaymentStatus();
                                    M_GetLedgerList();
                                    M_GetPaymentListByReferenceId();
                                }
                            }
                        }
                    }

                }
                else if (this.dgvLedgerList.Columns[e.ColumnIndex].Name == "ColHold")
                {
                    if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "PENDING")
                    {
                        if (MessageBox.Show("Are you sure you want to hold to this payment?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                        {
                            string result = PaymentContext.HoldPayment(RefId, Convert.ToInt32(dgvLedgerList.CurrentRow.Cells["Recid"].Value));
                            if (!string.IsNullOrEmpty(result))
                            {
                                if (result.Equals("SUCCESS"))
                                {
                                    MessageBox.Show("PAYMENT HOLD SUCCESS", "System Message", MessageBoxButtons.OK);
                                    M_GetPaymentListByReferenceId();
                                }
                                else
                                {
                                    MessageBox.Show(result, "System Message", MessageBoxButtons.OK);
                                }
                            }
                        }
                    }

                }
            }
        }

        private void btnCloseContract_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Are you sure you want to Close the contract ?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
            {
                string result = PaymentContext.CloseContract(RefId);
                if (!string.IsNullOrEmpty(result))
                {
                    if (result.Equals("SUCCESS"))
                    {
                        MessageBox.Show("CLOSE CONTRACT SUCCESS", "System Message", MessageBoxButtons.OK);
                        M_GetPaymentListByReferenceId();
                        M_GetComputationById();
                        M_GetCheckPaymentStatus();
                        this.btnCloseContract.Enabled = false;
                    }
                    else
                    {
                        MessageBox.Show(result, "System Message", MessageBoxButtons.OK);
                    }
                }
            }
        }

        private void btnTerminateContract_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Are you sure you want to Terminate the contract ?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
            {
                string result = PaymentContext.TerminateContract(RefId);
                if (!string.IsNullOrEmpty(result))
                {
                    if (result.Equals("SUCCESS"))
                    {
                        MessageBox.Show("CLOSE CONTRACT SUCCESS", "System Message", MessageBoxButtons.OK);
                        M_GetComputationById();
                        M_GetCheckPaymentStatus();
                        M_GetPaymentListByReferenceId();
                    }
                    else
                    {
                        MessageBox.Show(result, "System Message", MessageBoxButtons.OK);
                    }
                }
            }
        }
    }
}
