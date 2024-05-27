using LEASING.UI.APP.Common;
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
    public partial class frmPurchaseItemLogs : Form
    {
        public frmPurchaseItemLogs()
        {
            InitializeComponent();
        }

        private void frmPurchaseItemLogs_Load(object sender, EventArgs e)
        {
            Functions.EventCapturefrmName(this);
        }
    }
}
