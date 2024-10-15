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
    public partial class frmOtherPaymentType : Form
    {
        private OtherPaymentTypeModel _model;
        private PaymentContext _payment;
        public frmOtherPaymentType()
        {
            _model = new OtherPaymentTypeModel();
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
                        txtTypeName.Enabled = true;
                        btnNew.Enabled = false;
                        txtTypeName.Text = string.Empty;
                        txtOtherPaymentVatPCT.Enabled = true;
                        txtOtherPaymentVatPCT.Text = "0.00";
                        txtOtherPaymentTaxPCT.Enabled = true;
                        txtOtherPaymentTaxPCT.Text = "0.00";

                        break;
                    case "READ":
                        btnUndo.Enabled = false;
                        btnSave.Enabled = false;
                        txtTypeName.Enabled = false;
                        btnNew.Enabled = true;
                        txtTypeName.Text = string.Empty;
                        txtOtherPaymentVatPCT.Enabled = false;
                        txtOtherPaymentVatPCT.Text = "0.00";
                        txtOtherPaymentTaxPCT.Enabled = false;
                        txtOtherPaymentTaxPCT.Text = "0.00";
                        break;

                    default:
                        break;
                }
            }
        }
        private bool _isValid()
        {
            if (string.IsNullOrEmpty(txtTypeName.Text))
            {
                MessageBox.Show("Type Name cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            //if (string.IsNullOrEmpty(txtLocAddress.Text))
            //{
            //    MessageBox.Show("Address cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            //    return false;
            //}
            return true;
        }
        private void SaveOtherPaymentType()
        {
            try
            {
                _model.OtherPaymentTypeName = txtTypeName.Text;
                _model.OtherPaymentVatPCT = Functions.ConvertStringToDecimal(txtOtherPaymentVatPCT.Text);
                _model.OtherPaymentTaxPCT = Functions.ConvertStringToDecimal(txtOtherPaymentTaxPCT.Text);
                string result = _payment.SaveOtherPaymentType(_model);
                if (result.Equals("SUCCESS"))
                {
                    Functions.MessageShow("New Payment Type has been added successfully !");
                    this.FormMode = ModeStatus.READ.ToString();
                    this.GetOtherPaymentTypeBrowse();

                    _model.OtherPaymentTypeName = string.Empty;
                    _model.OtherPaymentVatPCT = 0;
                    _model.OtherPaymentTaxPCT = 0;
                }
                else
                {
                    Functions.MessageShow(result);
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("SaveOtherPaymentType()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("SaveOtherPaymentType()", ex.ToString());
            }
        }

        private void frmOtherPaymentType_Load(object sender, EventArgs e)
        {
            Functions.EventCapturefrmName(this);
            this.FormMode = ModeStatus.READ.ToString();
            GetOtherPaymentTypeBrowse();
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
                if (Functions.MessageConfirm("Are you sure you want to add this Payment Type ?") == DialogResult.Yes)
                {
                    this.SaveOtherPaymentType();
                }
            }
        }
        //private void UpdateTypeName()
        //{
        //    try
        //    {
        //        string result = _unit.UpdateFloorTypeInfo(Convert.ToInt32(dgvList.CurrentRow.Cells["RecId"].Value), Convert.ToString(dgvList.CurrentRow.Cells["FloorTypeName"].Value));
        //        if (result.Equals("SUCCESS"))
        //        {
        //            Functions.MessageShow("Floor Type has been updated successfully !");
        //            this.FormMode = ModeStatus.READ.ToString();
        //            this.GetTypeNameBrowse();
        //        }
        //        else
        //        {
        //            Functions.MessageShow(result);
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        Functions.LogError("UpdateTypeName()", this.Text, ex.ToString(), DateTime.Now, this);
        //        Functions.ErrorShow("UpdateTypeName()", ex.ToString());
        //    }
        //}
        //private void DeleteTypeName()
        //{
        //    try
        //    {
        //        string result = _unit.DeleteFloorType(Convert.ToString(dgvList.CurrentRow.Cells["FloorTypeName"].Value));
        //        if (result.Equals("SUCCESS"))
        //        {
        //            Functions.MessageShow("Deleted successfully !");
        //            this.FormMode = ModeStatus.READ.ToString();
        //            this.GetTypeNameBrowse();
        //        }
        //        else
        //        {
        //            Functions.MessageShow(result);
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        Functions.LogError("DeleteTypeName()", this.Text, ex.ToString(), DateTime.Now, this);
        //        Functions.ErrorShow("DeleteTypeName()", ex.ToString());
        //    }
        //}
        private void GetOtherPaymentTypeBrowse()
        {
            try
            {
                dgvList.DataSource = null;
                using (DataSet dt = _payment.GetOtherPaymentTypeBrowse())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        dgvList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("GetOtherPaymentTypeBrowse()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("GetOtherPaymentTypeBrowse()", ex.ToString());
            }
            //for (int i = 0; i < dgvList.Rows.Count; i++)
            //{
            //    this.dgvList.Rows[i].Cells["FloorTypeName"].ReadOnly = true;
            //    this.dgvList.Rows[i].Cells["ColRemoved"].Value = "Edit";
            //    this.dgvList.Rows[i].Cells["ColEdit"].ColumnInfo.IsVisible = false;
            //    this.dgvList.Rows[i].Cells["ColEdit"].Value = "???";
            //}
        }

        private void txtOtherPaymentVatPCT_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void txtOtherPaymentTaxPCT_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        /* dgvList.EndEdit();

            if (e.RowIndex >= 0)
            {
                if (this.dgvList.Columns[e.ColumnIndex].Name == "ColRemoved")
                {
                   
                    this.dgvList.CurrentRow.Cells["FloorTypeName"].ReadOnly = false;
                    this.dgvList.CurrentRow.Cells["ColRemoved"].ColumnInfo.IsVisible = false;
                    this.dgvList.CurrentRow.Cells["ColEdit"].ColumnInfo.IsVisible = true;
                    this.dgvList.CurrentRow.Cells["ColEdit"].Value = "Save";
                    dgvList.Refresh();
                }
                else if (this.dgvList.Columns[e.ColumnIndex].Name == "ColEdit")
                {
                    if (Convert.ToString(this.dgvList.CurrentRow.Cells["ColEdit"].Value) == "Save")
                    {
                        this.UpdateTypeName();
                        this.dgvList.CurrentRow.Cells["FloorTypeName"].ReadOnly = true;
                        this.dgvList.CurrentRow.Cells["ColEdit"].Value = "???";
                        this.dgvList.CurrentRow.Cells["ColEdit"].ColumnInfo.IsVisible = false;
                        this.dgvList.CurrentRow.Cells["ColRemoved"].ColumnInfo.IsVisible = true;
                    }
                }
            }*/
    }
}
