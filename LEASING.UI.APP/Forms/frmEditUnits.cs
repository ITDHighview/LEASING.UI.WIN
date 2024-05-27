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
    public partial class frmEditUnits : Form
    {
        ProjectContext ProjectContext = new ProjectContext();
        FloorTypeContext FloorTypeContext = new FloorTypeContext();
        UnitContext UnitContext = new UnitContext();
        RateSettingsContext RateSettingsContext = new RateSettingsContext();
        public int Recid { get; set; }
        public bool IsProceed = false;
        public bool isResidential = false;
        public bool isWarehouse = false;
        public bool isCommercial = false;

        private string _secAndMainVatPercentage { get; set; }
        private string _secAndMainAmount { get; set; }
        int vWithHoldingTax = 0;
        decimal WithHoldingTaxParam = 0;
        public frmEditUnits()
        {
            InitializeComponent();
        }
        private string _strUnitFormMode;
        public string strUnitFormMode
        {
            get
            {
                return _strUnitFormMode;
            }
            set
            {
                _strUnitFormMode = value;
                switch (_strUnitFormMode)
                {
                    case "EDIT":
                        btnUndo.Enabled = true;
                        btnSave.Enabled = true;
                        btnEdit.Enabled = false;
                        EnableFields();
                        this.M_GetProjectTypeById();
                        this.GetUnitStates();
                        break;
                    case "READ":
                        btnUndo.Enabled = false;
                        btnSave.Enabled = false;
                        btnEdit.Enabled = true;
                        DisEnableFields();
                        M_GetUnitStatus();
                        M_SelectProject();
                        M_SelectFloortypes();
                        M_GetUnitById();
                        break;

                    default:
                        break;
                }
            }
        }
        public class UnitStatus
        {
            public string UnitStatusName { get; set; }
        }
        List<UnitStatus> UnitStatusList = new List<UnitStatus>()
        {
            //new UnitStatus { UnitStatusName = "--SELECT--"},
            new UnitStatus { UnitStatusName = "VACANT"},
            new UnitStatus { UnitStatusName = "DISABLED"},
            //new UnitStatus { UnitStatusName = "OCCUPIED"},
             new UnitStatus { UnitStatusName = "HOLD"}
        };

        private void GetUnitStates()
        {
            if (chkIsParking.CheckState == CheckState.Checked)
            {
                txtSecAndMainVatPercentage.Text = string.Empty;
                txtSecAndMainAmount.Text = string.Empty;
                txtSecAndMainVatAmount.Text = string.Empty;
                txtSecAndMainWithVatAmount.Text = string.Empty;

                txtTotalRental.Text = string.Empty;
                M_GetBaseRentalVatAmount();
                M_GetBaseRentalWithVatAmount();
            }
            else
            {
                if (isResidential)
                {
                    M_GetResendentialRateSettings();

                    M_GetSecAndMainVatAMount();
                    M_GetSecAndMainWithVatAMount();
                    M_GetBaseRentalVatAmount();
                    M_GetBaseRentalWithVatAmount();

                }
                else if (isCommercial)
                {
                    M_GetCOMMERCIALateSettings();

                    M_GetSecAndMainVatAMount();
                    M_GetSecAndMainWithVatAMount();
                    M_GetBaseRentalVatAmount();
                    M_GetBaseRentalWithVatAmount();


                }
                else if (isWarehouse)
                {
                    M_GetWAREHOUSERateSettings();

                    M_GetSecAndMainVatAMount();
                    M_GetSecAndMainWithVatAMount();
                    M_GetBaseRentalVatAmount();
                    M_GetBaseRentalWithVatAmount();


                }
            }
        }
        private void M_GetSecAndMainVatAMount()
        {
            var AMount = (Functions.ConvertStringToDecimal(txtSecAndMainAmount.Text) * Functions.ConvertStringToDecimal(txtSecAndMainVatPercentage.Text) / 100);
            txtSecAndMainVatAmount.Text = AMount.ToString("0.00");
        }
        private void M_GetSecAndMainWithVatAMount()
        {
            var AMount = (Functions.ConvertStringToDecimal(txtSecAndMainAmount.Text) + Functions.ConvertStringToDecimal(txtSecAndMainVatAmount.Text));
            txtSecAndMainWithVatAmount.Text = AMount.ToString("0.00");
            if (!chkIsParking.Checked)
            {
                this.TotalRentalUnit();
            }
            else
            {
                this.TotalRentalParking();
            }
        }
        private void M_GetUnitStatus()
        {

            ddlUnitStatList.DataSource = null;
            if (UnitStatusList.Count() > 0)
            {
                ddlUnitStatList.DisplayMember = "UnitStatusName";
                ddlUnitStatList.ValueMember = "UnitStatusName";
                ddlUnitStatList.DataSource = UnitStatusList;
            }
        }
        private void M_GetUnitById()
        {
            vWithHoldingTax = 0;
            lblBaseRentalTax.Text = "TAX  : 0%";
            try
            {
                using (DataSet dt = UnitContext.GetUnitById(Recid))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        ddlProject.SelectedValue = Convert.ToInt32(dt.Tables[0].Rows[0]["ProjectId"]);
                        txtType.Text = Convert.ToString(dt.Tables[0].Rows[0]["ProjectType"]);
                        txtDetailsOfProperty.Text = Convert.ToString(dt.Tables[0].Rows[0]["DetailsofProperty"]);
                        ddlFloorType.SelectedText = Convert.ToString(dt.Tables[0].Rows[0]["FloorType"]);
                        txtUnitNumber.Text = Convert.ToString(dt.Tables[0].Rows[0]["UnitNo"]);
                        txtFloorNumber.Text = Convert.ToString(dt.Tables[0].Rows[0]["FloorNo"]);
                        txtUnitSequence.Text = Convert.ToString(dt.Tables[0].Rows[0]["UnitSequence"]);
                        txtAreSql.Text = Convert.ToString(dt.Tables[0].Rows[0]["AreaSqm"]);
                        txtAreRateSqm.Text = Convert.ToString(dt.Tables[0].Rows[0]["AreaRateSqm"]);
                        txtAreaTotalAmount.Text = Convert.ToString(dt.Tables[0].Rows[0]["AreaTotalAmount"]);
                        chkIsParking.Checked = Convert.ToBoolean(dt.Tables[0].Rows[0]["IsParking"]);
                        txtBaseRentalVatPercentage.Text = Convert.ToString(dt.Tables[0].Rows[0]["Vat"]);
                        this._secAndMainVatPercentage = Convert.ToString(dt.Tables[0].Rows[0]["Vat"]);
                        txtBaseRental.Text = Convert.ToString(dt.Tables[0].Rows[0]["BaseRental"]);
                        txtBaseRentalVatAmount.Text = Convert.ToString(dt.Tables[0].Rows[0]["BaseRentalVatAmount"]);
                        txtBaseRentalWithVatAmount.Text = Convert.ToString(dt.Tables[0].Rows[0]["BaseRentalWithVatAmount"]);
                        vWithHoldingTax = Convert.ToInt32(dt.Tables[0].Rows[0]["Tax"]);
                        WithHoldingTaxParam = vWithHoldingTax;
                        lblBaseRentalTax.Text = "TAX  : " + Convert.ToString(vWithHoldingTax) + "%";
                        txtBaseRentalTax.Text = Convert.ToString(dt.Tables[0].Rows[0]["TaxAmount"]);
                        chkNonVat.Checked = Convert.ToBoolean(dt.Tables[0].Rows[0]["IsNonVat"]);
                        txtSecAndMainVatPercentage.Text = Convert.ToString(dt.Tables[0].Rows[0]["Vat"]);
                        txtSecAndMainAmount.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecAndMainAmount"]);
                        this._secAndMainAmount = Convert.ToString(dt.Tables[0].Rows[0]["SecAndMainAmount"]);
                        txtSecAndMainVatAmount.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecAndMainVatAmount"]);
                        txtSecAndMainWithVatAmount.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecAndMainWithVatAmount"]);

                        var TotalMonthlyRental = Convert.ToString(dt.Tables[0].Rows[0]["TotalRental"]);
                        txtTotalRental.Text = TotalMonthlyRental.ToString();
                        if (Convert.ToString(dt.Tables[0].Rows[0]["UnitStatus"]) == "MOVE-IN" || Convert.ToString(dt.Tables[0].Rows[0]["UnitStatus"]) == "RESERVED")
                        {
                            ddlUnitStatList.SelectedText = Convert.ToString(dt.Tables[0].Rows[0]["UnitStatus"]);
                            ddlUnitStatList.Visible = false;
                            lblStat.Visible = false;
                        }
                        else
                        {
                            ddlUnitStatList.SelectedText = Convert.ToString(dt.Tables[0].Rows[0]["UnitStatus"]);
                            ddlUnitStatList.Visible = true;
                            lblStat.Visible = true;
                        }

                        //txtIsParking.Text = Convert.ToString(dt.Tables[0].Rows[0]["UnitDescription"]);

                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_GetUnitById()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_GetUnitById()", ex.ToString());
            }
        }
        private bool IsUnitValid()
        {
            if (ddlProject.SelectedText == "--SELECT--")
            {
                MessageBox.Show("Project  cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            if (isResidential)
            {
                if (ddlFloorType.SelectedText == "--SELECT--")
                {
                    MessageBox.Show("Floor Type cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                    return false;
                }
            }

            return true;
        }
        private void EnableFields()
        {

            //ddlProject.Enabled = true;
            //ddlUnitStatus.Enabled = true;



            ddlFloorType.Enabled = true;
            txtDetailsOfProperty.Enabled = true;
            //txtType.Enabled = true;
            txtUnitNumber.Enabled = true;
            txtFloorNumber.Enabled = true;

            txtBaseRental.Enabled = true;
            txtUnitSequence.Enabled = true;
            txtAreSql.Enabled = true;
            txtAreRateSqm.Enabled = true;
            //txtIsParking.Enabled = true;
            //dgvUnitList.Enabled = true;

            //chkIsParking.Enabled = true;
            chkNonVat.Enabled = true;
        }
        private void ClearFields()
        {

            ddlProject.SelectedIndex = 0;
            //ddlUnitStatus.SelectedIndex = 0;

            txtAreSql.Text = string.Empty;
            ddlFloorType.SelectedIndex = 0;
            txtDetailsOfProperty.Text = string.Empty;
            txtType.Text = string.Empty;
            txtUnitNumber.Text = string.Empty;
            txtFloorNumber.Text = string.Empty;
            txtAreRateSqm.Text = string.Empty;
            txtBaseRental.Text = string.Empty;
            txtUnitSequence.Text = string.Empty;
            //txtIsParking.Text = string.Empty;

        }
        private void DisEnableFields()
        {

            ddlProject.Enabled = false;
            //ddlUnitStatus.Enabled = false;

            txtAreSql.Enabled = false;
            ddlFloorType.Enabled = false;
            txtDetailsOfProperty.Enabled = false;
            txtType.Enabled = false;
            txtUnitNumber.Enabled = false;
            txtFloorNumber.Enabled = false;
            txtAreRateSqm.Enabled = false;
            txtBaseRental.Enabled = false;
            txtUnitSequence.Enabled = false;
            //txtIsParking.Enabled = false;
            //dgvUnitList.Enabled = false;

            txtAreaTotalAmount.Enabled = false;
            chkIsParking.Enabled = false;
            txtBaseRentalVatPercentage.Enabled = false;
            txtBaseRental.Enabled = false;
            txtBaseRentalVatAmount.Enabled = false;
            txtBaseRentalWithVatAmount.Enabled = false;
            txtBaseRentalTax.Enabled = false;
            chkNonVat.Enabled = false;
            txtSecAndMainVatPercentage.Enabled = false;
            txtSecAndMainAmount.Enabled = false;
            txtSecAndMainVatAmount.Enabled = false;
            txtSecAndMainWithVatAmount.Enabled = false;
            txtTotalRental.Enabled = false;
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
        private void M_SelectFloortypes()
        {
            try
            {
                ddlFloorType.DataSource = null;
                using (DataSet dt = FloorTypeContext.GetSelectFloortypes())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        ddlFloorType.DisplayMember = "FloorTypesDescription";
                        ddlFloorType.ValueMember = "RecId";
                        ddlFloorType.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_SelectFloortypes()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_SelectFloortypes()", ex.ToString());
            }
        }
        private void M_GetBaseRentalVatAmount()
        {
            var AMount = (Functions.ConvertStringToDecimal(txtBaseRental.Text) * (chkNonVat.Checked == true ? 0 : Functions.ConvertStringToDecimal(txtBaseRentalVatPercentage.Text)) / 100);
            txtBaseRentalVatAmount.Text = AMount.ToString("0.00");
        }
        private void M_GetBaseRentalWithVatAmount()
        {
            if (!chkIsParking.Checked)
            {
                //var AMount = (Functions.ConvertStringToDecimal(txtBaseRental.Text) + Functions.ConvertStringToDecimal(txtBaseRentalVatAmount.Text));
                txtBaseRentalWithVatAmount.Text = this.chkNonVat.Checked == true ? "0" : Convert.ToString(this.RentalNetOfVat());
                /*TAX*/
                M_GetBaseRentalTaxAMount();

                this.TotalRentalUnit();
            }
            else
            {
                //var AMount = (Functions.ConvertStringToDecimal(txtBaseRental.Text) + Functions.ConvertStringToDecimal(txtBaseRentalVatAmount.Text));
                txtBaseRentalWithVatAmount.Text = (this.chkNonVat.Checked == true ? "0" : Convert.ToString(this.RentalNetOfVat()));
                /*TAX*/
                M_GetBaseRentalTaxAMount();

                this.TotalRentalParking();
            }
        }
        private void TotalRentalUnit()
        {
            var tax = (Functions.ConvertStringToDecimal(txtBaseRentalTax.Text));
            var totalrental = ((this.chkNonVat.Checked == true ? Functions.ConvertStringToDecimal(txtBaseRental.Text) : Functions.ConvertStringToDecimal(txtBaseRentalWithVatAmount.Text)) + Functions.ConvertStringToDecimal(txtSecAndMainWithVatAmount.Text));
            var result = (totalrental - tax);
            if (Functions.ConvertStringToDecimal(txtBaseRental.Text) > 0)
            {
                txtTotalRental.Text = result.ToString("#,##0.00");
            }
            else
            {
                txtTotalRental.Text = "0.00";
            }
        }
        private void TotalRentalParking()
        {
            decimal tax = Functions.ConvertStringToDecimal(txtBaseRentalTax.Text);
            //var totalrental = Functions.ConvertStringToDecimal(txtBaseRentalWithVatAmount.Text);
            decimal totalrental = this.chkNonVat.Checked == true ? Functions.ConvertStringToDecimal(txtBaseRental.Text) : Functions.ConvertStringToDecimal(txtBaseRentalWithVatAmount.Text);
            decimal result = (totalrental - tax);
            if (Functions.ConvertStringToDecimal(txtBaseRental.Text) > 0)
            {
                txtTotalRental.Text = result.ToString("#,##0.00");
            }
            else
            {
                txtTotalRental.Text = "0.00";
            }
        }
        private void M_GetBaseRentalTaxAMount()
        {
            var amount = (Functions.ConvertStringToDecimal(txtBaseRental.Text) * (vWithHoldingTax) / 100);
            txtBaseRentalTax.Text = Convert.ToString(amount);
        }
        private decimal RentalNetOfVat()
        {
            return (Functions.ConvertStringToDecimal(txtBaseRental.Text) + Functions.ConvertStringToDecimal(txtBaseRentalVatAmount.Text));
        }
        private void M_GetCalculationAreaTotal()
        {
            var result = Math.Round(Functions.ConvertStringToDecimal(txtAreSql.Text) * Functions.ConvertStringToDecimal(txtAreRateSqm.Text));
            txtAreaTotalAmount.Text = Convert.ToString(result);
        }
        private void M_GetResendentialRateSettings()
        {
            txtBaseRentalVatPercentage.Text = string.Empty;
            txtSecAndMainVatPercentage.Text = string.Empty;
            txtSecAndMainAmount.Text = string.Empty;
            vWithHoldingTax = 0;
            lblBaseRentalTax.Text = "TAX  : 0%";
            try
            {
                using (DataSet dt = RateSettingsContext.GetRESIDENTIALSettings())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        txtBaseRentalVatPercentage.Text = Convert.ToString(dt.Tables[0].Rows[0]["GenVat"]);
                        txtSecAndMainVatPercentage.Text = String.Format("{0:0.00}", Convert.ToString(dt.Tables[0].Rows[0]["GenVat"]));
                        txtSecAndMainAmount.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecurityAndMaintenance"]);
                        lblBaseRentalTax.Text = "TAX  : " + Convert.ToString(vWithHoldingTax) + "%";
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_GetResendentialRateSettings()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_GetResendentialRateSettings()", ex.ToString());
            }
        }
        private void M_GetWAREHOUSERateSettings()
        {
            txtBaseRentalVatPercentage.Text = string.Empty;
            txtSecAndMainVatPercentage.Text = string.Empty;
            txtSecAndMainAmount.Text = string.Empty;
            vWithHoldingTax = 0;
            lblBaseRentalTax.Text = "TAX  : 0%";
            try
            {
                using (DataSet dt = RateSettingsContext.GetWAREHOUSESettings())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        txtBaseRentalVatPercentage.Text = Convert.ToString(dt.Tables[0].Rows[0]["GenVat"]);
                        txtSecAndMainVatPercentage.Text = String.Format("{0:0.00}", Convert.ToString(dt.Tables[0].Rows[0]["GenVat"]));
                        txtSecAndMainAmount.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecurityAndMaintenance"]);
                        vWithHoldingTax = Convert.ToInt32(dt.Tables[0].Rows[0]["WithHoldingTax"]);
                        WithHoldingTaxParam = vWithHoldingTax;
                        lblBaseRentalTax.Text = "TAX  : " + Convert.ToString(vWithHoldingTax) + "%";
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_GetWAREHOUSERateSettings()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_GetWAREHOUSERateSettings()", ex.ToString());
            }
        }
        private void M_GetCOMMERCIALateSettings()
        {
            txtBaseRentalVatPercentage.Text = string.Empty;
            txtSecAndMainVatPercentage.Text = string.Empty;
            txtSecAndMainAmount.Text = string.Empty;
            vWithHoldingTax = 0;
            lblBaseRentalTax.Text = "TAX  : 0%";
            try
            {
                using (DataSet dt = RateSettingsContext.GetCOMMERCIALSettings())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        txtBaseRentalVatPercentage.Text = Convert.ToString(dt.Tables[0].Rows[0]["GenVat"]);
                        txtSecAndMainVatPercentage.Text = String.Format("{0:0.00}", Convert.ToString(dt.Tables[0].Rows[0]["GenVat"]));
                        txtSecAndMainAmount.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecurityAndMaintenance"]);
                        vWithHoldingTax = Convert.ToInt32(dt.Tables[0].Rows[0]["WithHoldingTax"]);
                        WithHoldingTaxParam = vWithHoldingTax;
                        lblBaseRentalTax.Text = "TAX  : " + Convert.ToString(vWithHoldingTax) + "%";
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_GetCOMMERCIALateSettings()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_GetCOMMERCIALateSettings()", ex.ToString());
            }
        }
        private void M_GetProjectTypeById()
        {
            isResidential = false;
            isCommercial = false;
            isWarehouse = false;
            txtType.Text = string.Empty;
            try
            {
                using (DataSet dt = ProjectContext.GetProjectTypeById(Convert.ToInt32(ddlProject.SelectedValue)))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {

                        string Projecttype = Convert.ToString(dt.Tables[0].Rows[0]["ProjectType"]);
                        txtType.Text = Projecttype;
                        if (Projecttype == "RESIDENTIAL")
                        {
                            isResidential = true;
                            chkNonCusaMaintenance.Text = "Non Sec/Maintenance";
                            M_GetResendentialRateSettings();
                        }
                        else if (Projecttype == "COMMERCIAL")
                        {
                            isCommercial = true;
                            chkNonCusaMaintenance.Text = "Non Cusa";
                            M_GetCOMMERCIALateSettings();
                        }
                        else if (Projecttype == "WAREHOUSE")
                        {
                            isWarehouse = true;
                            chkNonCusaMaintenance.Text = "Non Cusa";
                            M_GetWAREHOUSERateSettings();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_GetProjectTypeById()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_GetProjectTypeById()", ex.ToString());
            }
        }
        private void frmEditUnits_Load(object sender, EventArgs e)
        {
            strUnitFormMode = "READ";
            this.Text = string.Empty;
            //lblUnitStatus.Visible = false;
            //ddlUnitStatus.Visible = false;

            //if (ddlUnitStatus.Text == "RESERVED")
            //{

            //    btnUndo.Visible = false;
            //    btnSave.Visible = false;
            //    btnEdit.Visible = false;
            //}
            //else
            //{
            //    btnUndo.Visible = true;
            //    btnSave.Visible = true;
            //    btnEdit.Visible = true;
            //}
            //this.Text = "UNIT # ( " + txtUnitNumber.Text + " )-" + ddlUnitStatus.Text;
        }
        private void btnEdit_Click(object sender, EventArgs e)
        {
            strUnitFormMode = "EDIT";
        }
        private string SelectFloorType()
        {
            if (this.ddlFloorType.Text == "--SELECT--")
            {
                return "NONE";
            }
            else
            {
                return this.ddlFloorType.Text;
            }
            return "";
        }
        private string SelectUnitStatus()
        {
            //if (this.ddlUnitStatus.Text == "--SELECT--")
            //{
            //    return "NONE";
            //}
            //else
            //{
            //    return this.ddlUnitStatus.Text;
            //}
            return "";
        }
        private void _toggleNonCusaMaintenance()
        {
            if (chkNonCusaMaintenance.Checked == true)
            {
                this.txtSecAndMainVatPercentage.Text = "0.00";
                this.txtSecAndMainAmount.Text = "0.00";
                this.txtSecAndMainVatAmount.Text = "0.00";
                this.txtSecAndMainWithVatAmount.Text = "0.00";
            }
            else
            {
                this.txtSecAndMainVatPercentage.Text = this._secAndMainVatPercentage;
                this.txtSecAndMainAmount.Text = this._secAndMainAmount;
                //this.txtSecAndMainVatAmount.Text = string.Empty;
                //this.txtSecAndMainWithVatAmount.Text = string.Empty;
            }

        }
        private void M_SaveUnit()
        {
            try
            {
                UnitModel UnitUpdate = new UnitModel();
                UnitUpdate.UnitId = Recid;
                UnitUpdate.ProjectId = Convert.ToInt32(this.ddlProject.SelectedValue);
                UnitUpdate.UnitNo = this.txtUnitNumber.Text;
                UnitUpdate.IsParking = this.chkIsParking.Checked;
                UnitUpdate.FloorNo = Functions.ConvertStringToInt(this.txtFloorNumber.Text);
                UnitUpdate.AreaSqm = Functions.ConvertStringToDecimal(this.txtAreSql.Text);
                UnitUpdate.AreaRateSqm = Functions.ConvertStringToDecimal(this.txtAreRateSqm.Text);
                UnitUpdate.AreaTotalAmount = Functions.ConvertStringToDecimal(this.txtAreaTotalAmount.Text);
                UnitUpdate.FloorType = this.SelectFloorType();
                UnitUpdate.BaseRental = Functions.ConvertStringToDecimal(this.txtBaseRental.Text);
                UnitUpdate.DetailsofProperty = this.txtDetailsOfProperty.Text;
                UnitUpdate.UnitSequence = Functions.ConvertStringToInt(this.txtUnitSequence.Text);
                UnitUpdate.BaseRentalVatAmount = Functions.ConvertStringToDecimal(this.txtBaseRentalVatAmount.Text);
                UnitUpdate.BaseRentalWithVatAmount = Functions.ConvertStringToDecimal(this.txtBaseRentalWithVatAmount.Text);
                UnitUpdate.BaseRentalTax = Functions.ConvertStringToDecimal(this.txtBaseRentalTax.Text);
                UnitUpdate.IsNonVat = this.chkNonVat.Checked;
                UnitUpdate.TotalRental = Functions.ConvertStringToDecimal(this.txtTotalRental.Text);
                UnitUpdate.SecAndMainAmount = Functions.ConvertStringToDecimal(this.txtSecAndMainAmount.Text);
                UnitUpdate.SecAndMainVatAmount = Functions.ConvertStringToDecimal(this.txtSecAndMainVatAmount.Text);
                UnitUpdate.SecAndMainWithVatAmount = Functions.ConvertStringToDecimal(this.txtSecAndMainWithVatAmount.Text);
                UnitUpdate.Vat = Functions.ConvertStringToDecimal(this.txtBaseRentalVatPercentage.Text);
                UnitUpdate.Tax = this.WithHoldingTaxParam;
                UnitUpdate.TaxAmount = Functions.ConvertStringToDecimal(this.txtBaseRentalTax.Text);
                UnitUpdate.UnitStatus = ddlUnitStatList.Text == "" ? "VACANT" : ddlUnitStatList.Text;
                UnitUpdate.Message_Code = UnitContext.EditUnit(UnitUpdate);
                if (UnitUpdate.Message_Code.Equals("SUCCESS"))
                {
                    Functions.MessageShow("Unit has been updated successfully !");
                    this.strUnitFormMode = "READ";
                    this.IsProceed = true;
                }
                else
                {
                    Functions.MessageShow(UnitUpdate.Message_Code);
                    this.strUnitFormMode = "READ";
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_SaveUnit()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_SaveUnit()", ex.ToString());
            }
        }
        private void btnSave_Click(object sender, EventArgs e)
        {
            if (this.strUnitFormMode == "EDIT")
            {
                if (this.Recid > 0)
                {
                    if (this.IsUnitValid())
                    {
                        if (MessageBox.Show("Are you sure you want to update the following Unit?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                        {
                            this.M_SaveUnit();
                        }
                    }
                }
            }
        }
        private void btnUndo_Click(object sender, EventArgs e)
        {
            strUnitFormMode = "READ";
        }
        //private void M_GetProjectTypeById()
        //{
        //    isResidential = false;
        //    txtType.Text = string.Empty;

        //    using (DataSet dt = ProjectContext.GetProjectTypeById(Convert.ToInt32(ddlProject.SelectedValue)))
        //    {
        //        if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
        //        {

        //            string Projecttype = Convert.ToString(dt.Tables[0].Rows[0]["ProjectType"]);
        //            txtType.Text = Convert.ToString(dt.Tables[0].Rows[0]["ProjectType"]);
        //            if (Projecttype == "RESIDENTIAL")
        //            {
        //                isResidential = true;
        //            }
        //        }
        //    }
        //}
        private void ddlProject_SelectedIndexChanged(object sender, Telerik.WinControls.UI.Data.PositionChangedEventArgs e)
        {
            //if (ddlProject.SelectedIndex > 0)
            //{
            //    M_GetProjectTypeById();
            //    if (isResidential)
            //    {
            //        ddlFloorType.Visible = true;
            //        lblFloorType.Visible = true;
            //        M_SelectFloortypes();
            //    }

            //    else
            //    {
            //        ddlFloorType.Visible = false;
            //        lblFloorType.Visible = false;
            //    }
            //}
            //else if (ddlProject.SelectedIndex == 0)
            //{
            //    ddlFloorType.Visible = false;
            //    lblFloorType.Visible = false;
            //    txtType.Text = string.Empty;
            //    ddlFloorType.SelectedIndex = 0;
            //    isResidential = false;
            //}
        }
        private void txtAreSql_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }
        private void txtFloorNumber_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9\b]"))
                e.Handled = true;
        }
        private void txtAreRateSqm_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }
        private void txtBaseRental_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }
        private void txtUnitSequence_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9\b]"))
                e.Handled = true;
        }
        private void btnPuchaseItemList_Click(object sender, EventArgs e)
        {

        }

        private void txtAreaTotalAmount_TextChanged(object sender, EventArgs e)
        {
            if (Functions.ConvertStringToDecimal(txtAreaTotalAmount.Text) > 0)
            {
                txtBaseRental.Text = txtAreaTotalAmount.Text;
            }
        }

        private void txtBaseRental_TextChanged(object sender, EventArgs e)
        {
            M_GetBaseRentalVatAmount();
            M_GetBaseRentalWithVatAmount();
        }

        private void txtAreRateSqm_TextChanged(object sender, EventArgs e)
        {
            M_GetCalculationAreaTotal();
        }

        private void txtAreSql_TextChanged(object sender, EventArgs e)
        {
            M_GetCalculationAreaTotal();
        }

        private void chkIsParking_ToggleStateChanged(object sender, Telerik.WinControls.UI.StateChangedEventArgs args)
        {
            //if (chkIsParking.CheckState == CheckState.Checked)
            //{
            //    txtSecAndMainVatPercentage.Text = string.Empty;
            //    txtSecAndMainAmount.Text = string.Empty;
            //    txtSecAndMainVatAmount.Text = string.Empty;
            //    txtSecAndMainWithVatAmount.Text = string.Empty;

            //    txtTotalRental.Text = string.Empty;
            //    M_GetBaseRentalVatAmount();
            //    M_GetBaseRentalWithVatAmount();
            //}
            //else
            //{
            //    if (isResidential)
            //    {
            //        M_GetResendentialRateSettings();

            //        M_GetSecAndMainVatAMount();
            //        M_GetSecAndMainWithVatAMount();
            //        M_GetBaseRentalVatAmount();
            //        M_GetBaseRentalWithVatAmount();

            //    }
            //    else if (isCommercial)
            //    {
            //        M_GetCOMMERCIALateSettings();

            //        M_GetSecAndMainVatAMount();
            //        M_GetSecAndMainWithVatAMount();
            //        M_GetBaseRentalVatAmount();
            //        M_GetBaseRentalWithVatAmount();


            //    }
            //    else if (isWarehouse)
            //    {
            //        M_GetWAREHOUSERateSettings();

            //        M_GetSecAndMainVatAMount();
            //        M_GetSecAndMainWithVatAMount();
            //        M_GetBaseRentalVatAmount();
            //        M_GetBaseRentalWithVatAmount();


            //    }
            //}
        }

        private void chkNonVat_ToggleStateChanged(object sender, Telerik.WinControls.UI.StateChangedEventArgs args)
        {
            M_GetBaseRentalVatAmount();
            M_GetBaseRentalWithVatAmount();
        }

        private void chkNonCusaMaintenance_ToggleStateChanged(object sender, Telerik.WinControls.UI.StateChangedEventArgs args)
        {
            this._toggleNonCusaMaintenance();
            this.M_GetSecAndMainVatAMount();
            this.M_GetSecAndMainWithVatAMount();
        }
    }
}
