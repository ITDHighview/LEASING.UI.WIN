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
using Telerik.WinControls.UI;

namespace LEASING.UI.APP.Forms
{
    public partial class MainDashboard : Form
    {
        OtherContext OtherContext = new OtherContext();
        ProjectContext ProjectContext = new ProjectContext();
        AnnouncementContext AnnouncementContext = new AnnouncementContext();
        frmPreEmp_Login _frmPreEmp_Login;
        private bool IsSwithUserLogOut = false;

        int NotificationTImer = 0;
        int seconds = 0;
        public MainDashboard()
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
        private DataTable ValidateDataTable(DataSet dt)
        {
            DataTable dTable = new DataTable();
            if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
            {
                dTable = dt.Tables[0];
            }
            return dTable;
        }
        private void SetGridDataItem(RadGridView dgv, DataSet Context)
        {
            dgv.DataSource = null;
            using (DataSet dt = Context)
            {
                dgv.DataSource = this.ValidateDataTable(dt);
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
        //private void GetNotificationList()
        //{
        //    using (DataSet dt = OtherContext.GetNotificationList())
        //    {
        //        if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
        //        {
        //            this.radMenuItemNotification.Text = "NOTIFICATION (0)";
        //            this.radMenuItemNotification.Text = "NOTIFICATION (" + Convert.ToString(dt.Tables[0].Rows.Count) + ")";
        //        }
        //    }
        //}

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
        int AnnouncementTimer = 0;
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


        private void GetNotificationListDetails() => this.SetGridDataItem(this.dgvNotificationList, OtherContext.GetNotificationList());
        private void M_GetUnitListByProjectAndStatus() => this.SetGridDataItem(this.dgvUnitList, OtherContext.GetUnitListByProjectAndStatus(Convert.ToInt32(ddlProject.SelectedValue),
                                                                                                                                            ddlUnitStatus.SelectedText,
                                                                                                                                            ddlProject.SelectedText));
        private void M_GetUnitListByProjectAndStatusCount()
        {
            lblNotAvailableCount.Text = "0";
            lblOccupiedCount.Text = "0";
            lblReservedCount.Text = "0";
            lblVacantCount.Text = "0";
            lblHoldCount.Text = "0";

            using (DataSet dt = OtherContext.GetProjectStatusCount(Convert.ToInt32(ddlProject.SelectedValue), ddlUnitStatus.SelectedText, ddlProject.SelectedText))
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
            //this.radMenuItemNotification.Text = "NOTIFICATION (0)";
            //GetNotificationList();
            M_SelectProject();
            this.InitProjectUnitBrowse();
            this.M_GetUnitListByProjectAndStatus();
            M_GetUnitListByProjectAndStatusCount();
            this.GetNotificationListDetails();

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

            //frmSettings forms = new frmSettings();
            //forms.ShowDialog();
        }
        private void radMenuItemAddNewLocation_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            LocationRegistrationForm forms = new LocationRegistrationForm();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemAddNewProject_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            ProjectRegistrationForm forms = new ProjectRegistrationForm();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemAddNewPurhcaseItem_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            PurchaseItemRegistrationForm forms = new PurchaseItemRegistrationForm();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItem5_Click(object sender, EventArgs e)
        {

        }
        private void radMenuItemAddNewClient_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            ClientRegistrationForm forms = new ClientRegistrationForm();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemResidentialSettings_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            ResidentialRateSettingForm forms = new ResidentialRateSettingForm();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemWareHouseSettings_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            WarehouseRateSettingForm forms = new WarehouseRateSettingForm();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemCommercialSettings_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            CommercialRateSettingForm forms = new CommercialRateSettingForm();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemAddNewUnit_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            UnitRegistrationForm forms = new UnitRegistrationForm();
            forms.ShowDialog();
            M_SelectProject();
            this.InitProjectUnitBrowse();
            this.M_GetUnitListByProjectAndStatus();
            M_GetUnitListByProjectAndStatusCount();
            this.GetNotificationListDetails();
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
            UnitComputationInquiry forms = new UnitComputationInquiry();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItem9_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            ViewClientInfo forms = new ViewClientInfo();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItem13_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            ForPaymentContractBrowse forms = new ForPaymentContractBrowse();
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
            ClientLedger forms = new ClientLedger();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemClientInformation_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            ViewClientInfo forms = new ViewClientInfo();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemTransactions_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            ForPaymentContractBrowse forms = new ForPaymentContractBrowse();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemLedger_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            ClientLedger forms = new ClientLedger();
            forms.ShowDialog();
            M_SelectProject();
            this.InitProjectUnitBrowse();
            this.M_GetUnitListByProjectAndStatus();
            M_GetUnitListByProjectAndStatusCount();
            this.GetNotificationListDetails();
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
            ParkingComputationInquiry forms = new ParkingComputationInquiry();
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
            UnitContractRegistrationForm forms = new UnitContractRegistrationForm();
            forms.ShowDialog();
            M_SelectProject();
            this.InitProjectUnitBrowse();
            this.M_GetUnitListByProjectAndStatus();
            M_GetUnitListByProjectAndStatusCount();
            this.GetNotificationListDetails();
            TimerCountDown.Start();
        }
        private void radMenuItemGenerateComputationParking2_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            ParkingContractRegistrationForm forms = new ParkingContractRegistrationForm();
            forms.ShowDialog();
            M_SelectProject();
            this.InitProjectUnitBrowse();
            this.M_GetUnitListByProjectAndStatus();
            M_GetUnitListByProjectAndStatusCount();
            this.GetNotificationListDetails();
            TimerCountDown.Start();

        }
        private void radMenuItemResidentialSettings2_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            ResidentialRateSettingForm forms = new ResidentialRateSettingForm();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemCommercialSettings2_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            CommercialRateSettingForm forms = new CommercialRateSettingForm();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemWareHouseSettings2_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            WarehouseRateSettingForm forms = new WarehouseRateSettingForm();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemContractSignedUnit_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            ForContractSignedUnitBrowse forms = new ForContractSignedUnitBrowse();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemUnitContracts_Click(object sender, EventArgs e)
        {

        }
        private void radMenuItemTenantMoveUnit_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            ForMoveInUnitBrowse forms = new ForMoveInUnitBrowse();
            forms.ShowDialog();
            this.M_GetUnitListByProjectAndStatus();
            M_GetUnitListByProjectAndStatusCount();
            TimerCountDown.Start();
        }
        private void radMenuItemContractSignedParking_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            ForContractSignedParkingBrowse forms = new ForContractSignedParkingBrowse();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemParkingContracts_Click(object sender, EventArgs e)
        {

        }
        private void radMenuItemTenantMoveParking_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            ForMoveInParkingBrowse forms = new ForMoveInParkingBrowse();
            forms.ShowDialog();
            this.M_GetUnitListByProjectAndStatus();
            M_GetUnitListByProjectAndStatusCount();
            TimerCountDown.Start();
        }
        private void radMenuItemUser_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            UserSecurityRegistrationForm forms = new UserSecurityRegistrationForm();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemGroupSecurity_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            GroupSecurityForm forms = new GroupSecurityForm();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemReciept_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            ClientContractRecieptBrowse forms = new ClientContractRecieptBrowse();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemCloseContract_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            ClosedContractBrowse forms = new ClosedContractBrowse();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemTenantMoveOutUnit_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            ForMoveOutUnitBrowse forms = new ForMoveOutUnitBrowse();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemTenantMoveOutParking_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            ForMoveOutParkingBrowse forms = new ForMoveOutParkingBrowse();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemBankName_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            BankSetupRegistrationForm forms = new BankSetupRegistrationForm();
            forms.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemFormControls_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            FormControlBrowse forms = new FormControlBrowse();
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
            UserDashBoard frmUserDashBoard = new UserDashBoard();
            frmUserDashBoard.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemGroup_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            UserGroupRegistrationForm frmUserGroup = new UserGroupRegistrationForm();
            frmUserGroup.ShowDialog();
            TimerCountDown.Start();
        }
        private void radMenuItemInformation_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            PurchaseItemRegistrationForm forms = new PurchaseItemRegistrationForm();
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
            ViewContractQuickInquiry forms = new ViewContractQuickInquiry();
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
            if (ddlProject.SelectedIndex >= 0)
            {
                if (ddlProject.SelectedText == "--ALL--")
                {
                    ddlUnitStatus.Text = "";
                    ddlUnitStatus.Text = "--ALL--";
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
                M_GetUnitListByProjectAndStatusCount();
            }
        }

        private void radMenuItemAddCompany_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            CompanyRegistrationForm forms = new CompanyRegistrationForm();
            forms.ShowDialog();
            TimerCountDown.Start();
        }

        private void radMenuItemAnnouncement_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            AdminAnnouncement forms = new AdminAnnouncement();
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
            //GetNotificationListDetails();
            //M_GetUnitListByProjectAndStatus();
            //M_GetUnitListByProjectAndStatusCount();
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

        private void radMenuItemReports_Click(object sender, EventArgs e)
        {

        }

        private void radMenuItemGeneralReport_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            GeneralReportSetPreview frmReport = new GeneralReportSetPreview();
            frmReport.ShowDialog();
            TimerCountDown.Start();
        }

        private void radMenuItemFloorTypes_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            FloorTypeSetupRegistrationForm frmFloorType = new FloorTypeSetupRegistrationForm();
            frmFloorType.ShowDialog();
            TimerCountDown.Start();
        }

        private void radMenuItemSpecialControlPermission_Click(object sender, EventArgs e)
        {
            TimerCountDown.Stop();
            SpecialControlPermission frmSpecialPermission = new SpecialControlPermission();
            frmSpecialPermission.ShowDialog();
            TimerCountDown.Start();
        }

        private void btnRefreshUnitList_Click(object sender, EventArgs e)
        {
            this.M_GetUnitListByProjectAndStatus();
            this.M_GetUnitListByProjectAndStatusCount();
            this.GetNotificationListDetails();

        }

        private void radMenuItemOtherPayment_Click(object sender, EventArgs e)
        {
            OtherPaymentCollection frmOtherPayment = new OtherPaymentCollection();
            frmOtherPayment.ShowDialog();
        }

        private void radMenuItemOtherPaymentType_Click(object sender, EventArgs e)
        {
            OtherPaymentTypeSetupRegistration frmOtherPaymentType = new OtherPaymentTypeSetupRegistration();
            frmOtherPaymentType.ShowDialog();
        }
    }
}
