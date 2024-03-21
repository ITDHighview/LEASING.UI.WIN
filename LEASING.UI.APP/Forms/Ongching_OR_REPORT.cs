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

namespace LEASING.UI.APP.Forms
{
    public partial class Ongching_OR_REPORT : Form
    {
        public string sTranID { get; set; } = string.Empty;
        public string sMode { get; set; } = string.Empty;
        public string sPaymentLevel { get; set; } = string.Empty;
        public Ongching_OR_REPORT(string TranID)
        {
            InitializeComponent();
            sTranID = TranID.Trim();
        }

        private void Ongching_PR_REPORT_Load(object sender, EventArgs e)
        {
            Functions.GetReceiptReport(Config.Ongching_OR_REPORT, this, Config.RecieptReportOption, sTranID, sMode, sPaymentLevel);
        }
    }
}
