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
    public partial class General_REPORT : Form
    {
        public General_REPORT()
        {
            InitializeComponent();
        }

        private void frmGeneral_REPORT_Load(object sender, EventArgs e)
        {
            Functions.EventCapturefrmName(this);
            Functions.GetGeneralReport(Config.GENERAL_REPORT, this, Config.RecieptReportOption, "");
        }
    }
}
