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
    public partial class frmClientTransactionParking : Form
    {
        //private DataTable data = new DataTable();
        ClientContext ClientContext = new ClientContext();
        ComputationContext ComputationContext = new ComputationContext();
        PaymentContext PaymentContext = new PaymentContext();
        public int TotalRental { get; set; }
        public int ComputationRecid { get; set; }
        public string TranID { get; set; }
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
        public int ModeType { get; set; }
        public frmClientTransactionParking()
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
            return true;
        }     
        private void M_sp_GenerateFirstPayment()
        {
            var result = PaymentContext.GeneratePaymentParking(RefId,
                Convert.ToString(dgvLedgerList.CurrentRow.Cells["LedgAmount"].Value) == string.Empty ? 0 : decimal.Parse(Convert.ToString(dgvLedgerList.CurrentRow.Cells["LedgAmount"].Value)),
                ReceiveAmount,
                ChangeAmount,
                CompanyORNo,
                CompanyPRNo,
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

            txtClientType.Text = string.Empty;
            txtClientId.Text = string.Empty;
            using (DataSet dt = ClientContext.GetGetClientTypeAndID(ClientId))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    txtClientType.Text = Convert.ToString(dt.Tables[0].Rows[0]["ClientType"]);
                    txtClientId.Text = Convert.ToString(dt.Tables[0].Rows[0]["ClientID"]);
                }
            }
        }
        private void frmSelectClient_Load(object sender, EventArgs e)
        {
            //ComputationRecid = Convert.ToInt32(dgvTransactionList.CurrentRow.Cells["RecId"].Value);
            M_GetLedgerList();
          
            M_GetPaymentListByReferenceId();
            
            M_GetComputationById();
            M_GetClientTypeAndID();
           
        }
        private void M_GetComputationById()
        {
            using (DataSet dt = ComputationContext.GetComputationById(ComputationRecid))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    RefId = Convert.ToString(dt.Tables[0].Rows[0]["RefId"]);
                    txtClientName.Text = Convert.ToString(dt.Tables[0].Rows[0]["InquiringClient"]);
                    dtpFrom.Text = Convert.ToString(dt.Tables[0].Rows[0]["StatDate"]);
                    dtpTo.Text = Convert.ToString(dt.Tables[0].Rows[0]["FinishDate"]);           
                    TotalRental = Convert.ToInt32(dt.Tables[0].Rows[0]["TotalRent"]);                          
                }
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
                    // e.CellElement.ForeColor = Color.White;

                    e.CellElement.DrawFill = true;
                    e.CellElement.GradientStyle = GradientStyles.Solid;
                    e.CellElement.BackColor = Color.Yellow;
                }
                else if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "FOR PAYMENT")
                {
                    // e.CellElement.ForeColor = Color.White;

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


                }
            }
        }
        private void radButton1_Click(object sender, EventArgs e)
        {          
            dgvLedgerList.DataSource = null;
            dgvPaymentList.DataSource = null;
            ComputationRecid = 0;
            RefId = string.Empty;
            ClientId = string.Empty;
            txtClientName.Text = string.Empty;          
            M_GetComputationById();
            M_GetPaymentListByReferenceId();
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
                            frmReceivePayment.Amount = Convert.ToString(dgvLedgerList.CurrentRow.Cells["LedgAmount"].Value);
                            frmReceivePayment.ShowDialog();
                            if (frmReceivePayment.IsProceed)
                            {
                                ReceiveAmount = frmReceivePayment.txtReceiveAmount.Text == string.Empty ? 0 : decimal.Parse(frmReceivePayment.txtReceiveAmount.Text);
                                ChangeAmount = frmReceivePayment.txtChangeAmount.Text == string.Empty ? 0 : decimal.Parse(frmReceivePayment.txtChangeAmount.Text);
                                M_sp_GenerateFirstPayment();
                                M_GetLedgerList();
                                M_GetPaymentListByReferenceId();

                                frmRecieptSelection frmRecieptSelection = new frmRecieptSelection(TranID,RefId);
                                frmRecieptSelection.ShowDialog();
                            }
                        }
                    }
                }
                else if (this.dgvLedgerList.Columns[e.ColumnIndex].Name == "ColHold")
                {
                    if (MessageBox.Show("Are you sure you want to hold to this payment?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                    {

                    }
                }
            }
        }

        private void btnPrintReciept_Click(object sender, EventArgs e)
        {
            frmRecieptSelection frmRecieptSelection = new frmRecieptSelection(TranID, RefId);
            frmRecieptSelection.ShowDialog();
        }
    }
}
