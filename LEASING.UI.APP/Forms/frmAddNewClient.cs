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
    public partial class frmAddNewClient : Form
    {
        ClientContext ClientContext = new ClientContext();
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
                    case "NEW":
                        btnUndo.Enabled = true;
                        btnSave.Enabled = true;
                        btnNewProject.Enabled = false;
                        EnabledFields();
                        EmptyFields();

                        break;
                    case "READ":
                        btnUndo.Enabled = false;
                        btnSave.Enabled = false;
                        btnNewProject.Enabled = true;
                        DisabledFields();
                        EmptyFields();


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
        }

        private void IsCorporate()
        {
            txtname.Enabled = true;
            txtpostaladdress.Enabled = true;
            txtaddresstelephoneno.Enabled = true;
            txttelno.Enabled = true;
            txtTinNo.Enabled = true;

            txtage.Enabled = false;
            dtpdob.Enabled = false;
            ddlgender.Enabled = false;
            txttelno.Enabled = false;
            txtnationality.Enabled = false;
            txtoccupation.Enabled = false;
            txtannualincome.Enabled = false;
            txtnameofemployer.Enabled = false;
            txtspousename.Enabled = false;
            txtnameofchildren.Enabled = false;
            txttotalnoofperson.Enabled = false;
            txtnameofmaid.Enabled = false;
            txtnameofdriver.Enabled = false;
            txtnoofvisitorperday.Enabled = false;



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
        }
        private bool IsClientValid()
        {
            if (string.IsNullOrEmpty(ddlClientType.Text))
            {
                MessageBox.Show("Client Type cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            if (string.IsNullOrEmpty(txtname.Text))
            {
                MessageBox.Show("Name cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }

            return true;
        }


        private string GetClientTypeCode()
        {
            string Code = string.Empty;
            switch (ddlClientType.Text)
            {
                case "INDIVIDUAL":
                    Code = "INDV";
                    break;
                case "CORPORATE":
                    Code = "CORP";
                    break;
                case "PARTNERSHIP":
                    Code = "PART";
                    break;
            }

            return Code;
        }
        private void M_SaveClient()
        {
            ClientModel dto = new ClientModel();
            dto.ClientType = GetClientTypeCode();
            dto.ClientName = txtname.Text;
            dto.Age = txtage.Text == string.Empty ? 0 : Convert.ToInt32(txtage.Text);
            dto.PostalAddress = txtpostaladdress.Text;
            dto.DateOfBirth = dtpdob.Text;
            dto.Gender = ddlgender.Text == "MALE" ? true : false;
            dto.TelNumber = txttelno.Text;
            dto.Nationality = txtnationality.Text;
            dto.Occupation = txtoccupation.Text;
            dto.AnnualIncome = txtannualincome.Text == string.Empty ? 0 : Convert.ToInt32(txtannualincome.Text);
            dto.EmployerName = txtnameofemployer.Text;
            dto.EmployerAddress = txtaddresstelephoneno.Text;
            dto.SpouseName = txtspousename.Text;
            dto.ChildrenNames = txtnameofchildren.Text;
            dto.TotalPersons = txttotalnoofperson.Text == string.Empty ? 0 : Convert.ToInt32(txttotalnoofperson.Text);
            dto.MaidName = txtnameofmaid.Text;
            dto.DriverName = txtnameofdriver.Text;
            dto.NoVisitorsPerDay = txtnoofvisitorperday.Text == string.Empty ? 0 : Convert.ToInt32(txtnoofvisitorperday.Text);
            dto.BuildingSecretary = 1;
            dto.EncodedBy = Variables.UserID;
            dto.TIN_No = txtTinNo.Text.Trim();
            dto.Message_Code = ClientContext.SaveClient(dto);
            if (dto.Message_Code.Equals("SUCCESS"))
            {
                MessageBox.Show("New Client  has been added successfully !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                strClientFormMode = "READ";
                M_GetClientList();

            }
            else
            {
                MessageBox.Show(dto.Message_Code, "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                strClientFormMode = "READ";
            }
        }
        public frmAddNewClient()
        {
            InitializeComponent();
        }
        private void M_GetClientList()
        {
            dgvClientList.DataSource = null;
            using (DataSet dt = ClientContext.GetClientList())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    dgvClientList.DataSource = dt.Tables[0];
                }
            }
        }
        private void txtage_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9\b]"))
                e.Handled = true;
        }
        private void txtannualincome_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9\b]"))
                e.Handled = true;
        }
        private void txttelno_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9\b]"))
                e.Handled = true;
        }
        private void radLabel16_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9\b]"))
                e.Handled = true;
        }
        private void btnNewProject_Click(object sender, EventArgs e)
        {
            strClientFormMode = "NEW";
        }
        private void frmAddNewClient_Load(object sender, EventArgs e)
        {
            strClientFormMode = "READ";
            M_GetClientList();
        }
        private void btnUndo_Click(object sender, EventArgs e)
        {
            strClientFormMode = "READ";
        }
        private void btnSave_Click(object sender, EventArgs e)
        {
            if (IsClientValid())
            {
                if (MessageBox.Show("Are you sure you want to add this client ?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                {
                    M_SaveClient();
                }
            }
        }
        private void txttotalnoofperson_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9\b]"))
                e.Handled = true;
        }
        private void txtnameofvisitorperday_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9\b]"))
                e.Handled = true;
        }
        private void dgvClientList_CellClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                if (this.dgvClientList.Columns[e.ColumnIndex].Name == "ColEdit")
                {
                    frmEditClient forms = new frmEditClient();
                    forms.ClientID = Convert.ToString(dgvClientList.CurrentRow.Cells["ClientID"].Value);
                    forms.ShowDialog();
                    M_GetClientList();
                    if (forms.IsProceed)
                    {
                        // M_GetProjectList();
                    }
                }
                //else if (this.dgvClientList.Columns[e.ColumnIndex].Name == "coldelete")
                //{

                //    if (MessageBox.Show("Are you sure you want to delete the Project?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                //    {

                //        var result = ProjectContext.DeleteProject(Convert.ToInt32(dgvProjectList.CurrentRow.Cells["RecId"].Value));
                //        if (result.Equals("SUCCESS"))
                //        {
                //            MessageBox.Show("Project has been Deleted successfully !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                //            M_GetProjectList();
                //        }
                //    }
                //}
            }
        }
        private void ddlClientType_SelectedIndexChanged(object sender, Telerik.WinControls.UI.Data.PositionChangedEventArgs e)
        {
            if (ddlClientType.SelectedIndex >= 0)
            {
                if (ddlClientType.SelectedIndex == 1 || ddlClientType.SelectedIndex == 2)
                {
                    IsCorporate();
                }
                else
                {
                    EnabledFields();
                }
            }
        }
    }
}
