using LEASING.UI.APP.Common;
using LEASING.UI.APP.Context;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace LEASING.UI.APP.Forms
{
    public partial class frmReceivePayment : Form
    {
        PaymentContext PaymentContext = new PaymentContext();
        public bool IsProceed = false;
        public bool IsPartialPayment = false;
        public string Amount = string.Empty;
        public int recid = 0;
        int DayCount = 0;
        public frmReceivePayment()
        {
            InitializeComponent();
        }

        private bool IsValid()
        {
            if (string.IsNullOrEmpty(txtReceiveAmount.Text))
            {
                Functions.MessageShow("Receive Amount cannot be empty.");
                return false;
            }
            if (decimal.Parse(txtReceiveAmount.Text) > decimal.Parse(txtPaidAmount.Text))
            {
                Functions.MessageShow("Receive Amount cannot be greater that Due Amount.");
                return false;
            }
            return true;
        }
    
        private void btnOK_Click(object sender, EventArgs e)
        {
            if (IsValid())
            {
                if (decimal.Parse(txtReceiveAmount.Text) != decimal.Parse(txtPaidAmount.Text))
                {
                    if (Functions.MessageConfirm("Due amount is not equal to Recieve amount, would you like to pay as Partial payment?.") == DialogResult.Yes)
                    {
                        IsPartialPayment = true;
                        IsProceed = true;
                        this.Close();
                    }
                }
                else
                {
                    if (Functions.MessageConfirm("Are you sure you want to proceed the payment?.") == DialogResult.Yes)
                    {
                        IsProceed = true;
                        this.Close();
                    }
                }                                         
            }           
        }

        private void frmReceivePayment_Load(object sender, EventArgs e)
        {
            txtPaidAmount.Text = string.Empty;         
            if (!string.IsNullOrEmpty(Amount))
            {
                txtPaidAmount.Text = Amount;
            }
            txtPaidAmount.ReadOnly = true;
        }

        private void txtPaidAmount_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void txtReceiveAmount_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void txtChangeAmount_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }
    }
}
