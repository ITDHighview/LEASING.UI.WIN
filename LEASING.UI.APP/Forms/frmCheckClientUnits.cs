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
    public partial class frmCheckClientUnits : Form
    {

        UnitContext UnitContext = new UnitContext();

        public bool IsProceed = false;
        public string ClientId { get; set; }
        public frmCheckClientUnits()
        {
            InitializeComponent();
        }


        private void M_GetClientUnitList()
        {
            dgvList.DataSource = null;
            using (DataSet dt = UnitContext.GetClientUnitList(ClientId))
            {
                if (dt !=null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    dgvList.DataSource = dt.Tables[0];
                }
            }

        }

        private void frmCheckClientUnits_Load(object sender, EventArgs e)
        {
            M_GetClientUnitList();
        }
    }
}
