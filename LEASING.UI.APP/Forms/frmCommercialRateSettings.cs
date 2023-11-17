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
    public partial class frmCommercialRateSettings : Form
    {
        RateSettingsContext RateSettingsContext = new RateSettingsContext();
        public frmCommercialRateSettings()
        {
            InitializeComponent();
        }
        private string _strRateFormMode;
        public string strRateFormMode
        {
            get
            {
                return _strRateFormMode;
            }
            set
            {
                _strRateFormMode = value;
                switch (_strRateFormMode)
                {
                    case "EDIT":
                        btnUndo.Enabled = true;
                        btnSave.Enabled = true;
                        btnEdit.Enabled = false;

                        txtGenVat.Enabled = true;
                        txtSecAndMaintenance.Enabled = true;

                        txtWithHoldingTax.Enabled = true;

                        break;
                    case "READ":
                        btnUndo.Enabled = false;
                        btnSave.Enabled = false;
                        btnEdit.Enabled = true;

                        txtGenVat.Enabled = false;
                        txtSecAndMaintenance.Enabled = false;
                        txtWithHoldingTax.Enabled = false;
                        txtVatAmount.Enabled = false;
                        txtSecAndMaintenanceWithVat.Enabled = false;
                        txtSecAndMaintenanceWithVatLessTAX.Enabled = false;
                        txtWithHoldingTaxAmount.Enabled = false;

                        break;

                    default:
                        break;
                }
            }
        }
        private void M_GetRateSettings()
        {
            using (DataSet dt = RateSettingsContext.GetCOMMERCIALSettings())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    txtGenVat.Text = Convert.ToString(dt.Tables[0].Rows[0]["GenVat"]);
                    txtSecAndMaintenance.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecurityAndMaintenance"]);
                    //chkIsSecAndMaintenenceVat.Checked = Convert.ToBoolean(dt.Tables[0].Rows[0]["IsSecAndMaintVat"]);
                    //txtSecAndMaintenanceVat.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecurityAndMaintenanceVat"]);
                    txtWithHoldingTax.Text = Convert.ToString(dt.Tables[0].Rows[0]["WithHoldingTax"]);
                }
            }
        }
        private void M_UpdateRates()
        {
            string results = RateSettingsContext.UpdateCOMMERCIALSettings(txtGenVat.Text == string.Empty ? 0 : decimal.Parse(txtGenVat.Text), txtSecAndMaintenance.Text == string.Empty ? 0 : decimal.Parse(txtSecAndMaintenance.Text), txtWithHoldingTax.Text == string.Empty ? 0 : decimal.Parse(txtWithHoldingTax.Text));
            if (results.Equals("SUCCESS"))
            {
                MessageBox.Show("Rate  has been Upated successfully !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                strRateFormMode = "READ";
                M_GetRateSettings();
            }
        }

        private void M_GetVatAMount()
        {
            var AMount = ((txtSecAndMaintenance.Text == "" ? 0 : Convert.ToDecimal(txtSecAndMaintenance.Text)) * (txtGenVat.Text == "" ? 0 : Convert.ToDecimal(txtGenVat.Text)) / 100);
            txtVatAmount.Text = Convert.ToString(AMount);
        }
        private void M_GetSecAndMainVatAMount()
        {
            var AMount = ((txtSecAndMaintenance.Text == "" ? 0 : Convert.ToDecimal(txtSecAndMaintenance.Text)) + (txtVatAmount.Text == "" ? 0 : Convert.ToDecimal(txtVatAmount.Text)));
            txtSecAndMaintenanceWithVat.Text = Convert.ToString(AMount);
        }
        private void M_GetTaxAMount()
        {
            var AMount = ((txtSecAndMaintenanceWithVat.Text == "" ? 0 : Convert.ToDecimal(txtSecAndMaintenanceWithVat.Text)) * (txtWithHoldingTax.Text == "" ? 0 : Convert.ToDecimal(txtWithHoldingTax.Text)) / 100);
            txtWithHoldingTaxAmount.Text = Convert.ToString(AMount);
        }
        private void M_GetSecAndMainWithVatandLessTax()
        {
            var AMount = (txtSecAndMaintenanceWithVat.Text == "" ? 0 : Convert.ToDecimal(txtSecAndMaintenanceWithVat.Text)) - (txtWithHoldingTaxAmount.Text == "" ? 0 : Convert.ToDecimal(txtWithHoldingTaxAmount.Text));
            txtSecAndMaintenanceWithVatLessTAX.Text = Convert.ToString(AMount);
        }
        private void frmCommercialRateSettings_Load(object sender, EventArgs e)
        {
            strRateFormMode = "READ";
            M_GetRateSettings();
            M_GetVatAMount();
            M_GetSecAndMainVatAMount();
            M_GetTaxAMount();
            M_GetSecAndMainWithVatandLessTax();
        }

        private void txtGenVat_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void txtWithHoldingTax_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void txtSecAndMaintenance_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void txtSecAndMaintenanceVat_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9\b]"))
                e.Handled = true;
        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            strRateFormMode = "EDIT";
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (strRateFormMode == "EDIT")
            {
                if (MessageBox.Show("Are you sure you want to update the following Rate?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                {
                    M_UpdateRates();
                }
            }
        }

        private void btnUndo_Click(object sender, EventArgs e)
        {
            strRateFormMode = "READ";
        }

        private void txtVatAmount_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9\b]"))
                e.Handled = true;
        }

        private void txtSecAndMaintenanceWithVat_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9\b]"))
                e.Handled = true;
        }

        private void txtGenVat_TextChanged(object sender, EventArgs e)
        {
            M_GetVatAMount();
            M_GetSecAndMainVatAMount();
            M_GetTaxAMount();
            M_GetSecAndMainWithVatandLessTax();
        }

        private void txtWithHoldingTax_TextChanged(object sender, EventArgs e)
        {
            M_GetTaxAMount();
            M_GetSecAndMainWithVatandLessTax();
        }
    }
}
