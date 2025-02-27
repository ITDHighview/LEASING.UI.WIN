using LEASING.UI.APP.Common;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Telerik.WinControls.UI;

namespace LEASING.UI.APP.Forms
{
    public partial class PrintReceiptFirstPaymentCategory : Form
    {
        const string ADV = "ADV";
        const string SEC = "SEC";
        public string sTranID { get; set; } = string.Empty;
        public string sRefId { get; set; } = string.Empty;
        public string sPaymentLevel { get; set; } = string.Empty;
        public string sMode { get; set; } = string.Empty;
        public bool IsNoOR = false;
        private string GetReceiptMode(RadDropDownList type)
        {
            string vmode = string.Empty;
            switch (type.Text)
            {
                case "ADVANCE":
                    vmode = ADV;
                    break;
                case "DEPOSIT":
                    vmode = SEC;
                    break;
                default:
                    break;
            }
            return vmode;
        }
        private void ShowReceipt(string type)
        {
            switch (type)
            {
                case "NATURE OR":
                    Nature_OR_REPORT Nature_OR_REPORT = new Nature_OR_REPORT(this.sTranID);
                    Nature_OR_REPORT.sMode = this.GetReceiptMode(ddlRecieptCategory);
                    Nature_OR_REPORT.sPaymentLevel = sPaymentLevel;
                    Nature_OR_REPORT.Show();
                    break;
                case "NATURE PR":
                    Nature_PR_REPORT Nature_PR_REPORT = new Nature_PR_REPORT(this.sTranID);
                    Nature_PR_REPORT.sMode = this.GetReceiptMode(ddlRecieptCategory);
                    Nature_PR_REPORT.sPaymentLevel = sPaymentLevel;
                    Nature_PR_REPORT.Show();
                    break;
                case "ONGCHING OR":
                    Ongching_OR_REPORT Ongching_OR_REPORT = new Ongching_OR_REPORT(this.sTranID);
                    Ongching_OR_REPORT.sMode = this.GetReceiptMode(ddlRecieptCategory);
                    Ongching_OR_REPORT.sPaymentLevel = sPaymentLevel;
                    Ongching_OR_REPORT.Show();
                    break;
                case "ONGCHING PR":
                    Ongching_PR_REPORT Ongching_PR_REPORT = new Ongching_PR_REPORT(this.sTranID);
                    Ongching_PR_REPORT.sMode = this.GetReceiptMode(ddlRecieptCategory);
                    Ongching_PR_REPORT.sPaymentLevel = sPaymentLevel;
                    Ongching_PR_REPORT.Show();
                    break;
                default:
                    break;
            }
        }
        public PrintReceiptFirstPaymentCategory(string TranID, string RefId,string PaymentLevel)
        {
            InitializeComponent();
            sTranID = TranID.Trim();
            sRefId = RefId.Trim();
            sPaymentLevel = PaymentLevel.Trim();
        }

        private void frmRecieptSelection_Load(object sender, EventArgs e)
        {
            Functions.EventCapturefrmName(this);         
        }

        private void btnPrint_Click(object sender, EventArgs e)
        {
            ShowReceipt(ddlCompanyRecieptCategory.Text);
        }
    }
}
