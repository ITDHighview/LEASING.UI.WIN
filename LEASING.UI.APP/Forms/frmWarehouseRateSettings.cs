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

                        break;
                    case "READ":
                        btnUndo.Enabled = false;
                        btnSave.Enabled = false;
                        btnEdit.Enabled = true;

                        txtGenVat.Enabled = false;
                        txtSecAndMaintenance.Enabled = false;

                        txtWithHoldingTax.Enabled = false;

                        break;

                    default:
                        break;
                }
            }
        }
        private void M_GetRateSettings()
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
                }
            }
        }
        private void M_UpdateRates()
        {
            string results = RateSettingsContext.UpdateWAREHOUSESettings(txtGenVat.Text == string.Empty ? 0 : Convert.ToInt32(txtGenVat.Text), txtSecAndMaintenance.Text == string.Empty ? 0 : decimal.Parse(txtSecAndMaintenance.Text), txtWithHoldingTax.Text == string.Empty ? 0 : Convert.ToInt32(txtWithHoldingTax.Text));
            if (results.Equals("SUCCESS"))
            {
                MessageBox.Show("Rate  has been Upated successfully !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                strRateFormMode = "READ";
                M_GetRateSettings();
            }
        }

        private void frmWarehouseRateSettings_Load(object sender, EventArgs e)
        {
            strRateFormMode = "READ";
            M_GetRateSettings();
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
                    M_UpdateRates();
                }
            }
        }

        private void txtGenVat_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9\b]"))
                e.Handled = true;
        }

        private void txtWithHoldingTax_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9\b]"))
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
    }
}
