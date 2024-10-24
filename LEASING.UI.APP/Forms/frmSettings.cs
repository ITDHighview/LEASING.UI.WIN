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
    public partial class frmSettings : Form
    {
        LocationContext LocationContext = new LocationContext();
        ProjectContext ProjectContext = new ProjectContext();
        public frmSettings()
        {
            InitializeComponent();
        }
        private string _strlocationFormMode;
        public string strlocationFormMode
        {
            get
            {
                return _strlocationFormMode;
            }
            set
            {
                _strlocationFormMode = value;
                switch (_strlocationFormMode)
                {
                    case "NEW":
                        btnUndo.Enabled = true;
                        btnSave.Enabled = true;
                        txtLocDescription.Enabled = true;
                        txtLocAddress.Enabled = true;


                        txtLocDescription.Text = string.Empty;
                        txtLocAddress.Text = string.Empty;
                        break;
                    case "READ":
                        btnUndo.Enabled = false;
                        btnSave.Enabled = false;
                        txtLocDescription.Enabled = false;
                        txtLocAddress.Enabled = false;


                        txtLocDescription.Text = string.Empty;
                        txtLocAddress.Text = string.Empty;
                        break;

                    default:
                        break;
                }
            }
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
                        ddLocationList.Enabled = true;

                        txtProjectName.Enabled = true;
                        txtProjectDescription.Enabled = true;
                        txtProjectName.Text = string.Empty;
                        txtProjectDescription.Text = string.Empty;

                        break;
                    case "READ":
                        btnUndoProject.Enabled = false;
                        btnSaveProject.Enabled = false;
                        ddLocationList.Enabled = false;
                        txtProjectName.Enabled = false;
                        txtProjectDescription.Enabled = false;
                        txtProjectName.Text = string.Empty;
                        txtProjectDescription.Text = string.Empty;
                        break;

                    default:
                        break;
                }
            }
        }
        private bool IsLocationValid()
        {
            if (string.IsNullOrEmpty(txtLocDescription.Text))
            {
                MessageBox.Show("Description cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            if (string.IsNullOrEmpty(txtLocAddress.Text))
            {
                MessageBox.Show("Address cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            return true;
        }
        private bool IsProjectValid()
        {
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
            if (ddLocationList.SelectedIndex ==-1)
            {
                MessageBox.Show("Please select location", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            if (ddLocationList.SelectedText == "--SELECT--")
            {
                MessageBox.Show("Please select location", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            return true;
        }
        private void M_GetLocationList()
        {
            dgvLocationList.DataSource = null;
            using (DataSet dt = LocationContext.GetLocationList())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    dgvLocationList.DataSource = dt.Tables[0];
                }
            }
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
        private void M_SaveLocation()
        {
            LocationModel dto = new LocationModel();
            dto.Description = txtLocDescription.Text;
            dto.LocAddress = txtLocAddress.Text;
            dto.Message_Code = LocationContext.SaveLocation(dto);
            if (dto.Message_Code.Equals("SUCCESS"))
            {
                MessageBox.Show("New Location has been added successfully !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                strlocationFormMode = "READ";
                M_GetLocationList();

            }
        }
        private void M_SaveProject()
        {
            ProjectModel dto = new ProjectModel();
            dto.LocId = Convert.ToInt32(ddLocationList.SelectedValue);
            dto.ProjectName = txtProjectName.Text;
            dto.Description = txtProjectDescription.Text;
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
        private void frmSettings_Load(object sender, EventArgs e)
        {
            strlocationFormMode = "READ";
            strProjectFormMode = "READ";
            M_GetLocationList();
            M_SelectLocation();
            M_GetProjectList();
        }
        private void btnNew_Click(object sender, EventArgs e)
        {
            strlocationFormMode = "NEW";
        }
        private void btnUndo_Click(object sender, EventArgs e)
        {
            strlocationFormMode = "READ";
        }
        private void btnSave_Click(object sender, EventArgs e)
        {
            if (IsLocationValid())
            {
                if (MessageBox.Show("Are you sure you want to save this location ?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                {
                    M_SaveLocation();
                }
            }
        }
        private void dgvLocationList_CellClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                if (this.dgvLocationList.Columns[e.ColumnIndex].Name == "coledit")
                {
                    EditLocationForm forms = new EditLocationForm();
                    forms.RecId = Convert.ToInt32(dgvLocationList.CurrentRow.Cells["RecId"].Value);
                    forms.ShowDialog();
                    if (forms.IsProceed)
                    {
                        M_GetLocationList();
                    }
                }
                else if (this.dgvLocationList.Columns[e.ColumnIndex].Name == "coldelete")
                {

                    if (MessageBox.Show("Are you sure you want to delete the location?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                    {

                        var result = LocationContext.DeleteLocation(Convert.ToInt32(dgvLocationList.CurrentRow.Cells["RecId"].Value));
                        if (result.Equals("SUCCESS"))
                        {
                            MessageBox.Show("Location has been Deleted successfully !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                            M_GetLocationList();
                        }
                    }
                }
            }
        }
        private void btnSaveProject_Click(object sender, EventArgs e)
        {
            if (IsProjectValid())
            {
                if (MessageBox.Show("Are you sure you want to save this Project ?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                {
                    M_SaveProject();
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
    }
}
