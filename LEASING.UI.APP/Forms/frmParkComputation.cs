using LEASING.UI.APP.Common;
using LEASING.UI.APP.Context;
using LEASING.UI.APP.Models;
using System;
using System.Collections;
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
    public partial class frmParkComputation : Form
    {
        //private DataTable data = new DataTable();
        RateSettingsContext RateSettingsContext = new RateSettingsContext();
        ProjectContext ProjectContext = new ProjectContext();
        UnitContext UnitContext = new UnitContext();
        ComputationContext ComputationContext = new ComputationContext();
        public bool sIsFullPayment = false;
        public bool IsComputed = false;
        private DataTable dataTable;
        public frmParkComputation()
        {
            InitializeComponent();
            //data.Columns.Add("Seq", typeof(int));         
            //data.Columns.Add("Date", typeof(string));
            //data.Columns.Add("Rental", typeof(string));



            // Bind the DataTable to the DataGridView
            //dgvpostdatedcheck.DataSource = data;
        }
        public int seq = 0;
        public decimal AdvancePaymentAmount { get; set; } = 0;
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

                        //ddlProject.SelectedIndex = 0;
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
                MessageBox.Show("Please select Project name.", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }

            if (string.IsNullOrEmpty(txtClient.Text))
            {
                MessageBox.Show("Please select Client", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            if (string.IsNullOrEmpty(ClientId))
            {
                MessageBox.Show("please select client", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return false;
            }
            if (ddlUnitNumber.SelectedIndex == -1)
            {
                MessageBox.Show("No available unit for this project, please contact admin.", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            if (string.IsNullOrEmpty(txtRental.Text))
            {
                MessageBox.Show("unit rental is not declared, please contact admin.", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            if (txtRental.Text == "0")
            {
                MessageBox.Show("unit rental is not declared, please contact admin.", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            if (!IsMoreThanSixMonths(Convert.ToDateTime(dtpStartDate.Text), Convert.ToDateTime(dtpFinishDate.Text)))
            {
                MessageBox.Show("Lease period is out of range", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return false;
            }
            if (!IsComputed)
            {
                MessageBox.Show("Please execute the computation", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return false;
            }

            return true;
        }
        private bool IsComputationValidForCompute()
        {
            if (ddlProject.SelectedText == "--SELECT--")
            {
                MessageBox.Show("Please select Project name.", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            if (string.IsNullOrEmpty(txtClient.Text))
            {
                MessageBox.Show("Please select Client", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            if (string.IsNullOrEmpty(ClientId))
            {
                MessageBox.Show("please select client", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return false;
            }
            if (ddlUnitNumber.SelectedIndex == -1)
            {
                MessageBox.Show("No available unit for this project, please contact admin.", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            if (string.IsNullOrEmpty(txtRental.Text))
            {
                MessageBox.Show("unit rental is not declared, please contact admin.", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            if (txtRental.Text == "0")
            {
                MessageBox.Show("unit rental is not declared, please contact admin.", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            if (!IsMoreThanSixMonths(Convert.ToDateTime(dtpStartDate.Text), Convert.ToDateTime(dtpFinishDate.Text)))
            {
                MessageBox.Show("Lease period is out of range", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return false;
            }


            return true;
        }
        private bool IsComputationValidForAdvancePayment()
        {
            if (ddlProject.SelectedText == "--SELECT--")
            {
                MessageBox.Show("Please select Project name.", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            if (string.IsNullOrEmpty(txtClient.Text))
            {
                MessageBox.Show("Please select Client", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            if (string.IsNullOrEmpty(ClientId))
            {
                MessageBox.Show("please select client", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return false;
            }
            if (ddlUnitNumber.SelectedIndex == -1)
            {
                MessageBox.Show("No available unit for this project, please contact admin.", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            if (string.IsNullOrEmpty(txtRental.Text))
            {
                MessageBox.Show("unit rental is not declared, please contact admin.", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            if (txtRental.Text == "0")
            {
                MessageBox.Show("unit rental is not declared, please contact admin.", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }

            if (!IsMoreThanSixMonths(Convert.ToDateTime(dtpStartDate.Text), Convert.ToDateTime(dtpFinishDate.Text)))
            {
                MessageBox.Show("Lease period is out of range", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                return false;
            }

            return true;
        }
        private void ClearFields()
        {
            txtProjectAddress.Text = string.Empty;
            txtProjectType.Text = string.Empty;
            txtClient.Text = string.Empty;
            //txtContactNumber.Text = string.Empty;
            txtFloorType.Text = string.Empty;
            txtRental.Text = string.Empty;
            txtTotal.Text = string.Empty;
            //txtSecAndMaintenance.Text = string.Empty;
            //txtTotalRental.Text = string.Empty;
            //txtMonthsAdvance1.Text = string.Empty;
            //txtMonthsAdvance2.Text = string.Empty;
            //txtMonthsSecurityDeposit.Text = string.Empty;
            //txtTotal.Text = string.Empty;
            ClientId = string.Empty;
            txtTotalPostDatedAmount.Text = string.Empty;
            dataTable.Clear();
            dgvAdvancePayment.DataSource = null;
            dgvpostdatedcheck.DataSource = null;
        }
        private void EnableFields()
        {
            txtProjectAddress.Enabled = true;
            txtProjectType.Enabled = true;
            txtClient.Enabled = true;
            //txtContactNumber.Enabled = true;
            txtFloorType.Enabled = true;
            txtRental.Enabled = true;
            txtTotal.Enabled = true;
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


            dgvpostdatedcheck.Enabled = true;

            btnSelectClient.Enabled = true;
            txtTotalPostDatedAmount.Enabled = true;
            toolStripAdvancePayment.Enabled = true;
            dgvAdvancePayment.Enabled = true;
        }
        private void DisableFields()
        {
            txtProjectAddress.Enabled = false;
            txtProjectType.Enabled = false;
            txtClient.Enabled = false;
            //txtContactNumber.Enabled = false;
            txtFloorType.Enabled = false;
            txtRental.Enabled = false;
            txtTotal.Enabled = false;
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


            dgvpostdatedcheck.Enabled = false;

            btnSelectClient.Enabled = false;
            txtTotalPostDatedAmount.Enabled = false;
            toolStripAdvancePayment.Enabled = false;
            dgvAdvancePayment.Enabled = false;

        }
        private void M_GetRateSettings()
        {
            //txtSecAndMaintenance.Text = string.Empty;
            lblVat.Text = string.Empty;
            try
            {
                using (DataSet dt = RateSettingsContext.GetRateSettingsByType(txtProjectType.Text))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        //txtGenVat.Text = Convert.ToString(dt.Tables[0].Rows[0]["GenVat"]);
                        //txtSecAndMaintenance.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecurityAndMaintenance"]);
                        lblVat.Text = Convert.ToString(dt.Tables[0].Rows[0]["labelVat"]);
                        //chkIsWithVat.Checked = Convert.ToBoolean(dt.Tables[0].Rows[0]["IsSecAndMaintVat"]);
                        //txtSecAndMaintenanceVat.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecurityAndMaintenanceVat"]);
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_GetRateSettings()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_GetRateSettings()", ex.ToString());
            }
        }
        private void M_SelectProject()
        {
            try
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
            catch (Exception ex)
            {
                Functions.LogError("M_SelectProject()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_SelectProject()", ex.ToString());
            }
        }
        private void M_SelectUnit()
        {
            try
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
            catch (Exception ex)
            {
                Functions.LogError("M_SelectUnit()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_SelectUnit()", ex.ToString());
            }
        }
        private void M_GetComputationList()
        {
            try
            {
                dgvList.DataSource = null;
                using (DataSet dt = ComputationContext.GetParkingComputationList())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {

                        dgvList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_GetComputationList()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_GetComputationList()", ex.ToString());
            }
        }
        private void M_GetPostDatedCountMonth()
        {
            try
            {
                dgvpostdatedcheck.DataSource = null;
                using (DataSet dt = ComputationContext.GetPostDatedCountMonthParking(dtpStartDate.Text, dtpFinishDate.Text, txtRental.Text, null))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {

                        dgvpostdatedcheck.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_GetPostDatedCountMonth()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_GetPostDatedCountMonth()", ex.ToString());
            }
        }
        private void M_GetProjecAddress()
        {

            txtProjectAddress.Text = string.Empty;
            txtProjectType.Text = string.Empty;
            try
            {
                using (DataSet dt = ProjectContext.GetProjectAddress(Convert.ToInt32(ddlProject.SelectedValue)))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        txtProjectAddress.Text = Convert.ToString(dt.Tables[0].Rows[0]["ProjectAddress"]);
                        txtProjectType.Text = Convert.ToString(dt.Tables[0].Rows[0]["ProjectType"]);
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_GetProjecAddress()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_GetProjecAddress()", ex.ToString());
            }
        }
        private void M_GetUnitAvaibleById()
        {
            txtFloorType.Text = string.Empty;
            txtRental.Text = string.Empty;
            try
            {
                using (DataSet dt = UnitContext.GetUnitAvailableById(Convert.ToInt32(ddlUnitNumber.SelectedValue)))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        txtFloorType.Text = Convert.ToString(dt.Tables[0].Rows[0]["FloorType"]);
                        txtRental.Text = Convert.ToString(dt.Tables[0].Rows[0]["BaseRental"]);
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_GetUnitAvaibleById()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_GetUnitAvaibleById()", ex.ToString());
            }
        }
        private void M_GetTotalRental()
        {


            //var rental = ((txtRental.Text == "" ? 0 : Convert.ToDecimal(txtRental.Text)) + (txtSecAndMaintenance.Text == "" ? 0 : Convert.ToDecimal(txtSecAndMaintenance.Text)));
            var rental = ((txtRental.Text == "" ? 0 : Convert.ToDecimal(txtRental.Text)));
            //txtTotalRental.Text = Convert.ToString(rental);
            //txtMonthsAdvance1.Text = Convert.ToString(rental);
            //txtMonthsAdvance2.Text = Convert.ToString(rental);
            //var rental2 = (rental * 3);
            //txtMonthsSecurityDeposit.Text = Convert.ToString(rental2);
            //var rentalfinal = ((txtMonthsAdvance1.Text == "" ? 0 : Convert.ToDecimal(txtMonthsAdvance1.Text)) + (txtMonthsAdvance2.Text == "" ? 0 : Convert.ToDecimal(txtMonthsAdvance2.Text)));
            var rentalfinal = (rental * dgvAdvancePayment.Rows.Count());
            if (sIsFullPayment)
            {
                txtTotal.Text = Convert.ToString(txtTotalPostDatedAmount.Text == "" ? 0 : Convert.ToDecimal(txtTotalPostDatedAmount.Text));

            }
            else
            {
                txtTotal.Text = Convert.ToString(rentalfinal);
            }
            AdvancePaymentAmount = rentalfinal;
        }
        private bool IsDuplicate(string Months)
        {
            // Check if the data already exists in the DataTable
            foreach (DataRow row in dataTable.Rows)
            {
                if (row.Field<string>("Months") == Months)
                {
                    return true; // Duplicate data found
                }
            }

            return false; // No duplicate data found
        }
        private bool IsMoreThanSixMonths(DateTime date1, DateTime date2)
        {
            // Calculate the difference in months
            int monthsDifference = (date2.Year - date1.Year) * 12 + date2.Month - date1.Month;

            // Check if the difference is more than 6 months
            return monthsDifference > 2;
        }
        #region XML
        private static string SetXMLTable(ref ArrayList xml)
        {
            StringBuilder strXML = new StringBuilder();
            try
            {
                if (xml.Count > 0)
                {
                    strXML.Append("<Table1>");
                    for (int iIndex = 0; iIndex < xml.Count; iIndex++)
                    {
                        strXML.Append("<c" + (iIndex + 1).ToString() + ">");
                        strXML.Append(parseXML(xml[iIndex]));
                        strXML.Append("</c" + (iIndex + 1).ToString() + ">");
                    }
                    strXML.Append("</Table1>");
                    xml = new ArrayList();
                }
            }
            catch (Exception)
            {

            }
            return strXML.ToString();
        }
        private static string parseXML(object strValue)
        {
            string retValue = string.Empty;
            retValue = strValue.ToString();
            try
            {
                if (retValue.Trim().Length > 0)
                {
                    retValue = retValue.Replace("&", "&amp;");
                    retValue = retValue.Replace("<", "&lt;");
                    retValue = retValue.Replace(">", "&gt;");
                    retValue = retValue.Replace("\"", "&quot;");
                    retValue = retValue.Replace("'", "&apos;");

                    retValue = retValue.Trim();
                }
            }
            catch (Exception)
            {

            }
            return retValue;
        }
        private string M_getXMLData()
        {
            StringBuilder sbDoctorSchedule = new StringBuilder();
            ArrayList alAdvancePayment = new ArrayList();
            this.dgvAdvancePayment.BeginEdit();
            for (int iRow = 0; iRow < dgvAdvancePayment.Rows.Count; iRow++)
            {
                //if (Convert.ToBoolean(this.dgvAdvancePayment.Rows[iRow].Cells["colCheck"].Value))
                //{
                //alDoctorSchedule.Add(Convert.ToString(vMasterRecordID));
                alAdvancePayment.Add(Convert.ToString(this.dgvAdvancePayment.Rows[iRow].Cells["Months"].Value));
                sbDoctorSchedule.Append(SetXMLTable(ref alAdvancePayment));
                //}
            }
            return sbDoctorSchedule.ToString();
        }
        #endregion
        private void M_Save()
        {
            try
            {
                ComputationModel dto = new ComputationModel();
                dto.ProjectId = Convert.ToInt32(ddlProject.SelectedValue);
                dto.InquiringClient = txtClient.Text;
                dto.ClientMobile = "";
                dto.ClientID = ClientId;
                dto.UnitId = Convert.ToInt32(ddlUnitNumber.SelectedValue);
                dto.UnitNo = ddlUnitNumber.Text;
                dto.StatDate = dtpStartDate.Text;
                dto.FinishDate = dtpFinishDate.Text;
                dto.Rental = Functions.ConvertStringToDecimal(txtRental.Text);
                //dto.SecAndMaintenance = txtSecAndMaintenance.Text == string.Empty ? 0 : decimal.Parse(txtSecAndMaintenance.Text);
                dto.TotalRent = Functions.ConvertStringToDecimal(txtRental.Text);
                //dto.SecDeposit = txtMonthsSecurityDeposit.Text == string.Empty ? 0 : decimal.Parse(txtMonthsSecurityDeposit.Text);
                dto.IsRenewal = chkIsRenewal.Checked;
                if (sIsFullPayment)
                {
                    dto.Total = Functions.ConvertStringToDecimal(txtTotal.Text);
                }
                else
                {
                    dto.Total = Functions.ConvertStringToDecimal(txtRental.Text);
                }

                dto.EncodedBy = Variables.UserID;
                dto.XML = M_getXMLData();
                dto.AdvancePaymentAmount = AdvancePaymentAmount;
                dto.IsFullPayment = sIsFullPayment;
                dto.Message_Code = ComputationContext.SaveComputationParking(dto);
                Functions.ShowLoadingBar("Processing...");
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
            catch (Exception ex)
            {
                Functions.LogError("M_Save()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_Save()", ex.ToString());
            }
        }
        private void frmComputation_Load(object sender, EventArgs e)
        {
            Functions.EventCapturefrmName(this);
            dtpStartDate.Text = DateTime.Now.ToString("MM/dd/yyyy");
            dtpFinishDate.Text = DateTime.Now.ToString("MM/dd/yyyy");
            txtRental.ReadOnly = true;
            txtTotal.ReadOnly = true;
            txtTotalPostDatedAmount.ReadOnly = true;

            dataTable = new DataTable();
            dataTable.Columns.Add("Months", typeof(string));
            dataTable.Columns.Add("Amount", typeof(string));

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
                /*if selected project is change refresh all*/
                ClearFields();

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
                //txtSecAndMaintenance.Text = string.Empty;
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
        private void btnNewComputation_Click(object sender, EventArgs e)
        {
          
            if (MessageBox.Show("Would you like to pay it as full?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
            {
                sIsFullPayment = true;
            }
            else
            {
                sIsFullPayment = false;
            }
            strFormMode = "NEW";

            if (sIsFullPayment)
            {
                radGroupBox4.Enabled = false;
            }
        }
        private void btnUndo_Click(object sender, EventArgs e)
        {
            strFormMode = "READ";
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

                            MessageBox.Show(ex.ToString(), "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
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
                    if (Convert.ToString(dgvList.CurrentRow.Cells["TypeOf"].Value) == "TYPE OF PARKING")
                    {
                        frmEditParkingComputation forms = new frmEditParkingComputation();
                        forms.Recid = Convert.ToInt32(dgvList.CurrentRow.Cells["RecId"].Value);
                        forms.Text = Convert.ToString(dgvList.CurrentRow.Cells["ProjectName"].Value) + " - " + " UNIT";
                        forms.ShowDialog();
                    }
                    else
                    {
                        frmEditUnitComputation forms = new frmEditUnitComputation();
                        forms.Recid = Convert.ToInt32(dgvList.CurrentRow.Cells["RecId"].Value);
                        forms.Text = Convert.ToString(dgvList.CurrentRow.Cells["ProjectName"].Value) + " - " + " UNIT";
                        forms.ShowDialog();
                    }
                    //if (forms.IsProceed)
                    //{
                    //    //M_GetUnitList();
                    //}
                }
                else if (this.dgvList.Columns[e.ColumnIndex].Name == "ColRemoved")
                {

                    if (MessageBox.Show("Are you sure you want to Delete this computation?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                    {
                        try
                        {
                            var result = ComputationContext.DeleteComputation(Convert.ToInt32(dgvList.CurrentRow.Cells["RecId"].Value), Convert.ToInt32(dgvList.CurrentRow.Cells["UnitId"].Value));
                            if (result.Equals("SUCCESS"))
                            {
                                MessageBox.Show("Reference has been deleted successfully !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                                M_GetComputationList();
                            }
                        }
                        catch (Exception ex)
                        {
                            Functions.LogError("Cell Click : ColRemoved", this.Text, ex.ToString(), DateTime.Now, this);
                            Functions.ErrorShow("Cell Click : ColRemoved", ex.ToString());
                        }

                    }
                }
                else if (this.dgvList.Columns[e.ColumnIndex].Name == "ColGenerate")
                {
                    if (MessageBox.Show("Are you sure you want to generate transaction to this Contract?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                    {
                        frmSelectClient forms = new frmSelectClient();
                        forms.contractId = Convert.ToInt32(dgvList.CurrentRow.Cells["RecId"].Value);
                        forms.ShowDialog();
                        M_GetComputationList();
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
            if (IsComputationValidForCompute())
            {
                IsComputed = true;
                seq = 0;
                txtTotalPostDatedAmount.Text = string.Empty;
                M_GetPostDatedCountMonth();
                var TotalPostDatedAmount = (dgvpostdatedcheck.Rows.Count() < 0) ? 0 : (Convert.ToDecimal(dgvpostdatedcheck.Rows.Count().ToString()) * ((txtRental.Text == "") ? 0 : Convert.ToDecimal(txtRental.Text)));
                txtTotalPostDatedAmount.Text = TotalPostDatedAmount.ToString();
                M_GetTotalRental();
                txtRental.Focus();
            }
        }
        private void txtTotalPostDatedAmount_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }
        private void txtTotal_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }

        private void btnAddAdvancePayment_Click(object sender, EventArgs e)
        {
            string selectedDate = string.Empty;

            if (IsComputationValidForAdvancePayment())
            {
                frmPostDatedCheckMonthsList PostDatedCheckMonthsList = new frmPostDatedCheckMonthsList(dtpStartDate.Text, dtpFinishDate.Text, M_getXMLData());
                PostDatedCheckMonthsList.ShowDialog();
                if (PostDatedCheckMonthsList.isProceed)
                {
                    selectedDate = Convert.ToDateTime(PostDatedCheckMonthsList.SelectedDate).ToString("MM/dd/yyyy");
                }
                if (string.IsNullOrEmpty(selectedDate))
                {
                    return;
                }
                if (IsDuplicate(selectedDate))
                {
                    MessageBox.Show("Date already exists. Please select another Date.", "Validation Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }

                dataTable.Rows.Add(selectedDate.ToString(), txtRental.Text);
                dgvAdvancePayment.DataSource = dataTable;
                M_GetTotalRental();
                txtTotalPostDatedAmount.Text = string.Empty;

                M_GetPostDatedCountMonth();
                var TotalPostDatedAmount = (dgvpostdatedcheck.Rows.Count() < 0) ? 0 : (Convert.ToDecimal(dgvpostdatedcheck.Rows.Count().ToString()) * ((txtRental.Text == "") ? 0 : Convert.ToDecimal(txtRental.Text)));
                txtTotalPostDatedAmount.Text = TotalPostDatedAmount.ToString();
                IsComputed = true;
                txtTotal.Focus();
            }
        }

        private void btnRemovedAdvancePayment_Click(object sender, EventArgs e)
        {
            if (dgvAdvancePayment.SelectedRows.Count > 0)
            {
                dgvAdvancePayment.Rows.Remove(dgvAdvancePayment.SelectedRows[0]);
                M_GetTotalRental();
                txtTotalPostDatedAmount.Text = string.Empty;
                M_GetPostDatedCountMonth();
                var TotalPostDatedAmount = (dgvpostdatedcheck.Rows.Count() < 0) ? 0 : (Convert.ToDecimal(dgvpostdatedcheck.Rows.Count().ToString()) * ((txtRental.Text == "") ? 0 : Convert.ToDecimal(txtRental.Text)));
                txtTotalPostDatedAmount.Text = TotalPostDatedAmount.ToString();
            }
            else
            {
                MessageBox.Show("Please select a row to remove.");
            }
        }

        private void chkIsRenewal_ToggleStateChanged(object sender, Telerik.WinControls.UI.StateChangedEventArgs args)
        {
            if (chkIsRenewal.Checked)
            {
                //txtSecurityPaymentMonthCount.Text = "0";
                //txtSecurityPaymentMonthCount.Enabled = false;
                //txtMonthsSecurityDeposit.Text = "0";
                //txtMonthsSecurityDeposit.ReadOnly = false;
                this.lblContractState.Text = "<<<---RENEWAL CONTRACT--->>>";
                this.lblContractState.ForeColor = Color.DarkSlateBlue;
            }
            else
            {
                //txtSecurityPaymentMonthCount.Text = "0";
                //txtSecurityPaymentMonthCount.Enabled = true;
                //txtMonthsSecurityDeposit.Text = "0";
                //txtMonthsSecurityDeposit.ReadOnly = true;
                this.lblContractState.Text = "<<<---NEW CONTRACT--->>>";
                this.lblContractState.ForeColor = Color.Green;
            }
        }
    }
}
