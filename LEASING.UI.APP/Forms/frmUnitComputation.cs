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
    public partial class frmUnitComputation : Form
    {
        private PrintDocument printDocument = new PrintDocument();
        RateSettingsContext RateSettingsContext = new RateSettingsContext();
        ProjectContext ProjectContext = new ProjectContext();
        UnitContext UnitContext = new UnitContext();
        ComputationContext ComputationContext = new ComputationContext();
        public frmUnitComputation()
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
            if (ddlProject.SelectedText == "--SELECT--")
            {
                MessageBox.Show("Project  cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }

            //if (ddlFloorType.SelectedText == "--SELECT--")
            //{
            //    MessageBox.Show("Floor Type cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            //    return false;
            //}


            return true;
        }

        private void ClearFields()
        {
            txtProjectAddress.Text = string.Empty;
            txtProjectType.Text = string.Empty;

            txtFloorType.Text = string.Empty;
            txtRental.Text = string.Empty;
            txtSecAndMaintenance.Text = string.Empty;
            txtTotalRental.Text = string.Empty;
            txtMonthsAdvance1.Text = string.Empty;
            txtMonthsAdvance2.Text = string.Empty;
            txtMonthsSecurityDeposit.Text = string.Empty;
            txtTotal.Text = string.Empty;
        }

        private void EnableFields()
        {
            txtProjectAddress.Enabled = true;
            txtProjectType.Enabled = true;

            txtFloorType.Enabled = true;
            txtRental.Enabled = true;
            txtSecAndMaintenance.Enabled = true;
            txtTotalRental.Enabled = true;
            txtMonthsAdvance1.Enabled = true;
            txtMonthsAdvance2.Enabled = true;
            txtMonthsSecurityDeposit.Enabled = true;
            txtTotal.Enabled = true;
            ddlProject.Enabled = true;
            ddlUnitNumber.Enabled = true;

            dtpStartDate.Enabled = true;
            dtpFinishDate.Enabled = true;
            dtpApplicableFrom.Enabled = true;
            dtpApplicableTo.Enabled = true;

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
            txtSecAndMaintenance.Enabled = false;
            txtTotalRental.Enabled = false;
            txtMonthsAdvance1.Enabled = false;
            txtMonthsAdvance2.Enabled = false;
            txtMonthsSecurityDeposit.Enabled = false;
            txtTotal.Enabled = false;

            dtpStartDate.Enabled = false;
            dtpFinishDate.Enabled = false;
            dtpApplicableFrom.Enabled = false;
            dtpApplicableTo.Enabled = false;

            ddlProject.Enabled = false;
            ddlUnitNumber.Enabled = false;
            btnCheckunits.Enabled = false;

        }
        private void M_GetPostDatedCountMonth()
        {

            dgvpostdatedcheck.DataSource = null;
            using (DataSet dt = ComputationContext.GetPostDatedCountMonth(dtpApplicableFrom.Text, dtpFinishDate.Text, dtpApplicableFrom.Text, dtpApplicableTo.Text, txtTotalRental.Text))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {

                    dgvpostdatedcheck.DataSource = dt.Tables[0];
                }
            }
        }
        private void M_GetRateSettings()
        {
            txtSecAndMaintenance.Text = string.Empty;
            lblVat.Text = string.Empty;

            using (DataSet dt = RateSettingsContext.GetRateSettingsByType(txtProjectType.Text))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    txtSecAndMaintenance.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecurityAndMaintenance"]);
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
            using (DataSet dt = UnitContext.GetUnitAvailableByProjectId(Convert.ToInt32(ddlProject.SelectedValue)))
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
        private void M_GetTotalRental()
        {
            var rental = ((txtRental.Text == "" ? 0 : Convert.ToDecimal(txtRental.Text)) + (txtSecAndMaintenance.Text == "" ? 0 : Convert.ToDecimal(txtSecAndMaintenance.Text)));
            txtTotalRental.Text = Convert.ToString(rental);
            txtMonthsAdvance1.Text = Convert.ToString(rental);
            txtMonthsAdvance2.Text = Convert.ToString(rental);
            var rental2 = (rental * 3);
            txtMonthsSecurityDeposit.Text = Convert.ToString(rental2);
            var rentalfinal = ((txtMonthsAdvance1.Text == "" ? 0 : Convert.ToDecimal(txtMonthsAdvance1.Text)) + (txtMonthsAdvance2.Text == "" ? 0 : Convert.ToDecimal(txtMonthsAdvance2.Text)));
            txtTotal.Text = Convert.ToString(rentalfinal + rental2);
        }

        private void frmComputation_Load(object sender, EventArgs e)
        {
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
                M_GetTotalRental();
            }
            else
            {
                txtProjectAddress.Text = string.Empty;
                txtFloorType.Text = string.Empty;
                txtRental.Text = string.Empty;
                txtProjectType.Text = string.Empty;
                txtSecAndMaintenance.Text = string.Empty;
                ddlUnitNumber.DataSource = null;
            }
        }

        private void ddlUnitNumber_SelectedIndexChanged(object sender, Telerik.WinControls.UI.Data.PositionChangedEventArgs e)
        {
            if (ddlUnitNumber.SelectedIndex >= 0)
            {
                M_GetUnitAvaibleById();
                M_GetTotalRental();
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

        //private void M_Save()
        //{
        //    ComputationModel dto = new ComputationModel();
        //    dto.ProjectId = Convert.ToInt32(ddlProject.SelectedValue);
        //    //dto.TransactionDate = dtpTransactionDate.Text;
        //    //dto.InquiringClient = txtClient.Text;
        //    //dto.ClientMobile = txtContactNumber.Text;
        //    dto.UnitId = Convert.ToInt32(ddlUnitNumber.SelectedValue);
        //    dto.UnitNo = ddlUnitNumber.Text;
        //    dto.StatDate = dtpStartDate.Text;
        //    dto.FinishDate = dtpFinishDate.Text;
        //    dto.Rental = Convert.ToInt32(decimal.Parse(txtRental.Text));
        //    dto.SecAndMaintenance = Convert.ToInt32(decimal.Parse(txtSecAndMaintenance.Text));
        //    dto.TotalRent = Convert.ToInt32(decimal.Parse(txtTotalRental.Text));
        //    dto.Advancemonths1 = Convert.ToInt32(decimal.Parse(txtMonthsAdvance1.Text));
        //    dto.Advancemonths2 = Convert.ToInt32(decimal.Parse(txtMonthsAdvance2.Text));
        //    dto.SecDeposit = Convert.ToInt32(decimal.Parse(txtMonthsSecurityDeposit.Text));
        //    dto.Total = Convert.ToInt32(decimal.Parse(txtTotal.Text));
        //    dto.EncodedBy = 1;
        //    dto.Message_Code = ComputationContext.SaveComputation(dto);
        //    if (dto.Message_Code.Equals("SUCCESS"))
        //    {
        //        MessageBox.Show("New Reference has been generated successfully !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
        //        strFormMode = "READ";


        //    }
        //    else
        //    {
        //        MessageBox.Show(dto.Message_Code, "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
        //        strFormMode = "READ";
        //    }
        //}
        //private void btnSaveComputation_Click(object sender, EventArgs e)
        //{
        //    if (strFormMode == "NEW")
        //    {
        //        if (IsComputationValid())
        //        {
        //            if (MessageBox.Show("Are you sure you want to generate this Reference ?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
        //            {
        //                M_Save();
        //            }
        //        }
        //    }
        //}

        //private void dgvList_CellClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        //{

        //    if (e.RowIndex >= 0)
        //    {
        //        if (this.dgvList.Columns[e.ColumnIndex].Name == "ColEdit")
        //        {
        //            frmEditUnitComputation forms = new frmEditUnitComputation();
        //            forms.Recid = Convert.ToInt32(dgvList.CurrentRow.Cells["RecId"].Value);
        //            forms.Text = Convert.ToString(dgvList.CurrentRow.Cells["ProjectName"].Value) + " - "+" UNIT";
        //            forms.ShowDialog();             
        //        }
        //        else if (this.dgvList.Columns[e.ColumnIndex].Name == "ColRemoved")
        //        {

        //            if (MessageBox.Show("Are you sure you want to Delete this computation?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
        //            {

        //                var result = ComputationContext.DeleteComputation(Convert.ToInt32(dgvList.CurrentRow.Cells["RecId"].Value), Convert.ToInt32(dgvList.CurrentRow.Cells["UnitId"].Value));
        //                if (result.Equals("SUCCESS"))
        //                {
        //                    MessageBox.Show("Reference has been deleted successfully !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
        //                    M_GetComputationList();
        //                }
        //            }
        //        }
        //    }
        //}

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
            M_GetPostDatedCountMonth();
        }
    }
}
