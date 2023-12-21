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
    public partial class frmRecieptSelection : Form
    {
        public string TranID { get; set; } = string.Empty;
        public string RefId { get; set; } = string.Empty;
        public frmRecieptSelection()
        {
            InitializeComponent();
        }            
        private void btnNATURE_OR_Click(object sender, EventArgs e)
        {
            frmNature_OR_REPORT frmNature_OR_REPORT = new frmNature_OR_REPORT();
            frmNature_OR_REPORT.TranID = TranID;
            frmNature_OR_REPORT.Show();
        }

        private void btnONGCHING_OR_Click(object sender, EventArgs e)
        {
            Ongching_PR_REPORT Ongching_PR_REPORT = new Ongching_PR_REPORT();
            Ongching_PR_REPORT.TranID = TranID;
            Ongching_PR_REPORT.Show();
        }

        private void btnNATURE_PR_Click(object sender, EventArgs e)
        {        
            frmNature_PR_REPORT frmNature_PR_REPORT = new frmNature_PR_REPORT();
            frmNature_PR_REPORT.TranID = TranID;
            frmNature_PR_REPORT.Show();
        }
    }
}
