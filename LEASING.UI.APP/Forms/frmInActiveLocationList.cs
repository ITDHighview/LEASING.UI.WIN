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
    public partial class frmInActiveLocationList : Form
    {
        LocationContext LocationContext = new LocationContext();
        public int RecId { get; set; }
        public bool IsProceed = false;
        public frmInActiveLocationList()
        {
            InitializeComponent();
        }
        private void M_GetLocationList()
        {
            dgvLocationList.DataSource = null;
            using (DataSet dt = LocationContext.GetInActiveLocationList())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    dgvLocationList.DataSource = dt.Tables[0];
                }
            }
        }

        private void dgvLocationList_CellClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {
            if (e.RowIndex >= 0)
            {
                if (this.dgvLocationList.Columns[e.ColumnIndex].Name == "ColActivate")
                {
                    if (MessageBox.Show("Are you sure you want to Activate the location?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                    {

                        var result = LocationContext.ActivateLocation(Convert.ToInt32(dgvLocationList.CurrentRow.Cells["RecId"].Value));
                        if (result.Equals("SUCCESS"))
                        {
                            MessageBox.Show("Location has been Activate successfully !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                            M_GetLocationList();
                        }
                    }
                }
                else if (this.dgvLocationList.Columns[e.ColumnIndex].Name == "ColDiActivate")
                {

                    if (MessageBox.Show("Are you sure you want to Delete the location?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                    {

                        var result = LocationContext.DeleteLocation(Convert.ToInt32(dgvLocationList.CurrentRow.Cells["RecId"].Value));
                        if (result.Equals("SUCCESS"))
                        {
                            MessageBox.Show("Location has been Delete successfully !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                            M_GetLocationList();
                        }
                    }
                }
            }
        }

        private void frmInActiveLocationList_Load(object sender, EventArgs e)
        {
            Functions.EventCapturefrmName(this);
            M_GetLocationList();
        }
    }
}
