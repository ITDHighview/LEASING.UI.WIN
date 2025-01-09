
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
    /*Second & Follow-up Payment Transaction*/
    public partial class ClientLedger : Form
    {

        #region Context
        private ClientContext _client = new ClientContext();
        private ComputationContext _contract = new ComputationContext();
        private PaymentContext _payment = new PaymentContext();
        private UnitContext _unit = new UnitContext();
        #endregion

        #region Constant
        private const string _TYPE_OF_UNIT_ = "TYPE OF UNIT";
        private const string _MSSG_SUCCESS_ = "SUCCESS";
        private const string _PAYMENT_SUCCESS_ = "PAYMENT SUCCESS";
        #endregion

        #region Viriables
        enum PaymentStatus
        {
            HOLD,
            PENDING

        }
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

                        this.btnPayAll.Text = "Pay";
                        break;

                    case false:
                        this.btnPayAll.Text = "Pay All";
                        break;
                }
            }
        }
        private int _contractId { get; set; } = 0;
        private string _contractNumber { get; set; }
        private string _clientId { get; set; }
        private bool _isProceedWithHold { get; set; } = false;
        public string TranID = string.Empty;
        public string RecieptID = string.Empty;
        public int TotalRental { get; set; }
        public string AdvancePaymentAmount { get; set; }


        public string FromDate { get; set; }
        public string Todate { get; set; }
        public int TotalAmount { get; set; }
        public decimal ReceiveAmount { get; set; }
        public decimal ChangeAmount { get; set; }
        public string CompanyORNo { get; set; }
        public string CompanyPRNo { get; set; }
        public string BankAccountName { get; set; }
        public string BankAccountNumber { get; set; }
        public string BankBranch { get; set; }
        public string BankName { get; set; }
        public string SerialNo { get; set; }
        public string PaymentRemarks { get; set; }
        public string REF { get; set; }
        public string ModeType { get; set; }
        public bool IsMoveOut { get; set; } = false;
        public string ItemTypeOf { get; set; } = string.Empty;
        public int ItemRecid { get; set; } = 0;
        public decimal ItemLedgAmount { get; set; } = 0;
        public int ItemTotalSelectedMonth { get; set; } = 0;
        public decimal ActualAmountTobePaidFromPaymentMode { get; set; } = 0;
        public bool IsHold { get; set; } = false;
        public bool IsClearPDC { get; set; } = false;
        public string RecieptDate { get; set; }
        public string CheckDate { get; set; }
        #endregion

        #region Call Methods
        private void OnInitialized()
        {
            this.FormLoadDisabledControls();
            this.FormLoadReadOnlyControls();
            this.getContractById();
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
                    if (Convert.ToBoolean(this.dgvLedgerList.Rows[iRow].Cells["ColCheck"].Value) && (Convert.ToString(this.dgvLedgerList.Rows[iRow].Cells["PaymentStatus"].Value) == "PENDING" || Convert.ToString(this.dgvLedgerList.Rows[iRow].Cells["PaymentStatus"].Value) == "HOLD" || Convert.ToString(this.dgvLedgerList.Rows[iRow].Cells["PaymentStatus"].Value) == "DUE"))
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
                    if (Convert.ToString(this.dgvLedgerList.Rows[iRow].Cells["PaymentStatus"].Value) == "PENDING" || Convert.ToString(this.dgvLedgerList.Rows[iRow].Cells["PaymentStatus"].Value) == "HOLD" || Convert.ToString(this.dgvLedgerList.Rows[iRow].Cells["PaymentStatus"].Value) == "DUE")
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
        private decimal fn_ConvertStringToDecimal(string amountString)
        {
            if (string.IsNullOrEmpty(amountString) || amountString == "0" || amountString == "0.00")
            {
                return 0;
            }
            return decimal.Parse(amountString);
        }
        private void InitiliazedGridItem()
        {
            this.ItemTypeOf = Convert.ToString(dgvTransactionList.CurrentRow.Cells["TypeOf"].Value);
            this.ItemRecid = Convert.ToInt32(dgvLedgerList.CurrentRow.Cells["Recid"].Value);
            //this.ItemLedgAmount = Convert.ToDecimal(dgvLedgerList.CurrentRow.Cells["LedgAmount"].Value);
            this.ItemTotalSelectedMonth = this.CountGridCheckBoxCheck();
            //this.ItemTotalAmountBySelectedMonth = this.getTotalAmountSelected();

            if (string.IsNullOrEmpty(this.ItemTypeOf))
            {
                Functions.MessageShow("Grid Item TypeOf is Empty.");
                return;
            }
            if (this.ItemRecid < 0)
            {
                Functions.MessageShow("Grid Item Recid is Empty.");
                return;
            }
            //if (this.ItemLedgAmount <= 0)
            //{
            //    Functions.MessageShow("Grid Item LedgAmount is Empty.");
            //    return;
            //}
            //if (this.ItemTotalSelectedMonth <= 0)
            //{
            //    Functions.MessageShow("Total Selected Month is less than 0.");
            //    return;
            //}
            //if (this.ItemTotalAmountBySelectedMonth <= 0)
            //{
            //    Functions.MessageShow("Total Amount By Selected Month is less than 0.");
            //    return;
            //}

        }
        private void GeneratePayment()
        {
            try
            {

                this.InitiliazedGridItem();

                string result = _payment.GenerateBulkPayment(this._contractNumber,
                this.ActualAmountTobePaidFromPaymentMode,
                this.ReceiveAmount,
                this.ChangeAmount,
                this.CompanyORNo,
                this.CompanyPRNo,
                this.BankAccountName,
                this.BankAccountNumber,
                this.BankName,
                this.SerialNo,
                this.PaymentRemarks,
                this.REF,
                this.ModeType,
                this.ItemRecid,
                this.M_getXMLData(),
                this.BankBranch,
                this.RecieptDate,
                this.CheckDate,
                 out TranID,
                 out RecieptID
                 );
                Functions.ShowLoadingBar("Processing...");
                if (!result.Equals(_MSSG_SUCCESS_))
                {
                    Functions.MessageShow(result);

                    return;
                }

                Functions.MessageShow(_PAYMENT_SUCCESS_);

                if (string.IsNullOrEmpty(this.TranID))
                {
                    Functions.MessageShow("No transaction code is generated, Please contact system administrator");
                    return;
                }

                if (string.IsNullOrEmpty(this.RecieptID))
                {
                    Functions.MessageShow("No Receipt code is generated, Please contact system administrator");
                    return;
                }

                Functions.GetNotification("PAYMENT SUCCESS ", $" Transaction ID : {TranID} generated");
                Functions.GetNotification("PAYMENT SUCCESS ", $" Reciept ID : {RecieptID} generated");

                this.getContractById();
                this.checkPaymentProgressStatus();
                this.getLedgerBrowseByContractIdClientId();
                this.getPaymentBrowseByContractNumber();

                var fReciept = new PrintReceiptSecondPaymentCategory(this.TranID, "", "SECOND");
                this.InitReciept(fReciept);

            }
            catch (Exception ex)
            {
                Functions.LogError("GeneratePayment()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("GeneratePayment()", ex.ToString());
            }
        }
        private bool IsComputationValid()
        {
            if (string.IsNullOrEmpty(this._clientId))
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

        bool IsContractApplyMonthlyPenalty = false;
        bool IsApplyMonthlyPenalty = false;


        private bool IsHasContractApplyMonthlyPenalty(int contractid)
        {
            try
            {
                using (DataSet dt = _contract.GetIsContractApplyMonthlyPenalty(contractid))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        IsContractApplyMonthlyPenalty = Convert.ToBoolean(dt.Tables[0].Rows[0]["IsContractApplyMonthlyPenalty"]);
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("IsHasContractApplyMonthlyPenalty()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("IsHasContractApplyMonthlyPenalty()", ex.ToString());
            }



            return IsContractApplyMonthlyPenalty;
        }


        bool IsHasPenalty = false;
        string MonthHavePenalty = string.Empty;
        string AmountOfPenalty = string.Empty;
        private void IsContractHaveMonthlyPenalty(int contractid)
        {
            try
            {
                using (DataSet dt = _contract.GetIsContractHaveMonthlyPenalty(contractid))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        IsHasPenalty = Convert.ToBoolean(dt.Tables[0].Rows[0]["IsHasPenalty"]);
                        MonthHavePenalty = Convert.ToString(dt.Tables[0].Rows[0]["MonthHavePenalty"]);
                        AmountOfPenalty = Convert.ToString(dt.Tables[0].Rows[0]["AmountOfPenalty"]);

                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("IsContractHaveMonthlyPenalty()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("IsContractHaveMonthlyPenalty()", ex.ToString());
            }
        }
        private bool IsContractPenaltyIsActive = false;
        private bool CheckContractMonthlyPenaltyIsActive(int contractid)
        {
            try
            {
                using (DataSet dt = _contract.CheckContractMonthlyPenaltyIsActive(contractid))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        IsContractPenaltyIsActive = Convert.ToBoolean(dt.Tables[0].Rows[0]["IsContractPenaltyIsActive"]);
         

                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("CheckContractMonthlyPenaltyIsActive()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("CheckContractMonthlyPenaltyIsActive()", ex.ToString());
            }

            return IsContractPenaltyIsActive;
        }

        private void getOnLoadLedgerBrowseByContractIdClientId()
        {

            try
            {
                IsContractHaveMonthlyPenalty(this._contractId);

                
                if (IsHasContractApplyMonthlyPenalty(this._contractId))
                {
                    //if (Functions.MessageConfirm("Would you like to integrate penalty for this contract?") == DialogResult.Yes)
                    //{
                    //    IsApplyMonthlyPenalty = true;
                    //}
                    if (IsHasPenalty)
                    {
                        PenaltyQuestionDetails penaltyquestion = new PenaltyQuestionDetails(MonthHavePenalty, AmountOfPenalty);

                        penaltyquestion.ShowDialog();
                        if (penaltyquestion.IsProceed)
                        {
                            IsApplyMonthlyPenalty = true;
                        }
                    }
                }

                dgvLedgerList.DataSource = null;
                using (DataSet dt = _contract.GetLedgerListWithPenaltyIntegration(this._contractId, this._clientId, IsApplyMonthlyPenalty))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        dgvLedgerList.DataSource = dt.Tables[0];
                    }
                }


            }
            catch (Exception ex)
            {
                Functions.LogError("getOnLoadLedgerBrowseByContractIdClientId()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("getOnLoadLedgerBrowseByContractIdClientId()", ex.ToString());
            }
        }

        private void getLedgerBrowseByContractIdClientId()
        {
            try
            {
                dgvLedgerList.DataSource = null;
                using (DataSet dt = _contract.GetLedgerListWithPenaltyIntegration(this._contractId, this._clientId, IsApplyMonthlyPenalty))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        dgvLedgerList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("getLedgerBrowseByContractIdClientId()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("getLedgerBrowseByContractIdClientId()", ex.ToString());
            }
        }
        private void getContractBrowseByClientId()
        {
            try
            {
                dgvTransactionList.DataSource = null;
                using (DataSet dt = _contract.GetReferenceByClientID(this._clientId))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {

                        dgvTransactionList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("getContractBrowseByClientId()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("getContractBrowseByClientId()", ex.ToString());
            }
        }
        private void getPaymentBrowseByContractNumber()
        {
            try
            {
                dgvPaymentList.DataSource = null;
                using (DataSet dt = _contract.GetPaymentListByReferenceId(this._contractNumber))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {

                        dgvPaymentList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("getPaymentBrowseByContractNumber()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("getPaymentBrowseByContractNumber()", ex.ToString());
            }
        }
        private void getContractById()
        {
            if (this._contractId <= 0)
            {
                return;
            }
            txtTotalPay.Text = string.Empty;
            try
            {
                using (DataSet dt = _contract.GetContractById(this._contractId))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        this._contractNumber = Convert.ToString(dt.Tables[0].Rows[0]["RefId"]);
                        this.txtClientName.Text = Convert.ToString(dt.Tables[0].Rows[0]["InquiringClient"]);
                        this.IsMoveOut = Convert.ToBoolean(dt.Tables[0].Rows[0]["IsUnitMoveOut"]);
                        this.dtpFrom.Text = Convert.ToString(dt.Tables[0].Rows[0]["StatDate"]);
                        this.dtpTo.Text = Convert.ToString(dt.Tables[0].Rows[0]["FinishDate"]);
                        this.TotalRental = Convert.ToInt32(dt.Tables[0].Rows[0]["TotalRent"]);
                        this.AdvancePaymentAmount = Convert.ToString(dt.Tables[0].Rows[0]["AdvancePaymentAmount"]);
                        this.txtTotalPay.Text = Convert.ToString(dt.Tables[0].Rows[0]["TotalPayAMount"]);
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("getContractById()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("getContractById()", ex.ToString());
            }
        }
        private void checkPaymentProgressStatus()
        {
            try
            {
                using (DataSet dt = _payment.GetCheckPaymentStatus(this._contractNumber))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        this.txtPaymentStatus.Text = Convert.ToString(dt.Tables[0].Rows[0]["PAYMENT_STATUS"]);
                        if (Convert.ToString(dt.Tables[0].Rows[0]["PAYMENT_STATUS"]) == "IN-PROGRESS")
                        {
                            this.btnCloseContract.Enabled = false;
                            this.btnTerminateContract.Enabled = true;
                            this.btnTerminateContract.Visible = true;
                            this.btnPayAll.Enabled = true;
                            this.btnPayAll.Visible = true;
                        }
                        else if (Convert.ToString(dt.Tables[0].Rows[0]["PAYMENT_STATUS"]) == "PAYMENT DONE")
                        {
                            //Functions.GetNotification("Payment Status", this.txtPaymentStatus.Text);
                            this.btnCloseContract.Enabled = true;
                            this.btnTerminateContract.Enabled = false;
                            this.btnTerminateContract.Visible = false;
                            this.btnPayAll.Enabled = false;
                            this.btnPayAll.Visible = false;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("checkPaymentProgressStatus()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("checkPaymentProgressStatus()", ex.ToString());
            }
        }
        private int CountGridCheckBoxCheck()
        {
            int idx = 0;
            if (this.IsPayAsSelected)
            {
                for (int iRow = 0; iRow < dgvLedgerList.Rows.Count; iRow++)
                {
                    if (Convert.ToBoolean(this.dgvLedgerList.Rows[iRow].Cells["ColCheck"].Value) && Convert.ToString(this.dgvLedgerList.Rows[iRow].Cells["PaymentStatus"].Value) == PaymentStatus.HOLD.ToString())
                    {
                        //if (Functions.MessageConfirm("There is a hold payment on your list would you like to proceed?") == DialogResult.Yes)
                        //{
                        if (Convert.ToBoolean(this.dgvLedgerList.Rows[iRow].Cells["ColCheck"].Value) && (Convert.ToString(this.dgvLedgerList.Rows[iRow].Cells["PaymentStatus"].Value) == PaymentStatus.PENDING.ToString() || Convert.ToString(this.dgvLedgerList.Rows[iRow].Cells["PaymentStatus"].Value) == PaymentStatus.HOLD.ToString()))
                        {
                            //alDoctorSchedule.Add(Convert.ToString(vMasterRecordID));
                            idx++;
                        }
                        this._isProceedWithHold = true;
                        //}
                        //else
                        //{
                        //    this.IsProceedWithHold = false;
                        //}
                    }
                    else
                    {
                        if (Convert.ToBoolean(this.dgvLedgerList.Rows[iRow].Cells["ColCheck"].Value) && Convert.ToString(this.dgvLedgerList.Rows[iRow].Cells["PaymentStatus"].Value) == PaymentStatus.PENDING.ToString())
                        {
                            //alDoctorSchedule.Add(Convert.ToString(vMasterRecordID));
                            idx++;
                        }
                        this._isProceedWithHold = true;
                    }
                }
            }
            else
            {
                for (int iRow = 0; iRow < dgvLedgerList.Rows.Count; iRow++)
                {
                    if (Convert.ToString(this.dgvLedgerList.Rows[iRow].Cells["PaymentStatus"].Value) == "HOLD")
                    {
                        //if (Functions.MessageConfirm("There is a hold payment on your list would you like to proceed?") == DialogResult.Yes)
                        //{
                        if (Convert.ToString(this.dgvLedgerList.Rows[iRow].Cells["PaymentStatus"].Value) == PaymentStatus.PENDING.ToString() || Convert.ToString(this.dgvLedgerList.Rows[iRow].Cells["PaymentStatus"].Value) == PaymentStatus.HOLD.ToString())
                        {
                            //alDoctorSchedule.Add(Convert.ToString(vMasterRecordID));
                            idx++;
                        }
                        this._isProceedWithHold = true;
                        //}
                        //else
                        //{
                        //    this.IsProceedWithHold = false;
                        //}

                    }
                    else
                    {
                        if (Convert.ToString(this.dgvLedgerList.Rows[iRow].Cells["PaymentStatus"].Value) == PaymentStatus.PENDING.ToString())
                        {
                            //alDoctorSchedule.Add(Convert.ToString(vMasterRecordID));
                            idx++;
                        }
                        this._isProceedWithHold = true;
                    }
                }
            }
            return idx;
        }
        private bool InitPayment(BulkPaymentModeForm pForm)
        {
            pForm.XML = this.M_getXMLData();
            pForm.ShowDialog();
            if (!pForm.IsProceed)
            {
                return false;
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
            this.ReceiveAmount = this.fn_ConvertStringToDecimal(pForm.txtReceiveAmount.Text);
            this.ActualAmountTobePaidFromPaymentMode = this.fn_ConvertStringToDecimal(pForm.txtPaidAmount.Text);
            this.ChangeAmount = 0;
            this.IsHold = pForm.IsHold;
            this.IsClearPDC = pForm.IsClearPDC;
            this.RecieptDate = pForm.RecieptDate;
            this.CheckDate = pForm.CheckDate;
            return true;
        }
        private void InitReciept(PrintReceiptSecondPaymentCategory pForm)
        {
            pForm.IsNoOR = string.IsNullOrEmpty(this.CompanyORNo) && !string.IsNullOrEmpty(this.CompanyPRNo);
            pForm.sTypeOf = Convert.ToString(dgvTransactionList.CurrentRow.Cells["TypeOf"].Value);
            pForm.ShowDialog();
        }
        private bool IsGridCheckboxCheck()
        {
            dgvLedgerList.EndEdit();
            foreach (GridViewRowInfo row in dgvLedgerList.Rows)
            {
                GridViewCellInfo cell = row.Cells["ColCheck"] as GridViewCellInfo;
                if (Convert.ToBoolean(cell.Value))
                {
                    this.IsPayAsSelected = true;
                    break;
                }
                else
                {
                    this.IsPayAsSelected = false;
                }
            }
            return this.IsPayAsSelected;
        }
        private void TerminateCOntract()
        {

            if (Functions.MessageConfirm("Are you sure you want to Terminate the contract and Move-Out the Client?") == DialogResult.No)
            {
                return;
            }
            if (string.IsNullOrEmpty(this._contractNumber))
            {
                return;
            }
            try
            {
                string result = _payment.TerminateContract(this._contractNumber);
                if (string.IsNullOrEmpty(result))
                {
                    Functions.MessageShow("Responce is empty please contact system administrator");
                    return;
                }


                if (!result.Equals(_MSSG_SUCCESS_))
                {
                    Functions.MessageShow(result);
                    return;
                }

                Functions.MessageShow($"CONTRACT TERMINATION {result}");
                Functions.GetNotification("CONTRACT TERMINATION ", " You can now proceed for contract closing.");
            }
            catch (Exception ex)
            {
                Functions.LogError("TerminateCOntract()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("TerminateCOntract()", ex.ToString());
            }

            this.getContractById();
            this.checkPaymentProgressStatus();
            this.getPaymentBrowseByContractNumber();
            this.btnTerminateContract.Enabled = false;
            this.btnPayAll.Enabled = false;
        }
        private void SaveTransaction()
        {
            if (Functions.MessageConfirm("Are you sure you want to hold the payment?") == DialogResult.Yes)
            {
                try
                {
                    string result = _payment.HoldPDCPayment(this.M_getXMLData(),
                                                            this.CompanyORNo,
                                                            this.CompanyPRNo,
                                                            this.BankAccountName,
                                                            this.BankAccountNumber,
                                                            this.BankName,
                                                            this.SerialNo,
                                                            this.BankBranch,
                                                            this.REF,
                                                            this.ModeType);
                    Functions.ShowLoadingBar("Processing...");
                    if (!string.IsNullOrEmpty(result))
                    {
                        if (result.Equals("SUCCESS"))
                        {
                            Functions.MessageShow("PAYMENT HOLD SUCCESS");
                            this.checkPaymentProgressStatus();
                            this.getLedgerBrowseByContractIdClientId();
                            this.getPaymentBrowseByContractNumber();
                        }
                        else
                        {
                            Functions.MessageShow(result);
                        }
                    }
                }
                catch (Exception ex)
                {
                    Functions.LogError("SaveTransaction()", this.Text, ex.ToString(), DateTime.Now, this);
                    Functions.ErrorShow("SaveTransaction()", ex.ToString());
                }
            }
        }

        private void ProceedToPayment()
        {
            var fPayment = new BulkPaymentModeForm();
            if (!this.InitPayment(fPayment))
            {
                return;
            }

            if (this.ModeType == "PDC")
            {
                if (this.IsClearPDC == false)
                {
                    this.SaveTransaction();
                }
                else if (this.IsClearPDC == true)
                {
                    this.GeneratePayment();
                }
            }
            else
            {
                this.GeneratePayment();
            }
        }
        private string SavePaymentConfirm() => this.IsGridCheckboxCheck() == true ? "Are you sure you want to pay the selected month?" : "Are you sure you want to pay it all?";
        private void SavePayment()
        {
            if (dgvLedgerList.Rows.Count <= 0)
            {
                return;
            }

            if (Functions.MessageConfirm(this.SavePaymentConfirm()) == DialogResult.No)
            {
                Functions.GetNotification("PAYMENT", "Payment Cancel");
                return;
            }
            this.ProceedToPayment();
        }
        private void MoveOut()
        {
            if (Functions.MessageConfirm("Are you sure you want to Move-Out this CLient? ?") == DialogResult.No)
            {
                return;
            }

            try
            {
                string result = _unit.MovedOut(this._contractNumber);

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

                Functions.MessageShow($"MOVE-OUT {result}");
                Functions.GetNotification("CLIENT MOVE-OUT ", " You can now proceed for contract closing.");
            }
            catch (Exception ex)
            {
                Functions.LogError("MoveOut()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("MoveOut()", ex.ToString());
            }

            this.getPaymentBrowseByContractNumber();
            this.getContractById();
            this.checkPaymentProgressStatus();
            this.btnCloseContract.Enabled = false;
        }
        private void FormLoadDisabledControls()
        {
            this.dtpFrom.Enabled = false;
            this.dtpTo.Enabled = false;
            this.btnCloseContract.Enabled = false;
            this.btnTerminateContract.Enabled = false;
        }
        private void FormLoadReadOnlyControls()
        {
            this.txtClientName.ReadOnly = true;
            this.txtPaymentStatus.ReadOnly = true;
            this.txtTotalPay.ReadOnly = true;
        }
        private void GetOtherPaymentHistoryBrowse()
        {
            try
            {
                dgvOtherPaymentHistory.DataSource = null;
                using (DataSet dt = _payment.GetOtherPaymentBrowseByClientID(this._clientId))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        dgvOtherPaymentHistory.DataSource = dt.Tables[0];

                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("GetOtherPaymentBrowse()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("GetOtherPaymentBrowse()", ex.ToString());
            }


        }

        #endregion

        #region Buttons
        private void btnCheckUnits_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(this.txtClientName.Text))
            {
                Functions.MessageShow("Please Select Client");
                return;
            }

            ClientUnitsBrowse CheckClientUnits = new ClientUnitsBrowse();
            CheckClientUnits.ClientId = this._clientId;
            CheckClientUnits.ShowDialog();
        }
        private void radButton1_Click(object sender, EventArgs e)
        {
            dgvTransactionList.DataSource = null;
            dgvLedgerList.DataSource = null;
            dgvPaymentList.DataSource = null;

            this._contractId = 0;
            this._contractNumber = string.Empty;
            this._clientId = string.Empty;
            this.txtClientName.Text = string.Empty;
            this.txtTotalPay.Text = string.Empty;
            ClientBrowse clientSearch = new ClientBrowse();
            clientSearch.ShowDialog();
            if (!clientSearch.IsProceed)
            {
                return;
            }

            this._clientId = clientSearch.ClientID;

            this.getContractBrowseByClientId();
            this.getContractById();
            this.checkPaymentProgressStatus();
            this.getPaymentBrowseByContractNumber();
            this.GetOtherPaymentHistoryBrowse();
        }
        private void btnCloseContract_Click(object sender, EventArgs e)
        {
            this.MoveOut();
        }
        private void btnTerminateContract_Click(object sender, EventArgs e)
        {
            this.TerminateCOntract();
        }
        private void btnPayAll_Click(object sender, EventArgs e)
        {
            this.SavePayment();
        }
        private void radTextBox1_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }
        #endregion

        #region GridView
        bool isContractMonthlyPenaltyActive = false;
        private void dgvTransactionList_SelectionChanged(object sender, EventArgs e)
        {
            if (dgvTransactionList.Rows.Count <= 0)
            {
                return;
            }

            this._contractId = Convert.ToInt32(dgvTransactionList.CurrentRow.Cells["RecId"].Value);

            this.getOnLoadLedgerBrowseByContractIdClientId();
            this.getContractById();
            this.checkPaymentProgressStatus();
            this.getPaymentBrowseByContractNumber();
            isContractMonthlyPenaltyActive = CheckContractMonthlyPenaltyIsActive(this._contractId);
            if (isContractMonthlyPenaltyActive)
            {
                btnDisableMonthlyPenalty.Text = "Disable Monthly Penalty";
            }
            else
            {
                btnDisableMonthlyPenalty.Text = "Enable Monthly Penalty";
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
        private string GetPaymentLevel()
        {

            return "";
        }
        private void dgvLedgerList_CellClick(object sender, GridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                if (this.dgvLedgerList.Columns[e.ColumnIndex].Name == "ColPay")
                {
                }

                else if (this.dgvLedgerList.Columns[e.ColumnIndex].Name == "ColHold")
                {
                    if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "PENDING" || Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "DUE")
                    {
                        if (MessageBox.Show("Are you sure you want to hold to this payment?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                        {
                            try
                            {
                                string result = _payment.HoldPayment(this._contractNumber, Convert.ToInt32(dgvLedgerList.CurrentRow.Cells["Recid"].Value));
                                if (!string.IsNullOrEmpty(result))
                                {
                                    if (result.Equals("SUCCESS"))
                                    {
                                        MessageBox.Show("PAYMENT HOLD SUCCESS", "System Message", MessageBoxButtons.OK);
                                        this.checkPaymentProgressStatus();
                                        this.getLedgerBrowseByContractIdClientId();
                                        this.getPaymentBrowseByContractNumber();
                                    }
                                    else
                                    {
                                        MessageBox.Show(result, "System Message", MessageBoxButtons.OK);
                                    }
                                }
                            }
                            catch (Exception ex)
                            {
                                Functions.LogError("Cell Click : ColHold", this.Text, ex.ToString(), DateTime.Now, this);
                                Functions.ErrorShow("Cell Click : ColHold", ex.ToString());
                            }
                        }
                    }
                    else if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "HOLD")
                    {
                        if (MessageBox.Show("Are you sure you want to Enable this payment?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                        {
                            try
                            {
                                string result = _payment.EnableHoldPayment(this._contractNumber, Convert.ToInt32(dgvLedgerList.CurrentRow.Cells["Recid"].Value));
                                if (!string.IsNullOrEmpty(result))
                                {
                                    if (result.Equals("SUCCESS"))
                                    {
                                        MessageBox.Show("PAYMENT ENABLED SUCCESS", "System Message", MessageBoxButtons.OK);
                                        this.checkPaymentProgressStatus();
                                        this.getLedgerBrowseByContractIdClientId();
                                        this.getPaymentBrowseByContractNumber();
                                    }
                                    else
                                    {
                                        MessageBox.Show(result, "System Message", MessageBoxButtons.OK);
                                    }
                                }
                            }
                            catch (Exception ex)
                            {
                                Functions.LogError("Cell Click : ColHold", this.Text, ex.ToString(), DateTime.Now, this);
                                Functions.ErrorShow("Cell Click : ColHold", ex.ToString());
                            }
                        }
                    }
                }
                else if (this.dgvLedgerList.Columns[e.ColumnIndex].Name == "ColPrint")
                {
                    if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "PAID")
                    {
                        PrintReceiptFirstPaymentCategory frmRecieptSelection = new PrintReceiptFirstPaymentCategory(Convert.ToString(dgvLedgerList.CurrentRow.Cells["TransactionID"].Value), "", this.GetPaymentLevel());
                        using (DataSet dt = _payment.CheckIfOrIsEmpty(Convert.ToString(dgvLedgerList.CurrentRow.Cells["TransactionID"].Value)))
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
                    this.dgvLedgerList.Rows[e.RowIndex].Cells["ColCheck"].ReadOnly = true;
                    //this.dgvLedgerList.Rows[e.RowIndex].Cells["ColCheck"].Style.DrawFill = true;
                }
                else if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "PENDING")
                {
                    e.CellElement.ForeColor = Color.Black;
                    e.CellElement.DrawFill = true;
                    e.CellElement.GradientStyle = GradientStyles.Solid;
                    e.CellElement.BackColor = Color.Yellow;
                }
                else if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "DUE")
                {
                    e.CellElement.ForeColor = Color.White;
                    e.CellElement.DrawFill = true;
                    e.CellElement.GradientStyle = GradientStyles.Solid;
                    e.CellElement.BackColor = Color.OrangeRed;
                }
                else if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "HOLD")
                {
                    e.CellElement.ForeColor = Color.White;
                    e.CellElement.DrawFill = true;
                    e.CellElement.GradientStyle = GradientStyles.Solid;
                    e.CellElement.BackColor = Color.Red;

                }
                else if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "FREE")
                {
                    e.CellElement.ForeColor = Color.White;
                    //e.CellElement.Font = new Font("Tahoma", 7f, FontStyle.Bold);
                    e.CellElement.DrawFill = true;
                    e.CellElement.GradientStyle = GradientStyles.Solid;
                    e.CellElement.BackColor = Color.Green;
                    this.dgvLedgerList.Rows[e.RowIndex].Cells["ColCheck"].ReadOnly = true;
                    //this.dgvLedgerList.Rows[e.RowIndex].Cells["ColCheck"].Style.DrawFill = true;
                }
                else if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "N/A")
                {
                    e.CellElement.ForeColor = Color.White;
                    //e.CellElement.Font = new Font("Tahoma", 7f, FontStyle.Bold);
                    e.CellElement.DrawFill = true;
                    e.CellElement.GradientStyle = GradientStyles.Solid;
                    e.CellElement.BackColor = Color.PaleVioletRed;
                    this.dgvLedgerList.Rows[e.RowIndex].Cells["ColCheck"].ReadOnly = true;
                    //this.dgvLedgerList.Rows[e.RowIndex].Cells["ColCheck"].Style.DrawFill = true;
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
                    if (column.Name == "ColHold")
                    {
                        if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "FREE")
                        {
                            element.ImageAlignment = ContentAlignment.MiddleCenter;
                            element.TextImageRelation = TextImageRelation.TextBeforeImage;
                            element.Image = Properties.Resources.cancel16;
                            element.ToolTipText = "This button is disabled";

                            element.Enabled = false;
                        }
                    }
                    if (column.Name == "ColHold")
                    {
                        if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "N/A")
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
                            element.Image = Properties.Resources.arrow_redo;
                            //element.ToolTipText = "this button is disaled";
                            element.ToolTipText = "Enable this payment";

                            element.Enabled = true;
                        }
                    }
                    if (column.Name == "ColPay")
                    {
                        if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "DUE")
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
                        if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "DUE")
                        {
                            element.ImageAlignment = ContentAlignment.MiddleCenter;
                            element.TextImageRelation = TextImageRelation.TextBeforeImage;
                            element.Image = Properties.Resources.bookmark_16;
                            element.ToolTipText = "Click to Hold";

                            element.Enabled = true;
                        }
                    }
                    //if (column.Name == "ColCheck")
                    //{
                    //    if (Convert.ToString(this.dgvLedgerList.Rows[e.RowIndex].Cells["PaymentStatus"].Value) == "PAID")
                    //    {
                    //        //element.ImageAlignment = ContentAlignment.MiddleCenter;
                    //        //element.TextImageRelation = TextImageRelation.TextBeforeImage;
                    //        //element.Image = Properties.Resources.bookmark_16;
                    //        //element.ToolTipText = "Click to Hold";

                    //        //e.CellElement.Visibility = ElementVisibility.Hidden;
                    //        e.CellElement.
                    //    }
                    //    else
                    //    {
                    //        //e.CellElement.Enabled = true;
                    //    }
                    //}
                    //if (column.Name == "ColCheck")
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
        #endregion

        public ClientLedger()
        {
            InitializeComponent();
        }
        private void frmSelectClient_Load(object sender, EventArgs e)
        {
            Functions.EventCapturefrmName(this);
            this.OnInitialized();
        }

        private void btnDisableMonthlyPenalty_Click(object sender, EventArgs e)
        {
            if (dgvTransactionList.Rows.Count > 0)
            {
                if (isContractMonthlyPenaltyActive)
                {
                    if (Functions.MessageConfirm("Are you sure you want to disable Monthly penalty to this contract ? ") == DialogResult.Yes)
                    {
                        string result = _contract.DisableContractMonthlyPenalty(this._contractId,false);
                        if (result.Equals("SUCCESS"))
                        {
                            Functions.MessageShow("Contract Monthly Penalty has been disable successfully!.");
                   
                        }
                        else
                        {
                            Functions.MessageShow(result);
                        }
                    }
                    else
                    {
                        Functions.MessageShow("Please select active contract.");
                    }
                }
                else
                {
                    if (Functions.MessageConfirm("Are you sure you want to Enable Monthly penalty to this contract ? ") == DialogResult.Yes)
                    {
                        string result = _contract.DisableContractMonthlyPenalty(this._contractId,true);
                        if (result.Equals("SUCCESS"))
                        {
                            Functions.MessageShow("Contract Monthly Penalty has been Enable successfully!.");
                          
                        }
                        else
                        {
                            Functions.MessageShow(result);
                        }
                    }
                    else
                    {
                        Functions.MessageShow("Please select active contract.");
                    }
                }

            }

            isContractMonthlyPenaltyActive = CheckContractMonthlyPenaltyIsActive(this._contractId);
            if (isContractMonthlyPenaltyActive)
            {
                btnDisableMonthlyPenalty.Text = "Disable Monthly Penalty";
            }
            else
            {
                btnDisableMonthlyPenalty.Text = "Enable Monthly Penalty";
            }

        }

        private void btnWaivePenalty_Click(object sender, EventArgs e)
        {
            if (dgvLedgerList.Rows.Count > 0)
            {
                PenaltyWaiveDetails form = new PenaltyWaiveDetails(this._contractId);
                form.ShowDialog();
                this.getLedgerBrowseByContractIdClientId();

            }
           
        }
    }
}
