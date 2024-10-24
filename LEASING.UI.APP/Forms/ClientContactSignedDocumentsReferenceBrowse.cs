using LEASING.UI.APP.Common;
using LEASING.UI.APP.Context;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace LEASING.UI.APP.Forms
{
    public partial class ClientContactSignedDocumentsReferenceBrowse : Form
    {
        ClientContext ClientContext = new ClientContext();
        public string ClientID { get; set; }
        public string ReferenceID { get; set; }
        public ClientContactSignedDocumentsReferenceBrowse()
        {
            InitializeComponent();
        }
        private void M_GetFilesByClientAndReference()
        {
            try
            {
                dgvFileList.DataSource = null;
                using (DataSet dt = ClientContext.GetFilesByClientAndReference(ClientID, ReferenceID))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        dgvFileList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_GetFilesByClientAndReference()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_GetFilesByClientAndReference()", ex.ToString());
            }

        }

        private void frmGetContactSignedDocumentsByReference_Load(object sender, EventArgs e)
        {
            Functions.EventCapturefrmName(this);
            M_GetFilesByClientAndReference();
        }

        private void dgvFileList_CellClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                if (this.dgvFileList.Columns[e.ColumnIndex].Name == "ColView")
                {
                    // forms.ClientID = Convert.ToString(dgvFileList.CurrentRow.Cells["ClientID"].Value);
                    ClientContext.GetViewFileById(ClientID.Trim(), Config.baseFolderPath, Convert.ToInt32(dgvFileList.CurrentRow.Cells["Id"].Value));
                }
                else if (this.dgvFileList.Columns[e.ColumnIndex].Name == "ColDelete")
                {

                    //if (!string.IsNullOrWhiteSpace(ClientID))
                    //{

                    //    DialogResult result = MessageBox.Show("Are you sure you want to delete all files for this client?", "Confirmation", MessageBoxButtons.YesNo);

                    //    if (result == DialogResult.Yes)
                    //    {
                    //        string sfilepath = Convert.ToString(dgvFileList.CurrentRow.Cells["FilePath"].Value);
                    //        if (File.Exists(sfilepath))
                    //        {
                    //            File.Delete(sfilepath);
                    //        }

                    //        ClientContext.DeleteFileFromDatabase(sfilepath);
                          
                    //        //labelStatus.Text = "Files deleted successfully!";
                    //    }

                    //}
                    //else
                    //{
                    //    MessageBox.Show("Please enter a client name.");
                    //}
                }

            }
        }
    }
}
