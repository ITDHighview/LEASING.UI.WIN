using LEASING.UI.APP.Context;
using LEASING.UI.APP.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace LEASING.UI.APP.Forms
{
    public partial class frmEditPurchaseItem : Form
    {
        ProjectContext ProjectContext = new ProjectContext();
        LocationContext LocationContext = new LocationContext();
        PurchaseItemContext PurchaseItemContext = new PurchaseItemContext();

        public int UnitID { get; set; }
        public int Recid { get; set; }
        public bool IsProceed = false;


        private string _strPurchaseFormMode;
        public string strPurchaseFormMode
        {
            get
            {
                return _strPurchaseFormMode;
            }
            set
            {
                _strPurchaseFormMode = value;
                switch (_strPurchaseFormMode)
                {
                    case "EDIT":
                        btnUndo.Enabled = true;
                        btnSaveProject.Enabled = true;
                        btnEdit.Enabled = false;

                        ddlProjectList.Enabled = true;
                        txtDescription.Enabled = true;
                        txtUnitAmount.Enabled = true;
                        txtAmount.Enabled = true;
                        txtRemarks.Enabled = true;
                        dtpDatePurchase.Enabled = true;
                        txtRemarks.Enabled = true;
                        txtTotal.Enabled = true;
                        txtUnitNumber.Enabled = true;
                        btnSelectUnit.Enabled = true;

                        //txtDescription.Text = string.Empty;
                        //txtUnitAmount.Text = string.Empty;
                        //txtAmount.Text = string.Empty;
                        //txtRemarks.Text = string.Empty;

                        break;
                    case "READ":
                        btnUndo.Enabled = false;
                        btnSaveProject.Enabled = false;
                        btnEdit.Enabled = true;

                        ddlProjectList.Enabled = false;
                        txtDescription.Enabled = false;
                        txtUnitAmount.Enabled = false;
                        txtAmount.Enabled = false;
                        txtRemarks.Enabled = false;
                        dtpDatePurchase.Enabled = false;
                        txtRemarks.Enabled = false;
                        txtTotal.Enabled = false;
                        txtUnitNumber.Enabled = false;
                        btnSelectUnit.Enabled = false;

                        //txtDescription.Text = string.Empty;
                        //txtUnitAmount.Text = string.Empty;
                        //txtAmount.Text = string.Empty;
                        //txtRemarks.Text = string.Empty;
                        //ddlProjectList.SelectedIndex = -1;
                        break;

                    default:
                        break;
                }
            }
        }

        public frmEditPurchaseItem()
        {
            InitializeComponent();
        }
        private bool IsPurchaseItemValid()
        {
            if (string.IsNullOrEmpty(txtDescription.Text))
            {
                MessageBox.Show("Item Name cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            if (string.IsNullOrEmpty(dtpDatePurchase.Text))
            {
                MessageBox.Show("Date Purchase cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            if (ddlProjectList.SelectedIndex == -1)
            {
                MessageBox.Show("Please select project", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            if (ddlProjectList.SelectedText == "--SELECT--")
            {
                MessageBox.Show("Please select project", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            if (string.IsNullOrEmpty(txtUnitAmount.Text))
            {
                MessageBox.Show("Unit Amount cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            if (string.IsNullOrEmpty(txtAmount.Text))
            {
                MessageBox.Show("Amount cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            return true;
        }
        private void M_getPurchaseItemInfoById()
        {

            txtDescription.Text = string.Empty;
            dtpDatePurchase.Text = string.Empty;
            txtUnitAmount.Text = string.Empty;
            txtUnitAmount.Text = "0";
            txtAmount.Text = string.Empty;
            txtAmount.Text = "0";
            txtRemarks.Text = string.Empty;
            txtTotal.Text = string.Empty;

            using (DataSet dt = PurchaseItemContext.GetGetPurchaseItemInfoById(Recid))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    lblItemId.Text = Convert.ToString(dt.Tables[0].Rows[0]["PurchItemID"]);
                    ddlProjectList.Text = Convert.ToString(dt.Tables[0].Rows[0]["ProjectName"]);
                    ddlProjectList.SelectedValue = Convert.ToInt32(dt.Tables[0].Rows[0]["ProjectId"]);
                    txtDescription.Text = Convert.ToString(dt.Tables[0].Rows[0]["Descriptions"]);
                    dtpDatePurchase.Value = Convert.ToDateTime(dt.Tables[0].Rows[0]["DatePurchase"]);
                    txtUnitAmount.Text = Convert.ToString(dt.Tables[0].Rows[0]["UnitAmount"]);
                    txtAmount.Text = Convert.ToString(dt.Tables[0].Rows[0]["Amount"]);
                    txtTotal.Text = Convert.ToString(dt.Tables[0].Rows[0]["TotalAmount"]);
                    txtRemarks.Text = Convert.ToString(dt.Tables[0].Rows[0]["Remarks"]);
                    txtUnitNumber.Text = Convert.ToString(dt.Tables[0].Rows[0]["UnitNumber"]);
                    UnitID = Convert.ToInt32(dt.Tables[0].Rows[0]["UnitID"]);

                }
            }
        }
        private void M_SelectProject()
        {

            ddlProjectList.DataSource = null;
            using (DataSet dt = ProjectContext.GetSelectProject())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    ddlProjectList.DisplayMember = "ProjectName";
                    ddlProjectList.ValueMember = "RecId";
                    ddlProjectList.DataSource = dt.Tables[0];
                }
            }
        }

        private void M_SavePurchaseItem()
        {

            PurchaseItemModel dto = new PurchaseItemModel();
            dto.RecId = Recid;
            dto.ProjectId = Convert.ToInt32(ddlProjectList.SelectedValue);
            dto.Descriptions = txtDescription.Text;
            dto.DatePurchase = dtpDatePurchase.Text;
            dto.UnitAmount = Convert.ToInt32(decimal.Parse(txtUnitAmount.Text));
            dto.Amount = txtAmount.Text == string.Empty ? 0 : decimal.Parse(txtAmount.Text);
            dto.TotalAmount = txtTotal.Text == string.Empty ? 0 : decimal.Parse(txtTotal.Text);
            dto.Remarks = txtRemarks.Text;
            dto.UnitNumber = txtUnitNumber.Text;
            dto.UnitID = UnitID;
            dto.Message_Code = PurchaseItemContext.EditPurchaseItem(dto);
            if (dto.Message_Code.Equals("SUCCESS"))
            {
                IsProceed = true;
                MessageBox.Show("Project info has been Upated successfully !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                strPurchaseFormMode = "READ";
                this.Close();
            }
            else
            {
                MessageBox.Show(dto.Message_Code, "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }

        }
        private void M_GetTotal()
        {

            var rental = (txtUnitAmount.Text == "") ? 0 : (Convert.ToDecimal(txtUnitAmount.Text) * ((txtAmount.Text == "") ? 0 : Convert.ToDecimal(txtAmount.Text)));
            txtTotal.Text = Convert.ToString(rental);
        }

        private void frmEditPurchaseItem_Load(object sender, EventArgs e)
        {
            strPurchaseFormMode = "READ";
            M_SelectProject();
            M_getPurchaseItemInfoById();
        }

        private void btnSaveProject_Click(object sender, EventArgs e)
        {
            if (strPurchaseFormMode == "EDIT")
            {
                if (Recid > 0)
                {
                    if (IsPurchaseItemValid())
                    {
                        if (MessageBox.Show("Are you sure you want to update the following Item?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                        {
                            M_SavePurchaseItem();
                        }
                    }
                }
            }
            else
            {
                MessageBox.Show("Please Click Edit", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }

        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            strPurchaseFormMode = "EDIT";
        }

        private void btnUndo_Click(object sender, EventArgs e)
        {
            strPurchaseFormMode = "READ";
        }

        private void txtAmount_TextChanged(object sender, EventArgs e)
        {
            M_GetTotal();
        }

        private void txtUnitAmount_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void txtAmount_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void txtTotal_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void btnSelectUnit_Click(object sender, EventArgs e)
        {
            frmSelectUnit forms = new frmSelectUnit();
            forms.RecId = Convert.ToInt32(ddlProjectList.SelectedValue);
            forms.ShowDialog();
            if (forms.IsProceed)
            {
                UnitID = forms.UnitID;
                txtUnitNumber.Text = forms.UnitNumber;
            }
        }

        private void txtUnitAmount_TextChanged(object sender, EventArgs e)
        {
            M_GetTotal();
        }
    }
}
