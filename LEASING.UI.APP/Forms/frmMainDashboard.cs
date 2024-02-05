using LEASING.UI.APP.Common;
using LEASING.UI.APP.Context;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using Telerik.WinControls;

namespace LEASING.UI.APP.Forms
{
    public partial class frmMainDashboard : Form
    {
        OtherContext OtherContext = new OtherContext();
        ProjectContext ProjectContext = new ProjectContext();
        frmPreEmp_Login _frmPreEmp_Login;
        private bool IsSwithUserLogOut = false;
        public frmMainDashboard()
        {
            InitializeComponent();
            if (Variables.UserGroupCode == 26319)
            {

            }
            else
            {
                if (Convert.ToBoolean(ConfigurationManager.AppSettings["IsPermission"].ToString()))
                {
                    Functions.SecurityControls(this);
                }
            }

        }
        //private void M_GetTotalCountLabel()
        //{

        //    using (DataSet dt = OtherContext.GetTotalCountLabel())
        //    {
        //        if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
        //        {
        //            lblTotalLocation.Text = Convert.ToString(dt.Tables[0].Rows[0]["TotalLocation"]);
        //            lblTotalProject.Text = Convert.ToString(dt.Tables[0].Rows[0]["TotalProject"]);
        //            lblTotalClient.Text = Convert.ToString(dt.Tables[0].Rows[0]["TotalClient"]);
        //            lblTotalActiveContract.Text = Convert.ToString(dt.Tables[0].Rows[0]["TotalActiveContract"]);
        //        }
        //    }
        //}
        private void GetNotificationList()
        {
            using (DataSet dt = OtherContext.GetNotificationList())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    this.radMenuItemNotification.Text = "NOTIFICATION (0)";
                    this.radMenuItemNotification.Text = "NOTIFICATION (" + Convert.ToString(dt.Tables[0].Rows.Count) + ")";
                }
            }
        }
        private void GetNotificationListDetails()
        {
            dgvNotificationList.DataSource = null;
            using (DataSet dt = OtherContext.GetNotificationList())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    dgvNotificationList.DataSource = dt.Tables[0];
                }
            }
        }
        private void M_GetUnitListByProjectAndStatus()
        {
            dgvUnitList.DataSource = null;
            using (DataSet dt = OtherContext.GetUnitListByProjectAndStatus(Convert.ToInt32(ddlProject.SelectedValue),ddlUnitStatus.SelectedText))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    dgvUnitList.DataSource = dt.Tables[0];
                }
            }
        }

        private void M_SelectProject()
        {

            ddlProject.DataSource = null;
            using (DataSet dt = ProjectContext.GetSelectProject())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    ddlProject.DisplayMember = "ProjectName";
                    ddlProject.ValueMember = "RecId";
                    ddlProject.DataSource = dt.Tables[0];
                }
            }
        }

        private void frmMainDashboard_Load(object sender, EventArgs e)
        {
            this.WindowState = FormWindowState.Maximized;
            this.radMenuItemNotification.Text = "NOTIFICATION (0)";
            GetNotificationList();
            M_SelectProject();
           

            //radMenu7.Visible = false;
            //radPanel7.Visible = false;

            //Variables.FirstName = FirstName;
            //Variables.UserID = Convert.ToInt32(this.txtUserName.Text);
            //Variables.UserGroupCode = Convert.ToInt32(cboGroup.SelectedValue);
            //Variables.UserGroupName = this.cboGroup.Text;
            //Variables.UserPassword = UserPassword;

            lblGroupName.Text = Variables.UserGroupName;
            lblStaffName.Text = Variables.FirstName;
            //M_GetTotalCountLabel();
        }
        private void btnSettings_Click(object sender, EventArgs e)
        {
            frmSettings forms = new frmSettings();
            forms.ShowDialog();
        }
        private void radMenuItemAddNewLocation_Click(object sender, EventArgs e)
        {
            frmAddNewLocation forms = new frmAddNewLocation();
            forms.ShowDialog();
        }
        private void radMenuItemAddNewProject_Click(object sender, EventArgs e)
        {
            frmAddNewProject forms = new frmAddNewProject();
            forms.ShowDialog();
        }
        private void radMenuItemAddNewPurhcaseItem_Click(object sender, EventArgs e)
        {
            frmAddNewPurchaseItem forms = new frmAddNewPurchaseItem();
            forms.ShowDialog();
        }
        private void radMenuItem5_Click(object sender, EventArgs e)
        {

        }
        private void radMenuItemAddNewClient_Click(object sender, EventArgs e)
        {
            frmAddNewClient forms = new frmAddNewClient();
            forms.ShowDialog();
        }
        private void radMenuItemResidentialSettings_Click(object sender, EventArgs e)
        {
            frmResidentialRateSettings forms = new frmResidentialRateSettings();
            forms.ShowDialog();
        }
        private void radMenuItemWareHouseSettings_Click(object sender, EventArgs e)
        {
            frmWarehouseRateSettings forms = new frmWarehouseRateSettings();
            forms.ShowDialog();
        }
        private void radMenuItemCommercialSettings_Click(object sender, EventArgs e)
        {
            frmCommercialRateSettings forms = new frmCommercialRateSettings();
            forms.ShowDialog();
        }
        private void radMenuItemAddNewUnit_Click(object sender, EventArgs e)
        {
            frmAddNewUnits forms = new frmAddNewUnits();
            forms.ShowDialog();
        }
        private void radMenuItem1_Click(object sender, EventArgs e)
        {

        }
        private void radMenuItem3_Click(object sender, EventArgs e)
        {

        }
        private void radMenuItem6_Click(object sender, EventArgs e)
        {

        }
        private void radMenuUnitComputation_Click(object sender, EventArgs e)
        {
            frmUnitComputation forms = new frmUnitComputation();
            forms.ShowDialog();
        }
        private void radMenuItem9_Click(object sender, EventArgs e)
        {
            frmClientInformation forms = new frmClientInformation();
            forms.ShowDialog();
        }
        private void radMenuItem13_Click(object sender, EventArgs e)
        {
            frmGenerateTrasaction forms = new frmGenerateTrasaction();
            forms.ShowDialog();
        }
        private void radMenuItemUnit_Click(object sender, EventArgs e)
        {
            //frmComputation forms = new frmComputation();
            //forms.ShowDialog();

        }
        private void radMenuItem14_Click(object sender, EventArgs e)
        {
            frmClientTransaction forms = new frmClientTransaction();
            forms.ShowDialog();
        }
        private void radMenuItemClientInformation_Click(object sender, EventArgs e)
        {
            frmClientInformation forms = new frmClientInformation();
            forms.ShowDialog();
        }
        private void radMenuItemTransactions_Click(object sender, EventArgs e)
        {
            frmGenerateTrasaction forms = new frmGenerateTrasaction();
            forms.ShowDialog();
        }
        private void radMenuItemLedger_Click(object sender, EventArgs e)
        {
            frmClientTransaction forms = new frmClientTransaction();
            forms.ShowDialog();
        }
        private void radMenuItemComputation_Click(object sender, EventArgs e)
        {

        }
        //private void radMenuItemGenerateComputationUnit_Click(object sender, EventArgs e)
        //{

        //    frmComputation forms = new frmComputation();
        //    forms.ShowDialog();
        //}
        private void radMenuParkingComputation_Click(object sender, EventArgs e)
        {
            frmParkingComputation forms = new frmParkingComputation();
            forms.ShowDialog();
        }
        private void radMenuItemGenerateComputationParking_Click(object sender, EventArgs e)
        {
            //frmParkComputation forms = new frmParkComputation();
            //forms.ShowDialog();
        }
        private void btnLogout_Click(object sender, EventArgs e)
        {
            if (MessageBox.Show("Are you sure you want to exit this application ?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == System.Windows.Forms.DialogResult.Yes)
            {
                IsSwithUserLogOut = true;
                Application.Exit();
            }
        }
        private void linkSwitchUser_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            IsSwithUserLogOut = true;
            _frmPreEmp_Login = new frmPreEmp_Login(frmPreEmp_Login.LoginMethod.Switch, this);
            _frmPreEmp_Login.StartPosition = FormStartPosition.CenterScreen;
            _frmPreEmp_Login.ShowDialog();
            IsSwithUserLogOut = false;
        }
        private void frmMainDashboard_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (!IsSwithUserLogOut)
                e.Cancel = true;
        }
        private void radMenuItemAdministrative_Click(object sender, EventArgs e)
        {

        }
        private void radMenuItemGenerateComputationUnit2_Click(object sender, EventArgs e)
        {
            frmComputation forms = new frmComputation();
            forms.ShowDialog();
        }
        private void radMenuItemGenerateComputationParking2_Click(object sender, EventArgs e)
        {
            frmParkComputation forms = new frmParkComputation();
            forms.ShowDialog();

        }
        private void radMenuItemResidentialSettings2_Click(object sender, EventArgs e)
        {
            frmResidentialRateSettings forms = new frmResidentialRateSettings();
            forms.ShowDialog();
        }
        private void radMenuItemCommercialSettings2_Click(object sender, EventArgs e)
        {
            frmCommercialRateSettings forms = new frmCommercialRateSettings();
            forms.ShowDialog();
        }
        private void radMenuItemWareHouseSettings2_Click(object sender, EventArgs e)
        {
            frmWarehouseRateSettings forms = new frmWarehouseRateSettings();
            forms.ShowDialog();
        }
        private void radMenuItemContractSignedUnit_Click(object sender, EventArgs e)
        {
            frmContractSignedUnit forms = new frmContractSignedUnit();
            forms.ShowDialog();
        }
        private void radMenuItemUnitContracts_Click(object sender, EventArgs e)
        {

        }
        private void radMenuItemTenantMoveUnit_Click(object sender, EventArgs e)
        {
            frmTenantMoveUnit forms = new frmTenantMoveUnit();
            forms.ShowDialog();
        }
        private void radMenuItemContractSignedParking_Click(object sender, EventArgs e)
        {
            frmContractSignedParking forms = new frmContractSignedParking();
            forms.ShowDialog();
        }
        private void radMenuItemParkingContracts_Click(object sender, EventArgs e)
        {

        }
        private void radMenuItemTenantMoveParking_Click(object sender, EventArgs e)
        {
            frmTenantMoveParking forms = new frmTenantMoveParking();
            forms.ShowDialog();

        }
        private void radMenuItemUser_Click(object sender, EventArgs e)
        {
            frmUserSecurity forms = new frmUserSecurity();
            forms.ShowDialog();
        }
        private void radMenuItemGroupSecurity_Click(object sender, EventArgs e)
        {
            frmGroupSecurity forms = new frmGroupSecurity();
            forms.ShowDialog();
        }
        private void radMenuItemReciept_Click(object sender, EventArgs e)
        {
            frmClientRecieptTransaction forms = new frmClientRecieptTransaction();
            forms.ShowDialog();
        }
        private void radMenuItemCloseContract_Click(object sender, EventArgs e)
        {
            frmClosedContracts forms = new frmClosedContracts();
            forms.ShowDialog();
        }
        private void radMenuItemTenantMoveOutUnit_Click(object sender, EventArgs e)
        {
            frmTenantMoveOutUnit forms = new frmTenantMoveOutUnit();
            forms.ShowDialog();
        }
        private void radMenuItemTenantMoveOutParking_Click(object sender, EventArgs e)
        {
            frmTenantMoveOutParking forms = new frmTenantMoveOutParking();
            forms.ShowDialog();
        }
        private void radMenuItemBankName_Click(object sender, EventArgs e)
        {
            frmAddBankName forms = new frmAddBankName();
            forms.ShowDialog();
        }
        private void radMenuItemFormControls_Click(object sender, EventArgs e)
        {
            frmFormControls forms = new frmFormControls();
            forms.ShowDialog();

        }
        private void btnSwitchUser_Click(object sender, EventArgs e)
        {
            IsSwithUserLogOut = true;
            _frmPreEmp_Login = new frmPreEmp_Login(frmPreEmp_Login.LoginMethod.Switch, this);
            _frmPreEmp_Login.StartPosition = FormStartPosition.CenterScreen;
            _frmPreEmp_Login.ShowDialog();
            IsSwithUserLogOut = false;
        }
        private void btnMyDashboard_Click(object sender, EventArgs e)
        {
            frmUserDashBoard frmUserDashBoard = new frmUserDashBoard();
            frmUserDashBoard.ShowDialog();
        }
        private void radMenuItemGroup_Click(object sender, EventArgs e)
        {
            frmUserGroup frmUserGroup = new frmUserGroup();
            frmUserGroup.ShowDialog();
        }
        private void radMenuItemInformation_Click(object sender, EventArgs e)
        {
            frmAddNewPurchaseItem forms = new frmAddNewPurchaseItem();
            forms.ShowDialog();
        }

        private void radMenuItemNotification_Click(object sender, EventArgs e)
        {
            GetNotificationListDetails();
        }

        private void radMenuItemQuickInquiry_Click(object sender, EventArgs e)
        {
            frmContractInquiry forms = new frmContractInquiry();
            forms.ShowDialog();
        }

        private void dgvNotificationList_CellFormatting(object sender, Telerik.WinControls.UI.CellFormattingEventArgs e)
        {
            if (!string.IsNullOrEmpty(Convert.ToString(this.dgvNotificationList.Rows[e.RowIndex].Cells["Status"].Value)))
            {
                if (Convert.ToString(this.dgvNotificationList.Rows[e.RowIndex].Cells["Status"].Value) == "DUE")
                {
                    e.CellElement.ForeColor = Color.White;
                    //e.CellElement.Font = new Font("Tahoma", 7f, FontStyle.Bold);
                    e.CellElement.DrawFill = true;
                    e.CellElement.GradientStyle = GradientStyles.Solid;
                    e.CellElement.BackColor = Color.Red;
                }
                else if (Convert.ToString(this.dgvNotificationList.Rows[e.RowIndex].Cells["Status"].Value) == "COMMING")
                {
                    e.CellElement.ForeColor = Color.Black;
                    //e.CellElement.Font = new Font("Tahoma", 7f, FontStyle.Bold);
                    e.CellElement.DrawFill = true;
                    e.CellElement.GradientStyle = GradientStyles.Solid;
                    e.CellElement.BackColor = Color.Orange;
                }
                else if (Convert.ToString(this.dgvNotificationList.Rows[e.RowIndex].Cells["Status"].Value) == "HOLD")
                {
                    e.CellElement.ForeColor = Color.White;
                    //e.CellElement.Font = new Font("Tahoma", 7f, FontStyle.Bold);
                    e.CellElement.DrawFill = true;
                    e.CellElement.GradientStyle = GradientStyles.Solid;
                    e.CellElement.BackColor = Color.Tomato;
                }
                else if (Convert.ToString(this.dgvNotificationList.Rows[e.RowIndex].Cells["Status"].Value) == "PARTIAL")
                {
                    e.CellElement.ForeColor = Color.White;
                    //e.CellElement.Font = new Font("Tahoma", 7f, FontStyle.Bold);
                    e.CellElement.DrawFill = true;
                    e.CellElement.GradientStyle = GradientStyles.Solid;
                    e.CellElement.BackColor = Color.Orange;
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
                else if (Convert.ToString(this.dgvUnitList.Rows[e.RowIndex].Cells["UnitStat"].Value) == "MOVE-IN")
                {
                    e.CellElement.DrawFill = true;
                    e.CellElement.GradientStyle = GradientStyles.Solid;
                    e.CellElement.ForeColor = Color.White;
                    e.CellElement.BackColor = Color.Green;

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

        private void ddlProject_SelectedIndexChanged(object sender, Telerik.WinControls.UI.Data.PositionChangedEventArgs e)
        {
            if (ddlProject.SelectedIndex >= 0)
            {
                M_GetUnitListByProjectAndStatus();
            }
        }

        private void ddlUnitStatus_SelectedIndexChanged(object sender, Telerik.WinControls.UI.Data.PositionChangedEventArgs e)
        {
            if (ddlProject.SelectedIndex >= 0)
            {
                M_GetUnitListByProjectAndStatus();
            }
        }

        private void radMenuItemAddCompany_Click(object sender, EventArgs e)
        {
            frmAddNewCompany forms = new frmAddNewCompany();
            forms.ShowDialog();
        }
    }
}
