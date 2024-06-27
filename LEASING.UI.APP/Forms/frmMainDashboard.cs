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
        AnnouncementContext AnnouncementContext = new AnnouncementContext();
        frmPreEmp_Login _frmPreEmp_Login;
        private bool IsSwithUserLogOut = false;
        int AnnouncementTimer = 0;
        int NotificationTImer = 0;
        int seconds = 0;
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

        private void GetAnnouncement()
        {
            using (DataSet dt = AnnouncementContext.GetAnnouncement())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {

                    txtAnnouncementMessage.Text = Convert.ToString(dt.Tables[0].Rows[0]["AnnounceMessage"]);

                }
            }
        }
        private void M_GetAnnouncementCheck()
        {
            if (txtAnnouncementMessage.Text.Trim() != GetAnnouncementCheck())
            {
                AnnouncementTimer = Config.NotificationSeconds;
            }
        }

        private string GetAnnouncementCheck()
        {
            using (DataSet dt = AnnouncementContext.GetAnnouncementCheck())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    return Convert.ToString(dt.Tables[0].Rows[0]["AnnounceMessage"]).Trim();

                }
            }
            return "";
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
            using (DataSet dt = OtherContext.GetUnitListByProjectAndStatus(Convert.ToInt32(ddlProject.SelectedValue), ddlUnitStatus.SelectedText, ddlProject.SelectedText))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    dgvUnitList.DataSource = dt.Tables[0];
                }
            }
        }
        private void M_GetUnitListByProjectAndStatusCount()
        {
            lblNotAvailableCount.Text = "0";
            lblOccupiedCount.Text = "0";
            lblReservedCount.Text = "0";
            lblVacantCount.Text = "0";
            lblHoldCount.Text = "0";

            using (DataSet dt = OtherContext.GetProjectStatusCount(Convert.ToInt32(ddlProject.SelectedValue)))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    lblNotAvailableCount.Text = Convert.ToString(dt.Tables[0].Rows[0]["NOT_AVAILABLE_COUNT"]);
                    lblOccupiedCount.Text = Convert.ToString(dt.Tables[0].Rows[0]["OCCUPIED_COUNT"]);
                    lblReservedCount.Text = Convert.ToString(dt.Tables[0].Rows[0]["RESERVED_COUNT"]);
                    lblVacantCount.Text = Convert.ToString(dt.Tables[0].Rows[0]["VACANT_COUNT"]);
                    lblHoldCount.Text = Convert.ToString(dt.Tables[0].Rows[0]["HOLD_COUNT"]);
                }
            }
        }

        private void M_SelectProject()
        {

            ddlProject.DataSource = null;
            using (DataSet dt = ProjectContext.GetSelectProjectAll())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    ddlProject.DisplayMember = "ProjectName";
                    ddlProject.ValueMember = "RecId";
                    ddlProject.DataSource = dt.Tables[0];
                }
            }
        }
        private void InitProjectUnitBrowse()
        {
            this.ddlProject.SelectedIndex = 0;
            this.ddlUnitStatus.SelectedIndex = 0;
        }

        private void frmMainDashboard_Load(object sender, EventArgs e)
        {
            this.WindowState = FormWindowState.Maximized;
            this.radMenuItemNotification.Text = "NOTIFICATION (0)";
            GetNotificationList();
            M_SelectProject();
            this.InitProjectUnitBrowse();


            //radMenu7.Visible = false;
            //radPanel7.Visible = false;

            //Variables.FirstName = FirstName;
            //Variables.UserID = Convert.ToInt32(this.txtUserName.Text);
            //Variables.UserGroupCode = Convert.ToInt32(cboGroup.SelectedValue);
            //Variables.UserGroupName = this.cboGroup.Text;
            //Variables.UserPassword = UserPassword;

            lblGroupName.Text = Variables.UserGroupName;
            lblStaffName.Text = Variables.FirstName;
            GetAnnouncement();


            TimerCountDown.Start();
            //M_GetTotalCountLabel();
        }
        private void btnSettings_Click(object sender, EventArgs e)
        {

            frmSettings forms = new frmSettings();
            forms.ShowDialog();
        }
        private void radMenuItemAddNewLocation_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            frmAddNewLocation forms = new frmAddNewLocation();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemAddNewProject_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            frmAddNewProject forms = new frmAddNewProject();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemAddNewPurhcaseItem_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            frmAddNewPurchaseItem forms = new frmAddNewPurchaseItem();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItem5_Click(object sender, EventArgs e)
        {

        }
        private void radMenuItemAddNewClient_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            frmAddNewClient forms = new frmAddNewClient();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemResidentialSettings_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            frmResidentialRateSettings forms = new frmResidentialRateSettings();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemWareHouseSettings_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            frmWarehouseRateSettings forms = new frmWarehouseRateSettings();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemCommercialSettings_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            frmCommercialRateSettings forms = new frmCommercialRateSettings();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemAddNewUnit_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            frmAddNewUnits forms = new frmAddNewUnits();
            forms.ShowDialog();
            TimerCountDown.Start();
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
            TimerCountDown.Stop();
            frmUnitComputation forms = new frmUnitComputation();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItem9_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            frmClientInformation forms = new frmClientInformation();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItem13_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            frmGenerateTrasaction forms = new frmGenerateTrasaction();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemUnit_Click(object sender, EventArgs e)
        {
            //frmComputation forms = new frmComputation();
            //forms.ShowDialog();

        }
        private void radMenuItem14_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            frmClientTransaction forms = new frmClientTransaction();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemClientInformation_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            frmClientInformation forms = new frmClientInformation();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemTransactions_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            frmGenerateTrasaction forms = new frmGenerateTrasaction();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemLedger_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            frmClientTransaction forms = new frmClientTransaction();
            forms.ShowDialog();
            TimerCountDown.Start();
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
            TimerCountDown.Stop();
            frmParkingComputation forms = new frmParkingComputation();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemGenerateComputationParking_Click(object sender, EventArgs e)
        {
            //frmParkComputation forms = new frmParkComputation();
            //forms.ShowDialog();
        }
        private void btnLogout_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            if (MessageBox.Show("Are you sure you want to exit this application ?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == System.Windows.Forms.DialogResult.Yes)
            {
                IsSwithUserLogOut = true;
                Application.Exit();
            }
            TimerCountDown.Start();
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
            TimerCountDown.Stop();
            frmComputation forms = new frmComputation();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemGenerateComputationParking2_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            frmParkComputation forms = new frmParkComputation();
            forms.ShowDialog();
            TimerCountDown.Start();

        }
        private void radMenuItemResidentialSettings2_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            frmResidentialRateSettings forms = new frmResidentialRateSettings();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemCommercialSettings2_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            frmCommercialRateSettings forms = new frmCommercialRateSettings();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemWareHouseSettings2_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            frmWarehouseRateSettings forms = new frmWarehouseRateSettings();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemContractSignedUnit_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            frmContractSignedUnit forms = new frmContractSignedUnit();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemUnitContracts_Click(object sender, EventArgs e)
        {

        }
        private void radMenuItemTenantMoveUnit_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            frmTenantMoveUnit forms = new frmTenantMoveUnit();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemContractSignedParking_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            frmContractSignedParking forms = new frmContractSignedParking();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemParkingContracts_Click(object sender, EventArgs e)
        {

        }
        private void radMenuItemTenantMoveParking_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            frmTenantMoveParking forms = new frmTenantMoveParking();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemUser_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            frmUserSecurity forms = new frmUserSecurity();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemGroupSecurity_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            frmGroupSecurity forms = new frmGroupSecurity();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemReciept_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            frmClientRecieptTransaction forms = new frmClientRecieptTransaction();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemCloseContract_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            frmClosedContracts forms = new frmClosedContracts();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemTenantMoveOutUnit_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            frmTenantMoveOutUnit forms = new frmTenantMoveOutUnit();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemTenantMoveOutParking_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            frmTenantMoveOutParking forms = new frmTenantMoveOutParking();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemBankName_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            frmAddBankName forms = new frmAddBankName();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemFormControls_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            frmFormControls forms = new frmFormControls();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void btnSwitchUser_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            IsSwithUserLogOut = true;
            _frmPreEmp_Login = new frmPreEmp_Login(frmPreEmp_Login.LoginMethod.Switch, this);
            _frmPreEmp_Login.StartPosition = FormStartPosition.CenterScreen;
            _frmPreEmp_Login.ShowDialog();
            IsSwithUserLogOut = false;

        }
        private void btnMyDashboard_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            frmUserDashBoard frmUserDashBoard = new frmUserDashBoard();
            frmUserDashBoard.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemGroup_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            frmUserGroup frmUserGroup = new frmUserGroup();
            frmUserGroup.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemInformation_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            frmAddNewPurchaseItem forms = new frmAddNewPurchaseItem();
            forms.ShowDialog();
            TimerCountDown.Start();
        }

        private void radMenuItemNotification_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            GetNotificationListDetails();
            TimerCountDown.Start();
        }

        private void radMenuItemQuickInquiry_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            frmContractInquiry forms = new frmContractInquiry();
            forms.ShowDialog();
            TimerCountDown.Start();
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
            if (ddlProject.SelectedIndex > 0)
            {
                if (ddlProject.SelectedText == "--ALL--")
                {
                    ddlUnitStatus.SelectedText = "--ALL--";
                }
                M_GetUnitListByProjectAndStatus();
                M_GetUnitListByProjectAndStatusCount();
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
            TimerCountDown.Stop();
            frmAddNewCompany forms = new frmAddNewCompany();
            forms.ShowDialog();
            TimerCountDown.Start();
        }

        private void radMenuItemAnnouncement_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            frmAnnouncement forms = new frmAnnouncement();
            forms.ShowDialog();
            GetAnnouncement();
            TimerCountDown.Start();
        }
        private void BilnkAnnouncement()
        {
            Random rand = new Random();
            int one = rand.Next(0, 255);
            int two = rand.Next(0, 255);
            int three = rand.Next(0, 255);
            int four = rand.Next(0, 255);

            txtAnnouncementMessage.ForeColor = Color.FromArgb(one, two, three, four);
        }
        private void TimerCountDown_Tick(object sender, EventArgs e)
        {
            M_GetAnnouncementCheck();
            GetAnnouncement();
            GetNotificationListDetails();
            //M_GetUnitListByProjectAndStatus();
            M_GetUnitListByProjectAndStatusCount();
            if (AnnouncementTimer > 0)
            {
                Functions.GetNotification("New Announcement", txtAnnouncementMessage.Text);
                AnnouncementTimer--;

            }
            //if (seconds > 0)
            //{
            //    TimerCountDown.Start();
            //}
        }

        private void btnRefresh_Click(object sender, EventArgs e)
        {
            M_GetUnitListByProjectAndStatus();
        }
    }
}
