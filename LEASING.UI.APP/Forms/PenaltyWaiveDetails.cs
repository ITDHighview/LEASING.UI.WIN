using LEASING.UI.APP.Common;
using LEASING.UI.APP.Context;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace LEASING.UI.APP.Forms
{
    public partial class PenaltyWaiveDetails : Form
    {
        private ComputationContext _contract = new ComputationContext();
        public int _contractId { get; set; } = 0;
        enum ModeStatus
        {
            NEW,
            READ
        }
        private string _FormMode;
        public string FormMode
        {
            get
            {
                return _FormMode;
            }
            set
            {
                _FormMode = value;
                switch (_FormMode)
                {
                    case "NEW":
                        //btnUndo.Enabled = true;
                        btnSave.Enabled = true;
                        btnNew.Enabled = false;
                        EnableControls();
                        EmptyFields();
                        break;
                    case "READ":
                        //btnUndo.Enabled = false;
                        btnSave.Enabled = false;
                        btnNew.Enabled = true;
                        DisAbleControls();
                        EmptyFields();
                        break;

                    default:
                        break;
                }
            }
        }
        private void EnableControls()
        {
            txtAmount.Enabled = true;
            txtRequestor.Enabled = true;
            txtRemarks.Enabled = true;
        }

        private void DisAbleControls()
        {
            txtAmount.Enabled = false;
            txtRequestor.Enabled = false;
            txtRemarks.Enabled = false;
        }
        private void EmptyFields()
        {
            txtAmount.Text = "0.00";
            txtRequestor.Text = string.Empty;
            txtRemarks.Text = string.Empty;
        }
        public PenaltyWaiveDetails(int contractId)
        {
            InitializeComponent();
            this._contractId = contractId;
        }


        private void GetPenaltyList(int contractid)
        {
            try
            {
                dgvPenaltyList.DataSource = null;
                using (DataSet dt = _contract.GetPenaltyList(contractid))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        dgvPenaltyList.DataSource = dt.Tables[0];
               
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("GetPenaltyList()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("GetPenaltyList()", ex.ToString());
            }
        }
        private void SaveWaivePenalty()
        {

        }
        private void PenaltyWaiveDetails_Load(object sender, EventArgs e)
        {
            FormMode = ModeStatus.READ.ToString();
            GetPenaltyList(_contractId);
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (Functions.MessageConfirm("Are you sure you want to apply the following details ?") == DialogResult.Yes)
            {
                SaveWaivePenalty();
            }
        }

        private void btnNew_Click(object sender, EventArgs e)
        {
            FormMode = ModeStatus.NEW.ToString();
        }

        private void txtAmount_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void txtAmount_Leave(object sender, EventArgs e)
        {
            string input = txtAmount.Text.Replace(",", "").Trim();
            decimal value;
            if (decimal.TryParse(input, NumberStyles.Any, CultureInfo.InvariantCulture, out value))
            {
                // Format the number with commas and two decimal places
                txtAmount.Text = value.ToString("N2"); // Format with commas and two decimal places
            }
        }

        private void txtAmount_MouseMove(object sender, MouseEventArgs e)
        {
            string input = txtAmount.Text.Replace(",", "").Trim();
            decimal value;
            if (decimal.TryParse(input, NumberStyles.Any, CultureInfo.InvariantCulture, out value))
            {
                // Format the number with commas and two decimal places
                txtAmount.Text = value.ToString("N2"); // Format with commas and two decimal places
            }
        }
    }
}
