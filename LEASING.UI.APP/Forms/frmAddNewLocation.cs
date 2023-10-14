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
        LocationContext LocationContext = new LocationContext();
        public frmAddNewLocation()
        {
            InitializeComponent();
        }
        private string _strlocationFormMode;
        public string strlocationFormMode
        {
            get
            {
                return _strlocationFormMode;
            }
            set
            {
                _strlocationFormMode = value;
                switch (_strlocationFormMode)
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
            dgvLocationList.DataSource = null;
            using (DataSet dt = LocationContext.GetLocationList())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    dgvLocationList.DataSource = dt.Tables[0];
                }
            }
        }
        private void M_SaveLocation()
        {
            LocationModel dto = new LocationModel();
            dto.Description = txtLocDescription.Text;
            dto.LocAddress = txtLocAddress.Text;
            dto.Message_Code = LocationContext.SaveLocation(dto);
            if (dto.Message_Code.Equals("SUCCESS"))
            {
                MessageBox.Show("New Location has been added successfully !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                strlocationFormMode = "READ";
                M_GetLocationList();

            }
        }

        private void frmAddNewLocation_Load(object sender, EventArgs e)
        {
            strlocationFormMode = "READ";
           
            M_GetLocationList();
        
        }

        private void btnNew_Click(object sender, EventArgs e)
        {
            strlocationFormMode = "NEW";
        }

        private void btnUndo_Click(object sender, EventArgs e)
        {
            strlocationFormMode = "READ";
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

                        var result = LocationContext.DeActivateLocation(Convert.ToInt32(dgvLocationList.CurrentRow.Cells["RecId"].Value));
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
