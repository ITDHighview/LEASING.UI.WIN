﻿using LEASING.UI.APP.Common;
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
    public partial class frmClientInformation : Form
    {
        private ClientContext _client = new ClientContext();
        public string clientNumber { get; set; }
        public string _Message_Code_ { get; set; }
        public frmClientInformation()
        {
            InitializeComponent();

        }
        private string _strClientFormMode;
        public string strClientFormMode
        {
            get
            {
                return _strClientFormMode;
            }
            set
            {
                _strClientFormMode = value;
                switch (_strClientFormMode)
                {
                    case "VIEW":
                        btnEnableView.Enabled = false;
                        btnUndo.Enabled = true;
                        EnabledFields();
                        break;
                    case "READ":
                        btnEnableView.Enabled = true;
                        btnUndo.Enabled = false;
                        DisabledFields();
                        break;

                    default:
                        break;
                }
            }
        }
        private void _clearFields()
        {
            ddlClientType.Text = string.Empty;
            txtname.Text = string.Empty;
            txtage.Text = string.Empty;
            txtpostaladdress.Text = string.Empty;
            txttelno.Text = string.Empty;
            txtnationality.Text = string.Empty;
            txtoccupation.Text = string.Empty;
            txtannualincome.Text = string.Empty;
            txtnameofemployer.Text = string.Empty;
            txtaddresstelephoneno.Text = string.Empty;
            txtspousename.Text = string.Empty;
            txtnameofchildren.Text = string.Empty;
            txttotalnoofperson.Text = string.Empty;
            txtnameofmaid.Text = string.Empty;
            txtnameofdriver.Text = string.Empty;
            txtnoofvisitorperday.Text = string.Empty;
            txtTinNo.Text = string.Empty;
            ddlgender.Text = string.Empty;

            dgvFileList.DataSource = null;
            dgvList.DataSource = null;

        }
        private void EnabledFields()
        {
            ddlClientType.Enabled = true;
            txtname.Enabled = true;
            txtage.Enabled = true;
            txtpostaladdress.Enabled = true;
            dtpdob.Enabled = true;
            ddlgender.Enabled = true;
            txttelno.Enabled = true;
            txtnationality.Enabled = true;
            txtoccupation.Enabled = true;
            txtannualincome.Enabled = true;
            txtnameofemployer.Enabled = true;
            txtaddresstelephoneno.Enabled = true;
            txtspousename.Enabled = true;
            txtnameofchildren.Enabled = true;
            txttotalnoofperson.Enabled = true;
            txtnameofmaid.Enabled = true;
            txtnameofdriver.Enabled = true;
            txtnoofvisitorperday.Enabled = true;
            txtTinNo.Enabled = true;

            ReadOnlyFields();
        }
        private void DisabledFields()
        {
            ddlClientType.Enabled = false;
            txtname.Enabled = false;
            txtage.Enabled = false;
            txtpostaladdress.Enabled = false;
            dtpdob.Enabled = false;
            ddlgender.Enabled = false;
            txttelno.Enabled = false;
            txtnationality.Enabled = false;
            txtoccupation.Enabled = false;
            txtannualincome.Enabled = false;
            txtnameofemployer.Enabled = false;
            txtaddresstelephoneno.Enabled = false;
            txtspousename.Enabled = false;
            txtnameofchildren.Enabled = false;
            txttotalnoofperson.Enabled = false;
            txtnameofmaid.Enabled = false;
            txtnameofdriver.Enabled = false;
            txtnoofvisitorperday.Enabled = false;
            txtTinNo.Enabled = false;


            ReadOnlyFields();
        }
        private void ReadOnlyFields()
        {
            //ddlClientType.Enabled = false;
            txtname.ReadOnly = true;
            txtage.ReadOnly = true;
            txtpostaladdress.ReadOnly = true;
            dtpdob.ReadOnly = true;
            ddlgender.ReadOnly = true;
            txttelno.ReadOnly = true;
            txtnationality.ReadOnly = true;
            txtoccupation.ReadOnly = true;
            txtannualincome.ReadOnly = true;
            txtnameofemployer.ReadOnly = true;
            txtaddresstelephoneno.ReadOnly = true;
            txtspousename.ReadOnly = true;
            txtnameofchildren.ReadOnly = true;
            txttotalnoofperson.ReadOnly = true;
            txtnameofmaid.ReadOnly = true;
            txtnameofdriver.ReadOnly = true;
            txtnoofvisitorperday.ReadOnly = true;
            txtTinNo.ReadOnly = true;


        }
        private void _getClientNumber()
        {
            try
            {
                using (DataSet dt = _client.CheckClientNumberExist(this.txtClienID.Text))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        this.clientNumber = Convert.ToString(dt.Tables[0].Rows[0]["ClientID"]);
                        this._Message_Code_ = Convert.ToString(dt.Tables[0].Rows[0]["Message_Code"]);
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogErrorIntoStoredProcedure("_getClientNumber()", this.Text, ex.Message, DateTime.Now, this);

                Functions.MessageShow("An error occurred : (" + ex.ToString() + ") Please check the [ErrorLog] ");
            }


        }
        private void _getClientFileBrowse()
        {
            try
            {
                dgvFileList.DataSource = null;
                using (DataSet dt = _client.GetClientFileBrowseByNumber(this.clientNumber))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        dgvFileList.AutoGenerateColumns = false;
                        dgvFileList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogErrorIntoStoredProcedure("_getClientFileBrowse()", this.Text, ex.Message, DateTime.Now, this);

                Functions.MessageShow("An error occurred : (" + ex.ToString() + ") Please check the [ErrorLog] ");
            }

        }
        private void _getClientByNumber()
        {
            this.ddlClientType.Text = string.Empty;
            this.txtname.Text = string.Empty;
            this.txtage.Text = string.Empty;
            this.txtpostaladdress.Text = string.Empty;
            this.dtpdob.Value = DateTime.Now;
            this.ddlgender.Text = string.Empty;
            this.txttelno.Text = string.Empty;
            this.txtnationality.Text = string.Empty;
            this.txtoccupation.Text = string.Empty;
            this.txtannualincome.Text = string.Empty;
            this.txtnameofemployer.Text = string.Empty;
            this.txtaddresstelephoneno.Text = string.Empty;
            this.txtspousename.Text = string.Empty;
            this.txtnameofchildren.Text = string.Empty;
            this.txttotalnoofperson.Text = string.Empty;
            this.txtnameofmaid.Text = string.Empty;
            this.txtnoofvisitorperday.Text = string.Empty;
            this.txtnameofdriver.Text = string.Empty;
            this.txtTinNo.Text = string.Empty;

            try
            {
                using (DataSet dt = _client.GetClientByNumber(this.clientNumber))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        this.ddlClientType.Text = Convert.ToString(dt.Tables[0].Rows[0]["ClientType"]);
                        this.txtname.Text = Convert.ToString(dt.Tables[0].Rows[0]["ClientName"]);
                        this.txtage.Text = Convert.ToString(dt.Tables[0].Rows[0]["Age"]);
                        this.txtpostaladdress.Text = Convert.ToString(dt.Tables[0].Rows[0]["PostalAddress"]);
                        this.dtpdob.Value = Convert.ToDateTime(dt.Tables[0].Rows[0]["DateOfBirth"]);
                        this.ddlgender.Text = Convert.ToString(dt.Tables[0].Rows[0]["Gender"]);
                        this.txttelno.Text = Convert.ToString(dt.Tables[0].Rows[0]["TelNumber"]);
                        this.txtnationality.Text = Convert.ToString(dt.Tables[0].Rows[0]["Nationality"]);
                        this.txtoccupation.Text = Convert.ToString(dt.Tables[0].Rows[0]["Occupation"]);
                        this.txtannualincome.Text = Convert.ToString(dt.Tables[0].Rows[0]["AnnualIncome"]);
                        this.txtnameofemployer.Text = Convert.ToString(dt.Tables[0].Rows[0]["EmployerName"]);
                        this.txtaddresstelephoneno.Text = Convert.ToString(dt.Tables[0].Rows[0]["EmployerAddress"]);
                        this.txtspousename.Text = Convert.ToString(dt.Tables[0].Rows[0]["SpouseName"]);
                        this.txtnameofchildren.Text = Convert.ToString(dt.Tables[0].Rows[0]["ChildrenNames"]);
                        this.txttotalnoofperson.Text = Convert.ToString(dt.Tables[0].Rows[0]["TotalPersons"]);
                        this.txtnameofmaid.Text = Convert.ToString(dt.Tables[0].Rows[0]["MaidName"]);
                        this.txtnoofvisitorperday.Text = Convert.ToString(dt.Tables[0].Rows[0]["VisitorsPerDay"]);
                        this.txtnameofdriver.Text = Convert.ToString(dt.Tables[0].Rows[0]["DriverName"]);
                        this.txtTinNo.Text = Convert.ToString(dt.Tables[0].Rows[0]["TIN_No"]);
                    }
                }
            }
            catch (Exception ex)
            {

                Functions.MessageShow(ex.ToString());
            }

        }
        private void _getContractByClientNumber()
        {
            try
            {
                dgvList.DataSource = null;
                using (DataSet dt = _client.GetReferenceByClientID(this.clientNumber))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        dgvList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogErrorIntoStoredProcedure("_getContractByClientNumber()", this.Text, ex.Message, DateTime.Now, this);

                Functions.MessageShow("An error occurred : (" + ex.ToString() + ") Please check the [ErrorLog] ");
            }

        }
        private void _getClientInfo()
        {
            if (string.IsNullOrEmpty(this.txtClienID.Text))
            {
                return;
            }
            this._getClientNumber();
            this._getClientByNumber();
            this._getClientFileBrowse();
            this._getContractByClientNumber();
            if (string.IsNullOrEmpty(this._Message_Code_))
            {
                return;
            }
            Functions.MessageShow(this._Message_Code_);
        }
        private void _getContractProjectTypeReport(string refid)
        {
            try
            {
                using (DataSet dt = _client.GetCheckContractProjectType(refid))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        if (Convert.ToString(dt.Tables[0].Rows[0]["UnitType"]) == "UNIT")
                        {
                            if (Convert.ToString(dt.Tables[0].Rows[0]["ProjectType"]) == "RESIDENTIAL")
                            {
                                frmContractSingedResidentialReport contractResidential = new frmContractSingedResidentialReport(refid);
                                contractResidential.Show();
                            }
                            else if (Convert.ToString(dt.Tables[0].Rows[0]["ProjectType"]) == "COMMERCIAL")
                            {
                                frmContractSingedCommercialReport contractCommercial = new frmContractSingedCommercialReport(refid);
                                contractCommercial.Show();
                            }
                            else
                            {
                                frmContractSingedWareHouseReport contractWareHouse = new frmContractSingedWareHouseReport(refid);
                                contractWareHouse.Show();
                            }
                        }
                        else
                        {
                            frmContractSingedParkingReport parking = new frmContractSingedParkingReport(refid);
                            parking.Show();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogErrorIntoStoredProcedure("_getContractProjectTypeReport()", this.Text, ex.Message, DateTime.Now, this);

                Functions.MessageShow("An error occurred : (" + ex.ToString() + ") Please check the [ErrorLog] ");
            }


        }
        private void txtClienID_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode != Keys.Enter)
            {
                this._clearFields();
                return;
            }
            this._getClientInfo();
        }
        private void frmClientInformation_Load(object sender, EventArgs e)
        {
            this.strClientFormMode = "READ";
            //Functions.SecurityControls(this);
        }
        private void btnUndo_Click(object sender, EventArgs e)
        {
            strClientFormMode = "READ";
        }
        private void btnEnableView_Click(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(txtClienID.Text))
            {
                strClientFormMode = "VIEW";
            }
            else
            {
                MessageBox.Show("Please provide Client ID !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }

        }
        private void txtClienID_TextChanged(object sender, EventArgs e)
        {
            if (!string.IsNullOrEmpty(this.txtClienID.Text))
            {
                return;
            }
            this._clearFields();
        }
        private void dgvFileList_CellClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                if (this.dgvFileList.Columns[e.ColumnIndex].Name == "ColView")
                {
                    // forms.ClientID = Convert.ToString(dgvFileList.CurrentRow.Cells["ClientID"].Value);
                    _client.GetViewFileById(this.clientNumber.Trim(), Config.baseFolderPath, Convert.ToInt32(dgvFileList.CurrentRow.Cells["Id"].Value));
                }
                //else if (this.dgvFileList.Columns[e.ColumnIndex].Name == "ColDelete")
                //{

                //    if (!string.IsNullOrWhiteSpace(ClientID))
                //    {

                //        DialogResult result = MessageBox.Show("Are you sure you want to delete all files for this client?", "Confirmation", MessageBoxButtons.YesNo);

                //        if (result == DialogResult.Yes)
                //        {
                //            string sfilepath = Convert.ToString(dgvFileList.CurrentRow.Cells["FilePath"].Value);
                //            if (File.Exists(sfilepath))
                //            {
                //                File.Delete(sfilepath);
                //            }

                //            ClientContext.DeleteFileFromDatabase(sfilepath);
                //            M_GetClientFileList();
                //            //labelStatus.Text = "Files deleted successfully!";
                //        }

                //    }
                //    else
                //    {
                //        MessageBox.Show("Please enter a client name.");
                //    }
                //}

            }
        }
        private void btnSelectClient_Click(object sender, EventArgs e)
        {
            frmGetSelectClient SearchClient = new frmGetSelectClient();
            SearchClient.ShowDialog();
            if (SearchClient.IsProceed)
            {
                this.txtClienID.Text = SearchClient.ClientID;
                this._getClientInfo();
                this.txtClienID.Focus();
            }
        }
        private void btnEnableView_Click_1(object sender, EventArgs e)
        {

        }
        private void dgvList_CellClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {

            if (e.RowIndex >= 0)
            {
                if (this.dgvList.Columns[e.ColumnIndex].Name == "ColViewFile")
                {
                    frmGetContactSignedDocumentsByReference forms = new frmGetContactSignedDocumentsByReference();
                    forms.ClientID = Convert.ToString(dgvList.CurrentRow.Cells["ClientID"].Value);
                    forms.ReferenceID = Convert.ToString(dgvList.CurrentRow.Cells["RefId"].Value);
                    forms.ShowDialog();
                }
                else if (this.dgvList.Columns[e.ColumnIndex].Name == "ColView")
                {
                    frmEditUnitComputation forms = new frmEditUnitComputation();
                    forms.Recid = Convert.ToInt32(dgvList.CurrentRow.Cells["RecId"].Value);
                    forms.ShowDialog();
                }
                else if (this.dgvList.Columns[e.ColumnIndex].Name == "ColLedger")
                {
                    frmClosedClientTransaction forms = new frmClosedClientTransaction();
                    forms.ComputationRecid = Convert.ToInt32(dgvList.CurrentRow.Cells["RecId"].Value);
                    forms.ClientId = Convert.ToString(dgvList.CurrentRow.Cells["ClientID"].Value);
                    forms.ShowDialog();
                }
                else if (this.dgvList.Columns[e.ColumnIndex].Name == "ColShowReceipt")
                {
                    frmClientRecieptTransactionList forms = new frmClientRecieptTransactionList();
                    forms.srefid = Convert.ToString(dgvList.CurrentRow.Cells["RefId"].Value);
                    forms.ShowDialog();
                }
            }
        }
        private void btnPrintContract_Click(object sender, EventArgs e)
        {
            if (dgvList.Rows.Count > 0)
            {
                this._getContractProjectTypeReport(Convert.ToString(dgvList.CurrentRow.Cells["RefId"].Value));
            }
            
        }
    }
}
