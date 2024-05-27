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
    public partial class frmGroupSecurity : Form
    {
        SecurityControlContext SecurityControlContext = new SecurityControlContext();
        public frmGroupSecurity()
        {
            InitializeComponent();
        }

        private void M_GetFormList()
        {
            ddlUserGroup.DataSource = null;
            using (DataSet dt = SecurityControlContext.GetGroupList())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    ddlUserGroup.ValueMember = "GroupId";
                    ddlUserGroup.DisplayMember = "GroupName";
                    ddlUserGroup.DataSource = dt.Tables[0];
                }
            }
        }
        private void M_GetFormListByGroupId(int groupid)
        {
            ddlFormName.DataSource = null;
            using (DataSet dt = SecurityControlContext.GetFormListByGroupId(groupid))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    ddlFormName.ValueMember = "FormId";
                    ddlFormName.DisplayMember = "FormDescription";
                    ddlFormName.DataSource = dt.Tables[0];
                }
            }
        }

        private void M_GetGetMenuListByFormId(int fromid)
        {
            ddlMenuName.DataSource = null;
            using (DataSet dt = SecurityControlContext.GetGetMenuListByFormId(fromid))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    ddlMenuName.ValueMember = "MenuId";
                    ddlMenuName.DisplayMember = "MenuName";
                    ddlMenuName.DataSource = dt.Tables[0];
                }
            }
        }

        private void M_GetGroupControlInfo(int controlid, int groupid, int formid)
        {

            chkControlPermission.Checked = false;
            using (DataSet dt = SecurityControlContext.GetGroupControlInfo(controlid, groupid, formid))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {

                    chkControlPermission.Checked = Convert.ToBoolean(dt.Tables[0].Rows[0]["IsVisible"]);
                }
            }
        }
        private void SaveControls()
        {
            try
            {
                string result = SecurityControlContext.UpdateGroupFormControls(Convert.ToInt32(ddlFormName.SelectedValue), Convert.ToInt32(dgvControlList.CurrentRow.Cells["ControlId"].Value), Convert.ToInt32(ddlUserGroup.SelectedValue), chkControlPermission.Checked);
                if (result.Equals("SUCCESS"))
                {
                    //MessageBox.Show("Save Successfully", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    M_GetControlListByGroupIdAndMenuId(Convert.ToInt32(ddlUserGroup.SelectedValue),Convert.ToInt32(ddlMenuName.SelectedValue));
                }
                else
                {
                    MessageBox.Show(result, "System Message", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                }
            }
            catch (Exception ex)
            {

                MessageBox.Show(ex.ToString(), "System Message", MessageBoxButtons.OK, MessageBoxIcon.Warning);
            }

        }
        private void M_GetControlListByGroupIdAndMenuId(int groupid, int menuid)
        {
            dgvControlList.DataSource = null;
            using (DataSet dt = SecurityControlContext.GetControlListByGroupIdAndMenuId(groupid, menuid))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {

                    dgvControlList.DataSource = dt.Tables[0];
                }
            }
        }

        private void frmGroupSecurity_Load(object sender, EventArgs e)
        {
            Functions.EventCapturefrmName(this);
            radLabel4.Visible = false;
            txtControlName.Visible = false;
            M_GetFormList();
        }

        private void btnRefresh_Click(object sender, EventArgs e)
        {
            M_GetFormList();
        }

        private void ddlUserGroup_SelectedIndexChanged(object sender, Telerik.WinControls.UI.Data.PositionChangedEventArgs e)
        {
            if (ddlUserGroup.SelectedIndex >= 0)
            {
                M_GetFormListByGroupId(Convert.ToInt32(ddlUserGroup.SelectedValue));
            }
        }

        private void ddlFormName_SelectedIndexChanged(object sender, Telerik.WinControls.UI.Data.PositionChangedEventArgs e)
        {
            if (ddlFormName.SelectedIndex >= 0)
            {
                M_GetGetMenuListByFormId(Convert.ToInt32(ddlFormName.SelectedValue));
            }
        }

        private void ddlMenuName_SelectedIndexChanged(object sender, Telerik.WinControls.UI.Data.PositionChangedEventArgs e)
        {
            if (ddlMenuName.SelectedIndex >= 0)
            {
                M_GetControlListByGroupIdAndMenuId(Convert.ToInt32(ddlUserGroup.SelectedValue), Convert.ToInt32(ddlMenuName.SelectedValue));
            }

        }

        private void dgvControlList_SelectionChanged(object sender, EventArgs e)
        {
            if (dgvControlList.Rows.Count > 0)
            {
                txtControlName.Text = Convert.ToString(dgvControlList.CurrentRow.Cells["ControlName"].Value);
                txtControlDescription.Text = Convert.ToString(dgvControlList.CurrentRow.Cells["ControlDescription"].Value);
                M_GetGroupControlInfo(Convert.ToInt32(dgvControlList.CurrentRow.Cells["ControlId"].Value), Convert.ToInt32(ddlUserGroup.SelectedValue), Convert.ToInt32(ddlFormName.SelectedValue));
            }
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Are you want to save the changes?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
            {
                SaveControls();
            }
        }
    }
}
