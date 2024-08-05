using LEASING.UI.APP.Common;
using LEASING.UI.APP.Context;
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
    public partial class frmAddFloorType : Form
    {
        private UnitContext _unit;
        public frmAddFloorType()
        {
            _unit = new UnitContext();
            InitializeComponent();
        }
        enum ModeStatus
        {
            NEW,
            READ
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
                        txtTypeName.Enabled = true;
                        btnNew.Enabled = false;
                        txtTypeName.Text = string.Empty;

                        break;
                    case "READ":
                        btnUndo.Enabled = false;
                        btnSave.Enabled = false;
                        txtTypeName.Enabled = false;
                        btnNew.Enabled = true;
                        txtTypeName.Text = string.Empty;
                        break;

                    default:
                        break;
                }
            }
        }
        private bool _isValid()
        {
            if (string.IsNullOrEmpty(txtTypeName.Text))
            {
                MessageBox.Show("Type Name cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            //if (string.IsNullOrEmpty(txtLocAddress.Text))
            //{
            //    MessageBox.Show("Address cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            //    return false;
            //}
            return true;
        }
        private void SaveTypeName()
        {
            try
            {
                string result = _unit.SaveFloorTypeInfo(this.txtTypeName.Text);
                if (result.Equals("SUCCESS"))
                {
                    Functions.MessageShow("New Floor Type has been added successfully !");
                    this.FormMode = ModeStatus.READ.ToString();
                    this.GetTypeNameBrowse();
                }
                else
                {
                    Functions.MessageShow(result);
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("SaveTypeName()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("SaveTypeName()", ex.ToString());
            }
        }
        private void UpdateTypeName()
        {
            try
            {
                string result = _unit.UpdateFloorTypeInfo(Convert.ToInt32(dgvList.CurrentRow.Cells["RecId"].Value), Convert.ToString(dgvList.CurrentRow.Cells["FloorTypeName"].Value));
                if (result.Equals("SUCCESS"))
                {
                    Functions.MessageShow("Floor Type has been updated successfully !");
                    this.FormMode = ModeStatus.READ.ToString();
                    this.GetTypeNameBrowse();
                }
                else
                {
                    Functions.MessageShow(result);
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("UpdateTypeName()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("UpdateTypeName()", ex.ToString());
            }
        }
        private void DeleteTypeName()
        {
            try
            {
                string result = _unit.DeleteFloorType(Convert.ToString(dgvList.CurrentRow.Cells["FloorTypeName"].Value));
                if (result.Equals("SUCCESS"))
                {
                    Functions.MessageShow("Deleted successfully !");
                    this.FormMode = ModeStatus.READ.ToString();
                    this.GetTypeNameBrowse();
                }
                else
                {
                    Functions.MessageShow(result);
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("DeleteTypeName()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("DeleteTypeName()", ex.ToString());
            }
        }
        private void GetTypeNameBrowse()
        {
            try
            {
                dgvList.DataSource = null;
                using (DataSet dt = _unit.GetFloorTypeBrowse())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        dgvList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("GetTypeNameBrowse()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("GetTypeNameBrowse()", ex.ToString());
            }
            for (int i = 0; i < dgvList.Rows.Count; i++)
            {
                this.dgvList.Rows[i].Cells["FloorTypeName"].ReadOnly = true;
                this.dgvList.Rows[i].Cells["ColRemoved"].Value = "Edit";
                this.dgvList.Rows[i].Cells["ColEdit"].ColumnInfo.IsVisible = false;
                this.dgvList.Rows[i].Cells["ColEdit"].Value = "???";
            }
        }

        private void frmAddFloorType_Load(object sender, EventArgs e)
        {
            Functions.EventCapturefrmName(this);
            this.FormMode = ModeStatus.READ.ToString();
            GetTypeNameBrowse();


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
            if (this._isValid())
            {
                if (Functions.MessageConfirm("Are you sure you want to add this Floor Type ?") == DialogResult.Yes)
                {
                    this.SaveTypeName();
                }
            }
        }


     
        private void dgvList_CellClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {
            dgvList.EndEdit();

            if (e.RowIndex >= 0)
            {
                if (this.dgvList.Columns[e.ColumnIndex].Name == "ColRemoved")
                {
                   
                    this.dgvList.CurrentRow.Cells["FloorTypeName"].ReadOnly = false;
                    this.dgvList.CurrentRow.Cells["ColRemoved"].ColumnInfo.IsVisible = false;
                    this.dgvList.CurrentRow.Cells["ColEdit"].ColumnInfo.IsVisible = true;
                    this.dgvList.CurrentRow.Cells["ColEdit"].Value = "Save";
                    dgvList.Refresh();
                }
                else if (this.dgvList.Columns[e.ColumnIndex].Name == "ColEdit")
                {
                    if (Convert.ToString(this.dgvList.CurrentRow.Cells["ColEdit"].Value) == "Save")
                    {
                        this.UpdateTypeName();
                        this.dgvList.CurrentRow.Cells["FloorTypeName"].ReadOnly = true;
                        this.dgvList.CurrentRow.Cells["ColEdit"].Value = "???";
                        this.dgvList.CurrentRow.Cells["ColEdit"].ColumnInfo.IsVisible = false;
                        this.dgvList.CurrentRow.Cells["ColRemoved"].ColumnInfo.IsVisible = true;
                    }
                }
            }
        }
    }
}
