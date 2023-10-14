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
    public partial class frmUploadFile : Form
    {

        public string sFilePath;
        public bool IsProceed = false;
        private bool IsFIleValid()
        {
            if (string.IsNullOrEmpty(txtfilename.Text))
            {
                MessageBox.Show("File Name cannot be empty !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Exclamation);
                return false;
            }
          

            return true;
        }
        public frmUploadFile()
        {
            InitializeComponent();
        }

        private void btnOk_Click(object sender, EventArgs e)
        {
            if (IsFIleValid())
            {
                if (MessageBox.Show("Are you sure you want to upload this file ?","System Message",MessageBoxButtons.YesNo,MessageBoxIcon.Question,MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                {
                    IsProceed = true;
                    this.Close();
                }
                
            }
        }

        private void frmUploadFile_Load(object sender, EventArgs e)
        {
            txtFilePath.Text = sFilePath;
        }
    }
}
