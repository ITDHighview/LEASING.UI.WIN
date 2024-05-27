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
    public partial class frmContractSingedCommercialReport : Form
    {
        public string sRefID { get; set; } = string.Empty;
        public frmContractSingedCommercialReport(string RefID)
        {
            InitializeComponent();
            sRefID = RefID;
        }

        private void frmContractSingedCommercialReport_Load(object sender, EventArgs e)
        {
            Functions.EventCapturefrmName(this);
            Functions.GetContractSignedCommercialReport(Config.CONTRACT_COMMERCIAL_REPORT, this, Config.RecieptReportOption, sRefID);
        }
    }
}
