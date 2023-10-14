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
    public partial class frmMainDashboard : Form
    {
        public frmMainDashboard()
        {
            InitializeComponent();
        }

        private void frmMainDashboard_Load(object sender, EventArgs e)
        {
            this.WindowState = FormWindowState.Maximized;
            this.radMenuItemNotification.Text = "NOTIFICATION (1)";
            //radMenu7.Visible = false;
            //radPanel7.Visible = false;
        }

        private void btnSettings_Click(object sender, EventArgs e)
        {
            frmSettings forms = new frmSettings();
            forms.ShowDialog();
        }

        private void radMenuItemSettings_Click(object sender, EventArgs e)
        {

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

        private void radMenuItem4_Click(object sender, EventArgs e)
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
            frmComputation forms = new frmComputation();
            forms.ShowDialog();

        }

        private void radMenuItem14_Click(object sender, EventArgs e)
        {
            frmClientTransaction forms = new frmClientTransaction();
            forms.ShowDialog();
        }
    }
}
