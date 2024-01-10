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
                        ClearFields();
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
        }
        private void btnShowPassword_Click(object sender, EventArgs e)
        {

        }
        private void M_GetUserList()
        {
            //dgvControlList.DataSource = null;
            using (DataSet dt = SecurityControlContext.GetUserInfo())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {

                    //dgvControlList.DataSource = dt.Tables[0];
                    txtUserGroup.Text = Convert.ToString(dt.Tables[0].Rows[0]["GroupName"]);
                    txtStaffName.Text = Convert.ToString(dt.Tables[0].Rows[0]["StaffName"]);
                    txtMiddlename.Text = Convert.ToString(dt.Tables[0].Rows[0]["Middlename"]);
                    txtLastname.Text = Convert.ToString(dt.Tables[0].Rows[0]["Lastname"]);
                    txtEmailAddress.Text = Convert.ToString(dt.Tables[0].Rows[0]["EmailAddress"]);
                    txtPhone.Text = Convert.ToString(dt.Tables[0].Rows[0]["Phone"]);
                    txtUserPassword.Text = Convert.ToString(dt.Tables[0].Rows[0]["UserPassword"]);
                }
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

        }
    }
}
