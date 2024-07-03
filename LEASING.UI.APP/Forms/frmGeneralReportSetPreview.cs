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
    public partial class frmGeneralReportSetPreview : Form
    {
        public frmGeneralReportSetPreview()
        {
            InitializeComponent();
        }

        private void btnPrint_Click(object sender, EventArgs e)
        {
            frmGeneral_REPORT frmreport = new frmGeneral_REPORT();
            frmreport.ShowDialog();
        }
    }
}
