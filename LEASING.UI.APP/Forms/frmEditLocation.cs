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
    public partial class frmEditLocation : Form
    {
        LocationContext context = new LocationContext();
        public int RecId { get; set; }
        public bool IsProceed = false;

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
                    case "EDIT":
                        btnUndo.Enabled = true;
                        btnSave.Enabled = true;
                        btnEdit.Enabled = false;
                        txtLocDescription.Enabled = true;
                        txtLocAddress.Enabled = true;


                        //txtLocDescription.Text = string.Empty;
                        //txtLocAddress.Text = string.Empty;
                        break;
                    case "READ":
                        btnUndo.Enabled = false;
                        btnSave.Enabled = false;
                        btnEdit.Enabled = true;
                        txtLocDescription.Enabled = false;
                        txtLocAddress.Enabled = false;


                        //txtLocDescription.Text = string.Empty;
                        //txtLocAddress.Text = string.Empty;
                        break;

                    default:
                        break;
                }
            }
        }
        public frmEditLocation()
        {
            InitializeComponent();
        }
        private bool IsValid()
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

        private void M_getLocationById()
        {
            txtLocDescription.Text = string.Empty;
            txtLocAddress.Text = string.Empty;
            try
            {
                using (DataSet dt = context.GetLocationById(RecId))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        txtLocDescription.Text = Convert.ToString(dt.Tables[0].Rows[0]["Descriptions"]);
                        txtLocAddress.Text = Convert.ToString(dt.Tables[0].Rows[0]["LocAddress"]);

                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogErrorIntoStoredProcedure("M_getLocationById()", this.Text, ex.Message, DateTime.Now, this);

                Functions.MessageShow("An error occurred : (" + ex.ToString() + ") Please check the [ErrorLog] ");
            }



        }
        private void M_SaveLotion()
        {
            try
            {
                LocationModel dto = new LocationModel();
                dto.LocId = RecId;
                dto.Description = txtLocDescription.Text;
                dto.LocAddress = txtLocAddress.Text;
                //dto.LocStatus = chkIsActive.Checked;
                dto.Message_Code = context.EditLocation(dto);
                if (dto.Message_Code.Equals("SUCCESS"))
                {
                    IsProceed = true;
                    MessageBox.Show("Location info has been Upated successfully !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    strlocationFormMode = "READ";
                    this.Close();
                }
            }
            catch (Exception ex)
            {
                Functions.LogErrorIntoStoredProcedure("M_SaveLotion()", this.Text, ex.Message, DateTime.Now, this);

                Functions.MessageShow("An error occurred : (" + ex.ToString() + ") Please check the [ErrorLog] ");
            }




        }

        private void btnSave_Click(object sender, EventArgs e)
        {
            if (strlocationFormMode == "EDIT")
            {
                if (RecId > 0)
                {
                    if (IsValid())
                    {
                        if (MessageBox.Show("Are you sure you want to update the following location?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                        {
                            M_SaveLotion();
                        }
                    }
                }
            }
            else
            {
                MessageBox.Show("Please Click Edit", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
    

        }

        private void frmEditLocation_Load(object sender, EventArgs e)
        {
            strlocationFormMode = "READ";
            M_getLocationById();
        }


        private void btnSave_Click_1(object sender, EventArgs e)
        {
            if (RecId > 0)
            {
                if (IsValid())
                {
                    if (MessageBox.Show("Are you sure you want to update the following location?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                    {
                        M_SaveLotion();
                    }
                }
            }
        }

        private void btnUndo_Click(object sender, EventArgs e)
        {
            strlocationFormMode = "READ";
        }

        private void btnEdit_Click(object sender, EventArgs e)
        {
            strlocationFormMode = "EDIT";
        }
    }
}
