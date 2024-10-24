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
    public partial class UserGroupRegistrationForm : Form
    {
        SecurityControlContext SecurityControlContext = new SecurityControlContext();
        public UserGroupRegistrationForm()
        {
            InitializeComponent();
        }
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
                        btnUndo.Enabled = true;
                        btnSave.Enabled = true;
                        txtGroupName.Enabled = true;
                        btnNew.Enabled = false;
                        txtGroupName.Text = string.Empty;

                        break;
                    case "READ":
                        btnUndo.Enabled = false;
                        btnSave.Enabled = false;
                        txtGroupName.Enabled = false;
                        btnNew.Enabled = true;
                        txtGroupName.Text = string.Empty;
                        break;

                    default:
                        break;
                }
            }
        }
        private bool IsValid()
        {
            if (string.IsNullOrEmpty(txtGroupName.Text))
            {
                MessageBox.Show("Group Name cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            return true;
        }
        private void SaveUserGroup()
        {
            try
            {
                string result = SecurityControlContext.SaveUserGroup(txtGroupName.Text);
                if (result.Equals("SUCCESS"))
                {
                    MessageBox.Show("New Group has been added successfully !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    strFormMode = "READ";
                    M_GetGroupList();
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
        private void DeleteUserGroup()
        {
            try
            {
                string result = SecurityControlContext.DeleteUserGroup(Convert.ToInt32(dgvList.CurrentRow.Cells["GroupId"].Value));
                if (result.Equals("SUCCESS"))
                {
                    MessageBox.Show("Group delete successfully !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    strFormMode = "READ";
                    M_GetGroupList();
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
        private void M_GetGroupList()
        {
            dgvList.DataSource = null;
            using (DataSet dt = SecurityControlContext.GetSelectUserGroup())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    dgvList.DataSource = dt.Tables[0];
                }
            }
        }
        private void frmUserGroup_Load(object sender, EventArgs e)
        {
            Functions.EventCapturefrmName(this);
            strFormMode = "READ";
            M_GetGroupList();
        }
        private void btnNew_Click(object sender, EventArgs e)
        {
            strFormMode = "NEW";
        }
        private void btnUndo_Click(object sender, EventArgs e)
        {
            strFormMode = "READ";
        }
        private void dgvList_CellClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                if (this.dgvList.Columns[e.ColumnIndex].Name == "ColRemoved")
                {
                    if (MessageBox.Show("Are you sure you want to delete this group ?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                    {
                        DeleteUserGroup();
                    }
                }
            }
        }
        private void btnSave_Click(object sender, EventArgs e)
        {
            if (strFormMode == "NEW")
            {
                if (IsValid())
                {
                    if (MessageBox.Show("Are you sure you want to add this Group ?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                    {
                        SaveUserGroup();
                    }
                }
            }
        }
    }
}
