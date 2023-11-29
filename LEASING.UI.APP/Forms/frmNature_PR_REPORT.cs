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
        public frmNature_PR_REPORT()
        {
            InitializeComponent();
        }

        private void frmNature_PR_REPORT_Load(object sender, EventArgs e)
        {
            Functions.GetReceiptReport(Config.Nature_PR_REPORT, this, Config.RecieptReportOption);
        }
    }
}
