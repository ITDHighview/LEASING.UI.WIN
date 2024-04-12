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
    public partial class frmContractSingedParkingReport : Form
    {
        public string sRefID { get; set; } = string.Empty;
        public frmContractSingedParkingReport(string RefID)
        {
            InitializeComponent();
            sRefID = RefID;
        }

        private void frmContractSingedParkingReport_Load(object sender, EventArgs e)
        {
            Functions.GetContractSignedParkingReport(Config.CONTRACT_PARKING_REPORT, this, Config.RecieptReportOption, sRefID);
        }
    }
}
