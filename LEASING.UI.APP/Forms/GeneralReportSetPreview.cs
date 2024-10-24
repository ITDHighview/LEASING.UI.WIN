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
    public partial class GeneralReportSetPreview : Form
    {
        public GeneralReportSetPreview()
        {
            InitializeComponent();
        }

        private void btnPrint_Click(object sender, EventArgs e)
        {
            General_REPORT frmreport = new General_REPORT();
            frmreport.ShowDialog();
        }
    }
}
