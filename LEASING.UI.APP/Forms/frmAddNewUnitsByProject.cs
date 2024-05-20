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

namespace LEASING.UI.APP.Forms
{
    public partial class frmAddNewUnitsByProject : Form
    {
        ProjectContext ProjectContext = new ProjectContext();
        FloorTypeContext FloorTypeContext = new FloorTypeContext();
        UnitContext UnitContext = new UnitContext();
        bool isResidential = false;
        public bool IsProceed = false;
        public int RecId { get; set; }

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
                       

                        ddlFloorType.SelectedIndex = 0;
                        ClearFields();
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
            new UnitStatus { UnitStatusName = "--SELECT--"},
            new UnitStatus { UnitStatusName = "VACANT"},
            new UnitStatus { UnitStatusName = "RESERVED"},
            new UnitStatus { UnitStatusName = "OCCUPIED"},
             new UnitStatus { UnitStatusName = "NOT AVAILABLE"}
        };


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


        private bool IsUnitValid()
        {
            //if (ddlProject.SelectedText == "--SELECT--")
            //{
            //    MessageBox.Show("Project  cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            //    return false;
            //}
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
        }

        private void ClearFields()
        {


            ddlUnitStatus.SelectedIndex = 0;

            txtAreSql.Text = string.Empty;
            ddlFloorType.SelectedIndex = 0;
            txtDetailsOfProperty.Text = string.Empty;
          
            txtUnitNumber.Text = string.Empty;
            txtFloorNumber.Text = string.Empty;
            txtAreRateSqm.Text = string.Empty;
            txtBaseRental.Text = string.Empty;
            txtUnitSequence.Text = string.Empty;
            chkIsParking.Checked = false;

        }

        private void DisEnableFields()
        {


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
        public frmAddNewUnitsByProject()
        {
            InitializeComponent();
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
                Functions.LogErrorIntoStoredProcedure("M_SelectFloortypes()", this.Text, ex.Message, DateTime.Now, this);

                Functions.MessageShow("An error occurred : (" + ex.ToString() + ") Please check the [ErrorLog] ");
            }



        }


        private void M_GetProjectTypeById()
        {
            isResidential = false;
            txtType.Text = string.Empty;
            try
            {
                using (DataSet dt = ProjectContext.GetProjectTypeById(RecId))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {

                        string Projecttype = Convert.ToString(dt.Tables[0].Rows[0]["ProjectType"]);
                        txtType.Text = Convert.ToString(dt.Tables[0].Rows[0]["ProjectType"]);
                        if (Projecttype == "RESIDENTIAL")
                        {
                            isResidential = true;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogErrorIntoStoredProcedure("M_GetProjectTypeById()", this.Text, ex.Message, DateTime.Now, this);

                Functions.MessageShow("An error occurred : (" + ex.ToString() + ") Please check the [ErrorLog] ");
            }


        }

        private void frmAddNewUnits_Load(object sender, EventArgs e)
        {
            strUnitFormMode = "READ";
            ddlFloorType.Visible = false;
            lblFloorType.Visible = false;
            lblUnitStatus.Visible = false;
            ddlUnitStatus.Visible = false;

            if (RecId > 0)
            {
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
            }
            else if (RecId == 0)
            {
                ddlFloorType.Visible = false;
                lblFloorType.Visible = false;
                
                ddlFloorType.SelectedIndex = 0;
                isResidential = false;
            }
          
            M_GetUnitStatus();


        }

        //private void ddlProject_SelectedIndexChanged(object sender, Telerik.WinControls.UI.Data.PositionChangedEventArgs e)
        //{
        //    if (RecId > 0)
        //    {
        //        M_GetProjectTypeById();
        //        if (isResidential)
        //        {
        //            ddlFloorType.Visible = true;
        //            lblFloorType.Visible = true;
        //            M_SelectFloortypes();
        //        }

        //        else
        //        {
        //            ddlFloorType.Visible = false;
        //            lblFloorType.Visible = false;
        //        }
        //    }
        //    else if (RecId == 0)
        //    {
        //        ddlFloorType.Visible = false;
        //        lblFloorType.Visible = false;
        //        txtType.Text = string.Empty;
        //        ddlFloorType.SelectedIndex = 0;
        //        isResidential = false;
        //    }
        //}

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
            if (!Regex.IsMatch(Convert.ToString(e.KeyChar), "[0-9\b]"))
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
            try
            {
                UnitModel dto = new UnitModel();
                dto.ProjectId = RecId;
                //dto.UnitStatus = ddlUnitStatus.Text;
                dto.UnitNo = txtUnitNumber.Text;
                dto.IsParking = chkIsParking.Checked;
                dto.FloorNo = Convert.ToInt32(txtFloorNumber.Text);
                dto.AreaSqm = txtAreSql.Text == string.Empty ? 0 : decimal.Parse(txtAreSql.Text);
                dto.AreaRateSqm = txtAreRateSqm.Text == string.Empty ? 0 : decimal.Parse(txtAreRateSqm.Text);
                dto.FloorType = ddlFloorType.Text;
                dto.BaseRental = txtBaseRental.Text == string.Empty ? 0 : decimal.Parse(txtBaseRental.Text);
                dto.DetailsofProperty = txtDetailsOfProperty.Text;
                dto.UnitSequence = Convert.ToInt32(txtUnitSequence.Text);
                dto.EncodedBy = 1;
                dto.Message_Code = UnitContext.SaveUnit(dto);
                if (dto.Message_Code.Equals("SUCCESS"))
                {
                    Functions.MessageShow("New Unit has been added successfully !");
                    strUnitFormMode = "READ";
                    IsProceed = true;
                    this.Close();


                }
                else
                {
                    Functions.MessageShow(dto.Message_Code);
                    strUnitFormMode = "READ";
                }
            }
            catch (Exception ex)
            {
                Functions.LogErrorIntoStoredProcedure("M_SaveUnit()", this.Text, ex.Message, DateTime.Now, this);

                Functions.MessageShow("An error occurred : (" + ex.ToString() + ") Please check the [ErrorLog] ");
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

    }
}
