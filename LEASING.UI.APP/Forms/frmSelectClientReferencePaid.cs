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
    public partial class frmSelectClientReferencePaid : Form
    {
        ClientContext ClientContext = new ClientContext();
        public string ClientID { get; set; }
        public bool IsProceed { get; set; }
        public string ReferenceId { get; set; }
        public frmSelectClientReferencePaid()
        {
            InitializeComponent();
        }
        private void M_GetSelectClientReferencePaid()
        {
            try
            {
                dgvList.DataSource = null;
                using (DataSet dt = ClientContext.GetClientReferencePaid(ClientID))
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
                Functions.LogError("M_GetSelectClientReferencePaid()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_GetSelectClientReferencePaid()", ex.ToString());
            }
        }

        private void frmSelectClientReferencePaid_Load(object sender, EventArgs e)
        {
            M_GetSelectClientReferencePaid();
        }

        private void dgvList_CellDoubleClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {
            if (dgvList.Rows.Count > 0)
            {
                ReferenceId = Convert.ToString(dgvList.CurrentRow.Cells["RefId"].Value);
                IsProceed = true;
                this.Close();
            }
        }
    }
}
