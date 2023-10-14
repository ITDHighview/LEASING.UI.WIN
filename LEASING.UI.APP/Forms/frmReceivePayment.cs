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
    public partial class frmReceivePayment : Form
    {
        public bool IsProceed = false;
        public string Amount = string.Empty;
        public frmReceivePayment()
        {
            InitializeComponent();
        }

        private void btnOK_Click(object sender, EventArgs e)
        {
            IsProceed = true;
            this.Close();
        }

        private void frmReceivePayment_Load(object sender, EventArgs e)
        {
            txtPaidAmount.Text = string.Empty;
            txtPaidAmount.Text = Amount;
        }
    }
}
