using LEASING.UI.APP.Common;
using LEASING.UI.APP.Context;
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
    public partial class GeneralReport : Form
    {
        GeneralReportContext GeneralReportContext = new GeneralReportContext();
        public GeneralReport()
        {
            InitializeComponent();
        }

        private void M_GetGeneralReport()
        {
            dgvList.DataSource = null;
            using (DataSet dt = GeneralReportContext.GetGeneralReport())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    dgvList.DataSource = dt.Tables[0];
                }
            }
        }

        private void btnPrintReport_Click(object sender, EventArgs e)
        {
            if (dgvList.Rows.Count > 0)
            {

            }
        }

        private void btnLoadReport_Click(object sender, EventArgs e)
        {
            if (dgvList.Rows.Count > 0)
            {
                M_GetGeneralReport();
            }
        }

        private void GeneralReport_Load(object sender, EventArgs e)
        {
            Functions.EventCapturefrmName(this);
        }
    }
}
