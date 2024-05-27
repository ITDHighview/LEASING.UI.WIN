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
    public partial class frmResidentialRateSettings : Form
    {
        RateSettingsContext RateSettingsContext = new RateSettingsContext();
        public frmResidentialRateSettings()
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
                        txtPentalty.Enabled = true;
                        //txtVatAmount.Enabled = true;
                        //txtSecAndMaintenanceWithVat.Enabled = true;


                        break;
                    case "READ":
                        btnUndo.Enabled = false;
                        btnSave.Enabled = false;
                        btnEdit.Enabled = true;

                        txtGenVat.Enabled = false;
                        txtSecAndMaintenance.Enabled = false;
                        txtVatAmount.Enabled = false;
                        txtSecAndMaintenanceWithVat.Enabled = false;
                        txtPentalty.Enabled = false;


                        break;

                    default:
                        break;
                }
            }
        }
        private void GetRateSettings()
        {
            try
            {
                using (DataSet dt = RateSettingsContext.GetRESIDENTIALSettings())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        txtGenVat.Text = Convert.ToString(dt.Tables[0].Rows[0]["GenVat"]);
                        txtSecAndMaintenance.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecurityAndMaintenance"]);
                        txtPentalty.Text = Convert.ToString(dt.Tables[0].Rows[0]["PenaltyPct"]);
                        //txtSecAndMaintenanceVat.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecurityAndMaintenanceVat"]);
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("GetRateSettings()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("GetRateSettings()", ex.ToString());
            }
        }

        private void M_UpdateRates()
        {
            try
            {
                string results = RateSettingsContext.UpdateRESIDENTIALSettings(Functions.ConvertStringToDecimal(txtGenVat.Text),
                                                                Functions.ConvertStringToDecimal(txtSecAndMaintenance.Text),
                                                                Functions.ConvertStringToDecimal(txtPentalty.Text));
                if (results.Equals("SUCCESS"))
                {
                    MessageBox.Show("Rate  has been Upated successfully !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    strRateFormMode = "READ";
                    this.GetRateSettings();
                }
                else
                {
                    MessageBox.Show(results, "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_UpdateRates()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_UpdateRates()", ex.ToString());
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
        private void frmResidentialRateSettings_Load(object sender, EventArgs e)
        {
            Functions.EventCapturefrmName(this);
            this.strRateFormMode = "READ";
            this.GetRateSettings();
            M_GetVatAMount();
            M_GetSecAndMainVatAMount();
        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            this.strRateFormMode = "EDIT";
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

        private void btnUndo_Click(object sender, EventArgs e)
        {
            this.strRateFormMode = "READ";
        }

        private void txtGenVat_KeyPress(object sender, KeyPressEventArgs e)
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

        private void txtGenVat_TextChanged(object sender, EventArgs e)
        {
            M_GetVatAMount();
            M_GetSecAndMainVatAMount();
        }

        private void txtVatAmount_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void txtSecAndMaintenanceWithVat_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void txtPentalty_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void txtSecAndMaintenance_TextChanged(object sender, EventArgs e)
        {
            M_GetVatAMount();
            M_GetSecAndMainVatAMount();
        }
    }
}
