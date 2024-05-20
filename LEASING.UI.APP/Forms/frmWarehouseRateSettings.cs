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
    public partial class frmWarehouseRateSettings : Form
    {
        RateSettingsContext RateSettingsContext = new RateSettingsContext();
        public frmWarehouseRateSettings()
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
                        txtPenalty.Enabled = true;

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
                        txtPenalty.Enabled = false;

                        break;

                    default:
                        break;
                }
            }
        }
        private void M_GetRateSettings()
        {
            try
            {
                using (DataSet dt = RateSettingsContext.GetWAREHOUSESettings())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        txtGenVat.Text = Convert.ToString(dt.Tables[0].Rows[0]["GenVat"]);
                        txtSecAndMaintenance.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecurityAndMaintenance"]);
                        //chkIsSecAndMaintenenceVat.Checked = Convert.ToBoolean(dt.Tables[0].Rows[0]["IsSecAndMaintVat"]);
                        //txtSecAndMaintenanceVat.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecurityAndMaintenanceVat"]);
                        txtWithHoldingTax.Text = Convert.ToString(dt.Tables[0].Rows[0]["WithHoldingTax"]);
                        txtPenalty.Text = Convert.ToString(dt.Tables[0].Rows[0]["PenaltyPct"]);
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogErrorIntoStoredProcedure("M_GetRateSettings()", this.Text, ex.Message, DateTime.Now, this);

                Functions.MessageShow("An error occurred : (" + ex.ToString() + ") Please check the [ErrorLog] ");
            }

        }
        private void M_UpdateRates()
        {
            try
            {
                string results = RateSettingsContext.UpdateWAREHOUSESettings(Functions.ConvertStringToDecimal(txtGenVat.Text),
                                                                             Functions.ConvertStringToDecimal(txtSecAndMaintenance.Text),
                                                                             Functions.ConvertStringToDecimal(txtWithHoldingTax.Text),
                                                                             Functions.ConvertStringToDecimal(txtPenalty.Text));
                if (results.Equals("SUCCESS"))
                {
                    MessageBox.Show("Rate  has been Upated successfully !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    strRateFormMode = "READ";
                    M_GetRateSettings();
                }
                else
                {
                    MessageBox.Show(results, "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
            catch (Exception ex)
            {
                Functions.LogErrorIntoStoredProcedure("M_UpdateRates()", this.Text, ex.Message, DateTime.Now, this);

                Functions.MessageShow("An error occurred : (" + ex.ToString() + ") Please check the [ErrorLog] ");
            }


        }
        private void M_GetVatAMount()
        {
            var AMount = ((Functions.ConvertStringToDecimal(txtSecAndMaintenance.Text) * Functions.ConvertStringToDecimal(txtGenVat.Text)) / 100);
            txtVatAmount.Text = AMount.ToString("0.00");
        }
        private void M_GetSecAndMainVatAMount()
        {
            var AMount = (Functions.ConvertStringToDecimal(txtSecAndMaintenance.Text) + Functions.ConvertStringToDecimal(txtVatAmount.Text));
            txtSecAndMaintenanceWithVat.Text = AMount.ToString("0.00");
        }
        private void M_GetTaxAMount()
        {
            var AMount = ((Functions.ConvertStringToDecimal(txtSecAndMaintenanceWithVat.Text) * Functions.ConvertStringToDecimal(txtWithHoldingTax.Text)) / 100);
            txtWithHoldingTaxAmount.Text = AMount.ToString("0.00");
        }
        private void M_GetSecAndMainWithVatandLessTax()
        {
            var AMount = (Functions.ConvertStringToDecimal(txtSecAndMaintenanceWithVat.Text) - Functions.ConvertStringToDecimal(txtWithHoldingTaxAmount.Text));
            txtSecAndMaintenanceWithVatLessTAX.Text = AMount.ToString("0.00");
        }
        private void frmWarehouseRateSettings_Load(object sender, EventArgs e)
        {
            strRateFormMode = "READ";
            M_GetRateSettings();
            M_GetVatAMount();
            M_GetSecAndMainVatAMount();
            M_GetTaxAMount();
            M_GetSecAndMainWithVatandLessTax();
        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            strRateFormMode = "EDIT";
        }

        private void btnUndo_Click(object sender, EventArgs e)
        {
            strRateFormMode = "READ";
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (strRateFormMode == "EDIT")
            {
                if (MessageBox.Show("Are you sure you want to update the following Rate?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                {
                    try
                    {
                        M_UpdateRates();
                    }
                    catch (Exception ex)
                    {

                        MessageBox.Show(ex.ToString(), "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    }
                   
                }
            }
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

        private void txtSecAndMaintenanceWithVatLessTAX_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9\b]"))
                e.Handled = true;
        }

        private void txtWithHoldingTaxAmount_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9\b]"))
                e.Handled = true;
        }

        private void txtPenalty_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void txtSecAndMaintenance_TextChanged(object sender, EventArgs e)
        {
            M_GetVatAMount();
            M_GetSecAndMainVatAMount();
            M_GetTaxAMount();
            M_GetSecAndMainWithVatandLessTax();
        }
    }
}
