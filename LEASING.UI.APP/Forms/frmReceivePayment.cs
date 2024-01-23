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
        public string Amount = string.Empty;
        public int recid = 0;
        int DayCount = 0;
        public frmReceivePayment()
        {
            InitializeComponent();
        }


        private void M_GetPenaltyResult()
        {
            Amount = string.Empty;
            lblPenaltyStatus.Text = "(No Penalty)";
            DayCount = 0;
            using (DataSet dt = PaymentContext.GetPenaltyResult(recid))
            {
                if (dt !=null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    Amount = Convert.ToString(dt.Tables[0].Rows[0]["AmountToPay"]);
                    lblPenaltyStatus.Text = Convert.ToString(dt.Tables[0].Rows[0]["PenaltyStatus"]);
                    DayCount = Convert.ToInt32(dt.Tables[0].Rows[0]["DayCount"]);
                }
            }
        }
        private void btnOK_Click(object sender, EventArgs e)
        {
            if (Functions.MessageConfirm("Are you sure you want to proceed the payment?.")== DialogResult.Yes)
            {
                IsProceed = true;
                this.Close();
            }        
        }

        private void frmReceivePayment_Load(object sender, EventArgs e)
        {
            M_GetPenaltyResult();
            txtPaidAmount.Text = string.Empty;
            txtPaidAmount.Text = Amount;
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
