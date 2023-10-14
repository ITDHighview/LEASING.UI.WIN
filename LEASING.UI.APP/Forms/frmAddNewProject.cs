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
        ProjectContext ProjectContext = new ProjectContext();
        LocationContext LocationContext = new LocationContext();
        public frmAddNewProject()
        {
            InitializeComponent();
        }
        private string _strProjectFormMode;
        public string strProjectFormMode
        {
            get
            {
                return _strProjectFormMode;
            }
            set
            {
                _strProjectFormMode = value;
                switch (_strProjectFormMode)
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
        }
        private void DisableFields()
        {
            txtProjectName.Enabled = false;
            txtProjectDescription.Enabled = false;
            txtProjectAddress.Enabled = false;

            ddLocationList.Enabled = false;
            ddlProjectType.Enabled = false;
        }
        private void Emptyfields()
        {
            txtProjectName.Text = string.Empty;
            txtProjectDescription.Text = string.Empty;
            txtProjectAddress.Text = string.Empty;

        }
        private bool IsProjectValid()
        {
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
            dgvProjectList.DataSource = null;
            using (DataSet dt = ProjectContext.GetProjectList())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    dgvProjectList.DataSource = dt.Tables[0];
                }
            }
        }
        private void M_SaveProject()
        {
            ProjectModel dto = new ProjectModel();
            dto.LocId = Convert.ToInt32(ddLocationList.SelectedValue);
            dto.ProjectType = ddlProjectType.Text;
            dto.ProjectName = txtProjectName.Text;
            dto.Description = txtProjectDescription.Text;
            dto.ProjectAddress = txtProjectAddress.Text;
            dto.Message_Code = ProjectContext.SaveProject(dto);
            if (dto.Message_Code.Equals("SUCCESS"))
            {
                MessageBox.Show("New Project has been added successfully !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                strProjectFormMode = "READ";
                M_GetProjectList();
            }
            else
            {
                MessageBox.Show(dto.Message_Code, "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                strProjectFormMode = "READ";
            }
        }
        private void M_SelectLocation()
        {

            ddLocationList.DataSource = null;
            using (DataSet dt = LocationContext.GetSelectLocation())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    ddLocationList.DisplayMember = "Descriptions";
                    ddLocationList.ValueMember = "RecId";
                    ddLocationList.DataSource = dt.Tables[0];
                }
            }
        }

        private void M_SelectProjectType()
        {

            ddlProjectType.DataSource = null;
            using (DataSet dt = ProjectContext.GetSelectProjectType())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    ddlProjectType.DisplayMember = "ProjectTypeName";
                    ddlProjectType.ValueMember = "Recid";
                    ddlProjectType.DataSource = dt.Tables[0];
                }
            }
        }
        private void frmAddNewProject_Load(object sender, EventArgs e)
        {
            strProjectFormMode = "READ";
            M_SelectProjectType();
            M_SelectLocation();
            M_GetProjectList();
        }

        private void btnSaveProject_Click(object sender, EventArgs e)
        {
            if (strProjectFormMode == "NEW")
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
            strProjectFormMode = "READ";
        }

        private void btnNewProject_Click(object sender, EventArgs e)
        {
            strProjectFormMode = "NEW";
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

                        var result = ProjectContext.DeActivateProject(Convert.ToInt32(dgvProjectList.CurrentRow.Cells["RecId"].Value));
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
