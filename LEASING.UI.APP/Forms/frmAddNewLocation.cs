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
using System.Threading.Tasks;
using System.Windows.Forms;

namespace LEASING.UI.APP.Forms
{
    public partial class frmAddNewLocation : Form
    {
        private LocationContext _location;
        public frmAddNewLocation()
        {
            _location = new LocationContext();
            InitializeComponent();
        }
        enum ModeStatus
        {
            READ,
            NEW
        }
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
                        txtLocDescription.Enabled = true;
                        txtLocAddress.Enabled = true;
                        txtLocDescription.Text = string.Empty;
                        txtLocAddress.Text = string.Empty;
                        break;
                    case "READ":
                        btnUndo.Enabled = false;
                        btnSave.Enabled = false;
                        txtLocDescription.Enabled = false;
                        txtLocAddress.Enabled = false;
                        txtLocDescription.Text = string.Empty;
                        txtLocAddress.Text = string.Empty;
                        break;

                    default:
                        break;
                }
            }
        }
        private bool IsLocationValid()
        {
            if (string.IsNullOrEmpty(txtLocDescription.Text))
            {
                MessageBox.Show("Description cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            if (string.IsNullOrEmpty(txtLocAddress.Text))
            {
                MessageBox.Show("Address cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            return true;
        }
        private void M_GetLocationList()
        {
            try
            {
                dgvLocationList.DataSource = null;
                using (DataSet dt = _location.GetLocationList())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        dgvLocationList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_GetLocationList()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_GetLocationList()", ex.ToString());
            }
        }
        private void M_SaveLocation()
        {
            try
            {
                LocationModel dto = new LocationModel();
                dto.Description = txtLocDescription.Text;
                dto.LocAddress = txtLocAddress.Text;
                dto.Message_Code = _location.SaveLocation(dto);
                if (dto.Message_Code.Equals("SUCCESS"))
                {
                    Functions.MessageShow("New Location has been added successfully !");
                    this.FormMode = ModeStatus.READ.ToString();
                    M_GetLocationList();
                }
                else
                {
                    Functions.MessageShow(dto.Message_Code);
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_SaveLocation()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_SaveLocation()", ex.ToString());
            }
        }

        private void frmAddNewLocation_Load(object sender, EventArgs e)
        {
            Functions.EventCapturefrmName(this);
            this.FormMode = ModeStatus.READ.ToString();
            M_GetLocationList();
        }

        private void btnNew_Click(object sender, EventArgs e)
        {
            this.FormMode = ModeStatus.NEW.ToString();
        }

        private void btnUndo_Click(object sender, EventArgs e)
        {
            this.FormMode = ModeStatus.READ.ToString();
        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (IsLocationValid())
            {
                if (MessageBox.Show("Are you sure you want to save this location ?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                {
                    M_SaveLocation();
                }
            }
        }

        private void dgvLocationList_CellClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                if (this.dgvLocationList.Columns[e.ColumnIndex].Name == "coledit")
                {
                    frmEditLocation forms = new frmEditLocation();
                    forms.RecId = Convert.ToInt32(dgvLocationList.CurrentRow.Cells["RecId"].Value);
                    forms.ShowDialog();
                    if (forms.IsProceed)
                    {
                        M_GetLocationList();
                    }
                }
                else if (this.dgvLocationList.Columns[e.ColumnIndex].Name == "coldelete")
                {

                    if (MessageBox.Show("Are you sure you want to Deactivate the location?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                    {

                        var result = _location.DeActivateLocation(Convert.ToInt32(dgvLocationList.CurrentRow.Cells["RecId"].Value));
                        if (result.Equals("SUCCESS"))
                        {
                            MessageBox.Show("Location has been Deactivate successfully !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                            M_GetLocationList();
                        }
                    }
                }
            }
        }

        private void ToolStripButton_Click(object sender, EventArgs e)
        {
            frmInActiveLocationList forms = new frmInActiveLocationList();
            forms.RecId = Convert.ToInt32(dgvLocationList.CurrentRow.Cells["RecId"].Value);
            forms.ShowDialog();
            M_GetLocationList();
        }
    }
}
