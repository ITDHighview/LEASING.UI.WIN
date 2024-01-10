using LEASING.UI.APP.Common;
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
        ClientContext ClientContext = new ClientContext();
        public string ClientID { get; set; }
        public string Message_Code { get; set; }
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
        private void EmptyFields()
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

            ddlgender.Text = string.Empty;
            dgvFileList.DataSource = null;
            txtTinNo.Text = string.Empty;
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

        private void M_GetClientID()
        {

            using (DataSet dt = ClientContext.GetClientID(txtClienID.Text))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {

                    ClientID = Convert.ToString(dt.Tables[0].Rows[0]["ClientID"]);
                    Message_Code = Convert.ToString(dt.Tables[0].Rows[0]["Message_Code"]);
                }
            }
        }
        private void M_GetClientFileList()
        {
            dgvFileList.DataSource = null;
            using (DataSet dt = ClientContext.GetGetFilesByClient(ClientID))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    dgvFileList.AutoGenerateColumns = false;
                    dgvFileList.DataSource = dt.Tables[0];
                }
            }
        }

        private void M_GetClientById()
        {

            using (DataSet dt = ClientContext.GetClientById(ClientID))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    ddlClientType.Text = Convert.ToString(dt.Tables[0].Rows[0]["ClientType"]);
                    txtname.Text = Convert.ToString(dt.Tables[0].Rows[0]["ClientName"]);
                    txtage.Text = Convert.ToString(dt.Tables[0].Rows[0]["Age"]);
                    txtpostaladdress.Text = Convert.ToString(dt.Tables[0].Rows[0]["PostalAddress"]);
                    dtpdob.Value = Convert.ToDateTime(dt.Tables[0].Rows[0]["DateOfBirth"]);
                    ddlgender.Text = Convert.ToString(dt.Tables[0].Rows[0]["Gender"]);
                    txttelno.Text = Convert.ToString(dt.Tables[0].Rows[0]["TelNumber"]);
                    txtnationality.Text = Convert.ToString(dt.Tables[0].Rows[0]["Nationality"]);
                    txtoccupation.Text = Convert.ToString(dt.Tables[0].Rows[0]["Occupation"]);
                    txtannualincome.Text = Convert.ToString(dt.Tables[0].Rows[0]["AnnualIncome"]);
                    txtnameofemployer.Text = Convert.ToString(dt.Tables[0].Rows[0]["EmployerName"]);
                    txtaddresstelephoneno.Text = Convert.ToString(dt.Tables[0].Rows[0]["EmployerAddress"]);
                    txtspousename.Text = Convert.ToString(dt.Tables[0].Rows[0]["SpouseName"]);
                    txtnameofchildren.Text = Convert.ToString(dt.Tables[0].Rows[0]["ChildrenNames"]);
                    txttotalnoofperson.Text = Convert.ToString(dt.Tables[0].Rows[0]["TotalPersons"]);
                    txtnameofmaid.Text = Convert.ToString(dt.Tables[0].Rows[0]["MaidName"]);
                    txtnoofvisitorperday.Text = Convert.ToString(dt.Tables[0].Rows[0]["VisitorsPerDay"]);
                    txtnameofdriver.Text = Convert.ToString(dt.Tables[0].Rows[0]["DriverName"]);
                    txtTinNo.Text = Convert.ToString(dt.Tables[0].Rows[0]["TIN_No"]);
                }
            }
        }
        private void M_GetReferenceByClientID()
        {
            dgvList.DataSource = null;
            using (DataSet dt = ClientContext.GetReferenceByClientID(ClientID))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    dgvList.DataSource = dt.Tables[0];
                }
            }
        }

        private void M_GetContractProjectTypeReport(string refid)
        {
            using (DataSet dt = ClientContext.GetCheckContractProjectType(refid))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
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
            }
        }
        private void txtClienID_KeyDown(object sender, KeyEventArgs e)
        {
            if (!string.IsNullOrEmpty(txtClienID.Text))
            {
                if (e.KeyCode == Keys.Enter)
                {
                    M_GetClientID();
                    M_GetClientById();
                    M_GetClientFileList();
                    M_GetReferenceByClientID();
                    if (!string.IsNullOrEmpty(Message_Code))
                    {
                        MessageBox.Show(Message_Code, "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    }
                }
                else
                {

                    EmptyFields();
                }
            }
            //else
            //{
            //    MessageBox.Show("Client ID Cannot be Empty", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
            //}
        }

        private void frmClientInformation_Load(object sender, EventArgs e)
        {
            strClientFormMode = "READ";
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
            if (string.IsNullOrEmpty(txtClienID.Text))
            {
                EmptyFields();
            }
        }

        private void dgvFileList_CellClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                if (this.dgvFileList.Columns[e.ColumnIndex].Name == "ColView")
                {
                    // forms.ClientID = Convert.ToString(dgvFileList.CurrentRow.Cells["ClientID"].Value);
                    ClientContext.GetViewFileById(ClientID.Trim(), Config.baseFolderPath, Convert.ToInt32(dgvFileList.CurrentRow.Cells["Id"].Value));
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
            frmGetSelectClient forms = new frmGetSelectClient();
            forms.ShowDialog();
            if (forms.IsProceed)
            {
                txtClienID.Text = forms.ClientID;
                txtClienID.Focus();
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
                else if (this.dgvList.Columns[e.ColumnIndex].Name == "ColReprintAuthorization")
                {

                }
            }
        }

        private void btnPrintContract_Click(object sender, EventArgs e)
        {

            //Convert.ToString(dgvFileList.CurrentRow.Cells["RefId"].Value)

            M_GetContractProjectTypeReport(Convert.ToString(dgvList.CurrentRow.Cells["RefId"].Value));
        }
    }
}
