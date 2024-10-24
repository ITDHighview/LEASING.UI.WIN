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
using System.Threading.Tasks;
using System.Windows.Forms;

namespace LEASING.UI.APP.Forms
{
    public partial class EditCompanyForm : Form
    {
        CompanyContext CompanyContext = new CompanyContext();
        public EditCompanyForm()
        {
            InitializeComponent();
        }
        public int Recid { get; set; } = 0;
        public bool IsProceed = false;  
        private string _strFormMode;
        public string strFormMode
        {
            get
            {
                return _strFormMode;
            }
            set
            {
                _strFormMode = value;
                switch (_strFormMode)
                {
                    case "NEW":
                        btnUndoProject.Enabled = true;
                        btnSaveProject.Enabled = true;
                        btnEditCompany.Enabled = false;
                        EnableFields();
                        break;
                    case "READ":
                        btnUndoProject.Enabled = false;
                        btnSaveProject.Enabled = false;
                        btnEditCompany.Enabled = true;
                        DisableFields();
                        break;

                    default:
                        break;
                }
            }
        }
        private void EnableFields()
        {
            txtCompanyName.Enabled = true;
            txtCompanyAddress.Enabled = true;
            txtCompanyTINNo.Enabled = true;
            txtCompanyOwnerName.Enabled = true;
        }
        private void DisableFields()
        {
            txtCompanyName.Enabled = false;
            txtCompanyAddress.Enabled = false;
            txtCompanyTINNo.Enabled = false;
            txtCompanyOwnerName.Enabled = false;
        }
        private bool IsValid()
        {
            if (string.IsNullOrEmpty(txtCompanyName.Text))
            {
                Functions.MessageShow("Company Name cannot be empty !");
                return false;
            }
            if (string.IsNullOrEmpty(txtCompanyOwnerName.Text))
            {
                Functions.MessageShow("Company Owner Name cannot be empty !");
                return false;
            }
            return true;
        }
        private void M_GetCompanyList()
        {
            txtCompanyName.Text = string.Empty;
            txtCompanyAddress.Text = string.Empty;
            txtCompanyTINNo.Text = string.Empty;
            txtCompanyOwnerName.Text = string.Empty;
            try
            {
                using (DataSet dt = CompanyContext.GetCompanyDetails(Recid))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        txtCompanyName.Text = Convert.ToString(dt.Tables[0].Rows[0]["CompanyName"]);
                        txtCompanyAddress.Text = Convert.ToString(dt.Tables[0].Rows[0]["CompanyAddress"]);
                        txtCompanyTINNo.Text = Convert.ToString(dt.Tables[0].Rows[0]["CompanyTIN"]);
                        txtCompanyOwnerName.Text = Convert.ToString(dt.Tables[0].Rows[0]["CompanyOwnerName"]);
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_GetCompanyList()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_GetCompanyList()", ex.ToString());
            }
        }
        private void M_SaveCompany()
        {
            try
            {
                CompanyModel dto = new CompanyModel();
                dto.RecId = Recid;
                dto.CompanyName = txtCompanyName.Text;
                dto.CompanyAddress = txtCompanyAddress.Text;
                dto.CompanyTIN = txtCompanyTINNo.Text;
                dto.CompanyOwnerName = txtCompanyOwnerName.Text;
                dto.Message_Code = CompanyContext.UpdateCompany(dto);
                if (dto.Message_Code.Equals("SUCCESS"))
                {
                    Functions.MessageShow("Company Details has been Updated successfully !");
                    strFormMode = "READ";

                }
                else
                {
                    Functions.MessageShow(dto.Message_Code);
                    strFormMode = "READ";
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_SaveCompany()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_SaveCompany()", ex.ToString());
            }
        }
        private void frmAddNewProject_Load(object sender, EventArgs e)
        {
            Functions.EventCapturefrmName(this);
            strFormMode = "READ";
            M_GetCompanyList();
        }
        private void btnSaveProject_Click(object sender, EventArgs e)
        {
            if (strFormMode == "NEW")
            {
                if (IsValid())
                {
                    if (Functions.MessageConfirm("Are you sure you want to save this Company ?") == DialogResult.Yes)
                    {
                        IsProceed = true;
                        M_SaveCompany();
                        this.Close();
                    }
                }
            }
        }
        private void btnUndoProject_Click(object sender, EventArgs e)
        {
            strFormMode = "READ";
        }
        private void btnNewProject_Click(object sender, EventArgs e)
        {
            strFormMode = "NEW";
        }
    }
}
