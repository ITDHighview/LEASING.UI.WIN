using LEASING.UI.APP.Common;
using LEASING.UI.APP.Context;
using LEASING.UI.APP.Models;
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
    public partial class OtherPaymentCollection : Form
    {
        private PaymentModel _model;
        private PaymentContext _payment;
        private string _vVatPCT { get; set; } = "0.00";
        private string _vTaxPCT { get; set; } = "0.00";
        public OtherPaymentCollection()
        {
            _model = new PaymentModel();
            _payment = new PaymentContext();
            InitializeComponent();
        }
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
                        btnUndo.Enabled = true;
                        btnSave.Enabled = true;
                        btnNew.Enabled = false;
                        btnSearchClient.Enabled = true;

                        txtClientID.Enabled = true;
                        txtClientID.ReadOnly = true;
                        txtClientID.Text = string.Empty;

                        txtClientName.Enabled = true;
                        txtClientName.ReadOnly = true;
                        txtClientName.Text = string.Empty;

                        ddlTypeName.Enabled = true;
                        ddlTypeName.SelectedIndex = 0;



                        txtAmount.Enabled = true;
                        txtAmount.Text = "0.00";

                        chkIsVatApplied.Enabled = true;
                        chkIsVatApplied.Checked = true;
                        txtVatPCT.Enabled = true;
                        txtVatPCT.ReadOnly = true;
                        txtVatPCT.Text = "0.00";
                        txtVatAmount.Enabled = true;
                        txtVatAmount.ReadOnly = true;
                        txtVatAmount.Text = "0.00";

                        chkIsTaxApplied.Enabled = true;
                        chkIsTaxApplied.Checked = true;
                        txtTaxPCT.ReadOnly = true;
                        txtTaxPCT.Text = "0.00";
                        txtTaxAmount.ReadOnly = true;
                        txtTaxAmount.Text = "0.00";




                        break;
                    case "READ":
                        btnUndo.Enabled = false;
                        btnSave.Enabled = false;
                        btnNew.Enabled = true;
                        btnSearchClient.Enabled = false;

                        txtClientID.Enabled = false;
                        txtClientID.ReadOnly = true;
                        txtClientID.Text = string.Empty;

                        txtClientName.Enabled = false;
                        txtClientName.ReadOnly = true;
                        txtClientName.Text = string.Empty;

                        ddlTypeName.Enabled = false;
                        ddlTypeName.SelectedIndex = -1;



                        txtAmount.Enabled = false;
                        txtAmount.Text = "0.00";

                        chkIsVatApplied.Enabled = false;
                        chkIsVatApplied.Checked = false;
                        txtVatPCT.Enabled = false;
                        txtVatPCT.ReadOnly = true;
                        txtVatPCT.Text = "0.00";
                        txtVatAmount.Enabled = false;
                        txtVatAmount.ReadOnly = true;
                        txtVatAmount.Text = "0.00";

                        chkIsTaxApplied.Enabled = false;
                        chkIsTaxApplied.Checked = false;
                        txtTaxPCT.Enabled = false;
                        txtTaxPCT.ReadOnly = true;
                        txtTaxPCT.Text = "0.00";
                        txtTaxAmount.Enabled = false;
                        txtTaxAmount.ReadOnly = true;
                        txtTaxAmount.Text = "0.00";

                        break;

                    default:
                        break;
                }
            }
        }
        private bool _isValid()
        {
            if (string.IsNullOrEmpty(txtClientID.Text))
            {
                MessageBox.Show("Client cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            if (ddlTypeName.SelectedIndex == 0)
            {
                MessageBox.Show("Please select Payment Type !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            if (string.IsNullOrEmpty(txtAmount.Text) || txtAmount.Text == "0" || txtAmount.Text == "0.00")
            {
                MessageBox.Show("Amount cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            return true;
        }
        private void GetVatAmount()
        {
            var result = ((Functions.ConvertStringToDecimal(txtAmount.Text) * Functions.ConvertStringToDecimal(_vVatPCT)) / 100);
            txtVatAmount.Text = result.ToString("N2");
        }
        private void GetTaxAmount()
        {
            var result = ((Functions.ConvertStringToDecimal(txtAmount.Text) * Functions.ConvertStringToDecimal(_vTaxPCT)) / 100);
            txtTaxAmount.Text = result.ToString("N2");
        }
        private void RemoveVat()
        {
            txtVatPCT.Text = "0.00";
            txtVatAmount.Text = "0.00";
        }
        private void RemoveTax()
        {
            txtTaxPCT.Text = "0.00";
            txtTaxAmount.Text = "0.00";
        }
        private void ReAddVat()
        {
            GetVatAmount();
            txtVatPCT.Text = _vVatPCT;
        }
        private void ReAddTax()
        {
            GetTaxAmount();
            txtTaxPCT.Text = _vTaxPCT;
        }
        private void frmOtherPayment_Load(object sender, EventArgs e)
        {
            Functions.EventCapturefrmName(this);
            this.FormMode = ModeStatus.READ.ToString();
            GetOtherPaymentTypeList();
            GetOtherPaymentBrowse();
        }

        private void btnNew_Click(object sender, EventArgs e)
        {
            this.FormMode = ModeStatus.NEW.ToString();
        }

        private void btnUndo_Click(object sender, EventArgs e)
        {
            this.FormMode = ModeStatus.READ.ToString();
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (this._isValid())
            {
                if (Functions.MessageConfirm("Are you sure you want to save this Payment ?") == DialogResult.Yes)
                {
                    this.SaveOtherPayment();
                }
            }
        }
        private void SaveOtherPayment()
        {
            try
            {
                _model.ClientID = txtClientID.Text;
                _model.OtherPaymentTypeName = Convert.ToString(ddlTypeName.SelectedValue);
                _model.OtherPaymentAmount = Functions.ConvertStringToDecimal(txtAmount.Text);

                _model.OtherPaymentVatPCT = Functions.ConvertStringToDecimal(txtVatPCT.Text);
                _model.OtherPaymentVatAmount = Functions.ConvertStringToDecimal(txtVatAmount.Text);
                _model.OtherPaymentIsVatApplied = chkIsVatApplied.Checked;
                _model.OtherPaymentTaxPCT = Functions.ConvertStringToDecimal(txtTaxPCT.Text);
                _model.OtherPaymentTaxAmount = Functions.ConvertStringToDecimal(txtTaxAmount.Text);
                _model.OtherPaymentTaxIsApplied = chkIsTaxApplied.Checked;

                string result = _payment.SaveOtherPayment(_model);
                Functions.ShowLoadingBar("Processing...");
                if (result.Equals("SUCCESS"))
                {
                    Functions.MessageShow("Payment has been save successfully !");
                    this.FormMode = ModeStatus.READ.ToString();
                    GetOtherPaymentBrowse();

                    _model.ClientID = string.Empty;
                    _model.OtherPaymentTypeName = string.Empty;
                    _model.OtherPaymentAmount = 0;

                    _model.OtherPaymentVatPCT = 0;
                    _model.OtherPaymentVatAmount = 0;
                    _model.OtherPaymentIsVatApplied = false;
                    _model.OtherPaymentTaxPCT = 0;
                    _model.OtherPaymentTaxAmount = 0;
                    _model.OtherPaymentTaxIsApplied = false;
                }
                else
                {
                    Functions.MessageShow(result);
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("SaveOtherPayment()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("SaveOtherPayment()", ex.ToString());
            }
        }
        private void GetOtherPaymentTypeList()
        {
            try
            {
                ddlTypeName.DataSource = null;
                using (DataSet dt = _payment.GetOtherPaymentTypeList())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        ddlTypeName.DataSource = dt.Tables[0];
                        ddlTypeName.ValueMember = "OtherPaymentTypeName";
                        ddlTypeName.DisplayMember = "OtherPaymentTypeName";
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("GetOtherPaymentTypeList()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("GetOtherPaymentTypeList()", ex.ToString());
            }


        }
        private void GetOtherPaymentBrowse()
        {
            try
            {
                dgvList.DataSource = null;
                using (DataSet dt = _payment.GetOtherPaymentBrowse())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        dgvList.DataSource = dt.Tables[0];
               
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("GetOtherPaymentBrowse()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("GetOtherPaymentBrowse()", ex.ToString());
            }


        }
        private void GetOtherPaymentTypeRateByName()
        {
            try
            {
                _vVatPCT = "0.00";
                _vTaxPCT = "0.00";
                using (DataSet dt = _payment.GetOtherPaymentTypeRateByName(ddlTypeName.Text))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        _vVatPCT = Convert.ToString(dt.Tables[0].Rows[0]["OtherPaymentVatPCT"]);
                        _vTaxPCT = Convert.ToString(dt.Tables[0].Rows[0]["OtherPaymentTaxPCT"]);

                        txtVatPCT.Text = _vVatPCT;
                        txtTaxPCT.Text = _vTaxPCT;
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("GetOtherPaymentTypeRateByName()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("GetOtherPaymentTypeRateByName()", ex.ToString());
            }


        }
        private void txtAmount_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void txtVatPCT_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void txtVatAmount_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void txtTaxPCT_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void txtTaxAmount_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void txtAmount_TextChanged(object sender, EventArgs e)
        {
            GetVatAmount();
            GetTaxAmount();
        }

        private void chkIsVatApplied_ToggleStateChanged(object sender, Telerik.WinControls.UI.StateChangedEventArgs args)
        {
            if (chkIsVatApplied.Checked == true)
            {
                ReAddVat();

            }
            else
            {
                RemoveVat();
            }
        }

        private void chkIsTaxApplied_ToggleStateChanged(object sender, Telerik.WinControls.UI.StateChangedEventArgs args)
        {
            if (chkIsTaxApplied.Checked == true)
            {
                ReAddTax();

            }
            else
            {
                RemoveTax();
            }
        }

        private void ddlTypeName_SelectedIndexChanged(object sender, Telerik.WinControls.UI.Data.PositionChangedEventArgs e)
        {
            if (ddlTypeName.SelectedIndex >0)
            {
                GetOtherPaymentTypeRateByName();
            }
        }

        private void btnSearchClient_Click(object sender, EventArgs e)
        {
            ClientBrowse SearchClient = new ClientBrowse();
            SearchClient.ShowDialog();
            if (SearchClient.IsProceed)
            {
                this.txtClientID.Text = SearchClient.ClientID;
                this.txtClientName.Text = SearchClient.ClientName;
                //this._getClientInfo();
                this.txtClientID.Focus();
            }
        }
    }
}
