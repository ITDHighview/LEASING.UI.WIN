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
    public partial class frmEditORNumber : Form
    {
        PaymentContext PaymentContext = new PaymentContext();
        public string RcptID { get; set; } = string.Empty;
        public bool IsProceed = false;
        public frmEditORNumber()
        {
            InitializeComponent();
        }

        private void btnCancel_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void M_SaveORNumber()
        {
            if (!string.IsNullOrEmpty(txtORNumber.Text) && !string.IsNullOrEmpty(RcptID))
            {
                string result = PaymentContext.UpdateORNumber(RcptID, txtORNumber.Text);
                if (result.Equals("SUCCESS"))
                {
                    IsProceed = true;
                    MessageBox.Show("OR Number Added Successfully.", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    this.Close();
                }
            }
            else
            {
                MessageBox.Show("OR Number Cannot be empty.", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }
        private void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (MessageBox.Show("Are you sure you want to save?","System Message",MessageBoxButtons.YesNo,MessageBoxIcon.Question,MessageBoxDefaultButton.Button2)== DialogResult.Yes)
                {
                    M_SaveORNumber();
                }
               
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.ToString(), "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }

        private void frmEditORNumber_Load(object sender, EventArgs e)
        {
            txtORNumber.Focus();
            txtReceiptNumber.Text = RcptID;
            txtReceiptNumber.Enabled = false;
           
        }
    }
}
