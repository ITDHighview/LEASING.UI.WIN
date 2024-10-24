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
    public partial class ViewContractUnitInfo : Form
    {

        RateSettingsContext RateSettingsContext = new RateSettingsContext();
        ProjectContext ProjectContext = new ProjectContext();
        UnitContext UnitContext = new UnitContext();
        ComputationContext ComputationContext = new ComputationContext();

        public int Recid { get; set; }
        public bool IsProceed = false;
        public ViewContractUnitInfo()
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

        //private bool IsComputationValid()
        //{
        //    if (ddlProject.SelectedText == "--SELECT--")
        //    {
        //        MessageBox.Show("Project  cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
        //        return false;
        //    }

        //    //if (ddlFloorType.SelectedText == "--SELECT--")
        //    //{
        //    //    MessageBox.Show("Floor Type cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
        //    //    return false;
        //    //}


        //    return true;
        //}

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

            //txtMonthsSecurityDeposit.Text = string.Empty;
            txtTotal.Text = string.Empty;
            txtPaymentStatus.Text = string.Empty;
            txtContractSignStatus.Text = string.Empty;
            txtMoveinStatus.Text = string.Empty;
            txtMoveOutStatus.Text = string.Empty;
            txtTerminationStatus.Text = string.Empty;
            txtContractStatus.Text = string.Empty;

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

            //txtMonthsSecurityDeposit.Enabled = true;
            txtTotal.Enabled = true;
            txtProjectName.Enabled = true;
            txtUnitNumber.Enabled = true;
            dtpTransactionDate.Enabled = true;
            dtpStartDate.Enabled = true;
            dtpFinishDate.Enabled = true;

            txtReferenceId.Enabled = true;

            txtPaymentStatus.Enabled = true;
            dtpLastPaymentDate.Enabled = true;
            txtContractSignStatus.Enabled = true;
            dtpContractSignedDate.Enabled = true;
            txtMoveinStatus.Enabled = true;
            dtpMoveInDate.Enabled = true;
            txtMoveOutStatus.Enabled = true;
            dtpMoveOutDate.Enabled = true;
            txtTerminationStatus.Enabled = true;
            dtpTerminationDate.Enabled = true;
            txtContractStatus.Enabled = true;
            dtpContractCloseDate.Enabled = true;


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

            //txtMonthsSecurityDeposit.Enabled = false;
            txtTotal.Enabled = false;
            dtpTransactionDate.Enabled = false;
            dtpStartDate.Enabled = false;
            dtpFinishDate.Enabled = false;
            txtProjectName.Enabled = false;
            txtUnitNumber.Enabled = false;
            txtReferenceId.Enabled = false;

            txtPaymentStatus.Enabled = false;
            dtpLastPaymentDate.Enabled = false;
            txtContractSignStatus.Enabled = false;
            dtpContractSignedDate.Enabled = false;
            txtMoveinStatus.Enabled = false;
            dtpMoveInDate.Enabled = false;
            txtMoveOutStatus.Enabled = false;
            dtpMoveOutDate.Enabled = false;
            txtTerminationStatus.Enabled = false;
            dtpTerminationDate.Enabled = false;
            txtContractStatus.Enabled = false;
            dtpContractCloseDate.Enabled = false;

        }
        private void M_GetRateSettings()
        {
            txtSecAndMaintenance.Text = string.Empty;
            lblVat.Text = string.Empty;
            try
            {
                using (DataSet dt = RateSettingsContext.GetRateSettingsByType(txtProjectType.Text))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        //txtGenVat.Text = Convert.ToString(dt.Tables[0].Rows[0]["GenVat"]);
                        txtSecAndMaintenance.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecurityAndMaintenance"]);
                        lblVat.Text = Convert.ToString(dt.Tables[0].Rows[0]["labelVat"]);
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_GetRateSettings()", this.Text, ex.Message, DateTime.Now, this);

                Functions.MessageShow("An error occurred : (" + ex.ToString() + ") Please check the [ErrorLog] ");
            }


        }

        private void M_GetTotalRental()
        {
            //var rental = (txtRental.Text == "") ? 0 : (Convert.ToDecimal(txtRental.Text) + ((txtSecAndMaintenance.Text == "") ? 0 : Convert.ToDecimal(txtSecAndMaintenance.Text)));
            //txtTotalRental.Text = Convert.ToString(rental);           
            //var rental2 = (rental * 3);
            //txtMonthsSecurityDeposit.Text = Convert.ToString(rental2);
            //var rentalfinal = (txtMonthsAdvance1.Text == "") ? 0 : (Convert.ToDecimal(txtMonthsAdvance1.Text) + ((txtMonthsAdvance2.Text == "") ? 0 : Convert.ToDecimal(txtMonthsAdvance2.Text)));
            //txtTotal.Text = Convert.ToString(rentalfinal + rental2);
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

                        txtRental.Text = Convert.ToString(dt.Tables[0].Rows[0]["Rental"]);
                        txtSecAndMaintenance.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecAndMaintenance"]);
                        txtTotalRental.Text = Convert.ToString(dt.Tables[0].Rows[0]["TotalRent"]);

                        //txtMonthsSecurityDeposit.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecDeposit"]);
                        txtTotal.Text = Convert.ToString(dt.Tables[0].Rows[0]["Total"]);

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
                Functions.LogError("M_GetComputationById()", this.Text, ex.Message, DateTime.Now, this);

                Functions.MessageShow("An error occurred : (" + ex.ToString() + ") Please check the [ErrorLog] ");
            }

        }

        private void frmEditUnitComputation_Load(object sender, EventArgs e)
        {
            Functions.EventCapturefrmName(this);
            strFormMode = "READ";
            txtProjectType.ReadOnly = true;
            txtFloorType.ReadOnly = true;


            //radLabel20.Visible = false;
            //txtMonthsSecurityDeposit.Visible = false;
            radLabel21.Visible = false;
            txtTotal.Visible = false;
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

        //private void ddlProject_SelectedIndexChanged(object sender, Telerik.WinControls.UI.Data.PositionChangedEventArgs e)
        //{
        //    if (ddlProject.SelectedIndex >= 0)
        //    {
        //        M_GetProjecAddress();
        //        //M_SelectUnit();
        //        //M_GetUnitAvaibleById();
        //        M_GetRateSettings();
        //        M_GetTotalRental();


        //    }
        //    else
        //    {
        //        txtProjectAddress.Text = string.Empty;
        //        txtFloorType.Text = string.Empty;
        //        txtRental.Text = string.Empty;
        //        txtProjectType.Text = string.Empty;
        //        txtSecAndMaintenance.Text = string.Empty;
        //        txtUnitNumber.Text = string.Empty;

        //    }
        //}

        //private void ddlUnitNumber_SelectedIndexChanged(object sender, Telerik.WinControls.UI.Data.PositionChangedEventArgs e)
        //{
        //    if (ddlUnitNumber.SelectedIndex >= 0)
        //    {
        //        M_GetUnitAvaibleById();
        //        M_GetTotalRental();
        //    }
        //    else
        //    {
        //        txtFloorType.Text = string.Empty;
        //        txtRental.Text = string.Empty;
        //    }
        //}

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
