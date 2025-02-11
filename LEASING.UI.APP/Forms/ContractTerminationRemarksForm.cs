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
    public partial class ContractTerminationRemarksForm : Form
    {
        public bool Isproceed = false;
        public string Remarks = string.Empty;
        public ContractTerminationRemarksForm()
        {
            InitializeComponent();
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            Isproceed = true;
            Remarks = txtRemarks.Text;
            this.Close();
        }

        private void ContractTerminationRemarksForm_Load(object sender, EventArgs e)
        {
            Remarks = string.Empty;
            txtRemarks.Text = string.Empty;
        }
    }
}
