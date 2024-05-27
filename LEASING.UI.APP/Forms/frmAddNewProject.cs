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
    public partial class frmAddNewProject : Form
    {
        private ProjectContext _project;
        private LocationContext _location;
        public frmAddNewProject()
        {
            _project = new ProjectContext();
            _location = new LocationContext();
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
            txtProjectName.Enabled = true;
            txtProjectDescription.Enabled = true;
            txtProjectAddress.Enabled = true;
            ddLocationList.Enabled = true;
            ddlProjectType.Enabled = true;
            ddlCompanyList.Enabled = true;
        }
        private void DisableFields()
        {
            txtProjectName.Enabled = false;
            txtProjectDescription.Enabled = false;
            txtProjectAddress.Enabled = false;
            ddLocationList.Enabled = false;
            ddlProjectType.Enabled = false;
            ddlCompanyList.Enabled = false;
        }
        private void Emptyfields()
        {
            txtProjectName.Text = string.Empty;
            txtProjectDescription.Text = string.Empty;
            txtProjectAddress.Text = string.Empty;
        }
        private bool IsProjectValid()
        {
            if (ddlCompanyList.SelectedIndex == -1)
            {
                MessageBox.Show("Company  cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            if (ddlCompanyList.SelectedText == "--SELECT--")
            {
                MessageBox.Show("Please select Company", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            if (ddlProjectType.SelectedIndex == -1)
            {
                MessageBox.Show("Project Type  cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            if (ddlProjectType.SelectedText == "--SELECT--")
            {
                MessageBox.Show("Please select Project Type", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }

            if (string.IsNullOrEmpty(txtProjectName.Text))
            {
                MessageBox.Show("Project Name cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            if (string.IsNullOrEmpty(txtProjectDescription.Text))
            {
                MessageBox.Show("Project Description cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            if (ddLocationList.SelectedIndex == -1)
            {
                MessageBox.Show("Please select location", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            if (ddLocationList.SelectedText == "--SELECT--")
            {
                MessageBox.Show("Please select location", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            if (string.IsNullOrEmpty(txtProjectAddress.Text))
            {
                MessageBox.Show("Project Addreess cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            return true;
        }
        private void M_GetProjectList()
        {
            try
            {
                dgvProjectList.DataSource = null;
                using (DataSet dt = _project.GetProjectList())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        dgvProjectList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_GetProjectList()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_GetProjectList()", ex.ToString());
            }
        }
        private void M_SaveProject()
        {
            try
            {
                ProjectModel dto = new ProjectModel();
                dto.LocId = Convert.ToInt32(ddLocationList.SelectedValue);
                dto.ProjectType = ddlProjectType.Text;
                dto.ProjectName = txtProjectName.Text;
                dto.Description = txtProjectDescription.Text;
                dto.ProjectAddress = txtProjectAddress.Text;
                dto.CompanyId = Convert.ToInt32(ddlCompanyList.SelectedValue);
                dto.Message_Code = _project.SaveProject(dto);
                if (dto.Message_Code.Equals("SUCCESS"))
                {
                    Functions.MessageShow("New Project has been added successfully !");
                    this.FormMode = ModeStatus.READ.ToString();
                    M_GetProjectList();
                }
                else
                {
                    Functions.MessageShow(dto.Message_Code);
                    this.FormMode = ModeStatus.READ.ToString();
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_SaveProject()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_SaveProject()", ex.ToString());
            }
        }
        private void M_SelectCompany()
        {
            try
            {
                ddlCompanyList.DataSource = null;
                using (DataSet dt = _project.GetSelectCompany())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        ddlCompanyList.DisplayMember = "CompanyName";
                        ddlCompanyList.ValueMember = "RecId";
                        ddlCompanyList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_SelectCompany()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_SelectCompany()", ex.ToString());
            }
        }
        private void M_SelectLocation()
        {
            try
            {
                ddLocationList.DataSource = null;
                using (DataSet dt = _location.GetSelectLocation())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        ddLocationList.DisplayMember = "Descriptions";
                        ddLocationList.ValueMember = "RecId";
                        ddLocationList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_SelectLocation()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_SelectLocation()", ex.ToString());
            }
        }

        private void M_SelectProjectType()
        {
            try
            {
                ddlProjectType.DataSource = null;
                using (DataSet dt = _project.GetSelectProjectType())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        ddlProjectType.DisplayMember = "ProjectTypeName";
                        ddlProjectType.ValueMember = "Recid";
                        ddlProjectType.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_SelectProjectType()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_SelectProjectType()", ex.ToString());
            }
        }
        private void frmAddNewProject_Load(object sender, EventArgs e)
        {
            this.FormMode = ModeStatus.READ.ToString();
            M_SelectCompany();
            M_SelectProjectType();
            M_SelectLocation();
            M_GetProjectList();
        }

        private void btnSaveProject_Click(object sender, EventArgs e)
        {
            if (this.FormMode == ModeStatus.NEW.ToString())
            {
                if (IsProjectValid())
                {
                    if (MessageBox.Show("Are you sure you want to save this Project ?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                    {
                        M_SaveProject();
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
            this.FormMode = ModeStatus.NEW.ToString();
        }

        private void dgvProjectList_CellClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                if (this.dgvProjectList.Columns[e.ColumnIndex].Name == "coledit")
                {
                    frmEditProject forms = new frmEditProject();
                    forms.Recid = Convert.ToInt32(dgvProjectList.CurrentRow.Cells["RecId"].Value);
                    forms.ShowDialog();
                    if (forms.IsProceed)
                    {
                        M_GetProjectList();
                    }
                }
                else if (this.dgvProjectList.Columns[e.ColumnIndex].Name == "coldelete")
                {

                    if (MessageBox.Show("Are you sure you want to Deactivated the Project?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                    {

                        var result = _project.DeActivateProject(Convert.ToInt32(dgvProjectList.CurrentRow.Cells["RecId"].Value));
                        if (result.Equals("SUCCESS"))
                        {
                            MessageBox.Show("Project has been Deactivated successfully !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                            M_GetProjectList();
                        }
                    }
                }
            }
        }

        private void btnCheckDeactivatedlist_Click(object sender, EventArgs e)
        {
            frmInActiveProjectList forms = new frmInActiveProjectList();
            forms.ShowDialog();
            M_GetProjectList();
        }
    }
}
