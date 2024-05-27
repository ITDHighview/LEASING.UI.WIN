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
    public partial class frmAddNewCompany : Form
    {
        private CompanyContext _company;
       
        public frmAddNewCompany()
        {
            _company = new CompanyContext();
            InitializeComponent();
        }
        enum ModeStatus
        {
            READ,
            NEW
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
                        btnUndoProject.Enabled = true;
                        btnSaveProject.Enabled = true;
                        btnNewProject.Enabled = false;

                        EnableFields();
                        Emptyfields();

                        break;
                    case "READ":
                        btnUndoProject.Enabled = false;
                        btnSaveProject.Enabled = false;
                        btnNewProject.Enabled = true;
                        DisableFields();
                        Emptyfields();

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
        private void Emptyfields()
        {
            txtCompanyName.Text = string.Empty;
            txtCompanyAddress.Text = string.Empty;
            txtCompanyTINNo.Text = string.Empty;
            txtCompanyOwnerName.Text = string.Empty;
        }
        private bool IsValid()
        {
            if (string.IsNullOrEmpty(this.txtCompanyName.Text))
            {
                Functions.MessageShow("Company Name cannot be empty !");
                return false;
            }
            if (string.IsNullOrEmpty(this.txtCompanyOwnerName.Text))
            {
                Functions.MessageShow("Company Owner Name cannot be empty !");
                return false;
            }
            return true;
        }
        private void M_GetCompanyList()
        {
            try
            {
                dgvCompanyList.DataSource = null;
                using (DataSet dt = _company.GetCompanyList())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        dgvCompanyList.DataSource = dt.Tables[0];
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
                dto.CompanyName = txtCompanyName.Text;
                dto.CompanyAddress = txtCompanyAddress.Text;
                dto.CompanyTIN = txtCompanyTINNo.Text;
                dto.CompanyOwnerName = txtCompanyOwnerName.Text;
                dto.Message_Code = _company.SaveCompany(dto);
                if (dto.Message_Code.Equals("SUCCESS"))
                {
                    Functions.MessageShow("New Company has been added successfully !");
                    this.FormMode = ModeStatus.READ.ToString();
                    M_GetCompanyList();
                }
                else
                {
                    Functions.MessageShow(dto.Message_Code);
                    this.FormMode = ModeStatus.READ.ToString();
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
            this.FormMode = ModeStatus.READ.ToString();
            M_GetCompanyList();
        }

        private void btnSaveProject_Click(object sender, EventArgs e)
        {
            if (this.FormMode == ModeStatus.NEW.ToString())
            {
                if (IsValid())
                {
                    if (Functions.MessageConfirm("Are you sure you want to save this Company ?") == DialogResult.Yes)
                    {
                        M_SaveCompany();
                    }
                }
            }
        }

        private void btnUndoProject_Click(object sender, EventArgs e)
        {
            this.FormMode = ModeStatus.READ.ToString();
        }

        private void btnNewProject_Click(object sender, EventArgs e)
        {
            this.FormMode = ModeStatus.READ.ToString();
        }

        private void dgvProjectList_CellClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                if (this.dgvCompanyList.Columns[e.ColumnIndex].Name == "coledit")
                {
                    frmEditCompany forms = new frmEditCompany();
                    forms.Recid = Convert.ToInt32(dgvCompanyList.CurrentRow.Cells["RecId"].Value);
                    forms.ShowDialog();
                    if (forms.IsProceed)
                    {
                        M_GetCompanyList();
                    }
                }
                else if (this.dgvCompanyList.Columns[e.ColumnIndex].Name == "coldelete")
                {
                }
            }
        }
    }
}
