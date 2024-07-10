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
    public partial class frmContractInquiryAdvanceSearch : Form
    {
        private ClientContext _client;
        public bool IsProceed = false;
        public string ContractID = string.Empty;
        public frmContractInquiryAdvanceSearch()
        {
            InitializeComponent();
            _client = new ClientContext();
        }
        private void getClientBrowse()
        {
            try
            {
                dgvClientList.DataSource = null;
                using (DataSet dt = _client.GetClientBrowse())
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        dgvClientList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("getClientBrowse()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("getClientBrowse()", ex.ToString());
            }
        }

        private void frmContractInquiryAdvanceSearch_Load(object sender, EventArgs e)
        {
            this.getClientBrowse();
        }
        private void GetContratBrowseByClientID()
        {
            try
            {
                dgvContractList.DataSource = null;
                using (DataSet dt = _client.GetContratBrowseByClientID(Convert.ToString(dgvClientList.CurrentRow.Cells["ClientID"].Value)))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        dgvContractList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("GetContratBrowseByClientID()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("GetContratBrowseByClientID()", ex.ToString());
            }
        }

        private void dgvClientList_SelectionChanged(object sender, EventArgs e)
        {
            if (dgvClientList.Rows.Count > 0)
            {
                this.GetContratBrowseByClientID();
            }
        }

        private void dgvContractList_CellClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                if (this.dgvContractList.Columns[e.ColumnIndex].Name == "ColSelect")
                {
                    this.IsProceed = true;
                    this.ContractID = Convert.ToString(dgvContractList.CurrentRow.Cells["RefId"].Value);
                    this.Close();
                }
            }
        }
    }
}
