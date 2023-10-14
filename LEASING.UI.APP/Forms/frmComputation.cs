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
    public partial class frmComputation : Form
    {
        //private DataTable data = new DataTable();
        RateSettingsContext RateSettingsContext = new RateSettingsContext();
        ProjectContext ProjectContext = new ProjectContext();
        UnitContext UnitContext = new UnitContext();
        ComputationContext ComputationContext = new ComputationContext();
        public frmComputation()
        {
            InitializeComponent();
            //data.Columns.Add("Seq", typeof(int));         
            //data.Columns.Add("Date", typeof(string));
            //data.Columns.Add("Rental", typeof(string));



            // Bind the DataTable to the DataGridView
            //dgvpostdatedcheck.DataSource = data;
        }

        public int seq = 0;
        //private void GenerateDataForMonths(DateTime startDate, DateTime endDate)
        //{
        //    DateTime currentDate = startDate;

        //    while (currentDate <= endDate)
        //    {
        //        seq++;
        //        data.Rows.Add(data.Rows.Count + 1, String.Format("{0:MMMM d, yyyy}",currentDate),txtTotalRental.Text);
        //        currentDate = currentDate.AddMonths(1);
        //    }
        //}
        private int CountMonths(DateTime startDate, DateTime endDate)
        {
            // The rest of the code remains the same as in the previous example
            if (endDate < startDate)
            {
                DateTime temp = startDate;
                startDate = endDate;
                endDate = temp;
            }

            int months = ((endDate.Year - startDate.Year) * 12) + endDate.Month - startDate.Month;

            if (endDate.Day >= startDate.Day)
            {
                months++;
            }

            return months;
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
                        btnSaveComputation.Enabled = true;
                        btnNewComputation.Enabled = false;
                        ClearFields();
                        EnableFields();
                        dgvpostdatedcheck.DataSource = null;

                        break;
                    case "READ":
                        btnUndo.Enabled = false;
                        btnSaveComputation.Enabled = false;
                        btnNewComputation.Enabled = true;

                        ddlProject.SelectedIndex = 0;
                        ddlUnitNumber.SelectedIndex = 0;
                        DisableFields();
                        //data.Clear();
                        txtTotalPostDatedAmount.Text = string.Empty;
                        dgvpostdatedcheck.DataSource = null;
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
            txtClient.Text = string.Empty;
            txtContactNumber.Text = string.Empty;
            txtFloorType.Text = string.Empty;
            txtRental.Text = string.Empty;
            txtSecAndMaintenance.Text = string.Empty;
            txtTotalRental.Text = string.Empty;
            txtMonthsAdvance1.Text = string.Empty;
            txtMonthsAdvance2.Text = string.Empty;
            txtMonthsSecurityDeposit.Text = string.Empty;
            txtTotal.Text = string.Empty;
            ClientId = string.Empty;
            txtTotalPostDatedAmount.Text = string.Empty;
            //data.Clear();
        }

        private void EnableFields()
        {
            txtProjectAddress.Enabled = true;
            txtProjectType.Enabled = true;
            txtClient.Enabled = true;
            txtContactNumber.Enabled = true;
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


            dgvpostdatedcheck.Enabled = true;

            btnSelectClient.Enabled = true;
            txtTotalPostDatedAmount.Enabled = true;
        }

        private void DisableFields()
        {
            txtProjectAddress.Enabled = false;
            txtProjectType.Enabled = false;
            txtClient.Enabled = false;
            txtContactNumber.Enabled = false;
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


            dgvpostdatedcheck.Enabled = false;

            btnSelectClient.Enabled = false;
            txtTotalPostDatedAmount.Enabled = false;

        }

        private void M_GetRateSettings()
        {
            txtSecAndMaintenance.Text = string.Empty;
            lblVat.Text = string.Empty;
            using (DataSet dt = RateSettingsContext.GetRateSettingsByType(txtProjectType.Text))
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    //txtGenVat.Text = Convert.ToString(dt.Tables[0].Rows[0]["GenVat"]);
                    txtSecAndMaintenance.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecurityAndMaintenance"]);
                    lblVat.Text = Convert.ToString(dt.Tables[0].Rows[0]["labelVat"]);
                    //chkIsWithVat.Checked = Convert.ToBoolean(dt.Tables[0].Rows[0]["IsSecAndMaintVat"]);
                    //txtSecAndMaintenanceVat.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecurityAndMaintenanceVat"]);
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
        private void M_GetComputationList()
        {

            dgvList.DataSource = null;
            using (DataSet dt = ComputationContext.GetComputationList())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {

                    dgvList.DataSource = dt.Tables[0];
                }
            }
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
            M_GetComputationList();
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

        private void M_Save()
        {
            ComputationModel dto = new ComputationModel();
            dto.ProjectId = Convert.ToInt32(ddlProject.SelectedValue);
            //dto.TransactionDate = dtpTransactionDate.Text;
            dto.InquiringClient = txtClient.Text;
            dto.ClientMobile = txtContactNumber.Text;
            dto.ClientID = ClientId;
            dto.UnitId = Convert.ToInt32(ddlUnitNumber.SelectedValue);
            dto.UnitNo = ddlUnitNumber.Text;
            dto.StatDate = dtpStartDate.Text;
            dto.FinishDate = dtpFinishDate.Text;
            dto.Applicabledate1 = dtpApplicableFrom.Text;
            dto.Applicabledate2 = dtpApplicableTo.Text;
            dto.Rental = txtRental.Text == string.Empty ? 0 : decimal.Parse(txtRental.Text);
            dto.SecAndMaintenance = txtSecAndMaintenance.Text == string.Empty ? 0 : decimal.Parse(txtSecAndMaintenance.Text);
            dto.TotalRent = txtTotalRental.Text == string.Empty ? 0 : decimal.Parse(txtTotalRental.Text);
            dto.Advancemonths1 = txtMonthsAdvance1.Text == string.Empty ? 0 : decimal.Parse(txtMonthsAdvance1.Text);
            dto.Advancemonths2 = txtMonthsAdvance2.Text == string.Empty ? 0 : decimal.Parse(txtMonthsAdvance2.Text);
            dto.SecDeposit = txtMonthsSecurityDeposit.Text == string.Empty ? 0 : decimal.Parse(txtMonthsSecurityDeposit.Text);
            dto.Total = txtTotal.Text == string.Empty ? 0 : decimal.Parse(txtTotal.Text);
            dto.EncodedBy = 1;
            dto.Message_Code = ComputationContext.SaveComputation(dto);
            if (dto.Message_Code.Equals("SUCCESS"))
            {
                MessageBox.Show("New Reference has been generated successfully !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                strFormMode = "READ";
                M_GetComputationList();

            }
            else
            {
                MessageBox.Show(dto.Message_Code, "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                strFormMode = "READ";
            }
        }
        private void btnSaveComputation_Click(object sender, EventArgs e)
        {
            if (strFormMode == "NEW")
            {
                if (IsComputationValid())
                {
                    if (MessageBox.Show("Are you sure you want to generate this Reference ?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                    {


                        try
                        {
                            M_Save();
                        }
                        catch (Exception ex)
                        {

                            throw;
                        }
                    }
                }
            }
        }

        private void dgvList_CellClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {

            if (e.RowIndex >= 0)
            {
                if (this.dgvList.Columns[e.ColumnIndex].Name == "ColEdit")
                {
                    frmEditUnitComputation forms = new frmEditUnitComputation();
                    forms.Recid = Convert.ToInt32(dgvList.CurrentRow.Cells["RecId"].Value);
                    forms.Text = Convert.ToString(dgvList.CurrentRow.Cells["ProjectName"].Value) + " - " + " UNIT";
                    forms.ShowDialog();
                    //if (forms.IsProceed)
                    //{
                    //    //M_GetUnitList();
                    //}
                }
                else if (this.dgvList.Columns[e.ColumnIndex].Name == "ColRemoved")
                {

                    if (MessageBox.Show("Are you sure you want to Delete this computation?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                    {

                        var result = ComputationContext.DeleteComputation(Convert.ToInt32(dgvList.CurrentRow.Cells["RecId"].Value), Convert.ToInt32(dgvList.CurrentRow.Cells["UnitId"].Value));
                        if (result.Equals("SUCCESS"))
                        {
                            MessageBox.Show("Reference has been deleted successfully !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                            M_GetComputationList();
                        }
                    }
                }
            }
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

        public string ClientId { get; set; }
        private void btnSelectClient_Click(object sender, EventArgs e)
        {
            frmGetSelectClient forms = new frmGetSelectClient();
            forms.ShowDialog();
            if (forms.IsProceed)
            {
                txtClient.Text = forms.ClientName;
                ClientId = forms.ClientID;
            }
        }

        private void dtpFinishDate_ValueChanged(object sender, EventArgs e)
        {



        }
        private void btnGeneratePostdatedCountMonth_Click(object sender, EventArgs e)
        {

            if (!string.IsNullOrEmpty(ClientId))
            {
                seq = 0;
                txtTotalPostDatedAmount.Text = string.Empty;
                //data.Clear(); // Clear existing data

                //DateTime startDate = dtpStartDate.Value;
                //DateTime endDate = dtpFinishDate.Value;

                //if (startDate > endDate)
                //{
                //    MessageBox.Show("Start date cannot be after end date.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                //    return;
                //}

                //GenerateDataForMonths(startDate, endDate);
                // txtTotalPostDatedAmount.Text = Convert.ToString(Convert.ToInt32(decimal.Parse(seq.ToString())) * Convert.ToInt32(decimal.Parse(txtTotalRental.Text)));

                // var rental = (txtRental.Text == "") ? 0 : (Convert.ToDecimal(txtRental.Text) + ((txtSecAndMaintenance.Text == "") ? 0 : Convert.ToDecimal(txtSecAndMaintenance.Text)));


                M_GetPostDatedCountMonth();

                var TotalPostDatedAmount = (dgvpostdatedcheck.Rows.Count() < 0) ? 0 : (Convert.ToDecimal(dgvpostdatedcheck.Rows.Count().ToString()) * ((txtTotalRental.Text == "") ? 0 : Convert.ToDecimal(txtTotalRental.Text)));
                txtTotalPostDatedAmount.Text = TotalPostDatedAmount.ToString();

            }
        }
    }
}
