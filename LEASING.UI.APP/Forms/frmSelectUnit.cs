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
    public partial class frmSelectUnit : Form
    {
        UnitContext UnitContext = new UnitContext();
        public bool IsProceed = false;
        public int RecId { get; set; }
        public string UnitNumber { get; set; }
        public int UnitID { get; set; }
        public frmSelectUnit()
        {
            InitializeComponent();
        }

        private void M_GetUnitByProjectId()
        {
            try
            {
                dgvList.DataSource = null;
                using (DataSet dt = UnitContext.GetUnitByProjectId(RecId))
                {
                    if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                    {
                        dgvList.DataSource = dt.Tables[0];
                    }
                }
            }
            catch (Exception ex)
            {
                Functions.LogErrorIntoStoredProcedure("M_GetUnitByProjectId()", this.Text, ex.Message, DateTime.Now, this);

                Functions.MessageShow("An error occurred : (" + ex.ToString() + ") Please check the [ErrorLog] ");
            }


        }

        private void frmSelectUnit_Load(object sender, EventArgs e)
        {
            M_GetUnitByProjectId();
        }

        private void dgvList_DoubleClick(object sender, EventArgs e)
        {
            IsProceed = true;
            UnitID = Convert.ToInt32(dgvList.CurrentRow.Cells["RecId"].Value);
            UnitNumber = Convert.ToString(dgvList.CurrentRow.Cells["UnitNo"].Value);
            this.Close();
        }
    }
}
