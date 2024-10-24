using LEASING.UI.APP.Common;
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
    public partial class ClientUploadFileInfoForm : Form
    {

        public string sFilePath;
        public bool IsProceed = false;
        public bool IsContractSigned { get; set; } = false;
        public string ReferenceId { get; set; } = string.Empty;
        private bool IsFIleValid()
        {
            if (string.IsNullOrEmpty(txtfilename.Text))
            {
                MessageBox.Show("File Name cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
            //if (chkSignContract.Checked)
            //{
            //    if (string.IsNullOrEmpty(txtReference.Text))
            //    {
            //        MessageBox.Show("Please select Reference!", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
            //        return false;
            //    }
            //}



            return true;
        }
        public ClientUploadFileInfoForm()
        {
            InitializeComponent();
        }

        private void btnOk_Click(object sender, EventArgs e)
        {
            if (IsFIleValid())
            {
                if (MessageBox.Show("Are you sure you want to upload this file ?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                {
                    IsProceed = true;
                    this.Close();
                }
            }
        }

        private void frmUploadFile_Load(object sender, EventArgs e)
        {
            Functions.EventCapturefrmName(this);
            txtReference.Text = string.Empty;
            if (IsContractSigned)
            {
                txtReference.Text = ReferenceId;
                //btnReference.Enabled = true;
                txtnotes.Text = "Contract Signed";
                txtReference.Enabled = true;
                //txtFilePath.Text = sFilePath;
                //txtFilePath.ReadOnly = true;
                txtClientID.ReadOnly = true;
            }
            else
            {
                //txtFilePath.Text = sFilePath;
                //txtFilePath.ReadOnly = true;
                //btnReference.Enabled = false;
                txtnotes.Text = string.Empty;
                txtReference.Enabled = false;
                txtClientID.ReadOnly = true;
            }
           
        }

        private void btnReference_Click(object sender, EventArgs e)
        {
            ClientContractPaidBrowse forms = new ClientContractPaidBrowse();
            forms.ClientID = txtClientID.Text;
            forms.ShowDialog();
            if (forms.IsProceed)
            {
                txtReference.Text = forms.ReferenceId;
                ReferenceId = forms.ReferenceId;
            }
        }
    }
}
