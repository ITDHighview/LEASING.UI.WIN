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
        public string sTranID { get; set; } = string.Empty;
        public string sRefId { get; set; }=string.Empty;
        public frmRecieptSelection(string TranID,string RefId)
        {
            InitializeComponent();
            sTranID = TranID.Trim();
            sRefId = RefId.Trim();
        }            
        private void btnNATURE_OR_Click(object sender, EventArgs e)
        {
            frmNature_OR_REPORT Nature_OR_REPORT = new frmNature_OR_REPORT(sTranID);
            Nature_OR_REPORT.Show();
        }

        private void btnONGCHING_OR_Click(object sender, EventArgs e)
        {
            Ongching_PR_REPORT Ongching_PR_REPORT = new Ongching_PR_REPORT(sTranID);        
            Ongching_PR_REPORT.Show();
        }

        private void btnNATURE_PR_Click(object sender, EventArgs e)
        {        
            frmNature_PR_REPORT Nature_PR_REPORT = new frmNature_PR_REPORT(sTranID);          
            Nature_PR_REPORT.Show();
        }
    }
}
