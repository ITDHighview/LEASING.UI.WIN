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

        private void M_GetResendentialRateSettings()
        {
            txtBaseRentalVatPercentage.Text = string.Empty;
            txtSecAndMainVatPercentage.Text = string.Empty;
            txtSecAndMainAmount.Text = string.Empty;
            vWithHoldingTax = 0;
            lblSecAndMainTax.Text = "TAX  : 0%";
            lblBaseRentalTax.Text = "TAX  : 0%";
            using (DataSet dt = RateSettingsContext.GetRESIDENTIALSettings())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    txtBaseRentalVatPercentage.Text = Convert.ToString(dt.Tables[0].Rows[0]["GenVat"]);
                    txtSecAndMainVatPercentage.Text = Convert.ToString(dt.Tables[0].Rows[0]["GenVat"]);
                    txtSecAndMainAmount.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecurityAndMaintenance"]);
                    lblSecAndMainTax.Text = "TAX  : " + Convert.ToString(vWithHoldingTax) + "%";
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
            lblSecAndMainTax.Text = "TAX  : 0%";
            lblBaseRentalTax.Text = "TAX  : 0%";
            using (DataSet dt = RateSettingsContext.GetWAREHOUSESettings())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    txtBaseRentalVatPercentage.Text = Convert.ToString(dt.Tables[0].Rows[0]["GenVat"]);
                    txtSecAndMainVatPercentage.Text = Convert.ToString(dt.Tables[0].Rows[0]["GenVat"]);
                    txtSecAndMainAmount.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecurityAndMaintenance"]);
                    vWithHoldingTax = Convert.ToInt32(dt.Tables[0].Rows[0]["WithHoldingTax"]);
                    lblSecAndMainTax.Text = "TAX  : " + Convert.ToString(vWithHoldingTax) + "%";
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
            lblSecAndMainTax.Text = "TAX  : 0%";
            lblBaseRentalTax.Text = "TAX  : 0%";
            using (DataSet dt = RateSettingsContext.GetCOMMERCIALSettings())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    txtBaseRentalVatPercentage.Text = Convert.ToString(dt.Tables[0].Rows[0]["GenVat"]);
                    txtSecAndMainVatPercentage.Text = Convert.ToString(dt.Tables[0].Rows[0]["GenVat"]);
                    txtSecAndMainAmount.Text = Convert.ToString(dt.Tables[0].Rows[0]["SecurityAndMaintenance"]);
                    vWithHoldingTax = Convert.ToInt32(dt.Tables[0].Rows[0]["WithHoldingTax"]);
                    lblSecAndMainTax.Text = "TAX  : " +Convert.ToString(vWithHoldingTax) + "%";
                    lblBaseRentalTax.Text = "TAX  : " + Convert.ToString(vWithHoldingTax) + "%";

                }
            }
        }

        private void M_ForDisableOnlyFields()
        {
            txtAreTotal.Enabled = false;
            txtBaseRentalVatPercentage.Enabled = false;
            txtBaseRentalVatAmount.Enabled = false;
            txtBaseRentalWithVatAmount.Enabled = false;
            txtSecAndMainVatPercentage.Enabled = false;
            txtSecAndMainAmount.Enabled = false;
            txtSecAndMainVatAmount.Enabled = false;
            txtSecAndMainWithVatAmount.Enabled = false;
            txtBaseRentalTax.Enabled = false;
            txtSecAndMainTax.Enabled = false;

        }
        private void M_GetUnitStatus()
        {

            ddlUnitStatus.DataSource = null;
            if (UnitStatusList.Count() > 0)
            {
                ddlUnitStatus.DisplayMember = "UnitStatusName";
                ddlUnitStatus.ValueMember = "UnitStatusName";
                ddlUnitStatus.DataSource = UnitStatusList;
            }
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
            ddlUnitStatus.Enabled = true;

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

            //dgvUnitList.Enabled = true;




        }

        private void ClearFields()
        {

            ddlProject.SelectedIndex = 0;
            ddlUnitStatus.SelectedIndex = 0;

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
            ddlUnitStatus.Enabled = false;

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
            //dgvUnitList.Enabled = false;
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
                    }
                    else if (Projecttype == "COMMERCIAL")
                    {
                        isCommercial = true;
                    }
                    else if (Projecttype == "WAREHOUSE")
                    {
                        isWarehouse = true;
                    }
                }
            }
        }

        private void M_GetCalculationAreaTotal()
        {

            var result = (txtAreSql.Text == "" ? 0 : Convert.ToDecimal(txtAreSql.Text)) * (txtAreRateSqm.Text == "" ? 0 : Convert.ToDecimal(txtAreRateSqm.Text));
            txtAreTotal.Text = Convert.ToString(result);

        }

        private void M_GetBaseRentalVatAmount()
        {

            var AMount = ((txtBaseRental.Text == "" ? 0 : Convert.ToDecimal(txtBaseRental.Text)) * (txtBaseRentalVatPercentage.Text == "" ? 0 : Convert.ToDecimal(txtBaseRentalVatPercentage.Text)) / 100);
            txtBaseRentalVatAmount.Text = Convert.ToString(AMount);
        }
        private void M_GetBaseRentalWithVatAmount()
        {
            if (!chkIsParking.Checked)
            {
                var AMount = ((txtBaseRental.Text == "" ? 0 : Convert.ToDecimal(txtBaseRental.Text)) + (txtBaseRentalVatAmount.Text == "" ? 0 : Convert.ToDecimal(txtBaseRentalVatAmount.Text)));
                txtBaseRentalWithVatAmount.Text = Convert.ToString(AMount);
                /*TAX*/
                M_GetBaseRentalTaxAMount();
                var tax = ((txtBaseRentalTax.Text == "" ? 0 : Convert.ToDecimal(txtBaseRentalTax.Text)) + (txtSecAndMainTax.Text == "" ? 0 : Convert.ToDecimal(txtSecAndMainTax.Text)));
                var totalrental = ((txtBaseRentalWithVatAmount.Text == "" ? 0 : Convert.ToDecimal(txtBaseRentalWithVatAmount.Text)) + (txtSecAndMainWithVatAmount.Text == "" ? 0 : Convert.ToDecimal(txtSecAndMainWithVatAmount.Text)));
                var result = (totalrental - tax);
                txtTotalRental.Text = String.Format("{0:0.00}", Convert.ToString(result));

            }
            else
            {
                var AMount = ((txtBaseRental.Text == "" ? 0 : Convert.ToDecimal(txtBaseRental.Text)) + (txtBaseRentalVatAmount.Text == "" ? 0 : Convert.ToDecimal(txtBaseRentalVatAmount.Text)));
                txtBaseRentalWithVatAmount.Text = Convert.ToString(AMount);
                /*TAX*/
                M_GetBaseRentalTaxAMount();
                var tax =(txtBaseRentalTax.Text == "" ? 0 : Convert.ToDecimal(txtBaseRentalTax.Text));
                var totalrental = (txtBaseRentalWithVatAmount.Text == "" ? 0 : Convert.ToDecimal(txtBaseRentalWithVatAmount.Text));
                var result = (totalrental - tax);
                txtTotalRental.Text = String.Format("{0:0.00}", Convert.ToString(result));
            }
      
        }
        private void M_GetSecAndMainVatAMount()
        {
            var AMount = ((txtSecAndMainAmount.Text == "" ? 0 : Convert.ToDecimal(txtSecAndMainAmount.Text)) * (txtSecAndMainVatPercentage.Text == "" ? 0 : Convert.ToDecimal(txtSecAndMainVatPercentage.Text)) / 100);
            txtSecAndMainVatAmount.Text = Convert.ToString(AMount);


        }
        private void M_GetSecAndMainWithVatAMount()
        {
            var AMount = ((txtSecAndMainAmount.Text == "" ? 0 : Convert.ToDecimal(txtSecAndMainAmount.Text)) + (txtSecAndMainVatAmount.Text == "" ? 0 : Convert.ToDecimal(txtSecAndMainVatAmount.Text)));
            txtSecAndMainWithVatAmount.Text = Convert.ToString(AMount);
            /*TAX*/
            var tax = ((txtBaseRentalTax.Text == "" ? 0 : Convert.ToDecimal(txtBaseRentalTax.Text)) + (txtSecAndMainTax.Text == "" ? 0 : Convert.ToDecimal(txtSecAndMainTax.Text))); ;
            var totalrental = ((txtBaseRentalWithVatAmount.Text == "" ? 0 : Convert.ToDecimal(txtBaseRentalWithVatAmount.Text)) + (txtSecAndMainWithVatAmount.Text == "" ? 0 : Convert.ToDecimal(txtSecAndMainWithVatAmount.Text)));
            var result = (totalrental - tax);
            txtTotalRental.Text = String.Format("{0:0.00}", Convert.ToString(result));
        }

        /*TAX*/
        private void M_GetSecAndMainTaxAMount()
        {
            var amount = ((txtSecAndMainWithVatAmount.Text == "" ? 0 : Convert.ToDecimal(txtSecAndMainWithVatAmount.Text)) * (vWithHoldingTax) / 100);
            txtSecAndMainTax.Text = Convert.ToString(amount);

        }
        private void M_GetBaseRentalTaxAMount()
        {
            var amount = ((txtBaseRentalWithVatAmount.Text == "" ? 0 : Convert.ToDecimal(txtBaseRentalWithVatAmount.Text)) * (vWithHoldingTax) / 100);
            txtBaseRentalTax.Text = Convert.ToString(amount);

        }
        private void frmAddNewUnits_Load(object sender, EventArgs e)
        {
            strUnitFormMode = "READ";
            txtTotalRental.ReadOnly = true;
            ddlFloorType.Visible = false;
            lblFloorType.Visible = false;
            lblUnitStatus.Visible = false;
            ddlUnitStatus.Visible = false;
            M_SelectProject();
            M_GetUnitStatus();
            M_GetUnitList();
            M_ForDisableOnlyFields();
            

        }

        private void ddlProject_SelectedIndexChanged(object sender, Telerik.WinControls.UI.Data.PositionChangedEventArgs e)
        {
            if (ddlProject.SelectedIndex > 0)
            {

                vWithHoldingTax = 0;
                txtBaseRentalTax.Text = string.Empty;
                txtSecAndMainTax.Text = string.Empty;
                M_GetProjectTypeById();
                if (isResidential)
                {
                    ddlFloorType.Visible = true;
                    lblFloorType.Visible = true;
                    M_SelectFloortypes();
                }
                else
                {
                    ddlFloorType.Visible = false;
                    lblFloorType.Visible = false;
                }
                if (isResidential)
                {
                    M_GetResendentialRateSettings();
                 
                    M_GetSecAndMainVatAMount();
                    M_GetSecAndMainWithVatAMount();
                    M_GetBaseRentalVatAmount();
                    M_GetBaseRentalWithVatAmount();
                    M_GetSecAndMainTaxAMount();
               

                }
                else if (isCommercial)
                {
                    M_GetCOMMERCIALateSettings();
                  
                    M_GetSecAndMainVatAMount();
                    M_GetSecAndMainWithVatAMount();
                    M_GetBaseRentalVatAmount();
                    M_GetBaseRentalWithVatAmount();
                    M_GetSecAndMainTaxAMount();

                }
                else if (isWarehouse)
                {
                    M_GetWAREHOUSERateSettings();
                  
                    M_GetSecAndMainVatAMount();
                    M_GetSecAndMainWithVatAMount();
                    M_GetBaseRentalVatAmount();
                    M_GetBaseRentalWithVatAmount();
                    M_GetSecAndMainTaxAMount();

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


        private void M_SaveUnit()
        {
            UnitModel dto = new UnitModel();
            dto.ProjectId = Convert.ToInt32(ddlProject.SelectedValue);
            //dto.UnitStatus = ddlUnitStatus.Text;
            dto.UnitNo = txtUnitNumber.Text;
            dto.IsParking = chkIsParking.Checked;
            dto.FloorNo = txtFloorNumber.Text==string.Empty ? 0 : Convert.ToInt32(txtFloorNumber.Text);
            dto.AreaSqm = txtAreSql.Text == string.Empty ? 0 : decimal.Parse(txtAreSql.Text);
            dto.AreaRateSqm = txtAreRateSqm.Text == string.Empty ? 0 : decimal.Parse(txtAreRateSqm.Text);
            dto.FloorType = ddlFloorType.Text;
            dto.BaseRental = txtBaseRental.Text == string.Empty ? 0 : decimal.Parse(txtBaseRental.Text);
            dto.DetailsofProperty = txtDetailsOfProperty.Text;
            dto.UnitSequence = txtUnitSequence.Text==string.Empty ? 0 : Convert.ToInt32(txtUnitSequence.Text);
            dto.EncodedBy = 1;
            dto.Message_Code = UnitContext.SaveUnit(dto);
            if (dto.Message_Code.Equals("SUCCESS"))
            {
                MessageBox.Show("New Unit has been added successfully !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                strUnitFormMode = "READ";
                M_GetUnitList();

            }
            else
            {
                MessageBox.Show(dto.Message_Code, "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                //strUnitFormMode = "READ";
            }
        }
        private void btnSave_Click(object sender, EventArgs e)
        {
            if (strUnitFormMode == "NEW")
            {
                if (IsUnitValid())
                {
                    if (MessageBox.Show("Are you sure you want to add this Unit ?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                    {
                        M_SaveUnit();
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

                            //var result = ProjectContext.DeActivateProject(Convert.ToInt32(dgvProjectList.CurrentRow.Cells["RecId"].Value));
                            //if (result.Equals("SUCCESS"))
                            //{
                            //    MessageBox.Show("Project has been Deactivated successfully !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                            //    M_GetProjectList();
                            //}
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

        //private void chkIsParking_ToggleStateChanged(object sender, Telerik.WinControls.UI.StateChangedEventArgs args)
        //{
        //    if (chkIsParking.Checked == true)
        //    {
        //        ddlFloorType.Visible = false;
        //        lblFloorType.Visible = false;
        //    }
        //    else
        //    {
        //        ddlFloorType.Visible = true;
        //        lblFloorType.Visible = true;
        //    }
        //}

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
            //M_GetSecAndMainTaxAMount();
           // M_GetBaseRentalTaxAMount();
        }

        private void txtSecAndMainWithVatAmount_TextChanged(object sender, EventArgs e)
        {

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
                txtSecAndMainTax.Text = string.Empty;
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
                    M_GetSecAndMainTaxAMount();
                }
                else if (isCommercial)
                {
                    M_GetCOMMERCIALateSettings();

                    M_GetSecAndMainVatAMount();
                    M_GetSecAndMainWithVatAMount();
                    M_GetBaseRentalVatAmount();
                    M_GetBaseRentalWithVatAmount();
                    M_GetSecAndMainTaxAMount();

                }
                else if (isWarehouse)
                {
                    M_GetWAREHOUSERateSettings();

                    M_GetSecAndMainVatAMount();
                    M_GetSecAndMainWithVatAMount();
                    M_GetBaseRentalVatAmount();
                    M_GetBaseRentalWithVatAmount();
                    M_GetSecAndMainTaxAMount();

                }
            }
        }
    }
}
