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
    public partial class frmGetSelectClient : Form
    {
        ClientContext ClientContext = new ClientContext();
        public bool IsProceed = false;
        public string ClientID { get; set; }
        public string ClientName { get; set; }
        public frmGetSelectClient()
        {
            InitializeComponent();
        }

        private void M_GetClientFileList()
        {
            try
            {
                dgvList.DataSource = null;
                using (DataSet dt = ClientContext.GetClientList())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        dgvList.AutoGenerateColumns = false;
                        dgvList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogErrorIntoStoredProcedure("M_GetClientFileList()", this.Text, ex.Message, DateTime.Now, this);

                Functions.MessageShow("An error occurred : (" + ex.ToString() + ") Please check the [ErrorLog] ");
            }

        }

        private void frmGetSelectClient_Load(object sender, EventArgs e)
        {
            M_GetClientFileList();
        }

        private void dgvList_CellDoubleClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {
            IsProceed = true;
            ClientID = Convert.ToString(dgvList.CurrentRow.Cells["ClientID"].Value);
            ClientName = Convert.ToString(dgvList.CurrentRow.Cells["ClientName"].Value);
            
            this.Close();
        }
    }
}
