using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace LEASING.UI.APP.Forms
{
    public partial class frmRecieptSelectionSecondPayment : Form
    {
        const string REN = "REN";
        const string MAIN = "MAIN";
        enum RecieptType
        {
            NT_OR,
            NT_PR,
            ONCH_OR,
            ONCH_PR,
        }
        public string sTranID { get; set; } = string.Empty;
        public string sRefId { get; set; } = string.Empty;
        public string sMode { get; set; } = string.Empty;
        public string sPaymentLevel { get; set; } = string.Empty;
        public bool IsNoOR = false;

        public frmRecieptSelectionSecondPayment(string TranID, string RefId, string PaymentLevel)
        {
            InitializeComponent();
            sTranID = TranID.Trim();
            sRefId = RefId.Trim();
            sPaymentLevel = PaymentLevel.Trim();
        }
        private string GetReceiptMode(RecieptType type)
        {
            string vmode = string.Empty;
            switch (type)
            {
                case RecieptType.NT_OR:
                    if (chkNatureOR_Advance.IsChecked && !chkNatureOR_Deposit.IsChecked)
                    {
                        vmode = REN;
                    }
                    else
                    {
                        vmode = MAIN;
                    }
                    break;
                case RecieptType.NT_PR:
                    if (chkNaturePR_Advance.IsChecked && !chkNaturePR_Deposit.IsChecked)
                    {
                        vmode = REN;
                    }
                    else
                    {
                        vmode = MAIN;
                    }
                    break;
                case RecieptType.ONCH_OR:
                    if (chkOnchingOR_Advance.IsChecked && !chkOnchingOR_Deposit.IsChecked)
                    {
                        vmode = REN;
                    }
                    else
                    {
                        vmode = MAIN;
                    }
                    break;
                case RecieptType.ONCH_PR:
                    if (chkOnchingPR_Advance.IsChecked && !chkOnchingPR_Deposit.IsChecked)
                    {
                        vmode = REN;
                    }
                    else
                    {
                        vmode = MAIN;
                    }
                    break;
                default:
                    break;
            }
            return vmode;
        }
        private void ShowReceipt(RecieptType type)
        {
            switch (type)
            {
                case RecieptType.NT_OR:
                    frmNature_OR_REPORT Nature_OR_REPORT = new frmNature_OR_REPORT(this.sTranID);
                    Nature_OR_REPORT.sMode = this.GetReceiptMode(type);
                    Nature_OR_REPORT.sPaymentLevel = sPaymentLevel;
                    Nature_OR_REPORT.Show();
                    break;
                case RecieptType.NT_PR:
                    frmNature_PR_REPORT Nature_PR_REPORT = new frmNature_PR_REPORT(this.sTranID);
                    Nature_PR_REPORT.sMode = this.GetReceiptMode(type);
                    Nature_PR_REPORT.sPaymentLevel = sPaymentLevel;
                    Nature_PR_REPORT.Show();
                    break;
                case RecieptType.ONCH_OR:
                    Ongching_PR_REPORT Ongching_OR_REPORT = new Ongching_PR_REPORT(this.sTranID);
                    Ongching_OR_REPORT.sMode = this.GetReceiptMode(type);
                    Ongching_OR_REPORT.sPaymentLevel = sPaymentLevel;
                    Ongching_OR_REPORT.Show();
                    break;
                case RecieptType.ONCH_PR:
                    Ongching_PR_REPORT Ongching_PR_REPORT = new Ongching_PR_REPORT(this.sTranID);
                    Ongching_PR_REPORT.sMode = this.GetReceiptMode(type);
                    Ongching_PR_REPORT.sPaymentLevel = sPaymentLevel;
                    Ongching_PR_REPORT.Show();
                    break;
                default:
                    break;
            }

        }
        private void btnNATURE_OR_Click(object sender, EventArgs e)
        {
            this.ShowReceipt(RecieptType.NT_OR);

        }
        private void btnNATURE_PR_Click(object sender, EventArgs e)
        {
            this.ShowReceipt(RecieptType.ONCH_OR);

        }
        private void btnONGCHING_OR_Click(object sender, EventArgs e)
        {
            this.ShowReceipt(RecieptType.NT_OR);

        }
        private void btnONGCHING_PR_Click(object sender, EventArgs e)
        {
            this.ShowReceipt(RecieptType.ONCH_PR);
        }
        private void frmRecieptSelection_Load(object sender, EventArgs e)
        {


            chkNatureOR_Advance.IsChecked = true;
            chkNaturePR_Advance.IsChecked = true;
            chkOnchingOR_Advance.IsChecked = true;
            chkOnchingPR_Advance.IsChecked = true;

            //if (IsNoOR)
            //{
            //    btnNATURE_OR.Enabled = false;
            //    btnNATURE_PR.Enabled = true;
            //    btnONGCHING_OR.Enabled = false;
            //    btnONGCHING_PR.Enabled = true;

            //    this.pnlNatureOR.Visible = btnNATURE_OR.Enabled;
            //    this.pnlNaturePR.Visible = btnNATURE_PR.Enabled;
            //    this.pnlOnchingOR.Visible = btnONGCHING_OR.Enabled;
            //    this.pnlOnchingPR.Visible = btnONGCHING_PR.Enabled;
            //}
            //else if (!IsNoOR)
            //{
            //    btnNATURE_OR.Enabled = true;
            //    btnNATURE_PR.Enabled = false;
            //    btnONGCHING_OR.Enabled = true;
            //    btnONGCHING_PR.Enabled = false;
            //    this.pnlNatureOR.Visible = btnNATURE_OR.Enabled;
            //    this.pnlNaturePR.Visible = btnNATURE_PR.Enabled;
            //    this.pnlOnchingOR.Visible = btnONGCHING_OR.Enabled;
            //    this.pnlOnchingPR.Visible = btnONGCHING_PR.Enabled;
            //}
            //else
            //{
            //    btnNATURE_OR.Enabled = true;
            //    btnNATURE_PR.Enabled = true;
            //    btnONGCHING_OR.Enabled = true;
            //    btnONGCHING_PR.Enabled = true;
            //    this.pnlNatureOR.Visible = btnNATURE_OR.Enabled;
            //    this.pnlNaturePR.Visible = btnNATURE_PR.Enabled;
            //    this.pnlOnchingOR.Visible = btnONGCHING_OR.Enabled;
            //    this.pnlOnchingPR.Visible = btnONGCHING_PR.Enabled;
            //}
        }

    }
}
