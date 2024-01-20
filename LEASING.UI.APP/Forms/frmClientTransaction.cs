using LEASING.UI.APP.Common;
using LEASING.UI.APP.Context;
using System;
using System.Collections;
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
        ClientContext ClientContext = new ClientContext();
        ComputationContext ComputationContext = new ComputationContext();
        PaymentContext PaymentContext = new PaymentContext();
        UnitContext UnitContext = new UnitContext();

        //public bool IsPayAsSelected = false;
        private bool _IsPayAsSelected;

        public bool IsPayAsSelected
        {
            get { return _IsPayAsSelected; }
            set
            {
                _IsPayAsSelected = value;
                switch (_IsPayAsSelected)
                {
                    case true:

                        btnPayAll.Text = "Pay";
                        break;

                    case false:
                        btnPayAll.Text = "Pay All";
                        break;
                }
            }
        }

        public string TranID = string.Empty;
        public int TotalRental { get; set; }
        public int ComputationRecid { get; set; }
        public string AdvancePaymentAmount { get; set; }
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
        public bool IsMoveOut { get; set; } = false;
        public frmClientTransaction()
        {
            InitializeComponent();

        }
        private void M_GenerateSecondPayment()
        {
            if (Convert.ToString(dgvTransactionList.CurrentRow.Cells["TypeOf"].Value) == "TYPE OF UNIT")
            {
                var result = PaymentContext.GenerateSecondPayment(RefId,
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
              Convert.ToInt32(dgvLedgerList.CurrentRow.Cells["Recid"].Value),
              out TranID);
                if (result.Equals("SUCCESS"))
                {
                    MessageBox.Show("PAYMENT SUCCESS", "System Message", MessageBoxButtons.OK);
                    IsProceed = true;
                }
                else
                {
                    MessageBox.Show(result, "System Message", MessageBoxButtons.OK);
                }
            }
            else
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
                else
                {
                    MessageBox.Show(result, "System Message", MessageBoxButtons.OK);
                }
            }
        }
        private void M_GenerateBulkPayment()
        {
            var result = PaymentContext.GenerateBulkPayment(RefId,
            Convert.ToDecimal(dgvLedgerList.CurrentRow.Cells["LedgAmount"].Value) * M_GetTotalSelectedMonth(),
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
          Convert.ToInt32(dgvLedgerList.CurrentRow.Cells["Recid"].Value),
           M_getXMLData(),
          out TranID
          );

            if (result.Equals("SUCCESS"))
            {
                MessageBox.Show("PAYMENT SUCCESS", "System Message", MessageBoxButtons.OK);
                IsProceed = true;
            }
            else
            {
                MessageBox.Show(result, "System Message", MessageBoxButtons.OK);
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
        //private void M_GetClientTypeAndID()
        //{

        //    txtTotalPay.Text = string.Empty;
        //    //txtPaymentStatus.Text = string.Empty;
        //    using (DataSet dt = ClientContext.GetGetClientTypeAndID(ClientId))
        //    {
        //        if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
        //        {
        //            txtTotalPay.Text = Convert.ToString(dt.Tables[0].Rows[0]["ClientType"]);
        //            //txtPaymentStatus.Text = Convert.ToString(dt.Tables[0].Rows[0]["ClientID"]);
        //        }
        //    }
        //}
        private void M_GetComputationById()
        {
            txtTotalPay.Text = string.Empty;

            using (DataSet dt = ComputationContext.GetComputationById(ComputationRecid))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    RefId = Convert.ToString(dt.Tables[0].Rows[0]["RefId"]);
                    txtClientName.Text = Convert.ToString(dt.Tables[0].Rows[0]["InquiringClient"]);
                    IsMoveOut = Convert.ToBoolean(dt.Tables[0].Rows[0]["IsUnitMoveOut"]);
                    dtpFrom.Text = Convert.ToString(dt.Tables[0].Rows[0]["StatDate"]);
                    dtpTo.Text = Convert.ToString(dt.Tables[0].Rows[0]["FinishDate"]);
                    TotalRental = Convert.ToInt32(dt.Tables[0].Rows[0]["TotalRent"]);
                    AdvancePaymentAmount = Convert.ToString(dt.Tables[0].Rows[0]["AdvancePaymentAmount"]);
                    txtTotalPay.Text = Convert.ToString(dt.Tables[0].Rows[0]["TotalPayAMount"]);
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
                        btnCloseContract.Enabled = false;
                        btnTerminateContract.Visible = true;
                        btnTerminateContract.Enabled = true;
                        btnPayAll.Visible = true;
                    }
                    else if (Convert.ToString(dt.Tables[0].Rows[0]["PAYMENT_STATUS"]) == "PAYMENT DONE")
                    {
                        Functions.GetNotification("Payment Status", txtPaymentStatus.Text);
                        btnCloseContract.Enabled = true;
                        btnTerminateContract.Visible = false;
                        btnPayAll.Visible = false;
                    }
                }
            }
        }
        #region XML
        private static string SetXMLTable(ref ArrayList xml)
        {
            StringBuilder strXML = new StringBuilder();
            try
            {
                if (xml.Count > 0)
                {
                    strXML.Append("<Table1>");
                    for (int iIndex = 0; iIndex < xml.Count; iIndex++)
                    {
                        strXML.Append("<c" + (iIndex + 1).ToString() + ">");
                        strXML.Append(parseXML(xml[iIndex]));
                        strXML.Append("</c" + (iIndex + 1).ToString() + ">");
                    }
                    strXML.Append("</Table1>");
                    xml = new ArrayList();
                }
            }
            catch (Exception)
            {

            }
            return strXML.ToString();
        }
        private static string parseXML(object strValue)
        {
            string retValue = string.Empty;
            retValue = strValue.ToString();
            try
            {
                if (retValue.Trim().Length > 0)
                {
                    retValue = retValue.Replace("&", "&amp;");
                    retValue = retValue.Replace("<", "&lt;");
                    retValue = retValue.Replace(">", "&gt;");
                    retValue = retValue.Replace("\"", "&quot;");
                    retValue = retValue.Replace("'", "&apos;");

                    retValue = retValue.Trim();
                }
            }
            catch (Exception)
            {

            }
            return retValue;
        }
        private string M_getXMLData()
        {
            StringBuilder sbPayment = new StringBuilder();
            ArrayList alAdvancePayment = new ArrayList();
            this.dgvLedgerList.BeginEdit();
            if (IsPayAsSelected)
            {
                for (int iRow = 0; iRow < dgvLedgerList.Rows.Count; iRow++)
                {
                    if (Convert.ToBoolean(this.dgvLedgerList.Rows[iRow].Cells["ColCheck"].Value) && (Convert.ToString(this.dgvLedgerList.Rows[iRow].Cells["PaymentStatus"].Value) == "PENDING" || Convert.ToString(this.dgvLedgerList.Rows[iRow].Cells["PaymentStatus"].Value) == "HOLD"))
                    {
                        //alDoctorSchedule.Add(Convert.ToString(vMasterRecordID));
                        alAdvancePayment.Add(Convert.ToString(this.dgvLedgerList.Rows[iRow].Cells["Recid"].Value));
                        sbPayment.Append(SetXMLTable(ref alAdvancePayment));
                    }
                }
            }
            else
            {
                for (int iRow = 0; iRow < dgvLedgerList.Rows.Count; iRow++)
                {
                    if (Convert.ToString(this.dgvLedgerList.Rows[iRow].Cells["PaymentStatus"].Value) == "PENDING" || Convert.ToString(this.dgvLedgerList.Rows[iRow].Cells["PaymentStatus"].Value) == "HOLD")
                    {
                        //alDoctorSchedule.Add(Convert.ToString(vMasterRecordID));
                        alAdvancePayment.Add(Convert.ToString(this.dgvLedgerList.Rows[iRow].Cells["Recid"].Value));
                        sbPayment.Append(SetXMLTable(ref alAdvancePayment));
                    }
                }
            }

            return sbPayment.ToString();
        }
        #endregion
        private int M_GetTotalSelectedMonth()
        {
            int idx = 0;
            if (IsPayAsSelected)
            {
                for (int iRow = 0; iRow < dgvLedgerList.Rows.Count; iRow++)
                {
                    if (Convert.ToBoolean(this.dgvLedgerList.Rows[iRow].Cells["ColCheck"].Value) && Convert.ToString(this.dgvLedgerList.Rows[iRow].Cells["PaymentStatus"].Value) == "PENDING")
                    {
                        //alDoctorSchedule.Add(Convert.ToString(vMasterRecordID));
                        idx++;
                    }
                }
            }
            else
            {
                for (int iRow = 0; iRow < dgvLedgerList.Rows.Count; iRow++)
                {
                    if (Convert.ToString(this.dgvLedgerList.Rows[iRow].Cells["PaymentStatus"].Value) == "PENDING")
                    {
                        //alDoctorSchedule.Add(Convert.ToString(vMasterRecordID));
                        idx++;
                    }
                }
            }

            return idx;
        }
        private void frmSelectClient_Load(object sender, EventArgs e)
        {
            dtpFrom.Enabled = false;
            dtpTo.Enabled = false;

            txtClientName.ReadOnly = true;
            txtPaymentStatus.ReadOnly = true;
            txtTotalPay.ReadOnly = true;

            M_GetComputationById();
            //M_GetClientTypeAndID();
            btnCloseContract.Enabled = false;
            btnTerminateContract.Enabled = false;
        }
        private void radTextBox1_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }
        private void radDateTimePicker2_ValueChanged(object sender, EventArgs e)
        {
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
            if (!string.IsNullOrEmpty(txtClientName.Text))
            {
                frmCheckClientUnits forms = new frmCheckClientUnits();
                forms.ClientId = ClientId;
                forms.ShowDialog();
            }
            else
            {
                MessageBox.Show("Please Select Client", "System Message", MessageBoxButtons.OK);
            }
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
                    if (column.Name == "ColPrint")
                    {
                        if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "PAID")
                        {
                            //element.ImageAlignment = ContentAlignment.MiddleCenter;
                            //element.TextImageRelation = TextImageRelation.TextBeforeImage;
                            //element.Text = "Un-Map";
                            element.Image = Properties.Resources.print_16;
                            element.ToolTipText = "Print Reciept";
                            element.Enabled = true;
                        }
                        else
                        {
                            element.Image = Properties.Resources.print_16;
                            element.ToolTipText = "This button is disabled";
                            element.Enabled = false;
                        }
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
                    }
                    //if (column.Name == "ColCheck" && e.RowIndex >= 0)
                    //{
                    //    if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "PAID")
                    //    {
                    //        //element.ImageAlignment = ContentAlignment.MiddleCenter;
                    //        //element.TextImageRelation = TextImageRelation.TextBeforeImage;
                    //        //element.Image = Properties.Resources.bookmark_16;
                    //        //element.ToolTipText = "Click to Hold";

                    //        e.CellElement.Visibility = ElementVisibility.Hidden;
                    //    }
                    //}
                    //if (column.Name == "ColCheck" && e.RowIndex >= 0)
                    //{
                    //    if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "HOLD")
                    //    {
                    //        //element.ImageAlignment = ContentAlignment.MiddleCenter;
                    //        //element.TextImageRelation = TextImageRelation.TextBeforeImage;
                    //        //element.Image = Properties.Resources.bookmark_16;
                    //        //element.ToolTipText = "Click to Hold";

                    //        e.CellElement.Visibility = ElementVisibility.Hidden;
                    //    }
                    //}
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
                                    M_GenerateSecondPayment();
                                    M_GetComputationById();
                                    M_GetCheckPaymentStatus();
                                    M_GetLedgerList();
                                    M_GetPaymentListByReferenceId();
                                    frmRecieptSelection frmRecieptSelection = new frmRecieptSelection(TranID, "");
                                    if (string.IsNullOrEmpty(CompanyORNo) && !string.IsNullOrEmpty(CompanyPRNo))
                                    {
                                        frmRecieptSelection.IsNoOR = true;
                                    }
                                    else if (!string.IsNullOrEmpty(CompanyORNo) && string.IsNullOrEmpty(CompanyPRNo))
                                    {
                                        frmRecieptSelection.IsNoOR = false;
                                    }
                                    frmRecieptSelection.ShowDialog();
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
                                    M_GetCheckPaymentStatus();
                                    M_GetLedgerList();
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
                else if (this.dgvLedgerList.Columns[e.ColumnIndex].Name == "ColPrint")
                {
                    if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "PAID")
                    {
                        frmRecieptSelection frmRecieptSelection = new frmRecieptSelection(Convert.ToString(dgvLedgerList.CurrentRow.Cells["TransactionID"].Value), "");
                        using (DataSet dt = PaymentContext.CheckIfOrIsEmpty(Convert.ToString(dgvLedgerList.CurrentRow.Cells["TransactionID"].Value)))
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
        }
        private void btnCloseContract_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Are you sure you want to Move-Out this CLient? ?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
            {
                string result = UnitContext.MovedOut(RefId);
                if (!string.IsNullOrEmpty(result))
                {
                    if (result.Equals("SUCCESS"))
                    {
                        MessageBox.Show("MOVE-OUT SUCCESS", "System Message", MessageBoxButtons.OK);
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
            if (MessageBox.Show("Are you sure you want to Terminate the contract and Move-Out the Client?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
            {
                string result = PaymentContext.TerminateContract(RefId);
                if (!string.IsNullOrEmpty(result))
                {
                    if (result.Equals("SUCCESS"))
                    {
                        MessageBox.Show("TERMINATE CONTRACT SUCCESS", "System Message", MessageBoxButtons.OK);
                        M_GetComputationById();
                        M_GetCheckPaymentStatus();
                        M_GetPaymentListByReferenceId();
                        this.btnTerminateContract.Enabled = false;
                    }
                    else
                    {
                        MessageBox.Show(result, "System Message", MessageBoxButtons.OK);
                    }
                }
            }
        }
        private void btnPayAll_Click(object sender, EventArgs e)
        {
            if (dgvLedgerList.Rows.Count > 0)
            {
                foreach (GridViewRowInfo row in dgvLedgerList.Rows)
                {
                    GridViewCellInfo cell = row.Cells["ColCheck"] as GridViewCellInfo;
                    if (Convert.ToBoolean(cell.Value))
                    {
                        IsPayAsSelected = true;
                        break;
                    }
                    else
                    {
                        IsPayAsSelected = false;
                    }
                }
                if (IsPayAsSelected)
                {
                    if (MessageBox.Show("Are you sure you want to pay the selected month?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
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
                            frmReceivePayment.Amount = Convert.ToString(Convert.ToDecimal(dgvLedgerList.CurrentRow.Cells["LedgAmount"].Value) * M_GetTotalSelectedMonth());
                            frmReceivePayment.ShowDialog();
                            if (frmReceivePayment.IsProceed)
                            {
                                ReceiveAmount = frmReceivePayment.txtReceiveAmount.Text == string.Empty ? 0 : decimal.Parse(frmReceivePayment.txtReceiveAmount.Text);
                                ChangeAmount = frmReceivePayment.txtChangeAmount.Text == string.Empty ? 0 : decimal.Parse(frmReceivePayment.txtChangeAmount.Text);
                                M_GenerateBulkPayment();
                                M_GetComputationById();
                                M_GetCheckPaymentStatus();
                                M_GetLedgerList();
                                M_GetPaymentListByReferenceId();

                                frmRecieptSelection frmRecieptSelection = new frmRecieptSelection(TranID, "");
                                if (string.IsNullOrEmpty(CompanyORNo) && !string.IsNullOrEmpty(CompanyPRNo))
                                {
                                    frmRecieptSelection.IsNoOR = true;
                                }
                                else if (!string.IsNullOrEmpty(CompanyORNo) && string.IsNullOrEmpty(CompanyPRNo))
                                {
                                    frmRecieptSelection.IsNoOR = false;
                                }
                                frmRecieptSelection.ShowDialog();
                            }
                        }
                    }
                }
                else
                {
                    if (MessageBox.Show("Are you sure you want to pay it all?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
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
                            frmReceivePayment.Amount = Convert.ToString(Convert.ToDecimal(dgvLedgerList.CurrentRow.Cells["LedgAmount"].Value) * M_GetTotalSelectedMonth());
                            frmReceivePayment.ShowDialog();
                            if (frmReceivePayment.IsProceed)
                            {
                                ReceiveAmount = frmReceivePayment.txtReceiveAmount.Text == string.Empty ? 0 : decimal.Parse(frmReceivePayment.txtReceiveAmount.Text);
                                ChangeAmount = frmReceivePayment.txtChangeAmount.Text == string.Empty ? 0 : decimal.Parse(frmReceivePayment.txtChangeAmount.Text);
                                M_GenerateBulkPayment();
                                M_GetCheckPaymentStatus();
                                M_GetLedgerList();
                                M_GetPaymentListByReferenceId();

                                frmRecieptSelection frmRecieptSelection = new frmRecieptSelection(TranID, "");
                                if (string.IsNullOrEmpty(CompanyORNo) && !string.IsNullOrEmpty(CompanyPRNo))
                                {
                                    frmRecieptSelection.IsNoOR = true;
                                }
                                else if (!string.IsNullOrEmpty(CompanyORNo) && string.IsNullOrEmpty(CompanyPRNo))
                                {
                                    frmRecieptSelection.IsNoOR = false;
                                }
                                frmRecieptSelection.ShowDialog();
                            }
                        }
                    }
                }
            }
            else
            {
                MessageBox.Show("No Ledger is Available", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }
        private void dgvLedgerList_CellValueChanged(object sender, GridViewCellEventArgs e)
        {
            dgvLedgerList.EndEdit();
            if (this.dgvLedgerList.Columns[e.ColumnIndex].Name == "ColCheck")
            {
                IsPayAsSelected = false;
                foreach (GridViewRowInfo row in dgvLedgerList.Rows)
                {
                    GridViewCellInfo cell = row.Cells["ColCheck"] as GridViewCellInfo;
                    if (Convert.ToBoolean(cell.Value))
                    {
                        IsPayAsSelected = true;
                        break;
                    }
                    else
                    {
                        IsPayAsSelected = false;
                    }
                }
            }
        }
    }
}
