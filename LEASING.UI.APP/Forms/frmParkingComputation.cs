using LEASING.UI.APP.Context;
using LEASING.UI.APP.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Printing;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace LEASING.UI.APP.Forms
{
    public partial class frmParkingComputation : Form
    {
        private PrintDocument printDocument = new PrintDocument();
        RateSettingsContext RateSettingsContext = new RateSettingsContext();
        ProjectContext ProjectContext = new ProjectContext();
        UnitContext UnitContext = new UnitContext();
        ComputationContext ComputationContext = new ComputationContext();
        public frmParkingComputation()
        {
            InitializeComponent();
            printDocument.PrintPage += PrintDocument_PrintPage;
        }
        private void PrintDocument_PrintPage(object sender, PrintPageEventArgs e)
        {
            // Calculate the scaling factor to fit the content on the printed page
            float scaleWidth = e.PageBounds.Width / (float)this.Width;
            float scaleHeight = e.PageBounds.Height / (float)this.Height;
            float scale = Math.Min(scaleWidth, scaleHeight);

            // Create a matrix for scaling and translation
            Matrix scaleMatrix = new Matrix();
            scaleMatrix.Scale(scale, scale);

            // Center the content horizontally on the printed page
            float translateX = (e.PageBounds.Width - this.Width * scale) / 2;
            scaleMatrix.Translate(translateX, 0);

            // Apply the scaling and translation transformations
            e.Graphics.Transform = scaleMatrix;

            // Draw the content of your form onto the printed page
            using (Bitmap bitmap = new Bitmap(this.Width, this.Height))
            {
                this.DrawToBitmap(bitmap, new Rectangle(0, 0, this.Width, this.Height));
                e.Graphics.DrawImage(bitmap, Point.Empty);
            }
        }
        private void printButton_Click(object sender, EventArgs e)
        {
            // Display the print preview dialog
            PrintPreviewDialog printPreviewDialog = new PrintPreviewDialog();
            printPreviewDialog.Document = printDocument;
            printPreviewDialog.ShowDialog();
            this.btnCheckunits.Visible = true;
            this.btnNewComputation.Visible = true;
            this.btnUndo.Visible = true;
            this.btnPrint.Visible = true;
            this.ControlBox = true;
            btnCompute.Visible = true;
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

                        btnNewComputation.Enabled = false;
                        ClearFields();
                        EnableFields();
                        dgvpostdatedcheck.DataSource = null;
                        btnCompute.Enabled = true;
                        break;
                    case "READ":
                        btnUndo.Enabled = false;

                        btnNewComputation.Enabled = true;

                        ddlProject.SelectedIndex = 0;
                        ddlUnitNumber.SelectedIndex = 0;
                        DisableFields();
                        dgvpostdatedcheck.DataSource = null;
                        btnCompute.Enabled = false;
                        break;

                    default:
                        break;
                }
            }
        }
        private bool IsComputationValid()
        {
            if (ddlProject.SelectedIndex == 0)
            {
                MessageBox.Show("Please select Project name.", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            return true;
        }
        private void ClearFields()
        {
            txtProjectAddress.Text = string.Empty;
            txtProjectType.Text = string.Empty;

            txtFloorType.Text = string.Empty;
            txtRental.Text = string.Empty;
            //txtSecAndMaintenance.Text = string.Empty;
            //txtTotalRental.Text = string.Empty;
            //txtMonthsAdvance1.Text = string.Empty;
            //txtMonthsAdvance2.Text = string.Empty;
            //txtMonthsSecurityDeposit.Text = string.Empty;
            //txtTotal.Text = string.Empty;
        }
        private void EnableFields()
        {
            txtProjectAddress.Enabled = true;
            txtProjectType.Enabled = true;

            txtFloorType.Enabled = true;
            txtRental.Enabled = true;
            //txtSecAndMaintenance.Enabled = true;
            //txtTotalRental.Enabled = true;
            //txtMonthsAdvance1.Enabled = true;
            //txtMonthsAdvance2.Enabled = true;
            //txtMonthsSecurityDeposit.Enabled = true;
            //txtTotal.Enabled = true;
            ddlProject.Enabled = true;
            ddlUnitNumber.Enabled = true;

            dtpStartDate.Enabled = true;
            dtpFinishDate.Enabled = true;
            //dtpApplicableFrom.Enabled = true;
            //dtpApplicableTo.Enabled = true;

            ddlProject.Enabled = true;
            ddlUnitNumber.Enabled = true;
            btnCheckunits.Enabled = true;
        }
        private void DisableFields()
        {
            txtProjectAddress.Enabled = false;
            txtProjectType.Enabled = false;

            txtFloorType.Enabled = false;
            txtRental.Enabled = false;
            //txtSecAndMaintenance.Enabled = false;
            //txtTotalRental.Enabled = false;
            //txtMonthsAdvance1.Enabled = false;
            //txtMonthsAdvance2.Enabled = false;
            //txtMonthsSecurityDeposit.Enabled = false;
            //txtTotal.Enabled = false;

            dtpStartDate.Enabled = false;
            dtpFinishDate.Enabled = false;
            //dtpApplicableFrom.Enabled = false;
            //dtpApplicableTo.Enabled = false;

            ddlProject.Enabled = false;
            ddlUnitNumber.Enabled = false;
            btnCheckunits.Enabled = false;

        }
        private void M_GetPostDatedCountMonth()
        {

            dgvpostdatedcheck.DataSource = null;
            using (DataSet dt = ComputationContext.GetPostDatedCountMonthParking(dtpStartDate.Text, dtpFinishDate.Text, txtRental.Text))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {

                    dgvpostdatedcheck.DataSource = dt.Tables[0];
                }
            }
        }
        private void M_GetRateSettings()
        {

            lblVat.Text = string.Empty;

            using (DataSet dt = RateSettingsContext.GetRateSettingsByType(txtProjectType.Text))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    //txtSecAndMaintenance.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecurityAndMaintenance"]);
                    lblVat.Text = Convert.ToString(dt.Tables[0].Rows[0]["labelVat"]);
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
        private void M_SelectUnit()
        {
            ddlUnitNumber.DataSource = null;
            using (DataSet dt = UnitContext.GetParkingAvailableByProjectId(Convert.ToInt32(ddlProject.SelectedValue)))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    ddlUnitNumber.DisplayMember = "UnitNo";
                    ddlUnitNumber.ValueMember = "RecId";
                    ddlUnitNumber.DataSource = dt.Tables[0];
                }
            }
        }
        private void M_GetProjecAddress()
        {
            txtProjectAddress.Text = string.Empty;
            txtProjectType.Text = string.Empty;
            using (DataSet dt = ProjectContext.GetProjectAddress(Convert.ToInt32(ddlProject.SelectedValue)))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    txtProjectAddress.Text = Convert.ToString(dt.Tables[0].Rows[0]["ProjectAddress"]);
                    txtProjectType.Text = Convert.ToString(dt.Tables[0].Rows[0]["ProjectType"]);
                }
            }
        }
        private void M_GetUnitAvaibleById()
        {
            txtFloorType.Text = string.Empty;
            txtRental.Text = string.Empty;
            using (DataSet dt = UnitContext.GetUnitAvailableById(Convert.ToInt32(ddlUnitNumber.SelectedValue)))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    txtFloorType.Text = Convert.ToString(dt.Tables[0].Rows[0]["FloorType"]);
                    txtRental.Text = Convert.ToString(dt.Tables[0].Rows[0]["BaseRental"]);
                }
            }
        }
        //private void M_GetTotalRental()
        //{
        //    var rental = ((txtRental.Text == "" ? 0 : Convert.ToDecimal(txtRental.Text)) + (txtSecAndMaintenance.Text == "" ? 0 : Convert.ToDecimal(txtSecAndMaintenance.Text)));
        //    //txtTotalRental.Text = Convert.ToString(rental);
        //    //txtMonthsAdvance1.Text = Convert.ToString(rental);
        //    //txtMonthsAdvance2.Text = Convert.ToString(rental);
        //    var rental2 = (rental * 3);
        //    txtMonthsSecurityDeposit.Text = Convert.ToString(rental2);
        //    var rentalfinal = ((txtMonthsAdvance1.Text == "" ? 0 : Convert.ToDecimal(txtMonthsAdvance1.Text)) + (txtMonthsAdvance2.Text == "" ? 0 : Convert.ToDecimal(txtMonthsAdvance2.Text)));
        //    txtTotal.Text = Convert.ToString(rentalfinal + rental2);
        //}
        private bool IsMoreThanSixMonths(DateTime date1, DateTime date2)
        {
            // Calculate the difference in months
            int monthsDifference = (date2.Year - date1.Year) * 12 + date2.Month - date1.Month;

            // Check if the difference is more than 6 months
            return monthsDifference > 9;
        }
        private void frmComputation_Load(object sender, EventArgs e)
        {
            dtpStartDate.Text = DateTime.Now.ToString("MM/dd/yyyy");
            dtpFinishDate.Text = DateTime.Now.ToString("MM/dd/yyyy");
            txtRental.ReadOnly = true;
            txtTotalCheck.ReadOnly = true;

            strFormMode = "READ";
            txtProjectType.ReadOnly = true;
            txtFloorType.ReadOnly = true;
            M_SelectProject();
        }
        private void ddlProject_SelectedIndexChanged(object sender, Telerik.WinControls.UI.Data.PositionChangedEventArgs e)
        {
            if (ddlProject.SelectedIndex >= 0)
            {
                M_GetProjecAddress();
                M_SelectUnit();
                M_GetUnitAvaibleById();
                M_GetRateSettings();
                //M_GetTotalRental();
            }
            else
            {
                txtProjectAddress.Text = string.Empty;
                txtFloorType.Text = string.Empty;
                txtRental.Text = string.Empty;
                txtProjectType.Text = string.Empty;
                //txtSecAndMaintenance.Text = string.Empty;
                ddlUnitNumber.DataSource = null;
            }
        }
        private void ddlUnitNumber_SelectedIndexChanged(object sender, Telerik.WinControls.UI.Data.PositionChangedEventArgs e)
        {
            if (ddlUnitNumber.SelectedIndex >= 0)
            {
                M_GetUnitAvaibleById();
                //M_GetTotalRental();
            }
            else
            {
                txtFloorType.Text = string.Empty;
                txtRental.Text = string.Empty;
            }
        }
        private void txtRental_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }
        private void txtSecAndMaintenance_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }
        private void txtTotalRental_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }
        private void txtMonthsAdvance1_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }
        private void txtMonthsAdvance2_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }
        private void txtMonthsSecurityDeposit_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }
        private void txtTotal_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }
        private void btnNewComputation_Click(object sender, EventArgs e)
        {
            strFormMode = "NEW";
        }
        private void btnUndo_Click(object sender, EventArgs e)
        {
            strFormMode = "READ";
        }
        private void btnCheckunits_Click(object sender, EventArgs e)
        {
            if (ddlProject.SelectedIndex >= 0)
            {
                frmCheckUnits forms = new frmCheckUnits();
                forms.Recid = Convert.ToInt32(ddlProject.SelectedValue);
                forms.Text = ddlProject.Text + " - " + " UNIT/PARKING LIST";
                forms.ShowDialog();
            }
            else
            {
                MessageBox.Show("Please select project name", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }
        private void btnPrint_Click(object sender, EventArgs e)
        {
            if (strFormMode == "NEW")
            {
                this.btnCheckunits.Visible = false;
                this.btnNewComputation.Visible = false;
                this.btnUndo.Visible = false;
                this.btnPrint.Visible = false;
                this.ControlBox = false;
                btnCompute.Visible = false;
                printButton_Click(sender, e);
            }
            else
            {
                MessageBox.Show("Please click compute button", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
        }
        private void btnCompute_Click(object sender, EventArgs e)
        {
            if (IsComputationValid())
            {
                if (IsMoreThanSixMonths(Convert.ToDateTime(dtpStartDate.Text), Convert.ToDateTime(dtpFinishDate.Text)))
                {
                    txtTotalCheck.Text = string.Empty;

                    M_GetPostDatedCountMonth();
                    var TotalPostDatedAmount = (dgvpostdatedcheck.Rows.Count() < 0) ? 0 : (Convert.ToDecimal(dgvpostdatedcheck.Rows.Count().ToString()) * ((txtRental.Text == "") ? 0 : Convert.ToDecimal(txtRental.Text)));
                    txtTotalCheck.Text = TotalPostDatedAmount.ToString();
                    txtTotalCheck.Focus();
                }
                else
                {
                    MessageBox.Show("Lease period is out of range", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                }
            }


        }
        private void txtTotalCheck_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }
    }
}
