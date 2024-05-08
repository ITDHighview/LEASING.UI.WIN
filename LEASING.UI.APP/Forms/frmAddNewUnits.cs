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
using Telerik.WinControls;
using Telerik.WinControls.UI;

namespace LEASING.UI.APP.Forms
{
    public partial class frmAddNewUnits : Form
    {
        ProjectContext ProjectContext = new ProjectContext();
        FloorTypeContext FloorTypeContext = new FloorTypeContext();
        UnitContext UnitContext = new UnitContext();
        RateSettingsContext RateSettingsContext = new RateSettingsContext();
        bool isResidential = false;
        bool isWarehouse = false;
        bool isCommercial = false;
        int vWithHoldingTax = 0;
        decimal WithHoldingTaxParam = 0;

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
            using (DataSet dt = RateSettingsContext.GetRESIDENTIALSettings())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    txtBaseRentalVatPercentage.Text = Convert.ToString(dt.Tables[0].Rows[0]["GenVat"]);
                    txtSecAndMainVatPercentage.Text = String.Format("{0:0.00}", Convert.ToString(dt.Tables[0].Rows[0]["GenVat"]));
                    this._secAndMainVatPercentage  = String.Format("{0:0.00}", Convert.ToString(dt.Tables[0].Rows[0]["GenVat"]));
                    txtSecAndMainAmount.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecurityAndMaintenance"]);
                    this._secAndMainAmount = Convert.ToString(dt.Tables[0].Rows[0]["SecurityAndMaintenance"]);
                    //lblSecAndMainTax.Text = "TAX  : " + Convert.ToString(vWithHoldingTax) + "%";
                    lblBaseRentalTax.Text = "TAX  : " + Convert.ToString(vWithHoldingTax) + "%";
                }
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
            using (DataSet dt = RateSettingsContext.GetWAREHOUSESettings())
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
        private void M_GetCOMMERCIALateSettings()
        {
            txtBaseRentalVatPercentage.Text = string.Empty;
            txtSecAndMainVatPercentage.Text = string.Empty;
            txtSecAndMainAmount.Text = string.Empty;
            vWithHoldingTax = 0;
            //lblSecAndMainTax.Text = "TAX  : 0%";
            lblBaseRentalTax.Text = "TAX  : 0%";
            using (DataSet dt = RateSettingsContext.GetCOMMERCIALSettings())
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
            dgvUnitList.DataSource = null;
            using (DataSet dt = UnitContext.GetUnitList())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    dgvUnitList.DataSource = dt.Tables[0];
                }
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
        }
        public frmAddNewUnits()
        {
            InitializeComponent();
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

        private void M_SelectFloortypes()
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


        private void M_GetProjectTypeById()
        {
            isResidential = false;
            isCommercial = false;
            isWarehouse = false;
            txtType.Text = string.Empty;

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

        private void M_GetCalculationAreaTotal()
        {
            var result = Math.Round(Functions.ConvertStringToDecimal(txtAreSql.Text) * Functions.ConvertStringToDecimal(txtAreRateSqm.Text));
            txtAreaTotalAmount.Text = result.ToString("0.00");
        }
        private void M_GetBaseRentalVatAmount()
        {
            var AMount = (Functions.ConvertStringToDecimal(txtBaseRental.Text) * (chkNonVat.Checked == true ? 0 : Functions.ConvertStringToDecimal(txtBaseRentalVatPercentage.Text)) / 100);
            txtBaseRentalVatAmount.Text = Convert.ToString(AMount);
        }

        private decimal RentalNetOfVat()
        {
            return (Functions.ConvertStringToDecimal(txtBaseRental.Text) + Functions.ConvertStringToDecimal(txtBaseRentalVatAmount.Text));
        }
        private void TotalRentalUnit()
        {
            var tax = (Functions.ConvertStringToDecimal(txtBaseRentalTax.Text));
            var totalrental = ((this.chkNonVat.Checked == true ? Functions.ConvertStringToDecimal(txtBaseRental.Text) : Functions.ConvertStringToDecimal(txtBaseRentalWithVatAmount.Text)) + Functions.ConvertStringToDecimal(txtSecAndMainWithVatAmount.Text));
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
            decimal tax = Functions.ConvertStringToDecimal(txtBaseRentalTax.Text);
            //var totalrental = Functions.ConvertStringToDecimal(txtBaseRentalWithVatAmount.Text);
            decimal totalrental = this.chkNonVat.Checked == true ? Functions.ConvertStringToDecimal(txtBaseRental.Text) : Functions.ConvertStringToDecimal(txtBaseRentalWithVatAmount.Text);
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
        private void M_GetBaseRentalTaxAMount()
        {
            var amount = (Functions.ConvertStringToDecimal(txtBaseRental.Text) * (vWithHoldingTax) / 100);
            txtBaseRentalTax.Text = Convert.ToString(amount);
        }
        private void frmAddNewUnits_Load(object sender, EventArgs e)
        {
            strUnitFormMode = "READ";
            txtTotalRental.ReadOnly = true;
            ddlFloorType.Visible = false;
            lblFloorType.Visible = false;
            M_SelectProject();
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
            strUnitFormMode = "NEW";
        }

        private void btnUndo_Click(object sender, EventArgs e)
        {
            strUnitFormMode = "READ";
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
            UnitModel UnitNew = new UnitModel();
            UnitNew.ProjectId = Convert.ToInt32(this.ddlProject.SelectedValue);
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
            UnitNew.TotalRental = Functions.ConvertStringToDecimal(this.txtTotalRental.Text);
            UnitNew.SecAndMainAmount = Functions.ConvertStringToDecimal(this.txtSecAndMainAmount.Text);
            UnitNew.SecAndMainVatAmount = Functions.ConvertStringToDecimal(this.txtSecAndMainVatAmount.Text);
            UnitNew.SecAndMainWithVatAmount = Functions.ConvertStringToDecimal(this.txtSecAndMainWithVatAmount.Text);
            UnitNew.Vat = Functions.ConvertStringToDecimal(this.txtBaseRentalVatPercentage.Text);
            UnitNew.Tax = this.WithHoldingTaxParam;
            UnitNew.TaxAmount = Functions.ConvertStringToDecimal(this.txtBaseRentalTax.Text);
            
            UnitNew.Message_Code = UnitContext.SaveUnit(UnitNew);
            if (UnitNew.Message_Code.Equals("SUCCESS"))
            {
                Functions.MessageShow("New Unit has been added successfully !");
                this.strUnitFormMode = "READ";
                this.M_GetUnitList();

            }
            else
            {
                Functions.MessageShow(UnitNew.Message_Code);

            }
        }
        private void btnSave_Click(object sender, EventArgs e)
        {
            if (this.strUnitFormMode == "NEW")
            {
                if (this.IsUnitValid())
                {
                    if (MessageBox.Show("Are you sure you want to add this Unit ?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
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
                else if (this.dgvUnitList.Columns[e.ColumnIndex].Name == "ColDeactivate")
                {
                    if (Convert.ToString(this.dgvUnitList.Rows[e.RowIndex].Cells["UnitStat"].Value) == "VACANT")
                    {
                        if (MessageBox.Show("Are you sure you want to Deactivated the Unit?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                        {


                        }
                    }
                }
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
        {
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
    }
}
