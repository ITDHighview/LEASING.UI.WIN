using LEASING.UI.APP.Common;
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

namespace LEASING.UI.APP.Forms
{
    public partial class frmMainDashboard : Form
    {
        frmPreEmp_Login _frmPreEmp_Login;
        private bool IsSwithUserLogOut = false;
        public frmMainDashboard()
        {
            InitializeComponent();
            if (Convert.ToBoolean(ConfigurationManager.AppSettings["IsPermission"].ToString()))
            {
                Functions.SecurityControls(this);
            }
        }

        private void frmMainDashboard_Load(object sender, EventArgs e)
        {
            this.WindowState = FormWindowState.Maximized;
         
            this.radMenuItemNotification.Text = "NOTIFICATION (1)";

            radPanel10.Visible = false;//Purchase Items button

            //radMenu7.Visible = false;
            //radPanel7.Visible = false;

            //Variables.FirstName = FirstName;
            //Variables.UserID = Convert.ToInt32(this.txtUserName.Text);
            //Variables.UserGroupCode = Convert.ToInt32(cboGroup.SelectedValue);
            //Variables.UserGroupName = this.cboGroup.Text;
            //Variables.UserPassword = UserPassword;

            lblGroupName.Text =Variables.UserGroupName;
            lblStaffName.Text = Variables.FirstName;
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
            frmParkComputation forms = new frmParkComputation();
            forms.ShowDialog();
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
            if (MessageBox.Show("Would you like to pay it as full?","System Message",MessageBoxButtons.YesNo,MessageBoxIcon.Question,MessageBoxDefaultButton.Button2)== DialogResult.Yes)
            {
                frmComputation forms = new frmComputation(true);
                forms.ShowDialog();
            }
            else
            {
                frmComputation forms = new frmComputation(false);
                forms.ShowDialog();
            }
            
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
    }
}
