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
using Telerik.WinControls;

namespace LEASING.UI.APP.Forms
{
    public partial class frmInActivePurchaseItemList : Form
    {

        PurchaseItemContext PurchaseItemContext = new PurchaseItemContext();
        public frmInActivePurchaseItemList()
        {
            InitializeComponent();
        }

        private void M_GetPurchaseItemList()
        {
            dgvPurchaseItemList.DataSource = null;
            using (DataSet dt = PurchaseItemContext.GetInActivePurchaseItemList())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    dgvPurchaseItemList.DataSource = dt.Tables[0];
                }
            }
        }

        private void frmInActivePurchaseItemList_Load(object sender, EventArgs e)
        {
            Functions.EventCapturefrmName(this);
            M_GetPurchaseItemList();
        }

        private void dgvPurchaseItemList_CellClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                if (this.dgvPurchaseItemList.Columns[e.ColumnIndex].Name == "ColActivate")
                {

                    if (MessageBox.Show("Are you sure you want to Activate the item?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                    {

                        var result = PurchaseItemContext.ActivatePurchaseItem(Convert.ToInt32(dgvPurchaseItemList.CurrentRow.Cells["RecId"].Value));
                        if (result.Equals("SUCCESS"))
                        {
                            MessageBox.Show("Item has been Activate successfully !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                            M_GetPurchaseItemList();
                        }
                    }
                }
                else if (this.dgvPurchaseItemList.Columns[e.ColumnIndex].Name == "ColDelete")
                {

                    if (MessageBox.Show("Are you sure you want to delete the item?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                    {

                        var result = PurchaseItemContext.DeletePurchaseItem(Convert.ToInt32(dgvPurchaseItemList.CurrentRow.Cells["RecId"].Value));
                        if (result.Equals("SUCCESS"))
                        {
                            MessageBox.Show("Item has been Deleted successfully !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                            M_GetPurchaseItemList();
                        }
                    }
                }
            }
        }

        private void dgvPurchaseItemList_CellFormatting(object sender, Telerik.WinControls.UI.CellFormattingEventArgs e)
        {
            
               
                    e.CellElement.ForeColor = Color.White;
                    //e.CellElement.Font = new Font("Tahoma", 7f, FontStyle.Bold);

                    e.CellElement.DrawFill = true;
                    e.CellElement.GradientStyle = GradientStyles.Solid;
                    e.CellElement.BackColor = Color.Red;
           
            
        }
    }
}
