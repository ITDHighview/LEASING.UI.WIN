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
    public partial class MoveInAuthorizationReport : Form
    {

        public string sRefId { get; set; } = string.Empty;
        public MoveInAuthorizationReport(string RefId)
        {
            InitializeComponent();
            sRefId = RefId;
        }

        private void frmMoveInAuthorizationReport_Load(object sender, EventArgs e)
        {
            Functions.EventCapturefrmName(this);
            Functions.GetMoveInAthorizationReport(Config.MoveIn_AUTHORIZATION_REPORT, this, Config.RecieptReportOption, sRefId);
        }
    }
}
