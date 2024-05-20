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
    public partial class frmEditParkingComputation : Form
    {

        RateSettingsContext RateSettingsContext = new RateSettingsContext();
        ProjectContext ProjectContext = new ProjectContext();
        UnitContext UnitContext = new UnitContext();
        ComputationContext ComputationContext = new ComputationContext();

        public int Recid { get; set; }
        public bool IsProceed = false;
        public frmEditParkingComputation()
        {
            InitializeComponent();
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
                    case "EDIT":
                        btnUndo.Enabled = true;
                        //btnSave.Enabled = true;
                        btnEdit.Enabled = false;                 
                        EnableFields();

                        break;
                    case "READ":
                        btnUndo.Enabled = false;
                        //btnSave.Enabled = false;
                        btnEdit.Enabled = true;

                       
                        //ddlUnitNumber.SelectedIndex = 0;
                        DisableFields();
                        break;

                    default:
                        break;
                }
            }
        }

       
        private void ClearFields()
        {
            txtProjectAddress.Text = string.Empty;
            txtProjectType.Text = string.Empty;
            txtClient.Text = string.Empty;
            txtContactNumber.Text = string.Empty;
            txtFloorType.Text = string.Empty;
            txtRental.Text = string.Empty;
            //txtSecAndMaintenance.Text = string.Empty;
            txtTotalRental.Text = string.Empty;
            //txtMonthsAdvance1.Text = string.Empty;
            //txtMonthsAdvance2.Text = string.Empty;
            //txtMonthsSecurityDeposit.Text = string.Empty;
            //txtTotal.Text = string.Empty;
        }

        private void EnableFields()
        {
            txtProjectAddress.Enabled = true;
            txtProjectType.Enabled = true;
            txtClient.Enabled = true;
            txtContactNumber.Enabled = true;
            txtFloorType.Enabled = true;
            txtRental.Enabled = true;
            //txtSecAndMaintenance.Enabled = true;
            //txtTotalRental.Enabled = true;
            //txtMonthsAdvance1.Enabled = true;
            //txtMonthsAdvance2.Enabled = true;
            //txtMonthsSecurityDeposit.Enabled = true;
            //txtTotal.Enabled = true;
            txtProjectName.Enabled = true;
            txtUnitNumber.Enabled = true;
            dtpTransactionDate.Enabled = true;
            dtpStartDate.Enabled = true;
            dtpFinishDate.Enabled = true;
            //dtpApplicableFrom.Enabled = true;
            //dtpApplicableTo.Enabled = true;
            txtReferenceId.Enabled = true;
                   
        }

        private void DisableFields()
        {
            txtProjectAddress.Enabled = false;
            txtProjectType.Enabled = false;
            txtClient.Enabled = false;
            txtContactNumber.Enabled = false;
            txtFloorType.Enabled = false;
            txtRental.Enabled = false;
            //txtSecAndMaintenance.Enabled = false;
            txtTotalRental.Enabled = false;
            //txtMonthsAdvance1.Enabled = false;
            //txtMonthsAdvance2.Enabled = false;
            //txtMonthsSecurityDeposit.Enabled = false;
            //txtTotal.Enabled = false;
            dtpTransactionDate.Enabled = false;
            dtpStartDate.Enabled = false;
            dtpFinishDate.Enabled = false;
            //dtpApplicableFrom.Enabled = false;
            //dtpApplicableTo.Enabled = false;

            txtProjectName.Enabled = false;
            txtUnitNumber.Enabled = false;
            txtReferenceId.Enabled = false;

        }
        private void M_GetRateSettings()
        {
            
            lblVat.Text = string.Empty;
            try
            {
                using (DataSet dt = RateSettingsContext.GetRateSettingsByType(txtProjectType.Text))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        //txtGenVat.Text = Convert.ToString(dt.Tables[0].Rows[0]["GenVat"]);
                        //txtSecAndMaintenance.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecurityAndMaintenance"]);
                        //chkIsWithVat.Checked = Convert.ToBoolean(dt.Tables[0].Rows[0]["IsSecAndMaintVat"]);
                        //txtSecAndMaintenanceVat.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecurityAndMaintenanceVat"]);
                        lblVat.Text = Convert.ToString(dt.Tables[0].Rows[0]["labelVat"]);
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogErrorIntoStoredProcedure("M_GetRateSettings()", this.Text, ex.Message, DateTime.Now, this);

                Functions.MessageShow("An error occurred : (" + ex.ToString() + ") Please check the [ErrorLog] ");
            }


        }

        private void M_GetComputationById()
        {
            try
            {
                using (DataSet dt = ComputationContext.GetContractById(Recid))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        txtReferenceId.Text = Convert.ToString(dt.Tables[0].Rows[0]["RefId"]);
                        //ddlProject.SelectedValue = Convert.ToInt32(dt.Tables[0].Rows[0]["ProjectId"]);
                        txtProjectName.Text = Convert.ToString(dt.Tables[0].Rows[0]["ProjectName"]);
                        txtProjectType.Text = Convert.ToString(dt.Tables[0].Rows[0]["ProjectType"]);
                        txtProjectAddress.Text = Convert.ToString(dt.Tables[0].Rows[0]["ProjectAddress"]);
                        dtpTransactionDate.Text = Convert.ToString(dt.Tables[0].Rows[0]["TransactionDate"]);
                        txtClient.Text = Convert.ToString(dt.Tables[0].Rows[0]["InquiringClient"]);
                        txtContactNumber.Text = Convert.ToString(dt.Tables[0].Rows[0]["ClientMobile"]);
                        txtUnitNumber.Text = Convert.ToString(dt.Tables[0].Rows[0]["UnitNo"]);
                        txtFloorType.Text = Convert.ToString(dt.Tables[0].Rows[0]["FloorType"]);
                        dtpStartDate.Text = Convert.ToString(dt.Tables[0].Rows[0]["StatDate"]);
                        dtpFinishDate.Text = Convert.ToString(dt.Tables[0].Rows[0]["FinishDate"]);
                        //dtpApplicableFrom.Text = Convert.ToString(dt.Tables[0].Rows[0]["Applicabledate1"]);
                        //dtpApplicableTo.Text = Convert.ToString(dt.Tables[0].Rows[0]["Applicabledate2"]);
                        txtRental.Text = Convert.ToString(dt.Tables[0].Rows[0]["Rental"]);
                        //txtSecAndMaintenance.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecAndMaintenance"]);
                        txtTotalRental.Text = Convert.ToString(dt.Tables[0].Rows[0]["TotalRent"]);
                        //txtMonthsAdvance1.Text = Convert.ToString(dt.Tables[0].Rows[0]["Advancemonths1"]);
                        //txtMonthsAdvance2.Text = Convert.ToString(dt.Tables[0].Rows[0]["Advancemonths2"]);
                        //txtMonthsSecurityDeposit.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecDeposit"]);
                        //txtTotal.Text = Convert.ToString(dt.Tables[0].Rows[0]["Total"]);
                        dtpLastPaymentDate.Visible = false;
                        txtPaymentStatus.Text = Convert.ToString(dt.Tables[0].Rows[0]["PaymentStatus"]);
                        dtpLastPaymentDate.Visible = string.IsNullOrEmpty(txtPaymentStatus.Text) ? false : true;
                        dtpLastPaymentDate.Text = Convert.ToString(dt.Tables[0].Rows[0]["LastPaymentDate"]);

                        dtpContractSignedDate.Visible = false;
                        txtContractSignStatus.Text = Convert.ToString(dt.Tables[0].Rows[0]["ContractSignStatus"]);
                        dtpContractSignedDate.Visible = string.IsNullOrEmpty(txtContractSignStatus.Text) ? false : true;
                        dtpContractSignedDate.Text = Convert.ToString(dt.Tables[0].Rows[0]["ContractSignedDate"]);

                        dtpMoveInDate.Visible = false;
                        txtMoveinStatus.Text = Convert.ToString(dt.Tables[0].Rows[0]["MoveinStatus"]);
                        dtpMoveInDate.Visible = string.IsNullOrEmpty(txtMoveinStatus.Text) ? false : true;
                        dtpMoveInDate.Text = Convert.ToString(dt.Tables[0].Rows[0]["MoveInDate"]);

                        dtpMoveOutDate.Visible = false;
                        txtMoveOutStatus.Text = Convert.ToString(dt.Tables[0].Rows[0]["MoveOutStatus"]);
                        dtpMoveOutDate.Visible = string.IsNullOrEmpty(txtMoveOutStatus.Text) ? false : true;
                        dtpMoveOutDate.Text = Convert.ToString(dt.Tables[0].Rows[0]["MoveOutDate"]);

                        dtpTerminationDate.Visible = false;
                        txtTerminationStatus.Text = Convert.ToString(dt.Tables[0].Rows[0]["TerminationStatus"]);
                        dtpTerminationDate.Visible = string.IsNullOrEmpty(txtTerminationStatus.Text) ? false : true;
                        dtpTerminationDate.Text = Convert.ToString(dt.Tables[0].Rows[0]["TerminationDate"]);

                        dtpContractCloseDate.Visible = false;
                        txtContractStatus.Text = Convert.ToString(dt.Tables[0].Rows[0]["ContractStatus"]);
                        dtpContractCloseDate.Visible = txtContractStatus.Text == "CLOSED" ? true : false;
                        dtpContractCloseDate.Text = Convert.ToString(dt.Tables[0].Rows[0]["ContractCloseDate"]);

                        txtPaymentStatus.Text = Convert.ToString(dt.Tables[0].Rows[0]["TerminationStatus"]) == "YES" ? "TERMINATION" : Convert.ToString(dt.Tables[0].Rows[0]["PaymentStatus"]);
                    }
                }

            }
            catch (Exception ex)
            {
                Functions.LogErrorIntoStoredProcedure("M_GetComputationById()", this.Text, ex.Message, DateTime.Now, this);

                Functions.MessageShow("An error occurred : (" + ex.ToString() + ") Please check the [ErrorLog] ");
            }
           
        }

        private void frmEditUnitComputation_Load(object sender, EventArgs e)
        {
            strFormMode = "READ";
            txtProjectType.ReadOnly = true;
            txtFloorType.ReadOnly = true;
            //M_SelectProject();
            M_GetComputationById();
        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            strFormMode = "EDIT";
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
        }

        private void btnUndo_Click(object sender, EventArgs e)
        {
            strFormMode = "READ";
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
    }
}
