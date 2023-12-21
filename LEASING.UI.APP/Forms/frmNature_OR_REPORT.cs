using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;
using CrystalDecisions.Windows.Forms;
using LEASING.UI.APP.Common;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace LEASING.UI.APP.Forms
{
    public partial class frmNature_OR_REPORT : Form
    {
        public string TranID { get; set; } = string.Empty;
        public frmNature_OR_REPORT()
        {
            InitializeComponent();
        }

        private void frmNature_OR_REPORT_Load(object sender, EventArgs e)
        {
            Functions.GetReceiptReport(Config.Nature_OR_REPORT,this, Config.RecieptReportOption, TranID);           
        }
    }
}
