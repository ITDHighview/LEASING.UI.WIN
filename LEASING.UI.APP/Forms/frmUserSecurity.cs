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
    public partial class frmUserSecurity : Form
    {
        SecurityControlContext SecurityControlContext = new SecurityControlContext();
        public frmUserSecurity()
        {
            InitializeComponent();
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
                        ClearFields();
                        EnableFields();
                        btnNewUser.Enabled = false;
                        btnEditUser.Enabled = false;
                        btnSave.Enabled = true;
                        btnUndo.Enabled = true;
                        break;
                    case "EDIT":
                        btnNewUser.Enabled = false;
                        btnEditUser.Enabled = false;
                        btnSave.Enabled = true;
                        btnUndo.Enabled = true;
                        EnableFields();
                        break;
                    case "READ":
                        btnNewUser.Enabled = true;
                        btnEditUser.Enabled = true;
                        btnSave.Enabled = false;
                        btnUndo.Enabled = false;
                        DisableFields();
                        ClearFields();
                        txtUserPassword.PasswordChar = '*';
                        break;
                }
            }
        }

        private void ClearFields()
        {

            txtStaffName.Text = string.Empty;
            txtMiddlename.Text = string.Empty;
            txtLastname.Text = string.Empty;
            txtEmailAddress.Text = string.Empty;
            txtPhone.Text = string.Empty;
            txtUserPassword.Text = string.Empty;
        }

        private void EnableFields()
        {
            ddlUserGroup.Enabled = true;
            txtStaffName.Enabled = true;
            txtMiddlename.Enabled = true;
            txtLastname.Enabled = true;
            txtEmailAddress.Enabled = true;
            txtPhone.Enabled = true;
            txtUserPassword.Enabled = true;
        }
        private void DisableFields()
        {
            ddlUserGroup.Enabled = false;
            txtStaffName.Enabled = false;
            txtMiddlename.Enabled = false;
            txtLastname.Enabled = false;
            txtEmailAddress.Enabled = false;
            txtPhone.Enabled = false;
            txtUserPassword.Enabled = false;
        }
        bool IsValid()
        {

            if (string.IsNullOrEmpty(txtStaffName.Text))
            {
                MessageBox.Show("Staff Name Cannot Be empty", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return false;
            }
            if (string.IsNullOrEmpty(txtUserPassword.Text))
            {
                MessageBox.Show("Password Cannot Be empty", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return false;
            }
            return true;
        }
        private DialogResult MessageShow(string message)
        {
            return MessageBox.Show(message, "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
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
        private void M_GetUserList()
        {
            dgvControlList.DataSource = null;
            using (DataSet dt = SecurityControlContext.GetUserList())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {

                    dgvControlList.DataSource = dt.Tables[0];
                }
            }
        }
        private void M_SaveUser()
        {
            if (FormMode == "NEW")
            {
                try
                {
                    string result = SecurityControlContext.SaveUser(Convert.ToInt32(ddlUserGroup.SelectedValue),Convert.ToInt32(dgvControlList.CurrentRow.Cells["UserId"].Value), txtUserPassword.Text.Trim(), txtStaffName.Text.Trim(), txtMiddlename.Text.Trim(), txtLastname.Text.Trim(), txtEmailAddress.Text.Trim(), txtPhone.Text.Trim(), FormMode);
                    if (result.Equals("SUCCESS"))
                    {

                        //MessageBox.Show("New user Save Successfully", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        MessageShow("New user Save Successfully");
                        M_GetUserList();
                        FormMode = "READ";
                    }
                    else
                    {
                        MessageBox.Show(result, "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    }
                }
                catch (Exception ex)
                {

                    MessageBox.Show(ex.ToString(), "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
            else if (FormMode == "EDIT")
            {
                try
                {
                    try
                    {
                        string result = SecurityControlContext.SaveUser(Convert.ToInt32(ddlUserGroup.SelectedValue), Convert.ToInt32(dgvControlList.CurrentRow.Cells["UserId"].Value), txtUserPassword.Text.Trim(), txtStaffName.Text.Trim(), txtMiddlename.Text.Trim(), txtLastname.Text.Trim(), txtEmailAddress.Text.Trim(), txtPhone.Text.Trim(), FormMode);
                        if (result.Equals("SUCCESS"))
                        {

                            //MessageBox.Show("New user Save Successfully", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                            MessageShow("user updated  Successfully");
                            M_GetUserList();
                            FormMode = "READ";
                        }
                        else
                        {
                            MessageBox.Show(result, "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                        }
                    }
                    catch (Exception ex)
                    {

                        MessageBox.Show(ex.ToString(), "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    }
                }
                catch (Exception ex)
                {

                    MessageBox.Show(ex.ToString(), "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }
        }

        private void frmUserSecurity_Load(object sender, EventArgs e)
        {
            FormMode = "READ";
            M_GetFormList();
            M_GetUserList();
            txtUserPassword.Text = "123456789";
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (IsValid())
            {
                if (MessageBox.Show("Are you sure you want to save this user?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                {
                    M_SaveUser();
                }
            }
        }

        private void btnNewUser_Click(object sender, EventArgs e)
        {
            FormMode = "NEW";
        }

        private void btnEditUser_Click(object sender, EventArgs e)
        {
            FormMode = "EDIT";
        }

        private void btnUndo_Click(object sender, EventArgs e)
        {
            FormMode = "READ";
        }

        private void btnRefresh_Click(object sender, EventArgs e)
        {
            M_GetUserList();
        }

        private void dgvControlList_SelectionChanged(object sender, EventArgs e)
        {
            if (dgvControlList.Rows.Count > 0)
            {
                txtStaffName.Text = Convert.ToString(dgvControlList.CurrentRow.Cells["StaffName"].Value);
                txtMiddlename.Text = Convert.ToString(dgvControlList.CurrentRow.Cells["Middlename"].Value);
                txtLastname.Text = Convert.ToString(dgvControlList.CurrentRow.Cells["Lastname"].Value);
                txtEmailAddress.Text = Convert.ToString(dgvControlList.CurrentRow.Cells["EmailAddress"].Value);
                txtPhone.Text = Convert.ToString(dgvControlList.CurrentRow.Cells["Phone"].Value);
                txtUserPassword.Text = Convert.ToString(dgvControlList.CurrentRow.Cells["UserPassword"].Value);
            }
        }

        private void btnShowPassword_Click(object sender, EventArgs e)
        {
            txtUserPassword.PasswordChar = '\0';
        }
    }
}
