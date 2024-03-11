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
    public partial class frmRecieptSelectionSecondPayment : Form
    {
        public string sTranID { get; set; } = string.Empty;
        public string sRefId { get; set; } = string.Empty;
        public string sMode { get; set; } = string.Empty;
        public bool IsNoOR = false;

        public frmRecieptSelectionSecondPayment(string TranID, string RefId)
        {
            InitializeComponent();
            sTranID = TranID.Trim();
            sRefId = RefId.Trim();
        }
        private void btnNATURE_OR_Click(object sender, EventArgs e)
        {
            if (chkNatureOR_Advance.IsChecked && !chkNatureOR_Deposit.IsChecked)
            {
                sMode = "REN";
            }
            else
            {
                sMode = "MAIN";
            }
            frmNature_OR_REPORT Nature_OR_REPORT = new frmNature_OR_REPORT(sTranID);
            Nature_OR_REPORT.sMode = sMode;
            Nature_OR_REPORT.Show();
        }

        private void btnONGCHING_OR_Click(object sender, EventArgs e)
        {
            if (chkOnchingOR_Advance.IsChecked && !chkOnchingOR_Deposit.IsChecked)
            {
                sMode = "REN";
            }
            else
            {
                sMode = "MAIN";
            }
            Ongching_PR_REPORT Ongching_PR_REPORT = new Ongching_PR_REPORT(sTranID);
            Ongching_PR_REPORT.sMode = sMode;
            Ongching_PR_REPORT.Show();
        }

        private void btnNATURE_PR_Click(object sender, EventArgs e)
        {
            if (chkNaturePR_Advance.IsChecked && !chkNaturePR_Deposit.IsChecked)
            {
                sMode = "REN";
            }
            else
            {
                sMode = "MAIN";
            }
            frmNature_PR_REPORT Nature_PR_REPORT = new frmNature_PR_REPORT(sTranID);
            Nature_PR_REPORT.sMode = sMode;
            Nature_PR_REPORT.Show();
        }

        private void frmRecieptSelection_Load(object sender, EventArgs e)
        {


            chkNatureOR_Advance.IsChecked = true;
            chkNaturePR_Advance.IsChecked = true;
            chkOnchingOR_Advance.IsChecked = true;
            chkOnchingPR_Advance.IsChecked = true;

            if (IsNoOR)
            {
                btnNATURE_OR.Enabled = false;
                btnNATURE_PR.Enabled = true;
                btnONGCHING_OR.Enabled = false;
                btnONGCHING_PR.Enabled = true;

                this.pnlNatureOR.Visible = btnNATURE_OR.Enabled;
                this.pnlNaturePR.Visible = btnNATURE_PR.Enabled;
                this.pnlOnchingOR.Visible = btnONGCHING_OR.Enabled;
                this.pnlOnchingPR.Visible = btnONGCHING_PR.Enabled;
            }
            else if (!IsNoOR)
            {
                btnNATURE_OR.Enabled = true;
                btnNATURE_PR.Enabled = false;
                btnONGCHING_OR.Enabled = true;
                btnONGCHING_PR.Enabled = false;
                this.pnlNatureOR.Visible = btnNATURE_OR.Enabled;
                this.pnlNaturePR.Visible = btnNATURE_PR.Enabled;
                this.pnlOnchingOR.Visible = btnONGCHING_OR.Enabled;
                this.pnlOnchingPR.Visible = btnONGCHING_PR.Enabled;
            }
            else
            {
                btnNATURE_OR.Enabled = true;
                btnNATURE_PR.Enabled = true;
                btnONGCHING_OR.Enabled = true;
                btnONGCHING_PR.Enabled = true;
                this.pnlNatureOR.Visible = btnNATURE_OR.Enabled;
                this.pnlNaturePR.Visible = btnNATURE_PR.Enabled;
                this.pnlOnchingOR.Visible = btnONGCHING_OR.Enabled;
                this.pnlOnchingPR.Visible = btnONGCHING_PR.Enabled;
            }
        }

        private void btnONGCHING_PR_Click(object sender, EventArgs e)
        {
            if (chkOnchingPR_Advance.IsChecked && !chkOnchingPR_Deposit.IsChecked)
            {
                sMode = "REN";
            }
            else
            {
                sMode = "MAIN";
            }
            Ongching_PR_REPORT Ongching_PR_REPORT = new Ongching_PR_REPORT(sTranID);
            Ongching_PR_REPORT.sMode = sMode;
            Ongching_PR_REPORT.Show();
        }
    }
}
