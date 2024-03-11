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
    public partial class frmNature_PR_REPORT : Form
    {
        public string sTranID { get; set; } = string.Empty;
        public string sMode { get; set; } = string.Empty;
        public frmNature_PR_REPORT(string TranID)
        {
            InitializeComponent();
            sTranID = TranID.Trim();
        }

        private void frmNature_PR_REPORT_Load(object sender, EventArgs e)
        {
            Functions.GetReceiptReport(Config.Nature_PR_REPORT, this, Config.RecieptReportOption, sTranID, sMode);
        }
    }
}
