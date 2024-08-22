using LEASING.UI.APP.Common;
using LEASING.UI.APP.Context;
using LEASING.UI.APP.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows.Forms;
using Telerik.WinControls;
using Telerik.WinControls.UI;

namespace LEASING.UI.APP.Forms
{
    public partial class frmAddNewUnits : Form
    {
        private ProjectContext _project;
        private FloorTypeContext _floorType;
        private UnitContext _unit;
        private RateSettingsContext _rateSettings;
        public int ProjectRecId { get; set; } = 0;
        public frmAddNewUnits()
        {
            _project = new ProjectContext();
            _floorType = new FloorTypeContext();
            _unit = new UnitContext();
            _rateSettings = new RateSettingsContext();
            InitializeComponent();
        }

        enum ModeStatus
        {
            READ,
            NEW,
            NEWWithID
        }

        bool isResidential = false;
        bool isWarehouse = false;
        bool isCommercial = false;
        int vWithHoldingTax = 0;
        decimal WithHoldingTaxParam = 0;

        private string _FormMode;
        public string FormMode
        {
            get
            {
                return _FormMode;
            }
            set
            {
                _FormMode = value;
                switch (_FormMode)
                {
                    case "NEW":
                        btnUndo.Enabled = true;
                        btnSave.Enabled = true;
                        btnNew.Enabled = false;
                        EnableFields();
                        ClearFields();

                        break;
                    case "READ":
                        btnUndo.Enabled = false;
                        btnSave.Enabled = false;
                        btnNew.Enabled = true;
                        DisEnableFields();
                        txtType.Text = string.Empty;
                        ddlProject.SelectedIndex = 0;
                        ddlFloorType.SelectedIndex = 0;
                        ClearFields();
                        break;
                    case "NEWWithID":
                        btnUndo.Enabled = false;
                        btnSave.Enabled = true;
                        btnNew.Enabled = false;
                        //DisEnableFields();
                        ClearFieldsWithID();
                        break;
                    default:
                        break;
                }
            }
        }
        private class UnitStatus
        {
            public string UnitStatusName { get; set; }
        }

        List<UnitStatus> UnitStatusList = new List<UnitStatus>()
        {
            new UnitStatus { UnitStatusName = "--SELECT--"},
            new UnitStatus { UnitStatusName = "VACANT"},
            new UnitStatus { UnitStatusName = "RESERVED"},
            new UnitStatus { UnitStatusName = "OCCUPIED"},
             new UnitStatus { UnitStatusName = "NOT AVAILABLE"}
        };
        private string _secAndMainVatPercentage { get; set; }
        private string _secAndMainAmount { get; set; }
        private void M_GetResendentialRateSettings()
        {
            txtBaseRentalVatPercentage.Text = string.Empty;
            txtSecAndMainVatPercentage.Text = string.Empty;
            txtSecAndMainAmount.Text = string.Empty;
            vWithHoldingTax = 0;
            //lblSecAndMainTax.Text = "TAX  : 0%";
            lblBaseRentalTax.Text = "TAX  : 0%";

            try
            {
                using (DataSet dt = _rateSettings.GetRESIDENTIALSettings())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        txtBaseRentalVatPercentage.Text = Convert.ToString(dt.Tables[0].Rows[0]["GenVat"]);
                        txtSecAndMainVatPercentage.Text = String.Format("{0:0.00}", Convert.ToString(dt.Tables[0].Rows[0]["GenVat"]));
                        this._secAndMainVatPercentage = String.Format("{0:0.00}", Convert.ToString(dt.Tables[0].Rows[0]["GenVat"]));
                        txtSecAndMainAmount.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecurityAndMaintenance"]);
                        this._secAndMainAmount = Convert.ToString(dt.Tables[0].Rows[0]["SecurityAndMaintenance"]);
                        //lblSecAndMainTax.Text = "TAX  : " + Convert.ToString(vWithHoldingTax) + "%";
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
            //lblSecAndMainTax.Text = "TAX  : 0%";
            lblBaseRentalTax.Text = "TAX  : 0%";
            try
            {
                using (DataSet dt = _rateSettings.GetWAREHOUSESettings())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        txtBaseRentalVatPercentage.Text = Convert.ToString(dt.Tables[0].Rows[0]["GenVat"]);
                        txtSecAndMainVatPercentage.Text = String.Format("{0:0.00}", Convert.ToString(dt.Tables[0].Rows[0]["GenVat"]));
                        this._secAndMainVatPercentage = String.Format("{0:0.00}", Convert.ToString(dt.Tables[0].Rows[0]["GenVat"]));
                        txtSecAndMainAmount.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecurityAndMaintenance"]);
                        this._secAndMainAmount = Convert.ToString(dt.Tables[0].Rows[0]["SecurityAndMaintenance"]);
                        vWithHoldingTax = Convert.ToInt32(dt.Tables[0].Rows[0]["WithHoldingTax"]);
                        WithHoldingTaxParam = vWithHoldingTax;
                        //lblSecAndMainTax.Text = "TAX  : " + Convert.ToString(vWithHoldingTax) + "%";
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
            //lblSecAndMainTax.Text = "TAX  : 0%";
            lblBaseRentalTax.Text = "TAX  : 0%";
            try
            {
                using (DataSet dt = _rateSettings.GetCOMMERCIALSettings())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        txtBaseRentalVatPercentage.Text = Convert.ToString(dt.Tables[0].Rows[0]["GenVat"]);
                        txtSecAndMainVatPercentage.Text = String.Format("{0:0.00}", Convert.ToString(dt.Tables[0].Rows[0]["GenVat"]));
                        this._secAndMainVatPercentage = String.Format("{0:0.00}", Convert.ToString(dt.Tables[0].Rows[0]["GenVat"]));
                        txtSecAndMainAmount.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecurityAndMaintenance"]);
                        this._secAndMainAmount = Convert.ToString(dt.Tables[0].Rows[0]["SecurityAndMaintenance"]);
                        vWithHoldingTax = Convert.ToInt32(dt.Tables[0].Rows[0]["WithHoldingTax"]);
                        WithHoldingTaxParam = vWithHoldingTax;
                        //lblSecAndMainTax.Text = "TAX  : " +Convert.ToString(vWithHoldingTax) + "%";
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
        private void M_ForDisableOnlyFields()
        {
            txtAreaTotalAmount.Enabled = false;
            txtBaseRentalVatPercentage.Enabled = false;
            txtBaseRentalVatAmount.Enabled = false;
            txtBaseRentalWithVatAmount.Enabled = false;
            txtSecAndMainVatPercentage.Enabled = false;
            txtSecAndMainAmount.Enabled = false;
            txtSecAndMainVatAmount.Enabled = false;
            txtSecAndMainWithVatAmount.Enabled = false;
            txtBaseRentalTax.Enabled = false;
            //txtSecAndMainTax.Enabled = false;

        }
        private void M_GetUnitList()
        {
            try
            {
                dgvUnitList.DataSource = null;
                using (DataSet dt = _unit.GetUnitList())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        dgvUnitList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_GetUnitList()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_GetUnitList()", ex.ToString());
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
                if (chkIsParking.Checked != true)
                {
                    if (ddlFloorType.SelectedText == "--SELECT--")
                    {
                        MessageBox.Show("Floor Type cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                        return false;
                    }
                }
            }
            return true;
        }
        private void ClearFields()
        {
            ddlProject.SelectedIndex = 0;
            txtAreSql.Text = string.Empty;
            ddlFloorType.SelectedIndex = 0;
            txtDetailsOfProperty.Text = string.Empty;
            txtType.Text = string.Empty;
            txtUnitNumber.Text = string.Empty;
            txtFloorNumber.Text = string.Empty;
            txtAreRateSqm.Text = string.Empty;
            txtBaseRental.Text = string.Empty;
            txtUnitSequence.Text = string.Empty;
            chkIsParking.Checked = false;
            chkNonVat.Checked = false;
            chkNonTax.Checked = false;
            chkNonCusaMaintenance.Checked = false;
            txtTotalRental.Text = "0.00";
        }
        private void ClearFieldsWithID()
        {

            txtAreSql.Text = string.Empty;
            ddlFloorType.SelectedIndex = 0;
            txtDetailsOfProperty.Text = string.Empty;
            txtType.Text = string.Empty;
            txtUnitNumber.Text = string.Empty;
            txtFloorNumber.Text = string.Empty;
            txtAreRateSqm.Text = string.Empty;
            txtBaseRental.Text = string.Empty;
            txtUnitSequence.Text = string.Empty;
            chkIsParking.Checked = false;
            chkNonVat.Checked = false;
            chkNonTax.Checked = false;
            chkNonCusaMaintenance.Checked = false;
            txtTotalRental.Text = "0.00";
        }
        private void EnableFields()
        {
            ddlProject.Enabled = true;
            txtAreSql.Enabled = true;
            ddlFloorType.Enabled = true;
            txtDetailsOfProperty.Enabled = true;
            txtType.Enabled = true;
            txtUnitNumber.Enabled = true;
            txtFloorNumber.Enabled = true;
            txtAreRateSqm.Enabled = true;
            txtBaseRental.Enabled = true;
            txtUnitSequence.Enabled = true;
            chkIsParking.Enabled = true;
            chkNonVat.Enabled = true;
            chkNonTax.Enabled = true;
            chkNonCusaMaintenance.Enabled = true;
            btnOverrideSecAndMain.Enabled = true;
            txtTotalRental.Enabled = true;
            btnTotalMonthlyRoundNoOff.Enabled = true;
        }

        private void DisEnableFields()
        {
            ddlProject.Enabled = false;
            txtAreSql.Enabled = false;
            ddlFloorType.Enabled = false;
            txtDetailsOfProperty.Enabled = false;
            txtType.Enabled = false;
            txtUnitNumber.Enabled = false;
            txtFloorNumber.Enabled = false;
            txtAreRateSqm.Enabled = false;
            txtBaseRental.Enabled = false;
            txtUnitSequence.Enabled = false;
            chkIsParking.Enabled = false;
            chkNonVat.Enabled = false;
            chkNonTax.Enabled = false;
            chkNonCusaMaintenance.Enabled = false;
            btnOverrideSecAndMain.Enabled = false;
            txtTotalRental.Enabled = false;
            btnTotalMonthlyRoundNoOff.Enabled = false;

        }
        private void M_SelectProject()
        {
            try
            {
                ddlProject.DataSource = null;
                using (DataSet dt = _project.GetSelectProject())
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
                using (DataSet dt = _floorType.GetSelectFloortypes())
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
        private void M_GetProjectTypeById()
        {
            isResidential = false;
            isCommercial = false;
            isWarehouse = false;
            txtType.Text = string.Empty;
            try
            {
                using (DataSet dt = _project.GetProjectTypeById(this.ProjectRecId > 0 ? this.ProjectRecId : Convert.ToInt32(ddlProject.SelectedValue)))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {

                        string Projecttype = Convert.ToString(dt.Tables[0].Rows[0]["ProjectType"]);
                        txtType.Text = Projecttype;
                        if (Projecttype == "RESIDENTIAL")
                        {
                            isResidential = true;
                            chkNonCusaMaintenance.Text = "Non Sec/Maintenance";
                        }
                        else if (Projecttype == "COMMERCIAL")
                        {
                            isCommercial = true;
                            chkNonCusaMaintenance.Text = "Non Cusa";
                        }
                        else if (Projecttype == "WAREHOUSE")
                        {
                            isWarehouse = true;
                            chkNonCusaMaintenance.Text = "Non Cusa";
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
        private void M_GetCalculationAreaTotal()
        {
            var result = Math.Round(Functions.ConvertStringToDecimal(txtAreSql.Text) * Functions.ConvertStringToDecimal(txtAreRateSqm.Text));
            txtAreaTotalAmount.Text = result.ToString("#,##0.00");
        }
        private void M_GetBaseRentalVatAmount()
        {
            var result = (Functions.ConvertStringToDecimal(txtBaseRental.Text) * (chkNonVat.Checked == true ? 0 : Functions.ConvertStringToDecimal(txtBaseRentalVatPercentage.Text)) / 100);
            txtBaseRentalVatAmount.Text = result.ToString("#,##0.00");
        }
        private decimal RentalNetOfVat()
        {
            return (Functions.ConvertStringToDecimal(txtBaseRental.Text) + Functions.ConvertStringToDecimal(txtBaseRentalVatAmount.Text));
        }
        private decimal getUnitIsNotVatAmount(bool NonVat)
        {

            if (NonVat == true)
            {
                return Functions.ConvertStringToDecimal(txtBaseRental.Text);
            }
            else
            {
                return Functions.ConvertStringToDecimal(txtBaseRentalWithVatAmount.Text);
            }
            return 0;
        }
        private decimal getParkingIsNotVatAmount(bool NonVat)
        {

            if (NonVat == true)
            {
                return Functions.ConvertStringToDecimal(txtBaseRental.Text);
            }
            else
            {
                return Functions.ConvertStringToDecimal(txtBaseRentalWithVatAmount.Text);
            }
            return 0;
        }
        private decimal getTaxAmount(bool IsNonTax)
        {
            if (IsNonTax == true)
            {
                return 0;
            }
            else
            {
                return Functions.ConvertStringToDecimal(txtBaseRentalTax.Text);
            }
            return 0;
        }
        private void TotalRentalNoRoundOffUnit()
        {
            //var tax = (Functions.ConvertStringToDecimal(txtBaseRentalTax.Text));
            var tax = this.getTaxAmount(this.chkNonTax.Checked);
            var totalrental = (this.getUnitIsNotVatAmount(this.chkNonVat.Checked) + Functions.ConvertStringToDecimal(txtSecAndMainWithVatAmount.Text));
            //var totalrental = ((this.chkNonVat.Checked == true ? Functions.ConvertStringToDecimal(txtBaseRental.Text) : Functions.ConvertStringToDecimal(txtBaseRentalWithVatAmount.Text)) + Functions.ConvertStringToDecimal(txtSecAndMainWithVatAmount.Text));
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
        private void TotalRentalUnit()
        {
            var tax = this.getTaxAmount(this.chkNonTax.Checked);
            //var tax = (Functions.ConvertStringToDecimal(txtBaseRentalTax.Text));
            var totalrental = (this.getUnitIsNotVatAmount(this.chkNonVat.Checked) + Functions.ConvertStringToDecimal(txtSecAndMainWithVatAmount.Text));
            //var totalrental = ((this.chkNonVat.Checked == true ? Functions.ConvertStringToDecimal(txtBaseRental.Text) : Functions.ConvertStringToDecimal(txtBaseRentalWithVatAmount.Text)) + Functions.ConvertStringToDecimal(txtSecAndMainWithVatAmount.Text));
            var result = Math.Round(totalrental - tax);
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
            //decimal tax = Functions.ConvertStringToDecimal(txtBaseRentalTax.Text);
            var tax = this.getTaxAmount(this.chkNonTax.Checked);
            //var totalrental = Functions.ConvertStringToDecimal(txtBaseRentalWithVatAmount.Text);
            decimal totalrental = this.getParkingIsNotVatAmount(this.chkNonVat.Checked);
            //decimal totalrental = this.chkNonVat.Checked == true ? Functions.ConvertStringToDecimal(txtBaseRental.Text) : Functions.ConvertStringToDecimal(txtBaseRentalWithVatAmount.Text);
            decimal result = Math.Round(totalrental - tax);
            if (Functions.ConvertStringToDecimal(txtBaseRental.Text) > 0)
            {
                txtTotalRental.Text = result.ToString("#,##0.00");
            }
            else
            {
                txtTotalRental.Text = "0.00";
            }
        }
        private void TotalRentalNoRoundOffParking()
        {
            var tax = this.getTaxAmount(this.chkNonTax.Checked);
            //decimal tax = Functions.ConvertStringToDecimal(txtBaseRentalTax.Text);
            //var totalrental = Functions.ConvertStringToDecimal(txtBaseRentalWithVatAmount.Text);
            decimal totalrental = this.getParkingIsNotVatAmount(this.chkNonVat.Checked);
            //decimal totalrental = this.chkNonVat.Checked == true ? Functions.ConvertStringToDecimal(txtBaseRental.Text) : Functions.ConvertStringToDecimal(txtBaseRentalWithVatAmount.Text);
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
        private string getBaseRentalVatAmount(bool nonVat)
        {
            if (nonVat == true)
            {
                return "0.00";
            }
            else
            {
                return (this.RentalNetOfVat()).ToString("#,##0.00");
            }

            return "";
        }
        private void M_GetBaseRentalWithVatAmount()
        {
            if (!chkIsParking.Checked)
            {
                //var AMount = (Functions.ConvertStringToDecimal(txtBaseRental.Text) + Functions.ConvertStringToDecimal(txtBaseRentalVatAmount.Text));
                //txtBaseRentalWithVatAmount.Text = this.chkNonVat.Checked == true ? "0" : Convert.ToString(this.RentalNetOfVat());
                txtBaseRentalWithVatAmount.Text = this.getBaseRentalVatAmount(this.chkNonVat.Checked);
                /*TAX*/
                M_GetBaseRentalTaxAMount();

                this.TotalRentalUnit();
            }
            else
            {
                //var AMount = (Functions.ConvertStringToDecimal(txtBaseRental.Text) + Functions.ConvertStringToDecimal(txtBaseRentalVatAmount.Text));
                //txtBaseRentalWithVatAmount.Text = (this.chkNonVat.Checked == true ? "0" : Convert.ToString(this.RentalNetOfVat()));
                txtBaseRentalWithVatAmount.Text = this.getBaseRentalVatAmount(this.chkNonVat.Checked);
                /*TAX*/
                M_GetBaseRentalTaxAMount();

                this.TotalRentalParking();
            }
        }
        public decimal OverrideSecAndMainAmount { get; set; } = 0;
        private void _toggleNonCusaMaintenance()
        {

            if (chkNonCusaMaintenance.Checked == true)
            {
                if (this.IsOverrideSecAndMain == true)
                {
                    this.OverrideSecAndMainAmount = Functions.ConvertStringToDecimal(txtSecAndMainAmount.Text);
                }
                else
                {
                    this.OverrideSecAndMainAmount = 0;
                }
                this.txtSecAndMainVatPercentage.Text = "0.00";
                this.txtSecAndMainAmount.Text = "0.00";
                this.txtSecAndMainVatAmount.Text = "0.00";
                this.txtSecAndMainWithVatAmount.Text = "0.00";
                btnOverrideSecAndMain.Visible = false;
                txtSecAndMainAmount.Enabled = false;
            }
            else
            {
                this.txtSecAndMainVatPercentage.Text = this._secAndMainVatPercentage;
                if (this.IsOverrideSecAndMain == true)
                {
                    this.txtSecAndMainAmount.Text = this.OverrideSecAndMainAmount.ToString("#,##0.00");
                }
                else
                {
                    this.txtSecAndMainAmount.Text = this._secAndMainAmount;
                }
                btnOverrideSecAndMain.Visible = true;
                txtSecAndMainAmount.Enabled = this.IsOverrideSecAndMain;
                //this.txtSecAndMainVatAmount.Text = string.Empty;
                //this.txtSecAndMainWithVatAmount.Text = string.Empty;
            }

        }
        private void M_GetSecAndMainVatAMount()
        {

            var result = (Functions.ConvertStringToDecimal(txtSecAndMainAmount.Text) * Functions.ConvertStringToDecimal(txtSecAndMainVatPercentage.Text) / 100);
            txtSecAndMainVatAmount.Text = result.ToString("#,##0.00");
        }
        private void M_GetSecAndMainWithVatAMount()
        {
            var result = (Functions.ConvertStringToDecimal(txtSecAndMainAmount.Text) + Functions.ConvertStringToDecimal(txtSecAndMainVatAmount.Text));
            txtSecAndMainWithVatAmount.Text = result.ToString("#,##0.00");
            if (!chkIsParking.Checked)
            {
                this.TotalRentalUnit();
            }
            else
            {
                this.TotalRentalParking();
            }
        }
        private string getBaseRentalTax(bool NonTax, decimal taxAmount)
        {
            if (NonTax == true)
            {
                return "0.00";
            }
            else
            {
                return taxAmount.ToString("#,##0.00");
            }
            return "0.00";
        }
        private void M_GetBaseRentalTaxAMount()
        {
            var amount = (Functions.ConvertStringToDecimal(txtBaseRental.Text) * (vWithHoldingTax) / 100);
            txtBaseRentalTax.Text = this.getBaseRentalTax(this.chkNonTax.Checked, amount);
        }
        private void frmAddNewUnits_Load(object sender, EventArgs e)
        {
            Functions.EventCapturefrmName(this);

            if (ProjectRecId > 0)
            {
                this.FormMode = ModeStatus.NEWWithID.ToString();
                txtTotalRental.ReadOnly = true;
                ddlFloorType.Visible = false;
                lblFloorType.Visible = false;
                M_SelectProject();
                this.ddlProject.SelectedValue = ProjectRecId;
                ddlProject.Enabled = false;
                vWithHoldingTax = 0;
                txtBaseRentalTax.Text = string.Empty;
                M_GetProjectTypeById();
                ddlFloorType.Visible = true;
                lblFloorType.Visible = true;
                M_SelectFloortypes();
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
            else
            {
                this.FormMode = ModeStatus.READ.ToString();
                txtTotalRental.ReadOnly = true;
                ddlFloorType.Visible = false;
                lblFloorType.Visible = false;
                M_SelectProject();
                //ddlProject.Enabled = false;
            }

            M_GetUnitList();
            M_ForDisableOnlyFields();
            txtType.ReadOnly = true;
        }
        private void ddlProject_SelectedIndexChanged(object sender, Telerik.WinControls.UI.Data.PositionChangedEventArgs e)
        {
            if (ddlProject.SelectedIndex > 0)
            {
                vWithHoldingTax = 0;
                txtBaseRentalTax.Text = string.Empty;
                M_GetProjectTypeById();
                ddlFloorType.Visible = true;
                lblFloorType.Visible = true;
                M_SelectFloortypes();
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
            else if (ddlProject.SelectedIndex == 0)
            {
                ddlFloorType.Visible = false;
                lblFloorType.Visible = false;
                txtType.Text = string.Empty;
                ddlFloorType.SelectedIndex = 0;
                isResidential = false;
            }
        }
        private void txtFloorNumber_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9\b]"))
                e.Handled = true;
        }
        private void txtUnitSequence_KeyPress(object sender, KeyPressEventArgs e)
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
        private void txtAreSql_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }
        private void btnNew_Click(object sender, EventArgs e)
        {
            this.FormMode = ModeStatus.NEW.ToString();
        }
        private void btnUndo_Click(object sender, EventArgs e)
        {
            this.FormMode = ModeStatus.READ.ToString();
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
        private void M_SaveUnit()
        {
            try
            {
                UnitModel UnitNew = new UnitModel();
                UnitNew.ProjectId = this.ProjectRecId > 0 ? this.ProjectRecId : Convert.ToInt32(this.ddlProject.SelectedValue);
                UnitNew.UnitNo = this.txtUnitNumber.Text;
                UnitNew.IsParking = this.chkIsParking.Checked;
                UnitNew.FloorNo = Functions.ConvertStringToInt(this.txtFloorNumber.Text);
                UnitNew.AreaSqm = Functions.ConvertStringToDecimal(this.txtAreSql.Text);
                UnitNew.AreaRateSqm = Functions.ConvertStringToDecimal(this.txtAreRateSqm.Text);
                UnitNew.AreaTotalAmount = Functions.ConvertStringToDecimal(this.txtAreaTotalAmount.Text);
                UnitNew.FloorType = this.SelectFloorType();
                UnitNew.BaseRental = Functions.ConvertStringToDecimal(this.txtBaseRental.Text);
                UnitNew.DetailsofProperty = this.txtDetailsOfProperty.Text;
                UnitNew.UnitSequence = Functions.ConvertStringToInt(this.txtUnitSequence.Text);
                UnitNew.BaseRentalVatAmount = Functions.ConvertStringToDecimal(this.txtBaseRentalVatAmount.Text);
                UnitNew.BaseRentalWithVatAmount = Functions.ConvertStringToDecimal(this.txtBaseRentalWithVatAmount.Text);
                UnitNew.BaseRentalTax = Functions.ConvertStringToDecimal(this.txtBaseRentalTax.Text);
                UnitNew.IsNonVat = this.chkNonVat.Checked;
                UnitNew.IsNonTax = this.chkNonTax.Checked;
                UnitNew.IsNonCusa = this.chkNonCusaMaintenance.Checked;
                UnitNew.TotalRental = Functions.ConvertStringToDecimal(this.txtTotalRental.Text);
                UnitNew.SecAndMainAmount = Functions.ConvertStringToDecimal(this.txtSecAndMainAmount.Text);
                UnitNew.SecAndMainVatAmount = Functions.ConvertStringToDecimal(this.txtSecAndMainVatAmount.Text);
                UnitNew.SecAndMainWithVatAmount = Functions.ConvertStringToDecimal(this.txtSecAndMainWithVatAmount.Text);
                UnitNew.Vat = Functions.ConvertStringToDecimal(this.txtBaseRentalVatPercentage.Text);
                UnitNew.Tax = this.WithHoldingTaxParam;
                UnitNew.TaxAmount = Functions.ConvertStringToDecimal(this.txtBaseRentalTax.Text);
                UnitNew.IsNotRoundOff = this.IsNotRoundOff;
                UnitNew.IsOverrideSecAndMain = this.IsOverrideSecAndMain;
                UnitNew.Message_Code = _unit.SaveUnit(UnitNew);
                if (UnitNew.Message_Code.Equals("SUCCESS"))
                {
                    Functions.MessageShow("New Unit has been added successfully !");
                    this.FormMode = ModeStatus.READ.ToString();
                    this.M_GetUnitList();

                }
                else
                {
                    Functions.MessageShow(UnitNew.Message_Code);

                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_SaveUnit()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_SaveUnit()", ex.ToString());
            }
        }
        private string SavingQuestionLabel() => this.FormMode == ModeStatus.NEWWithID.ToString() ? "Are you sure you want to add this Unit to this Project ?" : "Are you sure you want to add this Unit ?";
        private void btnSave_Click(object sender, EventArgs e)
        {
            if (this.FormMode == ModeStatus.NEW.ToString() || this.FormMode == ModeStatus.NEWWithID.ToString())
            {
                if (this.IsUnitValid())
                {
                    if (MessageBox.Show(this.SavingQuestionLabel(), "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                    {
                        this.M_SaveUnit();
                    }
                }
            }
        }
        private void dgvUnitList_CellClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                if (this.dgvUnitList.Columns[e.ColumnIndex].Name == "ColEdit")
                {
                    frmEditUnits forms = new frmEditUnits();
                    forms.Recid = Convert.ToInt32(dgvUnitList.CurrentRow.Cells["RecId"].Value);
                    forms.isResidential = isResidential;
                    forms.ShowDialog();
                    if (forms.IsProceed)
                    {
                        M_GetUnitList();
                    }
                }
                //else if (this.dgvUnitList.Columns[e.ColumnIndex].Name == "ColDeactivate")
                //{
                //    if (Convert.ToString(this.dgvUnitList.Rows[e.RowIndex].Cells["UnitStat"].Value) == "VACANT")
                //    {
                //        if (MessageBox.Show("Are you sure you want to Deactivated the Unit?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                //        {


                //        }
                //    }
                //}
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
                if (e.CellElement.ColumnInfo is GridViewCommandColumn && !(e.CellElement.RowElement is GridTableHeaderRowElement))
                {
                    GridViewCommandColumn column = (GridViewCommandColumn)e.CellElement.ColumnInfo;
                    RadButtonElement element = (RadButtonElement)e.CellElement.Children[0];

                    (element.Children[2] as Telerik.WinControls.Primitives.BorderPrimitive).Visibility =
                    Telerik.WinControls.ElementVisibility.Collapsed;
                    element.DisplayStyle = DisplayStyle.Image;
                    element.ImageAlignment = ContentAlignment.MiddleCenter;
                    element.Enabled = true;
                    element.Alignment = ContentAlignment.MiddleCenter;
                    element.Visibility = ElementVisibility.Visible;

                    if (column.Name == "ColDeactivate")
                    {
                        if (Convert.ToString(this.dgvUnitList.Rows[e.RowIndex].Cells["UnitStat"].Value) != "VACANT")
                        {
                            //element.ImageAlignment = ContentAlignment.MiddleCenter;
                            //element.TextImageRelation = TextImageRelation.TextBeforeImage;
                            //element.Text = "Un-Map";
                            //element.Image = Properties.Resources.cancel16;
                            //element.ToolTipText = "This button is disabled";

                            element.Enabled = false;
                        }
                        //else
                        //{
                        //    element.ImageAlignment = ContentAlignment.MiddleCenter;
                        //    element.TextImageRelation = TextImageRelation.TextBeforeImage;
                        //    //element.Text = "Un-Map";
                        //    element.Image = Properties.Resources.ico_remove_item;
                        //    element.ToolTipText = "";
                        //    element.Enabled = false;
                        //}
                    }
                }
            }
        }
        private void btnPuchaseItemList_Click(object sender, EventArgs e)
        {

        }
        private void txtAreRateSqm_TextChanged(object sender, EventArgs e)
        {
            M_GetCalculationAreaTotal();
        }
        private void txtAreSql_TextChanged(object sender, EventArgs e)
        {
            M_GetCalculationAreaTotal();
        }

        private void txtBaseRental_TextChanged(object sender, EventArgs e)
        {// Remove any non-numeric characters except for decimal point
            //string input = txtBaseRental.Text.Replace(",", "").Replace(" ", "").Trim();
            //decimal value;
            //if (decimal.TryParse(input, NumberStyles.Any, CultureInfo.InvariantCulture, out value))
            //{
            //    // Format the number with commas and two decimal places
            //    txtBaseRental.TextChanged -= txtBaseRental_TextChanged; // Unsubscribe to avoid recursion
            //    txtBaseRental.Text = value.ToString("N2"); // Format with commas and two decimal places
            //    txtBaseRental.SelectionStart = txtBaseRental.Text.Length; // Set cursor to end
            //    txtBaseRental.TextChanged += txtBaseRental_TextChanged; // Resubscribe
            //}
            M_GetBaseRentalVatAmount();
            M_GetBaseRentalWithVatAmount();
        }
        private void txtAreTotal_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }
        private void txtBaseRentalVatPercentage_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }
        private void txtBaseRentalVatAmount_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }
        private void txtBaseRentalWithVatAmount_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }
        private void txtBaseRentalTax_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }
        private void txtSecAndMainVatPercentage_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }
        private void txtSecAndMainAmount_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }
        private void txtSecAndMainVatAmount_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }
        private void txtSecAndMainWithVatAmount_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }
        private void txtSecAndMainTax_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }
        private void txtTotalRental_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9.\b]"))
                e.Handled = true;
        }
        private void chkIsParking_ToggleStateChanged(object sender, Telerik.WinControls.UI.StateChangedEventArgs args)
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
        private void txtAreTotal_TextChanged(object sender, EventArgs e)
        {
            if (Functions.ConvertStringToDecimal(txtAreaTotalAmount.Text) > 0)
            {
                txtBaseRental.Text = txtAreaTotalAmount.Text;
            }
        }
        private void chkNonVat_ToggleStateChanged(object sender, StateChangedEventArgs args)
        {
            M_GetBaseRentalVatAmount();
            M_GetBaseRentalWithVatAmount();
        }
        private void chkNonCusaMaintenance_ToggleStateChanged(object sender, StateChangedEventArgs args)
        {
            this._toggleNonCusaMaintenance();
            this.M_GetSecAndMainVatAMount();
            this.M_GetSecAndMainWithVatAMount();
        }

        bool IsNotRoundOff = true;
        private void btnTotalMonthlyRoundNoOff_Click(object sender, EventArgs e)
        {
            IsNotRoundOff = !IsNotRoundOff;
            if (!chkIsParking.Checked)
            {
                if (IsNotRoundOff)
                {
                    TotalRentalUnit();
                }
                else
                {
                    TotalRentalNoRoundOffUnit();
                }
            }
            else
            {
                if (IsNotRoundOff)
                {
                    TotalRentalParking();
                }
                else
                {
                    TotalRentalNoRoundOffParking();
                }
            }
        }

        private void chkNonTax_ToggleStateChanged(object sender, StateChangedEventArgs args)
        {
            M_GetBaseRentalWithVatAmount();
        }

        public bool IsOverrideSecAndMain { get; set; } = false;

        private void btnOverrideSecAndMain_Click(object sender, EventArgs e)
        {
            this.IsOverrideSecAndMain = !this.IsOverrideSecAndMain;
            if (this.IsOverrideSecAndMain == true)
            {
                btnOverrideSecAndMain.Text = "Revert";
                txtSecAndMainAmount.Enabled = this.IsOverrideSecAndMain;
            }
            else
            {
                btnOverrideSecAndMain.Text = "Override";
                txtSecAndMainAmount.Text = this._secAndMainAmount;
                txtSecAndMainAmount.Enabled = this.IsOverrideSecAndMain;
            }
        }

        private void txtSecAndMainAmount_TextChanged(object sender, EventArgs e)
        {
            M_GetSecAndMainVatAMount();
            M_GetSecAndMainWithVatAMount();
        }


        private void txtBaseRental_Leave(object sender, EventArgs e)
        {
            // Remove any non-numeric characters except for decimal point
            string input = txtBaseRental.Text.Replace(",", "").Trim();
            decimal value;
            if (decimal.TryParse(input, NumberStyles.Any, CultureInfo.InvariantCulture, out value))
            {
                // Format the number with commas and two decimal places
                txtBaseRental.Text = value.ToString("N2"); // Format with commas and two decimal places
            }

        }

        private void txtSecAndMainAmount_Leave(object sender, EventArgs e)
        {
            // Remove any non-numeric characters except for decimal point
            string input = txtSecAndMainAmount.Text.Replace(",", "").Trim();
            decimal value;
            if (decimal.TryParse(input, NumberStyles.Any, CultureInfo.InvariantCulture, out value))
            {
                // Format the number with commas and two decimal places
                txtSecAndMainAmount.Text = value.ToString("N2"); // Format with commas and two decimal places
            }
   
        }


        private void txtAreRateSqm_Leave(object sender, EventArgs e)
        {
            // Remove any non-numeric characters except for decimal point
            string input = txtAreRateSqm.Text.Replace(",", "").Trim();
            decimal value;
            if (decimal.TryParse(input, NumberStyles.Any, CultureInfo.InvariantCulture, out value))
            {
                // Format the number with commas and two decimal places
                txtAreRateSqm.Text = value.ToString("N2"); // Format with commas and two decimal places
            }
        }

        private void txtAreRateSqm_MouseMove(object sender, MouseEventArgs e)
        {
            // Remove any non-numeric characters except for decimal point
            string input = txtAreRateSqm.Text.Replace(",", "").Trim();
            decimal value;
            if (decimal.TryParse(input, NumberStyles.Any, CultureInfo.InvariantCulture, out value))
            {
                // Format the number with commas and two decimal places
                txtAreRateSqm.Text = value.ToString("N2"); // Format with commas and two decimal places
            }
        }

        private void txtBaseRental_MouseMove(object sender, MouseEventArgs e)
        {
            // Remove any non-numeric characters except for decimal point
            string input = txtBaseRental.Text.Replace(",", "").Trim();
            decimal value;
            if (decimal.TryParse(input, NumberStyles.Any, CultureInfo.InvariantCulture, out value))
            {
                // Format the number with commas and two decimal places
                txtBaseRental.Text = value.ToString("N2"); // Format with commas and two decimal places
            }
        }

        private void txtSecAndMainAmount_MouseMove(object sender, MouseEventArgs e)
        {
            // Remove any non-numeric characters except for decimal point
            string input = txtSecAndMainAmount.Text.Replace(",", "").Trim();
            decimal value;
            if (decimal.TryParse(input, NumberStyles.Any, CultureInfo.InvariantCulture, out value))
            {
                // Format the number with commas and two decimal places
                txtSecAndMainAmount.Text = value.ToString("N2"); // Format with commas and two decimal places
            }
        }
    }
}
