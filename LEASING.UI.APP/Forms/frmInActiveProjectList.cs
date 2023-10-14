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
    public partial class frmInActiveProjectList : Form
    {
        ProjectContext ProjectContext = new ProjectContext();
        LocationContext LocationContext = new LocationContext();
        public frmInActiveProjectList()
        {
            InitializeComponent();
        }

        private void M_GetProjectList()
        {
            dgvProjectList.DataSource = null;
            using (DataSet dt = ProjectContext.GetInActiveProjectList())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    dgvProjectList.DataSource = dt.Tables[0];
                }
            }
        }

        private void frmInActiveProjectList_Load(object sender, EventArgs e)
        {
            M_GetProjectList();
        }

        private void dgvProjectList_CellClick(object sender, Telerik.WinControls.UI.GridViewCellEventArgs e)
        {

            if (e.RowIndex >= 0)
            {
                if (this.dgvProjectList.Columns[e.ColumnIndex].Name == "ColDelete")
                {
                    if (MessageBox.Show("Are you sure you want to Delete the Project?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                    {

                        var result = ProjectContext.DeleteProject(Convert.ToInt32(dgvProjectList.CurrentRow.Cells["RecId"].Value));
                        if (result.Equals("SUCCESS"))
                        {
                            MessageBox.Show("Project has been Delete successfully !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                            M_GetProjectList();
                        }
                    }
                }
                else if (this.dgvProjectList.Columns[e.ColumnIndex].Name == "ColActivate")
                {

                    if (MessageBox.Show("Are you sure you want to Activated the Project?", "System Message", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button2) == DialogResult.Yes)
                    {

                        var result = ProjectContext.ActivateProject(Convert.ToInt32(dgvProjectList.CurrentRow.Cells["RecId"].Value));
                        if (result.Equals("SUCCESS"))
                        {
                            MessageBox.Show("Project has been Activated successfully !", "System Message", MessageBoxButtons.OK, MessageBoxIcon.Information);
                            M_GetProjectList();
                        }
                    }
                }
            }
        }
    }
}
