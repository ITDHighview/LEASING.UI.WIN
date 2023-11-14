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
    public partial class frmContractSignedUnit : Form
    {
        PaymentContext PaymentContext = new PaymentContext();
        public frmContractSignedUnit()
        {
            InitializeComponent();
        }

        private void M_GetForContractSignedUnitList()
        {
            dgvList.DataSource = null;
            using (DataSet dt = PaymentContext.GetForContractSignedUnitList())
            {
                if (dt != null && dt.Tables.Count > 0 && dt.Tables[0].Rows.Count > 0)
                {
                    dgvList.DataSource = dt.Tables[0];
                }
            }
        }

        private void frmContractSignedUnit_Load(object sender, EventArgs e)
        {
            M_GetForContractSignedUnitList();
        }

        private void btnRefresh_Click(object sender, EventArgs e)
        {
            M_GetForContractSignedUnitList();
        }
    }
}
