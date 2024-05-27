using LEASING.UI.APP.Common;
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
    public partial class frmAddNewPurchaseItem : Form
    {
       private ProjectContext _project;
       private LocationContext _location;
       private PurchaseItemContext _purchase;
        public frmAddNewPurchaseItem()
        {
            _project = new ProjectContext();
            _location = new LocationContext();
            _purchase = new PurchaseItemContext();
            InitializeComponent();
        }
        public int UnitID { get; set; }
        enum ModeStatus
        {
            READ,
            NEW
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
                        btnUndoProject.Enabled = true;
                        btnSaveProject.Enabled = true;
                        ddlProjectList.Enabled = true;
                        txtDescription.Enabled = true;
                        txtUnitAmount.Enabled = true;
                        txtAmount.Enabled = true;
                        txtRemarks.Enabled = true;
                        dtpDatePurchase.Enabled = true;
                        txtTotal.Enabled = true;
                        txtUnitNumber.Enabled = true;
                        btnSelectUnits.Enabled = true;
                        txtDescription.Text = string.Empty;
                        txtUnitAmount.Text = string.Empty;
                        txtAmount.Text = string.Empty;
                        txtRemarks.Text = string.Empty;
                        txtTotal.Text = string.Empty;
                        txtUnitNumber.Text = string.Empty;
                        break;
                    case "READ":
                        btnUndoProject.Enabled = false;
                        btnSaveProject.Enabled = false;
                        ddlProjectList.Enabled = false;
                        txtDescription.Enabled = false;
                        txtUnitAmount.Enabled = false;
                        txtAmount.Enabled = false;
                        txtRemarks.Enabled = false;
                        dtpDatePurchase.Enabled = false;
                        txtTotal.Enabled = false;
                        txtUnitNumber.Enabled = false;
                        btnSelectUnits.Enabled = false;
                        txtDescription.Text = string.Empty;
                        txtUnitAmount.Text = string.Empty;
                        txtAmount.Text = string.Empty;
                        txtRemarks.Text = string.Empty;
                        txtTotal.Text = string.Empty;
                        txtUnitNumber.Text = string.Empty;
                        ddlProjectList.SelectedIndex = -1;
                        break;

                    default:
                        break;
                }
            }
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
        private void M_SavePurchaseItem()
        {
            try
            {
                PurchaseItemModel dto = new PurchaseItemModel();
                dto.ProjectId = Convert.ToInt32(ddlProjectList.SelectedValue);
                dto.Descriptions = txtDescription.Text;
                dto.DatePurchase = dtpDatePurchase.Text;
                dto.UnitAmount = Convert.ToInt32(txtUnitAmount.Text);
                dto.Amount = txtAmount.Text == string.Empty ? 0 : decimal.Parse(txtAmount.Text);
                dto.TotalAmount = txtTotal.Text == string.Empty ? 0 : decimal.Parse(txtTotal.Text);
                dto.Remarks = txtRemarks.Text;
                dto.UnitNumber = txtUnitNumber.Text;
                dto.UnitID = UnitID;
                dto.Message_Code = _purchase.SavePurchaseItem(dto);
                if (dto.Message_Code.Equals("SUCCESS"))
                {
                    Functions.MessageShow("New Purchase Item has been added successfully !");
                    this.FormMode = ModeStatus.READ.ToString();
                    M_GetPurchaseItemList();

                }
                else
                {
                    Functions.MessageShow(dto.Message_Code);
                    this.FormMode = ModeStatus.READ.ToString();
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_SavePurchaseItem()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_SavePurchaseItem()", ex.ToString());
            }
        }
        private void M_SelectProject()
        {
            try
            {
                ddlProjectList.DataSource = null;
                using (DataSet dt = _project.GetSelectProject())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        ddlProjectList.DisplayMember = "ProjectName";
                        ddlProjectList.ValueMember = "RecId";
                        ddlProjectList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_SelectProject()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_SelectProject()", ex.ToString());
            }
        }
        private void M_GetPurchaseItemList()
        {
            try
            {
                dgvPurchaseItemList.DataSource = null;
                using (DataSet dt = _purchase.GetGetPurchaseItemList())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        dgvPurchaseItemList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_GetPurchaseItemList()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_GetPurchaseItemList()", ex.ToString());
            }
        }
        private void M_GetTotal()
        {

            var rental = (txtUnitAmount.Text == "") ? 0 : (Convert.ToDecimal(txtUnitAmount.Text) * ((txtAmount.Text == "") ? 0 : Convert.ToDecimal(txtAmount.Text)));
            txtTotal.Text = Convert.ToString(rental);
        }
        private void M_getPurchaseItemInfoById()
        {
            lblEncodedBy.Text = "Encoded By :";
            lblLastChangedBy.Text = "Last Changed By :";
            try
            {
                using (DataSet dt = _purchase.GetGetPurchaseItemInfoById(Convert.ToInt32(dgvPurchaseItemList.CurrentRow.Cells["RecId"].Value)))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        lblEncodedBy.Text = "Encoded By :" + Convert.ToString(dt.Tables[0].Rows[0]["EncodedBy"]) + "-" + Convert.ToString(dt.Tables[0].Rows[0]["EncodedName"]);
                        lblLastChangedBy.Text = "Last Changed By :" + Convert.ToString(dt.Tables[0].Rows[0]["LastChangedBy"]) + "-" + Convert.ToString(dt.Tables[0].Rows[0]["LastChangedName"]);
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_getPurchaseItemInfoById()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_getPurchaseItemInfoById()", ex.ToString());
            }
        }
        private void frmAddNewPurchaseItem_Load(object sender, EventArgs e)
        {
            Functions.EventCapturefrmName(this);
            this.FormMode = ModeStatus.READ.ToString();
            lblEncodedBy.Text = "Encoded By :";
            lblLastChangedBy.Text = "Last Changed By :";
            M_SelectProject();
            M_GetPurchaseItemList();
        }
        private void btnNewProject_Click(object sender, EventArgs e)
        {
            this.FormMode = ModeStatus.NEW.ToString();
        }
        private void btnUndoProject_Click(object sender, EventArgs e)
        {
            this.FormMode = ModeStatus.READ.ToString();
        }
        private void btnSaveProject_Click(object sender, EventArgs e)
        {
            if (IsPurchaseItemValid())
            {
                if (MessageBox.Show("Are you sure you want to save this Item ?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                {
                    M_SavePurchaseItem();
                }
            }
        }
        private void dgvPurchaseItemList_CellClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                if (this.dgvPurchaseItemList.Columns[e.ColumnIndex].Name == "coledit")
                {
                    frmEditPurchaseItem forms = new frmEditPurchaseItem();
                    forms.Recid = Convert.ToInt32(dgvPurchaseItemList.CurrentRow.Cells["RecId"].Value);
                    forms.ShowDialog();
                    if (forms.IsProceed)
                    {
                        M_GetPurchaseItemList();
                    }
                }
                else if (this.dgvPurchaseItemList.Columns[e.ColumnIndex].Name == "coldelete")
                {

                    if (MessageBox.Show("Are you sure you want to Dectivate the Item?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                    {

                        var result = _purchase.DeactivatePurchaseItem(Convert.ToInt32(dgvPurchaseItemList.CurrentRow.Cells["RecId"].Value));
                        if (result.Equals("SUCCESS"))
                        {
                            MessageBox.Show("Item has been Dectivate successfully !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                            M_GetPurchaseItemList();
                        }
                    }
                }
            }
        }
        private void btnCheckDeactivatedList_Click(object sender, EventArgs e)
        {
            frmInActivePurchaseItemList froms = new frmInActivePurchaseItemList();
            froms.ShowDialog();
            M_GetPurchaseItemList();
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
        private void txtAmount_TextChanged(object sender, EventArgs e)
        {
            M_GetTotal();
        }
        private void dgvPurchaseItemList_SelectionChanged(object sender, EventArgs e)
        {
            if (dgvPurchaseItemList.Rows.Count > 0)
            {
                M_getPurchaseItemInfoById();
            }
        }
        private void btnSelectUnits_Click(object sender, EventArgs e)
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
        private void btnLogs_Click(object sender, EventArgs e)
        {
            frmPurchaseItemLogs forms = new frmPurchaseItemLogs();
            forms.ShowDialog();
        }
        private void txtUnitAmount_TextChanged(object sender, EventArgs e)
        {
            M_GetTotal();
        }
    }
}
