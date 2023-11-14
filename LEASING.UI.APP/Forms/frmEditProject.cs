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
using Telerik.WinControls;

namespace LEASING.UI.APP.Forms
{
    public partial class frmEditProject : Form
    {
        ProjectContext ProjectContext = new ProjectContext();
        LocationContext LocationContext = new LocationContext();
        PurchaseItemContext PurchaseItemContext = new PurchaseItemContext();
        UnitContext UnitContext = new UnitContext();
        bool isResidential = false;
        public int Recid { get; set; }
        public bool IsProceed = false;

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
                    case "EDIT":
                        btnUndo.Enabled = true;
                        btnSave.Enabled = true;
                        btnEdit.Enabled = false;
                        EnableFields();
                        break;
                    case "READ":
                        btnUndo.Enabled = false;
                        btnSave.Enabled = false;
                        btnEdit.Enabled = true;
                        DisableFields();


                        break;

                    default:
                        break;
                }
            }
        }


        private void EnableFields()
        {
            txtProjectName.Enabled = true;
            txtDescription.Enabled = true;
            txtProjectAddress.Enabled = true;

            //ddLocationList.Enabled = true;
            //ddlProjectType.Enabled = true;
        }
        private void DisableFields()
        {
            txtProjectName.Enabled = false;
            txtDescription.Enabled = false;
            txtProjectAddress.Enabled = false;

            ddLocationList.Enabled = false;
            ddlProjectType.Enabled = false;
        }

        private void M_GetUnitByProjectId()
        {
            dgvUnitList.DataSource = null;
            using (DataSet dt = UnitContext.GetUnitByProjectId(Recid))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    dgvUnitList.DataSource = dt.Tables[0];
                }
            }
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
            if (string.IsNullOrEmpty(txtDescription.Text))
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
                MessageBox.Show("Project Address cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            return true;
        }
        public frmEditProject()
        {
            InitializeComponent();
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
        private void M_getProjectById()
        {
            txtProjectName.Text = string.Empty;
            txtDescription.Text = string.Empty;
            //chkIsActive.Checked = false;

            using (DataSet dt = ProjectContext.GetProjectById(Recid))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    ddlProjectType.Text = Convert.ToString(dt.Tables[0].Rows[0]["ProjectType"]);
                    txtProjectName.Text = Convert.ToString(dt.Tables[0].Rows[0]["ProjectName"]);
                    txtDescription.Text = Convert.ToString(dt.Tables[0].Rows[0]["Descriptions"]);
                    //chkIsActive.Checked = Convert.ToBoolean(dt.Tables[0].Rows[0]["IsActive"]);
                    ddLocationList.Text = Convert.ToString(dt.Tables[0].Rows[0]["LocationName"]);
                    ddLocationList.SelectedValue = Convert.ToInt32(dt.Tables[0].Rows[0]["LocationId"]);
                    txtProjectAddress.Text = Convert.ToString(dt.Tables[0].Rows[0]["ProjectAddress"]);
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
        //private void M_GetPurchaseItemList()
        //{
        //    dgvPurchaseItemList.DataSource = null;
        //    using (DataSet dt = PurchaseItemContext.GetGetPurchaseItemById(Recid))
        //    {
        //        if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
        //        {
        //            dgvPurchaseItemList.DataSource = dt.Tables[0];
        //        }
        //    }
        //}
        private void M_SaveProject()
        {
            ProjectModel dto = new ProjectModel();
            dto.ProjectId = Recid;
            dto.ProjectType = ddlProjectType.Text;
            dto.LocId = Convert.ToInt32(ddLocationList.SelectedValue);
            dto.ProjectName = txtProjectName.Text;
            dto.Description = txtDescription.Text;
            dto.ProjectAddress = txtProjectAddress.Text;
            //dto.ProjectStatus = chkIsActive.Checked;
            dto.Message_Code = ProjectContext.EditProject(dto);
            if (dto.Message_Code.Equals("SUCCESS"))
            {
                IsProceed = true;
                MessageBox.Show("Project info has been Upated successfully !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                strProjectFormMode = "READ";
                this.Close();
            }
        }

        private void frmEditProject_Load(object sender, EventArgs e)
        {
            strProjectFormMode = "READ";
            M_SelectLocation();
            M_SelectProjectType();
            M_getProjectById();
            M_GetUnitByProjectId();
            //M_GetPurchaseItemList();


        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (strProjectFormMode == "EDIT")
            {
                if (Recid > 0)
                {
                    if (IsProjectValid())
                    {
                        if (MessageBox.Show("Are you sure you want to update the following project?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                        {
                            M_SaveProject();
                        }
                    }
                }
            }

        }


        private void btnEdit_Click(object sender, EventArgs e)
        {
            strProjectFormMode = "EDIT";
        }

        private void btnUndo_Click(object sender, EventArgs e)
        {
            strProjectFormMode = "READ";
        }

        private void btnPuchaseItemList_Click(object sender, EventArgs e)
        {
            frmPurchaseItemList forms = new frmPurchaseItemList();
            forms.Recid = Recid;
            forms.ShowDialog();
        }

        private void dgvUnitList_CellClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                if (this.dgvUnitList.Columns[e.ColumnIndex].Name == "ColEdit")
                {
                    frmEditUnits forms = new frmEditUnits();
                    forms.Recid = Convert.ToInt32(dgvUnitList.CurrentRow.Cells["RecId"].Value);
                    forms.isResidential = isResidential;
                    forms.ShowDialog();
                    if (forms.IsProceed)
                    {
                        M_GetUnitByProjectId();
                    }
                }
                else if (this.dgvUnitList.Columns[e.ColumnIndex].Name == "ColDeactivate")
                {

                    if (MessageBox.Show("Are you sure you want to Deactivated the Unit?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                    {

                        //var result = ProjectContext.DeActivateProject(Convert.ToInt32(dgvProjectList.CurrentRow.Cells["RecId"].Value));
                        //if (result.Equals("SUCCESS"))
                        //{
                        //    MessageBox.Show("Project has been Deactivated successfully !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        //    M_GetProjectList();
                        //}
                    }
                }
            }
        }

        private void dgvUnitList_CellFormatting(object sender, Telerik.WinControls.UI.CellFormattingEventArgs e)
        {

            if (!string.IsNullOrEmpty(Convert.ToString(this.dgvUnitList.Rows[e.RowIndex].Cells["UnitStat"].Value)))
            {
                if (Convert.ToString(this.dgvUnitList.Rows[e.RowIndex].Cells["UnitStat"].Value) == "VACANT")
                {
                    //e.CellElement.ForeColor = Color.Green;
                    //e.CellElement.Font = new Font("Tahoma", 7f, FontStyle.Bold);
                    e.CellElement.ForeColor = Color.Black;
                    e.CellElement.DrawFill = true;
                    e.CellElement.GradientStyle = GradientStyles.Solid;
                    e.CellElement.BackColor = Color.Yellow;
                }
                else if (Convert.ToString(this.dgvUnitList.Rows[e.RowIndex].Cells["UnitStat"].Value) == "RESERVED")
                {
                    e.CellElement.DrawFill = true;
                    e.CellElement.GradientStyle = GradientStyles.Solid;
                    e.CellElement.ForeColor = Color.Black;
                    e.CellElement.BackColor = Color.LightSkyBlue;
                }
                else if (Convert.ToString(this.dgvUnitList.Rows[e.RowIndex].Cells["UnitStat"].Value) == "OCCUPIED")
                {
                    e.CellElement.DrawFill = true;
                    e.CellElement.GradientStyle = GradientStyles.Solid;
                    e.CellElement.ForeColor = Color.Black;
                    e.CellElement.BackColor = Color.LightGreen;

                }
                else if (Convert.ToString(this.dgvUnitList.Rows[e.RowIndex].Cells["UnitStat"].Value) == "NOT AVAILABLE")
                {
                    e.CellElement.DrawFill = true;
                    e.CellElement.GradientStyle = GradientStyles.Solid;
                    e.CellElement.ForeColor = Color.Black;
                    e.CellElement.BackColor = Color.LightSalmon;

                }
                else if (Convert.ToString(this.dgvUnitList.Rows[e.RowIndex].Cells["UnitStat"].Value) == "HOLD")
                {
                    e.CellElement.DrawFill = true;
                    e.CellElement.GradientStyle = GradientStyles.Solid;
                    e.CellElement.ForeColor = Color.White;
                    e.CellElement.BackColor = Color.Red;

                }
            }
        }

        private void btnNewPurchaseItems_Click(object sender, EventArgs e)
        {
            frmAddNewPurchaseItemByProject forms = new frmAddNewPurchaseItemByProject();
            forms.RecId = Recid;
            forms.ShowDialog();
            if (forms.IsProceed)
            {
                frmPurchaseItemList frmPurchaseItemList = new frmPurchaseItemList();
                frmPurchaseItemList.Recid = Recid;
                frmPurchaseItemList.ShowDialog();
            }
        }

        private void btnAddUnits_Click(object sender, EventArgs e)
        {
            frmAddNewUnitsByProject frmAddNewUnitsByProject = new frmAddNewUnitsByProject();
            frmAddNewUnitsByProject.RecId = Recid;
            frmAddNewUnitsByProject.ShowDialog();
            if (frmAddNewUnitsByProject.IsProceed)
            {
                M_GetUnitByProjectId();
            }
        }
    }
}
