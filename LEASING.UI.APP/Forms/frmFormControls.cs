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
    public partial class frmFormControls : Form
    {
        SecurityControlContext SecurityControlContext = new SecurityControlContext();
        public frmFormControls()
        {
            InitializeComponent();
        }
        bool IsValid()
        {
            if (string.IsNullOrEmpty(txtControlDesc.Text))
            {
                MessageBox.Show("Please provide Control Name", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return false;
            }

            return true;
        }
        private void ClearFields()
        {
            txtControlName.Text = string.Empty;
            txtControlDesc.Text = string.Empty;
            chkBackroundControl.Checked = false;
            chkHeaderControl.Checked = false;
        }
        private void M_GetFormList()
        {
            ddlFormName.DataSource = null;
            using (DataSet dt = SecurityControlContext.GetFormList())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    ddlFormName.ValueMember = "FormId";
                    ddlFormName.DisplayMember = "FormDescription";
                    ddlFormName.DataSource = dt.Tables[0];
                }
            }
        }
        private void M_GetMenuList()
        {
            ddlMenuName.DataSource = null;
            using (DataSet dt = SecurityControlContext.GetMenuList())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    ddlMenuName.ValueMember = "MenuId";
                    ddlMenuName.DisplayMember = "MenuName";
                    ddlMenuName.DataSource = dt.Tables[0];
                }
            }
        }
        private void M_GetControlList()
        {
            dgvControlList.DataSource = null;
            using (DataSet dt = SecurityControlContext.GetControlList())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {

                    dgvControlList.DataSource = dt.Tables[0];
                }
            }
        }
        private void M_SaveFormControls()
        {

            try
            {
                string result = SecurityControlContext.SaveFormControls(Convert.ToInt32(ddlFormName.SelectedValue), Convert.ToInt32(ddlMenuName.SelectedValue), txtControlName.Text.Trim(), txtControlDesc.Text.Trim(), chkBackroundControl.Checked, chkHeaderControl.Checked);
                if (result.Equals("SUCCESS"))
                {
                    MessageBox.Show("New Control has been added Successfully!", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    M_GetControlList();
                    ClearFields();
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
        private void frmFormControls_Load(object sender, EventArgs e)
        {
            ClearFields();
            M_GetFormList();
            M_GetMenuList();
            M_GetControlList();
        }
        private void btnSave_Click(object sender, EventArgs e)
        {
            if (IsValid())
            {
                if (MessageBox.Show("Are you sure you want to save ?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                {
                    M_SaveFormControls();
                }
            }
        }
        private void btnRefresh_Click(object sender, EventArgs e)
        {
            M_GetFormList();
            M_GetMenuList();
            M_GetControlList();
        }
    }
}
