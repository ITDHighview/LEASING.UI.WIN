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
    public partial class frmPurchaseItemList : Form
    {
        ProjectContext ProjectContext = new ProjectContext();
        LocationContext LocationContext = new LocationContext();
        PurchaseItemContext PurchaseItemContext = new PurchaseItemContext();
        public int Recid { get; set; }
        public frmPurchaseItemList()
        {
            InitializeComponent();
        }
        private void M_GetPurchaseItemList()
        {
            try
            {
                dgvPurchaseItemList.DataSource = null;
                using (DataSet dt = PurchaseItemContext.GetGetPurchaseItemById(Recid))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        dgvPurchaseItemList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogError("M_GetPurchaseItemList()", this.Text, ex.ToString(), DateTime.Now, this);
                Functions.ErrorShow("M_GetPurchaseItemList()", ex.ToString());
            }

        }

        private void frmPurchaseItemList_Load(object sender, EventArgs e)
        {
            Functions.EventCapturefrmName(this);
            M_GetPurchaseItemList();
        }
    }
}
