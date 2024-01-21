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
    public partial class frmUserDashBoard : Form
    {
        SecurityControlContext SecurityControlContext = new SecurityControlContext();
        bool IsShowPassword = false;
        public frmUserDashBoard()
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
                    //case "NEW":
                    //    ClearFields();
                    //    EnableFields();
                    //    btnNewUser.Enabled = false;
                    //    btnEditUser.Enabled = false;
                    //    btnSave.Enabled = true;
                    //    btnUndo.Enabled = true;
                    //    break;
                    case "EDIT":
                        //btnNewUser.Enabled = false;
                        btnEditUser.Enabled = false;
                        btnSave.Enabled = true;
                        btnUndo.Enabled = true;
                        EnableFields();
                        break;
                    case "READ":
                        //btnNewUser.Enabled = true;
                        btnEditUser.Enabled = true;
                        btnSave.Enabled = false;
                        btnUndo.Enabled = false;
                        DisableFields();
                      
                        txtUserPassword.PasswordChar = '*';
                        break;
                }
            }
        }
        private void ClearFields()
        {
            txtUserGroup.Text = string.Empty;
            txtStaffName.Text = string.Empty;
            txtMiddlename.Text = string.Empty;
            txtLastname.Text = string.Empty;
            txtEmailAddress.Text = string.Empty;
            txtPhone.Text = string.Empty;
            txtUserPassword.Text = string.Empty;
            txtUserName.Text = string.Empty;
        }
        private void EnableFields()
        {
            txtUserGroup.Enabled = true;
            txtStaffName.Enabled = true;
            txtMiddlename.Enabled = true;
            txtLastname.Enabled = true;
            txtEmailAddress.Enabled = true;
            txtPhone.Enabled = true;
            txtUserPassword.Enabled = true;
            txtUserName.Enabled = true;
        }
        private void DisableFields()
        {
            txtUserGroup.Enabled = false;
            txtStaffName.Enabled = false;
            txtMiddlename.Enabled = false;
            txtLastname.Enabled = false;
            txtEmailAddress.Enabled = false;
            txtPhone.Enabled = false;
            txtUserPassword.Enabled = false;
            txtUserName.Enabled = false;
        }
        private void M_GetUserList()
        {
            //dgvControlList.DataSource = null;
            using (DataSet dt = SecurityControlContext.GetUserInfo())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    txtUserGroup.Text = Convert.ToString(dt.Tables[0].Rows[0]["GroupName"]);
                    txtStaffName.Text = Convert.ToString(dt.Tables[0].Rows[0]["StaffName"]);
                    txtMiddlename.Text = Convert.ToString(dt.Tables[0].Rows[0]["Middlename"]);
                    txtLastname.Text = Convert.ToString(dt.Tables[0].Rows[0]["Lastname"]);
                    txtEmailAddress.Text = Convert.ToString(dt.Tables[0].Rows[0]["EmailAddress"]);
                    txtPhone.Text = Convert.ToString(dt.Tables[0].Rows[0]["Phone"]);
                    txtUserPassword.Text = Convert.ToString(dt.Tables[0].Rows[0]["UserPassword"]);
                    txtUserName.Text = Convert.ToString(dt.Tables[0].Rows[0]["UserName"]);
                }
            }
        }
        private bool Validates()
        {
            if (string.IsNullOrEmpty(txtUserName.Text))
            {
                Functions.MessageShow("user name cannot be empty.");
                return false;
            }
            if (string.IsNullOrEmpty(txtUserPassword.Text))
            {
                Functions.MessageShow("password cannot be empty.");
                return false;
            }
            return true;
        }
        private void M_SaveUser()
        {
            string result = SecurityControlContext.UpdateUserInfo(txtUserName.Text, txtUserPassword.Text, txtStaffName.Text, txtMiddlename.Text, txtLastname.Text, txtEmailAddress.Text, txtPhone.Text);
            if (result.Equals("SUCCESS"))
            {               
                Functions.MessageShow("Your information updated successfully.");
                FormMode = "READ";
            }
            else
            {               
                Functions.MessageShow(result);
            }
        }
        private void btnShowPassword_Click(object sender, EventArgs e)
        {
            IsShowPassword = !IsShowPassword;
            if (IsShowPassword)
            {
                txtUserPassword.PasswordChar = '\0';
            }
            else
            {
                txtUserPassword.PasswordChar = '*';
            }
           
        }
        private void frmUserDashBoard_Load(object sender, EventArgs e)
        {
            FormMode = "READ";
            M_GetUserList();
        }
        private void btnUndo_Click(object sender, EventArgs e)
        {
            FormMode = "READ";
        }
        private void btnEditUser_Click(object sender, EventArgs e)
        {
            FormMode = "EDIT";
        }
        private void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if (Validates())
                {
                    if (Functions.MessageConfirm("Are you sure you want to save your info?.") == DialogResult.Yes)
                    {
                        M_SaveUser();
                    }                
                }      
            }
            catch (Exception ex)
            {
                Functions.MessageShow(ex.ToString());
            }
        }
    }
}
